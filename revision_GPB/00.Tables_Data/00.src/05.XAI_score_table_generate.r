################################################################
# Script: 05.XAI_score_table_generate.r
# Description: Consolidate SHAP and LIME interpretability scores 
#              across different MHC prediction tools for length 9 peptides.
#              Standardizes tool names and merges into a single CSV.
# Author: Guojia Wu
################################################################

library(dplyr)
library(data.table)

# ===================================================================
# 1. Configuration & Setup
# ===================================================================

# Define input and output paths
path_input_dir  <- "/data1/wuguojia/data/mhc_benchmark/attentionbase/result"
path_output_dir <- "/home/wuguojia/biocode/mhc_benchmark/revision_GPB/00.Tables_Data/Tables"

# Ensure output directory exists
if (!dir.exists(path_output_dir)) {
    dir.create(path_output_dir, recursive = TRUE, showWarnings = FALSE)
    cat(sprintf("[%s] Created output directory: %s\n", Sys.time(), path_output_dir))
}

# Define formal tool name mapping
name_mapping <- c(
    "stmhcpan"         = "STMHCpan",
    "bigmhc"           = "BigMHC",
    "capsnetmhc_an"    = "CapsNet-MHC_AN",
    "mhcflurry_ps"     = "MHCflurry2.0_PS",
    "netmhcpan_el"     = "NetMHCpan4.1_EL",
    "mhcflurry_ba"     = "MHCflurry2.0_BA",
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
    "deepnetbim"       = "DeepNetBim"
)

# Helper function to map names safely
map_tool_name <- function(raw_names) {
    ifelse(raw_names %in% names(name_mapping), name_mapping[raw_names], raw_names)
}

cat(sprintf("[%s] >>> Starting XAI Score Table Generation...\n", Sys.time()))

# ===================================================================
# 2. File Identification
# ===================================================================

# Find all length 9 XAI result CSVs
target_files <- list.files(path_input_dir, pattern = "_length_9\\.csv$", full.names = TRUE)

if (length(target_files) == 0) {
    stop(sprintf("[%s] ERROR: No '_length_9.csv' files found in %s\n", Sys.time(), path_input_dir))
}

cat(sprintf("[%s] Found %d tool result files to process.\n", Sys.time(), length(target_files)))

# ===================================================================
# 3. Data Extraction and Merging
# ===================================================================

combined_data_list <- list()

for (file_path in target_files) {
    file_name <- basename(file_path)
    cat(sprintf("[%s] Reading and processing: %s\n", Sys.time(), file_name))
    
    # Use data.table::fread for significantly faster I/O on large matrix files
    df <- tryCatch({
        fread(file_path, stringsAsFactors = FALSE, data.table = FALSE)
    }, error = function(e) {
        cat(sprintf("[%s] ERROR reading %s: %s\n", Sys.time(), file_name, e$message))
        return(NULL)
    })
    
    if (!is.null(df) && nrow(df) > 0) {
        # Ensure tool names inside the dataframe are mapped properly
        # Handle cases where the 'tool' column might be named differently, though your 'head' showed 'tool'
        if ("tool" %in% colnames(df)) {
            df$tool <- map_tool_name(df$tool)
        } else {
            cat(sprintf("[%s] WARNING: 'tool' column missing in %s\n", Sys.time(), file_name))
        }
        
        combined_data_list[[file_name]] <- df
    }
}

# ===================================================================
# 4. Formatting & Export
# ===================================================================

if (length(combined_data_list) > 0) {
    cat(sprintf("[%s] Merging all tool data into a single dataset...\n", Sys.time()))
    
    # Bind all rows together
    final_df <- bind_rows(combined_data_list)
    
    # Optional: Reorder columns to ensure metadata is first, followed by pos_1 to pos_9
    # The expected base columns are mode, allele, length, peptide, tool, bind_result_tool, bind_result_base
    base_cols <- c("tool", "mode", "allele", "length", "peptide", "bind_result_tool", "bind_result_base")
    pos_cols <- paste0("pos_", 1:9)
    
    # Keep any other columns that might exist just in case
    other_cols <- setdiff(colnames(final_df), c(base_cols, pos_cols))
    
    # Arrange columns gracefully
    final_df <- final_df %>%
        select(all_of(intersect(c(base_cols, pos_cols, other_cols), colnames(final_df)))) %>%
        arrange(tool, mode, allele)
    
    # Save the output
    output_csv <- file.path(path_output_dir, "XAI_SHAP_LIME_scores_length_9.csv")
    
    cat(sprintf("[%s] Writing final merged data to disk (this may take a moment)...\n", Sys.time()))
    fwrite(final_df, file = output_csv, row.names = FALSE, quote = FALSE)
    
    cat(sprintf("[%s] >>> Success! XAI score table saved to: %s\n", Sys.time(), output_csv))
    
} else {
    cat(sprintf("[%s] ERROR: No data was extracted. Check the input files.\n", Sys.time()))
}

cat(sprintf("[%s] >>> Pipeline Complete.\n", Sys.time()))