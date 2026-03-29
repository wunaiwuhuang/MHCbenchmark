################################################################
# Script: 05.result_threshold_selection02.r
# Description: Calculate confusion matrix-dependent metrics for each tool 
#              across 1000 candidate thresholds using vectorized operations.
# Author: Guojia Wu (Refactored/Assisted)
################################################################

library(data.table)
library(dplyr)
library(parallel)
library(argparse)

# 1. Parse Arguments (Optional support for different folds)
parser <- ArgumentParser(description='Calculate performance metrics across thresholds')
parser$add_argument('fold', nargs = '?', default = '1_vs_9', 
                    help = 'Fold name, e.g., 1_vs_4, 1_vs_9 (Default: 1_vs_9)')
opt <- parser$parse_args()
fold <- opt$fold

cat(sprintf("[%s] >>> Starting Metrics Calculation Pipeline for fold: %s\n", Sys.time(), fold))

# 2. Path Definitions
path_base <- "/data1/wuguojia/data/mhc_benchmark/revision/03.result_codification"
# Input and Output path are the same as requested
path_io <- file.path(path_base, "threshold_selection")

if (!dir.exists(path_io)) {
    stop(sprintf("[%s] Error: Directory does not exist: %s\n", Sys.time(), path_io))
}

# 3. Find all target files generated from step 01
files <- list.files(path_io, pattern = "_threshold_list\\.Rdata$", full.names = TRUE)

if (length(files) == 0) {
    stop(sprintf("[%s] Error: No files found in %s\n", Sys.time(), path_io))
}
cat(sprintf("[%s] Found %d tool result files to process.\n", Sys.time(), length(files)))

# 4. Fast Vectorized Metrics Calculator
# This avoids using external packages which can be slow inside large loops
calculate_metrics <- function(TP, TN, FP, FN) {
    # Convert to numeric to avoid integer overflow when calculating MCC
    TP <- as.numeric(TP)
    TN <- as.numeric(TN)
    FP <- as.numeric(FP)
    FN <- as.numeric(FN)
    
    accuracy <- (TP + TN) / (TP + TN + FP + FN)
    sensitivity <- ifelse((TP + FN) == 0, NA, TP / (TP + FN)) # Also known as Recall
    recall <- sensitivity
    specificity <- ifelse((TN + FP) == 0, NA, TN / (TN + FP))
    precision <- ifelse((TP + FP) == 0, NA, TP / (TP + FP))
    
    # F1 Score
    f1_score <- ifelse(is.na(precision) | is.na(recall) | (precision + recall) == 0, 
                       NA, 
                       2 * (precision * recall) / (precision + recall))
    
    # MCC (Matthews correlation coefficient)
    mcc_denom <- sqrt((TP + FP) * (TP + FN) * (TN + FP) * (TN + FN))
    mcc <- ifelse(mcc_denom == 0, NA, (TP * TN - FP * FN) / mcc_denom)
    
    return(data.frame(
        TP = TP, TN = TN, FP = FP, FN = FN,
        mcc = mcc,
        accuracy = accuracy,
        f1_score = f1_score,
        precision = precision,
        recall = recall,
        sensitivity = sensitivity,
        specificity = specificity
    ))
}

# 5. Core Processing Function
process_metrics <- function(file_path) {
    
    # Extract tool name
    name <- gsub("_threshold_list\\.Rdata$", "", basename(file_path))
    cat(sprintf("[%s] [Process PID: %s] Started: %s\n", Sys.time(), Sys.getpid(), name))
    
    # Load previously saved data (candidate_thresholds, threshold_matrix, labels)
    temp_env <- new.env()
    load(file_path, envir = temp_env)
    
    labels <- temp_env$labels
    threshold_matrix <- temp_env$threshold_matrix
    candidate_thresholds <- temp_env$candidate_thresholds
    
    n_thresh <- length(candidate_thresholds)
    
    # Pre-allocate vectors for speed
    TP_vec <- integer(n_thresh)
    TN_vec <- integer(n_thresh)
    FP_vec <- integer(n_thresh)
    FN_vec <- integer(n_thresh)
    
    # Convert labels to raw format matching the threshold_matrix (1 for positive, 0 for negative)
    y_true_raw <- as.raw(ifelse(labels == "positive", 1, 0))
    raw_1 <- as.raw(1)
    raw_0 <- as.raw(0)
    
    # ---------------------------------------------------------
    # Calculate TP, TN, FP, FN for each threshold
    # Fast bitwise/raw comparison for maximum efficiency
    # ---------------------------------------------------------
    for (j in seq_len(n_thresh)) {
        y_pred_raw <- threshold_matrix[, j]
        
        TP_vec[j] <- sum(y_true_raw == raw_1 & y_pred_raw == raw_1)
        TN_vec[j] <- sum(y_true_raw == raw_0 & y_pred_raw == raw_0)
        FP_vec[j] <- sum(y_true_raw == raw_0 & y_pred_raw == raw_1)
        FN_vec[j] <- sum(y_true_raw == raw_1 & y_pred_raw == raw_0)
    }
    
    # Calculate all metrics using the vectorized helper function
    metrics_df <- calculate_metrics(TP_vec, TN_vec, FP_vec, FN_vec)
    
    # Combine threshold values with their corresponding metrics
    final_result_df <- data.frame(threshold = candidate_thresholds)
    final_result_df <- cbind(final_result_df, metrics_df)
    
    # Save the result
    output_file <- file.path(path_io, paste0(name, "_result_list.Rdata"))
    save(final_result_df, file = output_file)
    
    # Memory cleanup
    rm(temp_env, labels, threshold_matrix, candidate_thresholds, y_true_raw, y_pred_raw)
    gc(verbose = FALSE)
    
    cat(sprintf("[%s] [Process PID: %s] Finished: %s | Saved to %s\n", 
                Sys.time(), Sys.getpid(), name, basename(output_file)))
    
    return(TRUE)
}

# 6. Parallel Execution
# Configure for 20 CPU cores as requested
num_cores <- 20 
cat(sprintf("[%s] Launching mclapply with %d cores...\n", Sys.time(), num_cores))

# Execute. mc.preschedule = FALSE guarantees dynamic load balancing across processes.
results <- mclapply(files, process_metrics, mc.cores = num_cores, mc.preschedule = FALSE)

cat(sprintf("[%s] >>> Metrics Calculation Pipeline Completed Successfully.\n", Sys.time()))