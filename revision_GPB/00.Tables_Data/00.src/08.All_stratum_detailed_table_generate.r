################################################################
# Script: 08.All_stratum_detailed_table_generate.r
# Description: Extract AUROC, AUPRC, and Confusion Matrix metrics 
#              from all strata, generate a comprehensive tidy table 
#              and a highly readable summary wide table for publication.
# Target Journal: Genomics, Proteomics & Bioinformatics (GPB)
################################################################

library(data.table)
library(dplyr)
library(tidyr)
library(stringr)

# ==============================================================================
# 1. Environment & Path Configuration
# ==============================================================================
path_analysis <- "/data1/wuguojia/data/mhc_benchmark/revision/04.result_analysis"
path_output_dir <- "/home/wuguojia/biocode/mhc_benchmark/revision_GPB/00.Tables_Data/Tables"

if (!dir.exists(path_output_dir)) {
    dir.create(path_output_dir, recursive = TRUE)
}

# Formal Tool Names Mapping
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

# Helper functions for safe extraction from ROC/PRC objects
safe_auc <- function(roc_obj) {
    if (is.null(roc_obj) || inherits(roc_obj, "try-error")) return(NA_real_)
    return(as.numeric(roc_obj$auc))
}

safe_prc <- function(prc_obj) {
    if (is.null(prc_obj) || inherits(prc_obj, "try-error")) return(NA_real_)
    return(as.numeric(prc_obj$auc.integral))
}

# ==============================================================================
# 2. Data Extraction Execution
# ==============================================================================
folds <- list.dirs(path_analysis, full.names = FALSE, recursive = FALSE)
valid_folds <- folds[grepl("_vs_", folds) & nchar(folds) > 0]

master_list <- list()

cat(sprintf("[%s] >>> Starting data aggregation across %d folds.\n", Sys.time(), length(valid_folds)))

for (fold in valid_folds) {
    fold_dir <- file.path(path_analysis, fold)
    files_ana <- list.files(fold_dir, pattern = "_analysis\\.Rdata$", full.names = TRUE)
    
    for (file_ana in files_ana) {
        tool_base <- gsub("_analysis\\.Rdata$", "", basename(file_ana))
        file_cm <- file.path(fold_dir, paste0(tool_base, "_confusionMatrix.Rdata"))
        
        # Skip if formal name doesn't exist or CM file is missing
        if (!(tool_base %in% names(name_mapping))) next
        if (!file.exists(file_cm)) {
            cat(sprintf("[%s] Warning: Missing CM file for %s in fold %s.\n", Sys.time(), tool_base, fold))
            next
        }
        
        tool_formal <- name_mapping[[tool_base]]
        cat(sprintf("[%s] Processing: %s | Fold: %s\n", Sys.time(), tool_formal, fold))
        
        # Load Data in isolated environments
        env_ana <- new.env()
        env_cm <- new.env()
        load(file_ana, envir = env_ana)
        load(file_cm, envir = env_cm)
        
        # --- A. Overall Stratum ---
        if (!is.null(env_cm$all_info)) {
            df_overall <- as.data.table(env_cm$all_info)
            df_overall[, `:=`(
                Tool = tool_formal, Fold = fold, 
                Stratum_Category = "Overall", Stratum_Name = "Overall",
                AUROC = safe_auc(env_ana$all_info$auroc),
                AUPRC = safe_prc(env_ana$all_info$auprc)
            )]
            master_list[[length(master_list) + 1]] <- df_overall
        }
        
        # --- B. Length Stratum ---
        if (!is.null(env_cm$len_info) && nrow(env_cm$len_info) > 0) {
            df_len <- as.data.table(env_cm$len_info)
            # Match names like "netmhcpan_el_8"
            df_len[, AUROC := sapply(antigen_peptide_length, function(l) safe_auc(env_ana$len_info$auroc[[paste0(tool_base, "_", l)]]))]
            df_len[, AUPRC := sapply(antigen_peptide_length, function(l) safe_prc(env_ana$len_info$auprc[[paste0(tool_base, "_", l)]]))]
            setnames(df_len, "antigen_peptide_length", "Stratum_Name")
            df_len[, Stratum_Name := as.character(Stratum_Name)]
            df_len[, `:=`(Tool = tool_formal, Fold = fold, Stratum_Category = "Length")]
            master_list[[length(master_list) + 1]] <- df_len
        }
        
        # --- C. Allele Stratum ---
        if (!is.null(env_cm$hla_info) && nrow(env_cm$hla_info) > 0) {
            df_hla <- as.data.table(env_cm$hla_info)
            df_hla[, AUROC := sapply(allele, function(a) safe_auc(env_ana$hla_info$auroc[[paste0(tool_base, "_", a)]]))]
            df_hla[, AUPRC := sapply(allele, function(a) safe_prc(env_ana$hla_info$auprc[[paste0(tool_base, "_", a)]]))]
            setnames(df_hla, "allele", "Stratum_Name")
            df_hla[, `:=`(Tool = tool_formal, Fold = fold, Stratum_Category = "Allele")]
            master_list[[length(master_list) + 1]] <- df_hla
        }
        
        # --- D. Single Stratum (Allele + Length) ---
        if (!is.null(env_cm$single_info) && nrow(env_cm$single_info) > 0) {
            df_single <- as.data.table(env_cm$single_info)
            dt_ana_auroc <- as.data.table(env_ana$single_info$auroc)
            dt_ana_auprc <- as.data.table(env_ana$single_info$auprc)
            
            # Left join AUC and AUPRC
            df_single <- merge(df_single, dt_ana_auroc, by.x = c("allele", "antigen_peptide_length"), by.y = c("allele", "peptide_length"), all.x = TRUE)
            df_single <- merge(df_single, dt_ana_auprc, by.x = c("allele", "antigen_peptide_length"), by.y = c("allele", "peptide_length"), all.x = TRUE)
            
            # 【核心修复点】：把 merge 进来的小写 auroc 和 auprc 强制统一为大写，对齐所有列名
            setnames(df_single, old = c("auroc", "auprc"), new = c("AUROC", "AUPRC"), skip_absent = TRUE)
            
            df_single[, Stratum_Name := paste0(allele, "_", antigen_peptide_length)]
            df_single[, c("allele", "antigen_peptide_length") := NULL]
            df_single[, `:=`(Tool = tool_formal, Fold = fold, Stratum_Category = "Single")]
            master_list[[length(master_list) + 1]] <- df_single
        }
        
        rm(env_ana, env_cm)
    }
}

