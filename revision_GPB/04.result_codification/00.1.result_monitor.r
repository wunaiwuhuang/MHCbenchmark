#!/usr/bin/env Rscript
# ==============================================================================
# Script: 00.1.result_monitor.r
# Purpose: Simulate 1:99 positive-to-negative ratio results for inefficient tools
#          by downsampling the positive samples from the 1:9 dataset by a factor 
#          of 11. Preserves all negative predictions from the 1:9 baseline.
# ==============================================================================

library(data.table)
library(dplyr)
library(tidyr)
library(stringr)

# 1. Define Directories and Paths
path_base <- "/data1/wuguojia/data/mhc_benchmark/revision/02.negtive_sample_reconstruction/"
path_test_1_9 <- paste0(path_base, "retest_base/1_vs_9/TEST.Rdata")
path_result_1_9 <- paste0(path_base, "retest_result/1_vs_9/")
path_result_1_99 <- paste0(path_base, "retest_result/1_vs_99/")

tools_to_process <- c("consensus", "deepnetbim", "netmhccons", 
                      "netmhcpan_ba", "netmhcpan_el", "netmhcstabpan")

cat("====================================================================\n")
cat(sprintf("[%s] Start 1:99 simulation for inefficient tools.\n", Sys.time()))
cat("====================================================================\n")

# 2. Load 1:9 Base Data to establish ground truth
if (!file.exists(path_test_1_9)) {
    stop("Cannot find 1:9 base test data at: ", path_test_1_9)
}
cat(sprintf("[%s] Loading 1:9 TEST.Rdata...\n", Sys.time()))
load(path_test_1_9) # Loads 'test' and 'summary'
test_dt <- as.data.table(test)

# 3. Downsample Positive Samples
cat(sprintf("[%s] Downsampling positive samples (Seed: 20030622)...\n", Sys.time()))
set.seed(20030622)

keep_dt <- test_dt[, {
    pos_data <- .SD[bind_result == "positive"]
    neg_data <- .SD[bind_result == "negative"]
    
    n_pos <- nrow(pos_data)
    
    # 目标：大致压缩 11 倍，但任何类别至少保留 5 个样本（如果原始数据够的话）
    min_samples_to_keep <- 5

    if (n_pos <= min_samples_to_keep) {
        kept_pos <- pos_data
    } else {
        n_keep <- max(round(n_pos / 11), min_samples_to_keep)
        # 确保不超过总数
        n_keep <- min(n_keep, n_pos)
        kept_pos <- pos_data[sample(.N, n_keep, replace = FALSE)]
    }
    
    # Always carry over all 1:9 negative samples to simulate the 1:99 ratio
    rbind(kept_pos, neg_data)
}, by = .(hlatype, antigen_peptide_length)]

keep_df <- as.data.frame(keep_dt)
cat(sprintf("[%s] Original 1:9 rows: %d | Simulated 1:99 rows: %d\n", 
            Sys.time(), nrow(test_dt), nrow(keep_df)))

# 4. Save a mock TEST.Rdata specifically for downstream codification
#    Note: This is strictly required because the negatives randomly sampled for 
#    the 1:9 fold do not perfectly overlap with the negatives in the real 1:99 fold.
mock_summary <- list()
mock_summary$hla2bin <- as.data.frame.matrix(table(keep_df$hlatype, keep_df$bind_result))
mock_summary$hla2bin$SUM <- rowSums(mock_summary$hla2bin)
mock_summary$hla2len <- as.data.frame.matrix(table(keep_df$hlatype, keep_df$antigen_peptide_length))
mock_summary$hla2len$SUM <- rowSums(mock_summary$hla2len)
mock_summary$len2bin <- as.data.frame.matrix(table(keep_df$antigen_peptide_length, keep_df$bind_result))
mock_summary$len2bin$SUM <- rowSums(mock_summary$len2bin)

test <- keep_df
summary <- mock_summary
save(test, summary, file = paste0(path_result_1_99, "TEST_simulated_for_slow_tools.Rdata"))
cat(sprintf("[%s] Saved simulated TEST.Rdata to %s\n", Sys.time(), path_result_1_99))

