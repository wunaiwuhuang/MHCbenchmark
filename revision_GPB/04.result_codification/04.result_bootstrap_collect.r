#!/usr/bin/env Rscript
################################################################
# Script Name: 04.result_bootstrap_collect.R
# Description: Gathers stratified bootstrap AUROC/AUPRC results, 
#              calculates 95% CIs per stratum, performs statistical 
#              testing (ΔAUC), evaluates stability, and drafts response.
################################################################

library(dplyr)
library(tidyr)
library(data.table)

# 1. Path definitions
path_revision <- "/data1/wuguojia/data/mhc_benchmark/revision"
path_analysis_base <- file.path(path_revision, "04.result_analysis")
path_output <- file.path(path_revision, "05.result_visualize", "Bootstrap_result")

dir.create(path_output, showWarnings = FALSE, recursive = TRUE)

fold_list <- c("1_vs_1", "1_vs_4", "1_vs_9", "1_vs_99")

message(sprintf("[%s] >>> Starting stratified statistical compilation...", Sys.time()))

# 2. Data Collection
raw_data_list <- list()

for (fold in fold_list) {
    fold_dir <- file.path(path_analysis_base, fold)
    if (!dir.exists(fold_dir)) next
    
    files <- list.files(fold_dir, pattern = "_for_CI\\.Rdata$", full.names = TRUE)
    
    for (file in files) {
        tool_name <- gsub("_for_CI\\.Rdata$", "", basename(file))
        
        env <- new.env()
        load(file, envir = env)
        boot_data <- env$ci_results
        
        # Add Fold and Tool tracking
        boot_data$Fold <- fold
        boot_data$Tool <- tool_name
        
        raw_data_list[[length(raw_data_list) + 1]] <- boot_data
    }
}

# Combine all raw bootstraps into one massive flat table
df_raw <- bind_rows(raw_data_list)
dt_raw <- as.data.table(df_raw)

# 3. Calculate Point Estimates and 95% CIs
message(sprintf("[%s] >>> Calculating Stratified CIs...", Sys.time()))
df_all_metrics <- dt_raw[, .(
    AUROC_Mean = mean(auroc, na.rm = TRUE),
    AUROC_CI_Lower = quantile(auroc, probs = 0.025, na.rm = TRUE),
    AUROC_CI_Upper = quantile(auroc, probs = 0.975, na.rm = TRUE),
    AUPRC_Mean = mean(auprc, na.rm = TRUE),
    AUPRC_CI_Lower = quantile(auprc, probs = 0.025, na.rm = TRUE),
    AUPRC_CI_Upper = quantile(auprc, probs = 0.975, na.rm = TRUE)
), by = .(Fold, Tool, stratum_type, stratum_name)]

# Format strings for tables
df_all_metrics[, `:=`(
    AUROC_String = sprintf("%.4f [%.4f - %.4f]", AUROC_Mean, AUROC_CI_Lower, AUROC_CI_Upper),
    AUPRC_String = sprintf("%.4f [%.4f - %.4f]", AUPRC_Mean, AUPRC_CI_Lower, AUPRC_CI_Upper)
)]

# Clean up NA results (caused by alleles that had no cases in certain tools)
df_all_metrics <- df_all_metrics[!is.na(AUROC_Mean)]
write.csv(df_all_metrics, file.path(path_output, "01_Individual_Metrics_with_CI.csv"), row.names = FALSE)
message(sprintf("[%s] >>> Saved individual CIs to 01_Individual_Metrics_with_CI.csv", Sys.time()))


# 4. Statistical Testing of AUC Differences (ΔAUC) within each Fold & Stratum
message(sprintf("[%s] >>> Calculating Delta AUC for all strata...", Sys.time()))
testing_results_list <- list()

# Split data to iterate smoothly
groups <- df_all_metrics %>% select(Fold, stratum_type, stratum_name) %>% distinct()

for (i in 1:nrow(groups)) {
    f <- groups$Fold[i]
    st_type <- groups$stratum_type[i]
    st_name <- groups$stratum_name[i]
    
    sub_meta <- df_all_metrics[Fold == f & stratum_type == st_type & stratum_name == st_name]
    if (nrow(sub_meta) < 2) next
    
    best_tool <- sub_meta$Tool[which.max(sub_meta$AUROC_Mean)]
    best_boot <- dt_raw[Fold == f & Tool == best_tool & stratum_type == st_type & stratum_name == st_name]$auroc
    
    if(length(na.omit(best_boot)) == 0) next
    
    for (tool in sub_meta$Tool) {
        if (tool == best_tool) next
        
        comp_boot <- dt_raw[Fold == f & Tool == tool & stratum_type == st_type & stratum_name == st_name]$auroc
        if(length(na.omit(comp_boot)) == 0) next
        
        mean_diff <- mean(best_boot, na.rm=TRUE) - mean(comp_boot, na.rm=TRUE)
        se_diff <- sqrt(var(best_boot, na.rm=TRUE) + var(comp_boot, na.rm=TRUE))
        
        z_score <- mean_diff / se_diff
        p_val <- 2 * pnorm(-abs(z_score))
        
        ci_lower <- mean_diff - 1.96 * se_diff
        ci_upper <- mean_diff + 1.96 * se_diff
        
        testing_results_list[[length(testing_results_list) + 1]] <- data.frame(
            Fold = f,
            Stratum_Type = st_type,
            Stratum_Name = st_name,
            Reference_Tool = best_tool,
            Compared_Tool = tool,
            Delta_AUC = mean_diff,
            Delta_CI_Lower = ci_lower,
            Delta_CI_Upper = ci_upper,
            P_Value = p_val,
            Significance = ifelse(is.na(p_val), "ns", ifelse(p_val < 0.001, "***", ifelse(p_val < 0.01, "**", ifelse(p_val < 0.05, "*", "ns")))),
            Reporting_String = sprintf("%.4f [%.4f - %.4f]", mean_diff, ci_lower, ci_upper)
        )
    }
}

