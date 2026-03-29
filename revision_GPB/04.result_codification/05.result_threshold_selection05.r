################################################################
# Script: 05.result_threshold_selection05.r
# Description: Apply optimal thresholds to generate labeled data and 
#              calculate confusion matrix metrics across 4 dimensions 
#              (Overall, Allele, Length, Single) with precise directory mapping.
#              INCLUDES the Comprehensive Score calculation.
# Author: Guojia Wu (Refactored/Assisted)
################################################################

library(data.table)
library(dplyr)
library(parallel)
library(argparse)

# 1. Parse Arguments
parser <- ArgumentParser(description='Label data and calculate confusion matrix metrics')
parser$add_argument('fold', nargs = '?', default = 'all', 
                    help = 'Fold name to process (e.g., 1_vs_9), or "all" for all folds (Default: all)')
opt <- parser$parse_args()
target_fold <- opt$fold

cat(sprintf("[%s] >>> Starting Labeling & Metrics Pipeline for fold: %s\n", Sys.time(), target_fold))

# 2. Precise Path Definitions
path_base <- "/data1/wuguojia/data/mhc_benchmark/revision"
path_codify <- file.path(path_base, "03.result_codification")
path_analysis <- file.path(path_base, "04.result_analysis")

# Optimal thresholds CSV path
path_thresholds <- file.path(path_codify, "threshold_selection", "final", "optimal_thresholds_summary.csv")

if (!file.exists(path_thresholds)) {
    stop(sprintf("[%s] Error: Optimal thresholds CSV not found at %s\n", Sys.time(), path_thresholds))
}

# 3. Load Optimal Thresholds
threshold_df <- read.csv(path_thresholds, stringsAsFactors = FALSE)
threshold_lookup <- setNames(threshold_df$Optimal_Threshold, threshold_df$Tool)
definition_lookup <- setNames(threshold_df$Definition, threshold_df$Tool)

# 4. Explicit Directory Mapping
if (target_fold == "all") {
    # Scan for fold directories explicitly (ignoring threshold_selection)
    all_dirs <- list.dirs(path_codify, full.names = FALSE, recursive = FALSE)
    valid_folds <- all_dirs[grepl("_vs_", all_dirs) & nchar(all_dirs) > 0]
} else {
    valid_folds <- c(target_fold)
}

# Build a strict list of tasks containing exact input and output paths
tasks <- list()
for (f in valid_folds) {
    fold_dir_in <- file.path(path_codify, f)
    if (dir.exists(fold_dir_in)) {
        fold_files <- list.files(fold_dir_in, pattern = "_no_threshold\\.Rdata$", full.names = TRUE)
        for (file_path in fold_files) {
            tasks[[length(tasks) + 1]] <- list(
                file_path = file_path,
                fold = f
            )
        }
    }
}

if (length(tasks) == 0) {
    stop(sprintf("[%s] Error: No valid _no_threshold.Rdata files found.\n", Sys.time()))
}

cat(sprintf("[%s] Successfully mapped %d files across %d fold(s).\n", Sys.time(), length(tasks), length(valid_folds)))

# 5. Helper Function: Vectorized Metrics Calculator (WITH COMPREHENSIVE SCORE)
calc_cm_metrics <- function(df_counts) {
    df_counts %>%
        mutate(
            accuracy = (TP + TN) / (TP + TN + FP + FN),
            sensitivity = ifelse((TP + FN) == 0, NA_real_, TP / (TP + FN)),
            specificity = ifelse((TN + FP) == 0, NA_real_, TN / (TN + FP)),
            precision = ifelse((TP + FP) == 0, NA_real_, TP / (TP + FP)),
            recall = sensitivity, 
            f1_score = ifelse(is.na(precision) | is.na(recall) | (precision + recall) == 0, 
                              NA_real_, 2 * (precision * recall) / (precision + recall)),
            mcc_denom = sqrt(as.numeric(TP + FP) * as.numeric(TP + FN) * as.numeric(TN + FP) * as.numeric(TN + FN)),
            mcc = ifelse(mcc_denom == 0, NA_real_, (as.numeric(TP) * as.numeric(TN) - as.numeric(FP) * as.numeric(FN)) / mcc_denom),
            
            # --- NEW: Incorporating the Comprehensive Score and its components ---
            balanced_accuracy = (sensitivity + specificity) / 2,
            normalized_mcc = (mcc + 1) / 2,
            # Handle potential NAs by replacing them with 0 just for the comprehensive score calculation
            comprehensive = 0.4 * ifelse(is.na(normalized_mcc), 0, normalized_mcc) + 
                            0.3 * ifelse(is.na(f1_score), 0, f1_score) + 
                            0.3 * ifelse(is.na(balanced_accuracy), 0, balanced_accuracy)
        ) %>%
        # Remove intermediate columns to keep the final output clean
        select(-mcc_denom, -balanced_accuracy, -normalized_mcc) 
}