# 5. Helper Function to Parse Filenames (Extract HLA and Length)
parse_filename <- function(fname) {
    name_no_ext <- sub("\\.[^.]+$", "", fname)
    # Target files typically named like HLA-A*01:01_10.txt
    if (grepl("_\\d+$", name_no_ext)) {
        parts <- strsplit(name_no_ext, "_")[[1]]
        len_str <- parts[length(parts)]
        hla_str <- paste(parts[1:(length(parts)-1)], collapse="_")
        return(list(hla = hla_str, len = as.integer(len_str)))
    } else {
        return(list(hla = name_no_ext, len = NA))
    }
}

# 6. Process Data File-by-File for Each Tool
for (tool in tools_to_process) {
    cat("--------------------------------------------------------------------\n")
    cat(sprintf("[%s] Processing tool: %s\n", Sys.time(), tool))
    
    dir_in <- paste0(path_result_1_9, tool)
    dir_out <- paste0(path_result_1_99, tool)
    
    if (!dir.exists(dir_out)) dir.create(dir_out, recursive = TRUE)
    
    files <- list.files(dir_in, full.names = TRUE)
    if (length(files) == 0) {
        cat(sprintf("  Warning: No files found in %s\n", dir_in))
        next
    }
    
    total_in <- 0
    total_out <- 0
    
    for (i in seq_along(files)) {
        f <- files[i]
        fname <- basename(f)
        parsed <- parse_filename(fname)
        
        # Determine valid target peptides for this specific allele and length
        if (!is.na(parsed$len)) {
            valid_peps <- keep_df$antigen_peptide[keep_df$hlatype == parsed$hla & 
                                                  keep_df$antigen_peptide_length == parsed$len]
        } else {
            valid_peps <- keep_df$antigen_peptide[keep_df$hlatype == parsed$hla]
        }
        
        # Fallback if HLA naming conventions differ slightly (e.g., missing '*')
        if (length(valid_peps) == 0) {
            matched_hla <- unique(keep_df$hlatype)[gsub("\\*", "", unique(keep_df$hlatype)) == gsub("\\*", "", parsed$hla)]
            if (length(matched_hla) == 1) {
                if (!is.na(parsed$len)) {
                    valid_peps <- keep_df$antigen_peptide[keep_df$hlatype == matched_hla & 
                                                          keep_df$antigen_peptide_length == parsed$len]
                } else {
                    valid_peps <- keep_df$antigen_peptide[keep_df$hlatype == matched_hla]
                }
            }
        }
        
        data <- fread(f)
        total_in <- total_in + nrow(data)
        
        # If file is empty or no valid peptides align, write raw header/file and skip
        if (nrow(data) == 0 || length(valid_peps) == 0) {
            fwrite(data, paste0(dir_out, "/", fname), sep="\t", quote=FALSE)
            next
        }
        
        # Identify the peptide column flexibly based on codification pipeline standards
        peptide_cols <- c("peptide", "Peptide", "sequence", "Sequence", "pep")
        pep_col <- intersect(colnames(data), peptide_cols)
        
        if (length(pep_col) > 0) {
            pep_col <- pep_col[1]
            data_filtered <- data[data[[pep_col]] %in% valid_peps, ]
            fwrite(data_filtered, paste0(dir_out, "/", fname), sep="\t", quote=FALSE)
            total_out <- total_out + nrow(data_filtered)
        } else {
            cat(sprintf("  [Warning] Peptide col not found in %s. Copying raw.\n", fname))
            fwrite(data, paste0(dir_out, "/", fname), sep="\t", quote=FALSE)
            total_out <- total_out + nrow(data)
        }
        
        # Print progress to nohup log safely
        if (i %% 100 == 0) {
            cat(sprintf("  [%s] Processed %d / %d files...\n", Sys.time(), i, length(files)))
        }
    }
    cat(sprintf("[%s] Completed %s. Files: %d | Rows In: %d | Rows Out: %d\n", 
                Sys.time(), tool, length(files), total_in, total_out))
}

cat("====================================================================\n")
cat(sprintf("[%s] All 1:99 simulations finished successfully.\n", Sys.time()))
cat("====================================================================\n")