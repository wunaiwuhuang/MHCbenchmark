##################################################################
# Script to extract and compress the complete TOOL_COMBINE dataset
# Task: Convert the Rdata file containing all tool training sets 
#       into a highly compressed, universally readable CSV.gz format.
##################################################################

library(data.table)

# 1. Define Paths
# The input path is derived from your filter_toolbase generation script
path_filter <- "/data1/wuguojia/data/mhc_benchmark/toolbase/filter_toolbase/"
input_file  <- paste0(path_filter, "TOOL_COMBINE.Rdata")

# Output path specified for the GPB revision data
path_out <- "/home/wuguojia/biocode/mhc_benchmark/revision_GPB/00.Tables_Data/Data/"

# Ensure output directory exists
dir.create(path_out, recursive = TRUE, showWarnings = FALSE)

# 2. Helper Function: Standardized logging for nohup
log_msg <- function(msg) {
  timestamp <- format(Sys.time(), "%Y-%m-%d %H:%M:%S")
  cat(sprintf("[%s] %s\n", timestamp, msg))
}

# 3. Main Processing Logic
log_msg("=== Starting TOOL_COMBINE Dataset Extraction ===")

# Check if the input file exists
if (!file.exists(input_file)) {
  log_msg(sprintf("FATAL ERROR: Input file not found at %s", input_file))
  quit(status = 1)
}

log_msg(sprintf("Loading workspace from: %s", input_file))

# Load the data into a safe environment to prevent namespace pollution
temp_env <- new.env()
load(input_file, envir = temp_env)

# Verify the required object exists
if (!"tool_combine" %in% ls(temp_env)) {
  log_msg("FATAL ERROR: 'tool_combine' dataframe not found in the loaded workspace.")
  rm(temp_env)
  quit(status = 1)
}

# Extract the dataframe
tool_data <- temp_env$tool_combine
log_msg(sprintf("Successfully loaded tool_combine. Total rows: %d, Total columns: %d", 
                nrow(tool_data), ncol(tool_data)))

# 4. Data Export and Compression
# Define the final highly-compressed output file
output_file <- paste0(path_out, "Complete_Tool_Training_Dataset.csv.gz")

log_msg(sprintf("Compressing and writing data to: %s", output_file))

# Write using data.table::fwrite with native gzip compression.
# This avoids intermediate large CSVs and writes directly to a compressed binary format.
fwrite(tool_data, file = output_file, compress = "gzip", row.names = FALSE)

# 5. Memory Cleanup
log_msg("Export complete. Cleaning up memory...")
rm(temp_env, tool_data)
gc()

log_msg("=== Extraction finished successfully! ===")
##################################################################