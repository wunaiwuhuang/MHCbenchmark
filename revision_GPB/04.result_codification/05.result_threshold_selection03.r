################################################################
# Script: 05.result_threshold_selection03.r
# Description: Calculate the comprehensive metric to find the optimal global 
#              threshold, evaluate metric stability across thresholds, and 
#              generate reviewer response.
# Author: Guojia Wu (Refactored/Assisted)
################################################################

library(data.table)
library(dplyr)
library(argparse)

# 1. Parse Arguments
parser <- ArgumentParser(description='Find optimal threshold and evaluate stability')
parser$add_argument('fold', nargs = '?', default = '1_vs_9', 
                    help = 'Fold name, e.g., 1_vs_4, 1_vs_9 (Default: 1_vs_9)')
opt <- parser$parse_args()
fold <- opt$fold

cat(sprintf("[%s] >>> Starting Optimal Threshold & Stability Selection for fold: %s\n", Sys.time(), fold))

# 2. Path Definitions
path_base <- "/data1/wuguojia/data/mhc_benchmark/revision/03.result_codification"
path_input <- file.path(path_base, "threshold_selection")
path_final <- file.path(path_input, "final")

if (!dir.exists(path_final)) {
    dir.create(path_final, recursive = TRUE)
    cat(sprintf("[%s] Created final output directory: %s\n", Sys.time(), path_final))
}

# 3. Tool Binding Definitions
reverse_tools <- c("netmhcpan_el", "mhcflurry_ba", "netmhccons", "netmhcpan_ba", 
                   "mixmhcpred", "netmhcstabpan", "consensus", "capsnetmhc_ie", 
                   "deepattentionpan")

# 4. Find all target files
files <- list.files(path_input, pattern = "_result_list\\.Rdata$", full.names = TRUE)

if (length(files) == 0) {
    stop(sprintf("[%s] Error: No files found in %s\n", Sys.time(), path_input))
}

cat(sprintf("[%s] Found %d tool result files to process.\n", Sys.time(), length(files)))

# 5. Core Loop to find optimal thresholds and evaluate stability
final_results <- data.frame()
stability_results <- data.frame()

for (file_path in files) {
    name <- gsub("_result_list\\.Rdata$", "", basename(file_path))
    cat(sprintf("[%s] Processing tool: %s\n", Sys.time(), name))
    
    # Load the data frame (contains variable final_result_df)
    temp_env <- new.env()
    load(file_path, envir = temp_env)
    df <- temp_env$final_result_df
    
    # Handle NA values (convert to 0 to penalize invalid thresholds)
    df[is.na(df)] <- 0
    
    # Calculate Comprehensive Score
    # Formula: 0.4 * Normalized_MCC + 0.3 * F1 + 0.3 * Balanced_Accuracy
    df <- df %>%
        mutate(
            balanced_accuracy = (sensitivity + specificity) / 2,
            normalized_mcc = (mcc + 1) / 2,
            comprehensive = 0.4 * normalized_mcc + 0.3 * f1_score + 0.3 * balanced_accuracy
        )
    
    # Find the optimal point
    max_comp_score <- max(df$comprehensive, na.rm = TRUE)
    optimal_idx <- which.max(df$comprehensive)
    optimal_row <- df[optimal_idx, ]
    
    # Determine the binding definition string
    if (name %in% reverse_tools) {
        definition <- "Score <= Threshold is Positive"
    } else {
        definition <- "Score >= Threshold is Positive"
    }
    
    # -----------------------------------------------------------------
    # Evaluate Stability
    # 1. Robustness_Span_90: Proportion of thresholds that yield a 
    #    comprehensive score >= 90% of the maximum score.
    # 2. Global_CV: Coefficient of Variation (SD / Mean) of comprehensive scores.
    # -----------------------------------------------------------------
    robust_count <- sum(df$comprehensive >= (0.9 * max_comp_score))
    total_count <- nrow(df)
    robustness_span_90 <- robust_count / total_count
    
    mean_comp <- mean(df$comprehensive, na.rm = TRUE)
    sd_comp <- sd(df$comprehensive, na.rm = TRUE)
    global_cv <- ifelse(mean_comp == 0, NA, sd_comp / mean_comp)
    
    # Format the main summary row
    tool_summary <- data.frame(
        Tool = name,
        Optimal_Threshold = optimal_row$threshold,
        Definition = definition,
        Comprehensive_Score = round(optimal_row$comprehensive, 4),
        MCC = round(optimal_row$mcc, 4),
        F1_Score = round(optimal_row$f1_score, 4),
        Accuracy = round(optimal_row$accuracy, 4),
        Sensitivity = round(optimal_row$sensitivity, 4),
        Specificity = round(optimal_row$specificity, 4),
        Precision = round(optimal_row$precision, 4)
    )
    final_results <- rbind(final_results, tool_summary)
    
    # Format the stability summary row
    tool_stability <- data.frame(
        Tool = name,
        Max_Comprehensive_Score = round(max_comp_score, 4),
        Mean_Comprehensive_Score = round(mean_comp, 4),
        SD_Comprehensive_Score = round(sd_comp, 4),
        Global_CV = round(global_cv, 4),
        Robustness_Span_90 = round(robustness_span_90, 4)
    )
    stability_results <- rbind(stability_results, tool_stability)
    
    rm(temp_env, df, optimal_row)
}

