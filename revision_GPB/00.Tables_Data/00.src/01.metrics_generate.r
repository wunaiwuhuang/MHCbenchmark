################################################################
# Script: 01.metrics_generate.r
# Description: Consolidate AUROC, AUPRC, and confusion matrix metrics 
#              across different tools and folds (1_vs_1, 1_vs_4, 1_vs_9).
#              Outputs a formatted summary CSV table.
# Author: Guojia Wu
################################################################

library(data.table)
library(dplyr)
library(pROC)
library(PRROC)

# ===================================================================
# 1. Configuration & Setup
# ===================================================================

# Define target folds
folds <- c("1_vs_1", "1_vs_4", "1_vs_9", "1_vs_99")

# Define paths
path_input_base <- "/data1/wuguojia/data/mhc_benchmark/revision/04.result_analysis"
path_output_dir <- "/home/wuguojia/biocode/mhc_benchmark/revision_GPB/00.Tables_Data/Tables"

# Ensure output directory exists (creates it if missing)
if (!dir.exists(path_output_dir)) {
    dir.create(path_output_dir, recursive = TRUE, showWarnings = FALSE)
    cat(sprintf("[%s] Created output directory: %s\n", Sys.time(), path_output_dir))
}

# Define formal tool name mapping
name_mapping <- c(
    "stmhcpan"         = "STMHCpan",
    "bigmhc"           = "BigMHC",
    "capsnetmhc_an"    = "CapsNet-MHC_AN",
    "mhcflurry_ps"     = "MHCflurry2.0_PS",
    "netmhcpan_el"     = "NetMHCpan4.1_EL",
    "mhcflurry_ba"     = "MHCflurry2.0_BA",
    "transphla"        = "TransPHLA",
    "netmhccons"       = "NetMHCcons1.1",
    "netmhcpan_ba"     = "NetMHCpan4.1_BA",
    "mixmhcpred"       = "MixMHCpred3.0",
    "netmhcstabpan"    = "NetMHCstabpan1.0",
    "acme"             = "ACME",
    "consensus"        = "IEDBconsensus2.18",
    "deephlapan"       = "DeepHLApan",
    "deepattentionpan" = "DeepAttentionpan",
    "capsnetmhc_ie"    = "CapsNet-MHC_IE",
    "deepnetbim"       = "DeepNetBim"
)

cat(sprintf("[%s] >>> Starting metrics compilation pipeline...\n", Sys.time()))

# ===================================================================
# 2. Data Extraction
# ===================================================================

# Initialize an empty list to store all row records
results_list <- list()

for (fold in folds) {
    fold_dir <- file.path(path_input_base, fold)
    
    if (!dir.exists(fold_dir)) {
        cat(sprintf("[%s] WARNING: Directory for fold %s not found. Skipping.\n", Sys.time(), fold))
        next
    }
    
    cat(sprintf("[%s] Processing fold: %s\n", Sys.time(), fold))
    
    # Identify unique tools in this fold by finding all analysis files
    analysis_files <- list.files(fold_dir, pattern = "_analysis\\.Rdata$", full.names = TRUE)
    
    for (ana_file in analysis_files) {
        # Extract base tool name
        tool_raw_name <- gsub("_analysis\\.Rdata$", "", basename(ana_file))
        cm_file <- file.path(fold_dir, paste0(tool_raw_name, "_confusionMatrix.Rdata"))
        
        # Check if corresponding confusion matrix file exists
        if (!file.exists(cm_file)) {
            cat(sprintf("[%s] WARNING: Confusion matrix file missing for %s in fold %s. Skipping tool.\n", 
                        Sys.time(), tool_raw_name, fold))
            next
        }
        
        # -----------------------------------------------------------
        # Use isolated environments to prevent object overwriting
        # (Both Rdata files contain an object named 'all_info')
        # -----------------------------------------------------------
        env_ana <- new.env()
        env_cm  <- new.env()
        
        load(ana_file, envir = env_ana)
        load(cm_file, envir = env_cm)
        
        # Extract AUROC and AUPRC (handling potential PRROC/pROC structure variations safely)
        auroc_val <- NA_real_
        auprc_val <- NA_real_
        
        if (!is.null(env_ana$all_info$auroc)) {
            auroc_val <- as.numeric(env_ana$all_info$auroc$auc)
        }
        if (!is.null(env_ana$all_info$auprc)) {
            auprc_val <- as.numeric(env_ana$all_info$auprc$auc.integral)
        }
        
        # Extract Confusion Matrix metrics
        cm_metrics <- env_cm$all_info
        
        # Append to results
        metrics_row <- data.frame(
            Fold          = fold,
            Tool_Raw      = tool_raw_name,
            AUROC         = auroc_val,
            AUPRC         = auprc_val,
            Sensitivity   = cm_metrics$sensitivity,
            Specificity   = cm_metrics$specificity,
            Precision     = cm_metrics$precision,
            F1_Score      = cm_metrics$f1_score,
            Accuracy      = cm_metrics$accuracy,
            MCC           = cm_metrics$mcc,
            Comprehensive = cm_metrics$comprehensive,
            stringsAsFactors = FALSE
        )
        
        results_list[[length(results_list) + 1]] <- metrics_row
        
        # Clean up environments to free memory
        rm(env_ana, env_cm)
    }
}

# ===================================================================
# 3. Formatting & Export
# ===================================================================

cat(sprintf("[%s] Aggregating data and applying tool name mappings...\n", Sys.time()))

# Combine all lists into a single dataframe
final_df <- bind_rows(results_list)

# Map the raw names to the formal names
final_df <- final_df %>%
    mutate(
        Tool = ifelse(Tool_Raw %in% names(name_mapping), 
                      name_mapping[Tool_Raw], 
                      Tool_Raw) # Fallback to raw name if not in mapping
    ) %>%
    # Reorder columns for readability: Tool, Fold, then metrics
    select(Tool, Fold, AUROC, AUPRC, Sensitivity, Specificity, Precision, F1_Score, Accuracy, MCC, Comprehensive) %>%
    arrange(Fold, desc(Comprehensive)) # Optional: sort by fold, then by best comprehensive score

# Save to CSV
output_csv <- file.path(path_output_dir, "metrics_summary_all_folds.csv")
write.csv(final_df, file = output_csv, row.names = FALSE, quote = FALSE)

cat(sprintf("[%s] >>> Pipeline Complete! Results saved to: %s\n", Sys.time(), output_csv))