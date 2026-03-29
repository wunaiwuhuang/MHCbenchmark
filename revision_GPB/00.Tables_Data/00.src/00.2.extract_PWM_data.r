##################################################################
# Script to calculate Position Probability Matrices (PPM/PWM)
# Task: Extract positional amino acid frequencies for all HLA-length
#       combinations and save them in a highly compressed format.
##################################################################

library(dplyr)
library(data.table)
library(Biostrings) # Used for ultra-fast matrix calculation

# 1. Define Paths
path_data <- "/data1/wuguojia/data/mhc_benchmark/database/extract_database/"
path_test <- "/data1/wuguojia/data/mhc_benchmark/testbase/"
path_out  <- "/home/wuguojia/biocode/mhc_benchmark/revision_GPB/00.Tables_Data/Data/"

# Ensure output directory exists
dir.create(path_out, recursive = TRUE, showWarnings = FALSE)

# 2. Helper Function: Standardized logging for nohup
log_msg <- function(msg) {
  timestamp <- format(Sys.time(), "%Y-%m-%d %H:%M:%S")
  cat(sprintf("[%s] %s\n", timestamp, msg))
}

# 3. Load and Process Data
log_msg("=== Starting PWM/PPM Data Extraction ===")
log_msg("Loading databases...")

load(paste0(path_data, "DATABASE_COMBINE.Rdata"))
load(paste0(path_test, "TEST.Rdata"))

filteration <- database_combine

log_msg("Filtering data for Class I, positive binds, and valid sequences...")

# Retain relevant data based on test sets
filteration <- filteration[grep("\\*", filteration$hlatype), ] %>%
  filter(mhc_class == "I" & bind_result == "positive") %>%
  filter(hlatype %in% unique(test_mhci$hlatype)) %>%
  filter(antigen_peptide_length %in% unique(test_mhci$antigen_peptide_length))

# Delete unnatural peptides
valid_amino_acids <- "^[ARNDCEQGHILKMFPSTWYV]+$"
filteration <- filteration[grepl(valid_amino_acids, filteration$antigen_peptide), ]

# Remove redundant peptides
filteration <- filteration %>% distinct(hlatype, antigen_peptide, .keep_all = TRUE)

log_msg(sprintf("Filtering complete. Total unique valid sequences: %d", nrow(filteration)))

# 4. Calculate Position Matrices
log_msg("Calculating probability matrices for all HLA and length combinations...")

# Define standard alphabet to ensure matrix rows are always consistent
aa_alphabet <- unlist(strsplit("ARNDCEQGHILKMFPSTWYV", ""))
all_pwm_list <- list()

unique_hlas <- sort(unique(filteration$hlatype))
total_hlas <- length(unique_hlas)
counter <- 1

for(hla in unique_hlas) {
  for(len in sort(unique(filteration$antigen_peptide_length))) {
    
    df <- filteration %>% filter(hlatype == hla & antigen_peptide_length == len)
    
    if(nrow(df) == 0) next
    
    # Convert sequences to Biostrings object
    seqs <- AAStringSet(df$antigen_peptide)
    
    # Calculate raw counts WITHOUT subsetting immediately
    counts_mat_raw <- consensusMatrix(seqs)
    
    # 1. Identify any standard amino acids missing from this specific matrix
    missing_aa <- setdiff(aa_alphabet, rownames(counts_mat_raw))
    
    # 2. Pad the matrix with rows of zeros for those missing amino acids
    if(length(missing_aa) > 0) {
      zero_pad <- matrix(0, nrow = length(missing_aa), ncol = ncol(counts_mat_raw),
                         dimnames = list(missing_aa, NULL))
      counts_mat_raw <- rbind(counts_mat_raw, zero_pad)
    }
    
    # 3. Safely subset the 20 rows we need. 
    # drop = FALSE ensures it stays a matrix even if it only has 1 column
    counts_mat <- counts_mat_raw[aa_alphabet, , drop = FALSE]
    
    # Convert counts to probabilities (column-wise proportion)
    prob_mat <- round(prop.table(counts_mat, margin = 2), 4)
    
    # Transpose so positions are rows, amino acids are columns
    prob_mat_t <- t(prob_mat)
    
    # Create a structured data frame
    pwm_df <- data.frame(
      hlatype = hla,
      length = len,
      position = 1:len,
      prob_mat_t,
      stringsAsFactors = FALSE
    )
    
    all_pwm_list[[paste0(hla, "_", len)]] <- pwm_df
  }
  
  # Log progress every 10 HLAs
  if(counter %% 10 == 0 || counter == total_hlas) {
    log_msg(sprintf("Processed %d / %d HLA types...", counter, total_hlas))
  }
  counter <- counter + 1
}

# 5. Combine and Export
log_msg("Combining all matrices into a single master table...")
master_pwm_table <- rbindlist(all_pwm_list)

output_file <- paste0(path_out, "master_pwm_probabilities.csv.gz")
log_msg(sprintf("Writing highly compressed master matrix to: %s", output_file))

# Write using extreme gzip compression. 
# A single compressed file is vastly smaller than directory structures full of tiny files.
fwrite(master_pwm_table, file = output_file, compress = "gzip")

log_msg("=== Matrix Extraction Complete! Memory cleanup... ===")
rm(database_combine, test_mhci, filteration, all_pwm_list, master_pwm_table)
gc()
log_msg("Done.")
##################################################################