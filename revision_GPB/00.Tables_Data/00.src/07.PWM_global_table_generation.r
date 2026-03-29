################################################################
# Script: 07.PWM_global_table_generation.r
# Description: Generate Position Weight Matrix (PWM) positional 
#              frequency tables for all MHC alleles and peptide 
#              lengths from the ground truth database.
# Author: Guojia Wu
################################################################

library(dplyr)
library(tidyr)
library(data.table)

# ===================================================================
# 1. Configuration & Setup
# ===================================================================

# Define input and output paths
path_data       <- "/data1/wuguojia/data/mhc_benchmark/database/extract_database/"
path_test       <- "/data1/wuguojia/data/mhc_benchmark/testbase/"
path_output_dir <- "/home/wuguojia/biocode/mhc_benchmark/revision_GPB/00.Tables_Data/Tables"

# Ensure output directory exists
if (!dir.exists(path_output_dir)) {
    dir.create(path_output_dir, recursive = TRUE, showWarnings = FALSE)
    cat(sprintf("[%s] Created output directory: %s\n", Sys.time(), path_output_dir))
}

cat(sprintf("[%s] >>> Starting PWM Global Table Generation...\n", Sys.time()))

# ===================================================================
# 2. Data Loading & Filtering (Ground Truth Logic)
# ===================================================================

cat(sprintf("[%s] Loading DATABASE_COMBINE.Rdata and TEST.Rdata...\n", Sys.time()))

# Load data into isolated environments or globally 
# (Assuming the objects inside are named 'database_combine' and 'test_mhci')
load(paste0(path_data, "DATABASE_COMBINE.Rdata"))
load(paste0(path_test, "TEST.Rdata"))

cat(sprintf("[%s] Applying filtering logic...\n", Sys.time()))

filteration <- database_combine

# Retain test data conditions
filteration <- filteration[grep("\\*", filteration$hlatype), ] %>%
    filter(mhc_class == "I" & bind_result == "positive") %>%
    filter(hlatype %in% unique(test_mhci$hlatype)) %>%
    filter(antigen_peptide_length %in% unique(test_mhci$antigen_peptide_length))

# Delete unnatural peptides
valid_amino_acids <- "^[ARNDCEQGHILKMFPSTWYV]+$"
filteration <- filteration[grepl(valid_amino_acids, filteration$antigen_peptide), ]

# Remove redundant peptides
filteration <- filteration %>% distinct(hlatype, antigen_peptide, .keep_all = TRUE)

cat(sprintf("[%s] Filtering complete. Total unique valid peptides: %d\n", Sys.time(), nrow(filteration)))

# ===================================================================
# 3. PWM Calculation
# ===================================================================

cat(sprintf("[%s] Calculating positional frequencies (PWM)...\n", Sys.time()))

# Define all 20 standard amino acids to ensure fixed column structure
aa_levels <- unlist(strsplit("ARNDCEQGHILKMFPSTWYV", ""))

pwm_results_list <- list()
alleles <- sort(unique(filteration$hlatype))

for (hla in alleles) {
    lengths <- sort(unique(filteration$antigen_peptide_length[filteration$hlatype == hla]))
    
    for (len in lengths) {
        cat(sprintf("[%s] Processing %s (%d-mer)...\n", Sys.time(), hla, len))
        
        # Subset data for the specific allele and length
        df <- filteration %>% filter(hlatype == hla & antigen_peptide_length == len & bind_result == "positive")
        peptides <- df$antigen_peptide
        n_peptides <- length(peptides)
        
        # Skip if no peptides remain (shouldn't happen with current filtering, but safe)
        if (n_peptides == 0) next
        
        # Split strings into a matrix (Rows = peptides, Columns = positions)
        pep_matrix <- do.call(rbind, strsplit(peptides, ""))
        
        # Calculate frequencies for each position (1 to len)
        for (pos in 1:len) {
            # Factor with aa_levels ensures missing AAs are counted as 0
            counts <- table(factor(pep_matrix[, pos], levels = aa_levels))
            freqs <- counts / sum(counts) # Convert to probability/frequency
            
            # Create a row for this position
            row_data <- data.frame(
                Allele = hla,
                Length = len,
                Position = pos,
                Total_Peptides = n_peptides,
                stringsAsFactors = FALSE
            )
            
            # Append the 20 AA frequencies to the row
            freq_df <- as.data.frame(t(as.numeric(freqs)))
            colnames(freq_df) <- aa_levels
            row_data <- cbind(row_data, freq_df)
            
            # Store in the list
            list_key <- paste(hla, len, pos, sep = "_")
            pwm_results_list[[list_key]] <- row_data
        }
    }
}

# ===================================================================
# 4. Formatting & Export
# ===================================================================

cat(sprintf("[%s] Merging PWM results into a single table...\n", Sys.time()))

final_pwm_df <- bind_rows(pwm_results_list)

# Export as CSV
output_file <- file.path(path_output_dir, "07_Global_PWM_Frequencies.csv")
fwrite(final_pwm_df, file = output_file, row.names = FALSE, quote = FALSE)

cat(sprintf("[%s] >>> Success! PWM Global Table saved to: %s\n", Sys.time(), output_file))