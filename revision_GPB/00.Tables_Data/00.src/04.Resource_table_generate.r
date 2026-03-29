################################################################
# Script: 04.Resource_table_generate.r
# Description: Consolidate computational resource metrics from 
#              different folds (1_vs_4, 1_vs_9), standardize tool 
#              names, and merge into a single summary table.
# Author: Guojia Wu
################################################################

library(dplyr)

# ===================================================================
# 1. Configuration & Setup
# ===================================================================

# Define input and output paths
path_input_dir  <- "/home/wuguojia/biocode/mhc_benchmark/revision_GPB/03.performance_command"
path_output_dir <- "/home/wuguojia/biocode/mhc_benchmark/revision_GPB/00.Tables_Data/Tables"

# Ensure output directory exists
if (!dir.exists(path_output_dir)) {
    dir.create(path_output_dir, recursive = TRUE, showWarnings = FALSE)
    cat(sprintf("[%s] Created output directory: %s\n", Sys.time(), path_output_dir))
}

# Define formal tool name mapping
# Note: Added "mhcflurry" = "MHCflurry2.0" to handle the naming in the summary logs
name_mapping <- c(
    "stmhcpan"         = "STMHCpan",
    "bigmhc"           = "BigMHC",
    "capsnetmhc_an"    = "CapsNet-MHC_AN",
    "mhcflurry_ps"     = "MHCflurry2.0_PS",
    "netmhcpan_el"     = "NetMHCpan4.1_EL",
    "mhcflurry_ba"     = "MHCflurry2.0_BA",
    "mhcflurry"        = "MHCflurry2.0",  # Added for computational log matching
    "transphla"        = "TransPHLA",
    "netmhccons"       = "NetMHCcons1.1",
    "netmhcpan_ba"     = "NetMHCpan4.1_BA",
    "mixmhcpred"       = "MixMHCpred3.0",
    "netmhcstabpan"    = "NetMHCstabpan1.0",
    "acme"             = "ACME",
    "consensus"        = "IEDBconsensus2.18",
    "deephlapan"       = "DeepHLApan",
    "deepattentionpan" = "DeepAttentionpan",
    "capsnetmhc_ie"    = "CapsNet-MHC_IE",
    "deepnetbim"       = "DeepNetBim",
    "netmhcpan"        = "NetMHCpan4.1"   # Just in case there is a generic call
)

# Helper function to map names safely
map_tool_name <- function(raw_names) {
    ifelse(raw_names %in% names(name_mapping), name_mapping[raw_names], raw_names)
}

# Define the input files and their corresponding fold tags
files_to_process <- list(
    "1_vs_4" = "summary_1_vs_4.csv",
    "1_vs_9" = "summary_1_vs_9.csv"
)

cat(sprintf("[%s] >>> Starting Computational Resource Table Generation...\n", Sys.time()))

# ===================================================================
# 2. Data Extraction and Merging
# ===================================================================

combined_data <- list()

for (fold_name in names(files_to_process)) {
    file_name <- files_to_process[[fold_name]]
    file_path <- file.path(path_input_dir, file_name)
    
    if (file.exists(file_path)) {
        cat(sprintf("[%s] Processing file: %s for Fold: %s\n", Sys.time(), file_name, fold_name))
        
        # Read the CSV file
        df <- read.csv(file_path, stringsAsFactors = FALSE)
        
        # Add the Fold column and map the Tool names
        df <- df %>%
            mutate(
                Fold = fold_name,
                Tool = map_tool_name(Tool)
            )
        
        # Append to our list
        combined_data[[fold_name]] <- df
        
    } else {
        cat(sprintf("[%s] WARNING: %s not found in %s. Skipping.\n", Sys.time(), file_name, path_input_dir))
    }
}

# ===================================================================
# 3. Formatting & Export
# ===================================================================

if (length(combined_data) > 0) {
    cat(sprintf("[%s] Merging extracted data and standardizing columns...\n", Sys.time()))
    
    # Combine all dataframes into one
    final_df <- bind_rows(combined_data)
    
    # Reorder columns to put Tool and Fold first for readability
    final_df <- final_df %>%
        select(Tool, Fold, Status, Average_CPU_usage, Peak_CPU_usage, 
               Peak_Memory_usage, Peak_RSS, Total_wall_time, Theoretic_time) %>%
        arrange(Fold, Tool)
    
    # Save the output
    output_csv <- file.path(path_output_dir, "computational_resources_summary.csv")
    write.csv(final_df, file = output_csv, row.names = FALSE, quote = TRUE)
    
    cat(sprintf("[%s] >>> Success! Merged resource table saved to: %s\n", Sys.time(), output_csv))
    
} else {
    cat(sprintf("[%s] ERROR: No files were successfully read. Check input directory.\n", Sys.time()))
}

cat(sprintf("[%s] >>> Pipeline Complete.\n", Sys.time()))