#!/usr/bin/env Rscript
################################################################
# Script Name: 03.result_bootstrap_AUROC_and_AUPRC.R
# Description: Generates 1000 bootstrap samples (10,000 cases each).
#              Calculates AUROC/AUPRC for Overall, Peptide Length, 
#              and HLA Allele strata. 
#              Optimized to process ALL folds simultaneously with 50 cores.
################################################################

library(data.table)
library(dplyr)
library(tidyr)
library(pROC)      # AUROC
library(PRROC)     # AUPRC
library(parallel)  # For parallel processing

# 1. Path definitions
path_revision <- "/data1/wuguojia/data/mhc_benchmark/revision"
path_codify_base <- file.path(path_revision, "03.result_codification")
path_analysis_base <- file.path(path_revision, "04.result_analysis")

message(sprintf("[%s] >>> Starting universal bootstrap processing across all folds...", Sys.time()))

# Ensure base analysis directory exists
dir.create(path_analysis_base, showWarnings = FALSE, recursive = TRUE)

# Tools where a smaller affinity score means a better prediction
reverse <- c("netmhcpan_el", "mhcflurry_ba", "netmhccons", "netmhcpan_ba", 
             "mixmhcpred", "netmhcstabpan", "consensus", "capsnetmhc_ie", "deepattentionpan")

# Get ALL target files across ALL folds
files <- list.files(path_codify_base, pattern = "_no_threshold\\.Rdata$", recursive = TRUE, full.names = TRUE)

if (length(files) == 0) {
    stop("No '_no_threshold.Rdata' files found in the specified base directory.")
}

message(sprintf("[%s] >>> Found %d files across all folds. Starting parallel execution on 50 cores...", Sys.time(), length(files)))

# 2. Helper function to calculate metrics robustly
calc_metrics <- function(labels, scores) {
    pos_idx <- labels == "positive"
    neg_idx <- labels == "negative"
    
    # Need at least one positive and one negative case to calculate AUC
    if (sum(pos_idx) > 0 && sum(neg_idx) > 0) {
        # Force direction to avoid auto-detect errors in skewed bootstrap samples
        auroc <- tryCatch(as.numeric(pROC::roc(response = labels, predictor = scores, 
                                               levels = c("negative", "positive"), direction = "<", 
                                               quiet = TRUE)$auc), error = function(e) NA_real_)
        auprc <- tryCatch(PRROC::pr.curve(scores.class0 = scores[pos_idx], 
                                          scores.class1 = scores[neg_idx], curve = FALSE)$auc.integral, 
                          error = function(e) NA_real_)
        return(list(auroc = auroc, auprc = auprc))
    } else {
        return(list(auroc = NA_real_, auprc = NA_real_))
    }
}

# 3. Define the processing function for each file
process_tool_file <- function(filepath) {
    # Prevent data.table internal threading from colliding with mclapply forks
    setDTthreads(1) 
    
    # Extract tool name and fold name directly from the filepath
    name <- gsub("\\_no_threshold.Rdata", "", basename(filepath))
    fold <- basename(dirname(filepath)) 
    
    # Dynamically set paths for this specific tool/fold
    path_codify <- dirname(filepath)
    path_analysis <- file.path(path_analysis_base, fold)
    dir.create(path_analysis, showWarnings = FALSE, recursive = TRUE)
    
    log_prefix <- sprintf("[%s] [Fold: %s] [%s]", Sys.time(), fold, name)
    
    message(sprintf("%s Loading and preparing data...", log_prefix))
    env <- new.env()
    load(filepath, envir = env)
    
    # Convert to data.table for lightning-fast grouped operations
    dt <- as.data.table(do.call(rbind, env$tool_result))
    setnames(dt, "bind_result", "bind_result_base", skip_absent = TRUE)
    
    # Keep only necessary columns for stratification to save memory
    dt <- dt[, .(affinity, bind_result_base, antigen_peptide_length, allele)]
    
    # Standardize score direction (larger = better)
    if (name %in% reverse) {
        dt[, score_used := -affinity]
    } else {
        dt[, score_used := affinity]
    }
    
    message(sprintf("%s Starting 1000 bootstrap samplings with stratification...", log_prefix))
    
    metrics_res_list <- vector("list", 1000)
    bootstrap_raw_list <- vector("list", 1000)
    
    for (i in 1:1000) {
        idx <- sample(nrow(dt), 10000, replace = TRUE)
        boot_dt <- dt[idx]
        
        # Save raw bootstrap data
        bootstrap_raw_list[[i]] <- boot_dt[, .(affinity, bind_result_base, antigen_peptide_length, allele)]
        
        # 1. Overall Metrics
        ov <- boot_dt[, calc_metrics(bind_result_base, score_used)]
        ov[, `:=`(iteration = i, stratum_type = "Overall", stratum_name = "All")]
        
        # 2. Peptide Length Metrics
        len <- boot_dt[, calc_metrics(bind_result_base, score_used), by = .(stratum_name = as.character(antigen_peptide_length))]
        len[, `:=`(iteration = i, stratum_type = "Length")]
        
        # 3. HLA Allele Metrics
        alll <- boot_dt[, calc_metrics(bind_result_base, score_used), by = .(stratum_name = as.character(allele))]
        alll[, `:=`(iteration = i, stratum_type = "Allele")]
        
        # Combine all strata for this iteration
        metrics_res_list[[i]] <- rbindlist(list(ov, len, alll), use.names = TRUE, fill = TRUE)
    }
    
    # Save the 1000 iteration raw data
    boot_file <- file.path(path_codify, paste0(name, "_Bootstrap.Rdata"))
    save(bootstrap_raw_list, file = boot_file)
    
    # Save the calculated CI results across all strata
    ci_results <- rbindlist(metrics_res_list)
    analysis_file <- file.path(path_analysis, paste0(name, "_for_CI.Rdata"))
    save(ci_results, file = analysis_file)
    
    message(sprintf("%s Calculation complete.", log_prefix))
    return(TRUE)
}

# 4. Execute parallel processing
# Processing all files simultaneously across 50 cores
system.time({
    results <- mclapply(files, process_tool_file, mc.cores = 50, mc.preschedule = FALSE)
})

message(sprintf("[%s] >>> All processing finished successfully!", Sys.time()))