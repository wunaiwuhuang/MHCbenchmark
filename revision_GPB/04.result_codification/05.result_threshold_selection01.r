################################################################
# Script: 05.result_threshold_selection01.r
# Description: Generate 1000 candidate thresholds for each tool and 
#              save binary predictions to optimize threshold-dependent metrics.
# Author: Guojia Wu (Refactored/Assisted)
################################################################

library(data.table)
library(dplyr)
library(parallel)
library(argparse)

# 1. Parse Arguments (optional support for specific folders)
parser <- ArgumentParser(description='Process threshold selection for MHC benchmark tools')
parser$add_argument('fold', nargs = '?', default = '1_vs_9', 
                    help = 'Fold name, e.g., 1_vs_4, 1_vs_9 (Default: 1_vs_9)')
opt <- parser$parse_args()
fold <- opt$fold

cat(sprintf("[%s] >>> Starting Threshold Selection Pipeline for fold: %s\n", Sys.time(), fold))

# 2. Path Definitions
path_base <- "/data1/wuguojia/data/mhc_benchmark/revision/03.result_codification"
path_input <- file.path(path_base, fold)
path_output <- file.path(path_base, "threshold_selection")

# Create output directory if it does not exist
if (!dir.exists(path_output)) {
    dir.create(path_output, recursive = TRUE)
    cat(sprintf("[%s] Created output directory: %s\n", Sys.time(), path_output))
}

# 3. Tool specific configurations
reverse_tools <- c("netmhcpan_el", "mhcflurry_ba", "netmhccons", "netmhcpan_ba", 
                   "mixmhcpred", "netmhcstabpan", "consensus", "capsnetmhc_ie", 
                   "deepattentionpan")

# 4. Find all target files
files <- list.files(path_input, pattern = "_no_threshold\\.Rdata$", full.names = TRUE)

if (length(files) == 0) {
    stop(sprintf("[%s] Error: No files found in %s", Sys.time(), path_input))
}
cat(sprintf("[%s] Found %d files to process.\n", Sys.time(), length(files)))

# 5. Core Processing Function
process_tool_file <- function(file_path) {
    
    # Extract tool name from file path
    name <- gsub("_no_threshold\\.Rdata$", "", basename(file_path))
    cat(sprintf("[%s] [Process PID: %s] Started: %s\n", Sys.time(), Sys.getpid(), name))
    
    # Load data into an isolated environment to prevent variable collisions
    temp_env <- new.env()
    load(file_path, envir = temp_env)
    
    # Use data.table::rbindlist for extremely fast binding of large lists
    all_data <- data.table::rbindlist(temp_env$tool_result)
    
    # Ensure column name consistency (based on your refactored code)
    if("bind_result" %in% names(all_data)){
        setnames(all_data, "bind_result", "bind_result_base")
    }
    
    affinities <- all_data$affinity
    labels <- all_data$bind_result_base
    n_rows <- length(affinities)
    
    # ---------------------------------------------------------
    # Generate 1000 Candidate Thresholds
    # Strategy: Combine 500 quantiles (dense region coverage) 
    # and 500 linear steps (global bounds coverage)
    # ---------------------------------------------------------
    quant_thresh <- quantile(affinities, probs = seq(0, 1, length.out = 500), na.rm = TRUE)
    linear_thresh <- seq(min(affinities, na.rm = TRUE), max(affinities, na.rm = TRUE), length.out = 500)
    
    candidate_thresholds <- sort(unique(c(quant_thresh, linear_thresh)))
    
    # Downsample exactly to 1000 if unique length exceeds 1000
    if (length(candidate_thresholds) > 1000) {
        idx <- round(seq(1, length(candidate_thresholds), length.out = 1000))
        candidate_thresholds <- candidate_thresholds[idx]
    }
    n_thresh <- length(candidate_thresholds)
    
    # ---------------------------------------------------------
    # Calculate Binary Predictions
    # Optimization: Store as 'raw' (1 byte) instead of 'logical' (4 bytes)
    # This saves 75% of RAM during parallel execution and massive disk space.
    # ---------------------------------------------------------
    threshold_matrix <- matrix(raw(n_rows * n_thresh), nrow = n_rows, ncol = n_thresh)
    is_reverse <- name %in% reverse_tools
    
    for (j in seq_len(n_thresh)) {
        t <- candidate_thresholds[j]
        if (is_reverse) {
            # For reverse tools, smaller score means stronger binding
            threshold_matrix[, j] <- as.raw(affinities <= t)
        } else {
            # For normal tools, larger score means stronger binding
            threshold_matrix[, j] <- as.raw(affinities >= t)
        }
    }
    
    # ---------------------------------------------------------
    # Save Results
    # ---------------------------------------------------------
    output_file <- file.path(path_output, paste0(name, "_threshold_list.Rdata"))
    save(candidate_thresholds, threshold_matrix, labels, file = output_file)
    
    # Memory cleanup for parallel safety
    rm(temp_env, all_data, threshold_matrix, affinities, labels, quant_thresh, linear_thresh)
    gc(verbose = FALSE)
    
    cat(sprintf("[%s] [Process PID: %s] Finished: %s | Saved to %s\n", 
                Sys.time(), Sys.getpid(), name, basename(output_file)))
    
    return(TRUE)
}

# 6. Parallel Execution
# Configure for 20 CPU cores as requested
num_cores <- 20 
cat(sprintf("[%s] Launching mclapply with %d cores...\n", Sys.time(), num_cores))

# Execute. mc.preschedule = FALSE helps balance loads if some files are much larger
results <- mclapply(files, process_tool_file, mc.cores = num_cores, mc.preschedule = FALSE)

cat(sprintf("[%s] >>> Threshold Selection Pipeline Completed Successfully.\n", Sys.time()))