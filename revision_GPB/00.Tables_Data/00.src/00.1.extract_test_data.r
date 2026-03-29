##################################################################
# Script to extract and compress MHC benchmark data for Zenodo
# Task: Extract 1:1, 1:4, and 1:9 folds, isolate 'test' data, 
#       and compress heavily to save space.
##################################################################

library(data.table)

# 1. Define Paths
path_retest_base <- "/data1/wuguojia/data/mhc_benchmark/revision/02.negtive_sample_reconstruction/retest_base/"
path_zenodo_out <- "/home/wuguojia/biocode/mhc_benchmark/revision_GPB/00.Tables_Data/Data/"

# Ensure output directory exists
dir.create(path_zenodo_out, recursive = TRUE, showWarnings = FALSE)

# 2. Define Target Folds (Excluding 1:99 to save Zenodo storage)
target_folds <- c(1, 4, 9, 99)

# 3. Helper Function: Standardized logging for nohup
# This ensures every step is timestamped in your nohup.out log
log_msg <- function(msg) {
  timestamp <- format(Sys.time(), "%Y-%m-%d %H:%M:%S")
  cat(sprintf("[%s] %s\n", timestamp, msg))
}

# 4. Main Extraction Loop
log_msg("=== Starting Zenodo Data Extraction and Compression ===")

for (fold in target_folds) {
  log_msg(sprintf(">>> Processing fold: 1_vs_%d", fold))
  
  input_file <- paste0(path_retest_base, "1_vs_", fold, "/TEST.Rdata")
  
  # Check if the file exists before attempting to load
  if (!file.exists(input_file)) {
    log_msg(sprintf("ERROR: Input file not found: %s", input_file))
    next
  }
  
  log_msg(sprintf("Loading workspace from: %s", input_file))
  
  # Use a new environment to load the .Rdata file safely
  # This prevents overwriting existing variables and helps with memory management
  temp_env <- new.env()
  load(input_file, envir = temp_env)
  
  # Verify the 'test' dataframe exists in the loaded data
  if (!"test" %in% ls(temp_env)) {
    log_msg("ERROR: 'test' data frame not found in the loaded workspace.")
    rm(temp_env)
    next
  }
  
  # Extract only the target data frame
  test_df <- temp_env$test
  log_msg(sprintf("Successfully isolated 'test' data frame. Row count: %d", nrow(test_df)))
  
  # Define output filename with .csv.gz extension
  # .csv.gz is highly compressed and universally accepted by Zenodo/OSF reviewers
  output_file <- paste0(path_zenodo_out, "test_1_vs_", fold, ".csv.gz")
  
  log_msg(sprintf("Compressing and writing to: %s", output_file))
  
  # Use data.table::fwrite for extreme write speed and built-in gzip compression.
  # This provides the smallest file footprint for tabular text data.
  fwrite(test_df, file = output_file, compress = "gzip")
  
  # Memory Management: Clear the isolated data and force garbage collection
  # This prevents RAM bloat when dealing with massive datasets in loops
  rm(temp_env, test_df)
  gc()
  
  log_msg(sprintf("<<< Finished processing fold 1_vs_%d successfully.\n", fold))
}

log_msg("=== All requested folds have been processed and saved ===")
##################################################################