################################################################
# Script: 06.PDB_table_generate.r
# Description: Consolidate DDG (Delta Delta G) raw contributions 
#              across 3 specific peptide-MHC complexes, map the 
#              model names, and export to the final tables directory.
# Author: Guojia Wu
################################################################

library(dplyr)

# ===================================================================
# 1. Configuration & Setup
# ===================================================================

# Define input and output paths
path_input_dir  <- "/data1/wuguojia/data/mhc_benchmark/revision/06.PDB_construction/reviewer_response_outputs"
path_output_dir <- "/home/wuguojia/biocode/mhc_benchmark/revision_GPB/00.Tables_Data/Tables"

# Ensure output directory exists
if (!dir.exists(path_output_dir)) {
    dir.create(path_output_dir, recursive = TRUE, showWarnings = FALSE)
    cat(sprintf("[%s] Created output directory: %s\n", Sys.time(), path_output_dir))
}

# Define the sample mapping dictionary based on the file prefix / PDBname
sample_mapping <- list(
    "01" = "HLA-A*02:01 9-mer + NAAERRGPL",
    "02" = "HLA-B*15:02 9-mer + HVEKLARTL",
    "03" = "HLA-C*05:01 9-mer + SLIARLERL"
)

cat(sprintf("[%s] >>> Starting PDB DDG Table Generation...\n", Sys.time()))

# ===================================================================
# 2. Data Extraction and Merging
# ===================================================================

combined_data_list <- list()

# Loop through the defined sample mappings
for (prefix in names(sample_mapping)) {
    model_name <- sample_mapping[[prefix]]
    file_name <- paste0(prefix, "_raw_combined.csv")
    file_path <- file.path(path_input_dir, file_name)
    
    if (file.exists(file_path)) {
        cat(sprintf("[%s] Processing file: %s for Sample: %s\n", Sys.time(), file_name, model_name))
        
        # Read the CSV file
        df <- read.csv(file_path, stringsAsFactors = FALSE)
        
        # Add the Model_name column
        df <- df %>%
            mutate(Model_name = model_name)
        
        # Append to our list
        combined_data_list[[prefix]] <- df
        
    } else {
        cat(sprintf("[%s] WARNING: %s not found in %s. Skipping.\n", Sys.time(), file_name, path_input_dir))
    }
}

# ===================================================================
# 3. Formatting & Export
# ===================================================================

if (length(combined_data_list) > 0) {
    cat(sprintf("[%s] Merging extracted PDB data and structuring columns...\n", Sys.time()))
    
    # Combine all dataframes into one
    final_df <- bind_rows(combined_data_list)
    
    # Reorder columns to put the new descriptive Model_name right after PDBname and Model_ID
    # The expected columns from the raw output are:
    # PDBname, Model_ID, Index, Number, Name, Chain, InterDG, InterDDG, NormTerDDG, IntraDG, IntraDDG, NormTraDDG, ChainAtoms
    final_df <- final_df %>%
        select(Model_name, PDBname, Model_ID, Index, Number, Name, Chain, 
               InterDG, InterDDG, NormTerDDG, IntraDG, IntraDDG, NormTraDDG, ChainAtoms) %>%
        arrange(Model_name, PDBname, Model_ID, Index)
    
    # Save the output
    output_csv <- file.path(path_output_dir, "06_PDB_contribution_combined.csv")
    write.csv(final_df, file = output_csv, row.names = FALSE, quote = FALSE)
    
    cat(sprintf("[%s] >>> Success! Merged PDB table saved to: %s\n", Sys.time(), output_csv))
    
} else {
    cat(sprintf("[%s] ERROR: No files were successfully read. Check input directory.\n", Sys.time()))
}

cat(sprintf("[%s] >>> Pipeline Complete.\n", Sys.time()))