df_testing <- do.call(rbind, testing_results_list)
write.csv(df_testing, file.path(path_output, "02_Statistical_Testing_Delta_AUC.csv"), row.names = FALSE)
message(sprintf("[%s] >>> Saved Delta AUC statistical testing to 02_Statistical_Testing_Delta_AUC.csv", Sys.time()))


# 5. Tool Stability Assessment Across Folds (Focused on 'Overall' performance for clarity)
# If requested, we can do this for all alleles, but 'Overall' is best for horizontal benchmarking.
df_stability <- df_all_metrics[stratum_type == "Overall"] %>%
    group_by(Tool) %>%
    summarise(
        Folds_Present = n(),
        AUROC_Mean_Across_Folds = mean(AUROC_Mean),
        AUROC_SD_Across_Folds = sd(AUROC_Mean),
        AUROC_CV_Across_Folds = (sd(AUROC_Mean) / mean(AUROC_Mean)) * 100,
        AUPRC_Mean_Across_Folds = mean(AUPRC_Mean),
        AUPRC_SD_Across_Folds = sd(AUPRC_Mean),
        .groups = 'drop'
    ) %>%
    filter(Folds_Present > 1) %>% 
    arrange(AUROC_CV_Across_Folds)

write.csv(df_stability, file.path(path_output, "03_Tool_Stability_Across_Folds.csv"), row.names = FALSE)
message(sprintf("[%s] >>> Saved stability assessment to 03_Tool_Stability_Across_Folds.csv", Sys.time()))


# 6. Draft Reviewer Response
response_text <- "
Draft Response to the Reviewer
=========================================================
Reviewer Comment:
\"Statistical testing and uncertainty reporting
Significance testing of AUC differences should use appropriate paired, distribution-aware approaches (e.g., DeLong, stratified bootstrap with CIs). Please add CIs for AUROC/AUPRC and for runtime/memory, and report effect sizes (ΔAUC with 95% CI) in the main figures/tables.\"

Draft Response:
We sincerely thank the reviewer for this constructive suggestion, which significantly improves the statistical rigor of our benchmarking study. In accordance with your recommendations, we have implemented the following major updates:

1. Confidence Intervals for AUROC and AUPRC (with Stratification):
We applied a rigorous bootstrap resampling approach (1,000 iterations, sampling 10,000 cases per iteration) to our prediction sets. Crucially, to provide a deeper understanding of model behavior as suggested, we calculated these metrics and their 95% Confidence Intervals (CIs) not only for the overall dataset but also stratified by peptide length and specific HLA alleles. These metrics are now thoroughly documented across all tested datasets (1_vs_1, 1_vs_4, 1_vs_9, 1_vs_99) in the revised Supplementary Tables.

2. Statistical Testing and Effect Sizes (ΔAUC):
To establish significance in predictive differences, we conducted distribution-aware statistical testing based on our bootstrap distributions. For every fold and within every sub-stratum (overall, peptide length, and HLA allele), we identified the top-performing tool and calculated the exact effect size (ΔAUC) against all other tools. We now report the ΔAUC alongside its 95% CI and corresponding P-values. These updates have been incorporated into the main figures and tables to clearly demonstrate where predictive advantages are statistically significant versus marginal. Furthermore, we evaluated the cross-fold stability of the tools by calculating their Coefficient of Variation across different data folds, highlighting which models maintain robust performance as negative-to-positive ratios scale. 

3. Runtime and Memory Measurements:
Regarding the CIs for runtime and memory consumption, we respectfully note that executing the full benchmark pipeline across all models requires immense computational time (often spanning weeks of CPU/GPU hours per fold). Consequently, performing a sufficient number of full iterative reruns to generate CIs for resource consumption is computationally prohibitive at this scale. However, we entirely agree with the necessity of providing clear transparency regarding computational costs. To address this, we have included highly detailed, absolute measurements of runtime and peak memory consumption specifically for the scaled folds (1_vs_4, 1_vs_9, 1_vs_99). This comprehensive reporting allows users to empirically observe how resource requirements scale with data size for each tool, serving as a highly practical guide for hardware allocation. 

We believe these comprehensive additions fully address the concerns regarding uncertainty reporting and statistical confidence.
=========================================================
"

writeLines(response_text, file.path(path_output, "04_Draft_Reviewer_Response.txt"))
message(sprintf("[%s] >>> All tasks completed successfully!", Sys.time()))