# 6. Core Processing Function
process_task <- function(task) {
    
    file_path <- task$file_path
    fold_dir <- task$fold
    name <- gsub("_no_threshold\\.Rdata$", "", basename(file_path))
    
    cat(sprintf("[%s] [PID: %s] Processing: %s (Fold: %s)\n", Sys.time(), Sys.getpid(), name, fold_dir))
    
    # Strictly define output directories
    out_dir_codify <- file.path(path_codify, fold_dir)      # For _labeled.Rdata
    out_dir_analysis <- file.path(path_analysis, fold_dir)  # For _confusionMatrix.Rdata
    
    if (!dir.exists(out_dir_analysis)) dir.create(out_dir_analysis, recursive = TRUE, showWarnings = FALSE)
    
    # Retrieve Threshold Rules
    if (!(name %in% names(threshold_lookup))) {
        cat(sprintf("[%s] Warning: %s not found in threshold summary. Skipping.\n", Sys.time(), name))
        return(FALSE)
    }
    opt_thresh <- threshold_lookup[[name]]
    opt_def <- definition_lookup[[name]]
    
    # Load Data
    temp_env <- new.env()
    load(file_path, envir = temp_env)
    all_data <- data.table::rbindlist(temp_env$tool_result)
    
    if("bind_result" %in% names(all_data)) setnames(all_data, "bind_result", "bind_result_base")
    
    # -----------------------------------------------------------------
    # STEP A: Apply Threshold and Create Labels
    # -----------------------------------------------------------------
    is_reverse <- grepl("<=", opt_def)
    
    all_labeled <- all_data %>%
        mutate(
            bind_result_tool = ifelse(
                if (is_reverse) affinity <= opt_thresh else affinity >= opt_thresh,
                "positive", "negative"
            )
        )
    
    # Save labeled data correctly to 03.result_codification/fold/
    labeled_output_file <- file.path(out_dir_codify, paste0(name, "_labeled.Rdata"))
    save(all_labeled, file = labeled_output_file)
    
    # -----------------------------------------------------------------
    # STEP B: Calculate Confusion Matrix Metrics across 4 Dimensions
    # -----------------------------------------------------------------
    compute_base_counts <- function(df, ...) {
        df %>%
            group_by(...) %>%
            summarise(
                TP = sum(bind_result_base == "positive" & bind_result_tool == "positive", na.rm = TRUE),
                TN = sum(bind_result_base == "negative" & bind_result_tool == "negative", na.rm = TRUE),
                FP = sum(bind_result_base == "negative" & bind_result_tool == "positive", na.rm = TRUE),
                FN = sum(bind_result_base == "positive" & bind_result_tool == "negative", na.rm = TRUE),
                .groups = 'drop'
            ) %>%
            calc_cm_metrics()
    }
    
    # 1. Overall dimension
    all_info <- all_labeled %>%
        summarise(
            TP = sum(bind_result_base == "positive" & bind_result_tool == "positive", na.rm = TRUE),
            TN = sum(bind_result_base == "negative" & bind_result_tool == "negative", na.rm = TRUE),
            FP = sum(bind_result_base == "negative" & bind_result_tool == "positive", na.rm = TRUE),
            FN = sum(bind_result_base == "positive" & bind_result_tool == "negative", na.rm = TRUE)
        ) %>%
        calc_cm_metrics()
    
    # 2. Allele dimension
    hla_info <- compute_base_counts(all_labeled, allele)
    
    # 3. Length dimension
    len_info <- compute_base_counts(all_labeled, antigen_peptide_length)
    
    # 4. Combined Single dimension
    single_info <- compute_base_counts(all_labeled, allele, antigen_peptide_length)
    
    # Save metrics results correctly to 04.result_analysis/fold/
    cm_output_file <- file.path(out_dir_analysis, paste0(name, "_confusionMatrix.Rdata"))
    save(all_info, hla_info, len_info, single_info, file = cm_output_file)
    
    # Cleanup memory
    rm(temp_env, all_data, all_labeled, all_info, hla_info, len_info, single_info)
    gc(verbose = FALSE)
    
    return(TRUE)
}

# 7. Parallel Execution
num_cores <- 20 
cat(sprintf("[%s] Launching mclapply with %d cores...\n", Sys.time(), num_cores))

# Execute processing over the strictly defined task list
results <- mclapply(tasks, process_task, mc.cores = num_cores, mc.preschedule = FALSE)

cat(sprintf("[%s] >>> Labeling & Metrics Pipeline Completed Successfully.\n", Sys.time()))