# Combine all extracted data
dt_final <- rbindlist(master_list, use.names = TRUE, fill = TRUE)

# 【核心修复点】：把之前的混淆矩阵小写指标全部拉平为首字母大写
setnames(dt_final, 
         old = c("accuracy", "sensitivity", "specificity", "precision", "recall", "f1_score", "mcc", "comprehensive"),
         new = c("Accuracy", "Sensitivity", "Specificity", "Precision", "Recall", "F1_Score", "MCC", "Comprehensive"),
         skip_absent = TRUE)

# Standardize column ordering for the Tidy Table
metrics_cols <- c("AUROC", "AUPRC", "Sensitivity", "Specificity", "Precision", "Recall", "F1_Score", "Accuracy", "MCC", "Comprehensive")
# Exclude Recall if it's identical to Sensitivity
if("Recall" %in% names(dt_final)) dt_final[, Recall := NULL] 
metrics_cols <- setdiff(metrics_cols, "Recall")

col_order <- c("Tool", "Fold", "Stratum_Category", "Stratum_Name", "TP", "TN", "FP", "FN", metrics_cols)
setcolorder(dt_final, intersect(col_order, names(dt_final)))

# ==============================================================================
# 3. Output 1: Save Detailed Tidy Table (For Supplementary Data / Excel Pivots)
# ==============================================================================
file_tidy <- file.path(path_output_dir, "Table_S_Detailed_Metrics_All_Strata.csv")
fwrite(dt_final, file_tidy)
cat(sprintf("[%s] >>> Success: Detailed Tidy table saved to %s\n", Sys.time(), file_tidy))

# ==============================================================================
# 4. Output 2: Generate & Save Two-Level Index Summary Table (For Manuscript)
# ==============================================================================
# Concept: Row = Tool & Metric | Col = Fold & Stratum_Category (Averaged)

# Melt the metrics to long format
dt_long <- melt(dt_final, 
                id.vars = c("Tool", "Fold", "Stratum_Category", "Stratum_Name"),
                measure.vars = metrics_cols,
                variable.name = "Metric", value.name = "Value")

# Calculate Macro-Average for Length, Allele, and Single strata
dt_summary <- dt_long[, .(Mean_Value = mean(Value, na.rm = TRUE)), 
                      by = .(Tool, Metric, Fold, Stratum_Category)]

# Create the two-level column name: Fold_StratumCategory
dt_summary[, Fold_Stratum := paste(Fold, Stratum_Category, sep = " | ")]

# Dcast to wide matrix: Rows (Tool, Metric) ~ Cols (Fold_Stratum)
dt_wide <- dcast(dt_summary, Tool + Metric ~ Fold_Stratum, value.var = "Mean_Value")

# Ensure Tool order matches your formal definition mapping
dt_wide$Tool <- factor(dt_wide$Tool, levels = unname(name_mapping))
dt_wide <- dt_wide[order(Tool, Metric)]

# Clean up NAs
dt_wide[is.na(dt_wide)] <- NA

file_wide <- file.path(path_output_dir, "Table_S_Summary_Metrics_Matrix.csv")
fwrite(dt_wide, file_wide)
cat(sprintf("[%s] >>> Success: Summary Wide table saved to %s\n", Sys.time(), file_wide))

cat("#------------------------------------------------------------------\n")
cat("Pipeline finished. Both Detailed and Summary tables have been generated.\n")