# 6. Output CSVs
csv_summary_file <- file.path(path_final, "optimal_thresholds_summary.csv")
write.csv(final_results, csv_summary_file, row.names = FALSE)
cat(sprintf("[%s] >>> Saved: %s\n", Sys.time(), csv_summary_file))

csv_stability_file <- file.path(path_final, "threshold_stability_metrics.csv")
write.csv(stability_results, csv_stability_file, row.names = FALSE)
cat(sprintf("[%s] >>> Saved: %s\n", Sys.time(), csv_stability_file))


# 7. Generate Reviewer Response and Explanations
response_text <- "
====================================================================
Response to Reviewer Comment (1): Class-thresholding strategy may inflate metrics
====================================================================

We sincerely thank the reviewer for this insightful comment. We agree that enforcing a median-based class-thresholding strategy within each stratum could artificially enforce a 50/50 class balance, potentially distorting threshold-dependent metrics and complicating cross-tool comparability, particularly in highly imbalanced datasets like MHC-peptide binding.

To address this, we have systematically revised our thresholding evaluation:

1. Emphasis on Threshold-Free Metrics: 
As the primary measure of model performance, we emphasized AUROC and AUPRC. AUPRC is highly sensitive to class prevalence and provides an unbiased summary statistic for the imbalanced nature of our data.

2. Global Operating Point via 'Comprehensive Score':
For analyses requiring binarized summaries, we abandoned the stratum-specific median approach. Instead, we tested 1,000 systematically selected candidate thresholds for each tool across the entire dataset to establish a single, globally optimal operating point. 

To prevent metric inflation via class imbalance, we defined a 'Comprehensive Score' to select this optimal point:
Comprehensive Score = 0.4 * Normalized_MCC + 0.3 * F1_Score + 0.3 * Balanced_Accuracy
- Normalized MCC (40%): Recognized as the most robust metric for imbalanced classification.
- F1-Score (30%): Ensures balance between Precision and Recall for the minority positive class.
- Balanced Accuracy (30%): The mean of Sensitivity and Specificity, preventing standard Accuracy inflation caused by negative sample dominance.

3. Evaluation of Threshold Stability (Robustness):
A reliable bioinformatics tool should not only peak at a specific threshold but also maintain robust performance across a reasonable threshold range. To evaluate this, we introduced two stability metrics:
- Robustness_Span_90: The proportion of tested thresholds that maintain a Comprehensive Score at or above 90% of the tool's maximum score. A higher value indicates a wider 'sweet spot' and higher tolerance for user-defined threshold variations.
- Global_CV (Coefficient of Variation): Evaluates the overall fluctuation of performance across all candidate thresholds.

The optimal thresholds, associated metrics, and stability evaluations are now detailed in the supplementary files, providing a highly rigorous and comparable benchmark.
"

txt_response_file <- file.path(path_final, "reviewer_response_and_methods.txt")
writeLines(response_text, txt_response_file)
cat(sprintf("[%s] >>> Saved: %s\n", Sys.time(), txt_response_file))

cat(sprintf("[%s] >>> All tasks completed successfully.\n", Sys.time()))