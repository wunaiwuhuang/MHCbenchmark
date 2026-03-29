################################################################
# Script: 02.Bootstrap_table_generate.r
# Description: Standardize tool names across bootstrap result CSVs,
#              sort them logically by strata, and export them to 
#              the final manuscript tables directory.
# Author: Guojia Wu
################################################################

library(dplyr)

# ===================================================================
# 1. Configuration & Setup
# ===================================================================

# Define input and output paths
path_input_dir <- "/data1/wuguojia/data/mhc_benchmark/revision/05.result_visualize/Bootstrap_result"
path_output_dir <- "/home/wuguojia/biocode/mhc_benchmark/revision_GPB/00.Tables_Data/Tables"

# Ensure output directory exists
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

# Helper function to map names safely, falling back to original if not found
map_tool_name <- function(raw_names) {
    ifelse(raw_names %in% names(name_mapping), name_mapping[raw_names], raw_names)
}

cat(sprintf("[%s] >>> Starting Bootstrap Table Generation...\n", Sys.time()))

# ===================================================================
# 2. Process File 01: Individual Metrics
# ===================================================================
file_01_name <- "01_Individual_Metrics_with_CI.csv"
file_01_in <- file.path(path_input_dir, file_01_name)
file_01_out <- file.path(path_output_dir, file_01_name)

if (file.exists(file_01_in)) {
    cat(sprintf("[%s] Processing: %s\n", Sys.time(), file_01_name))
    df_01 <- read.csv(file_01_in, stringsAsFactors = FALSE)
    
    # Map 'Tool' column and sort logically for supplementary tables
    df_01 <- df_01 %>% 
        mutate(Tool = map_tool_name(Tool)) %>%
        arrange(Fold, stratum_type, stratum_name, desc(AUROC_Mean)) # Sort by highest AUROC within each stratum
    
    write.csv(df_01, file = file_01_out, row.names = FALSE, quote = TRUE)
    cat(sprintf("[%s] Successfully saved mapped %s\n", Sys.time(), file_01_name))
} else {
    cat(sprintf("[%s] WARNING: %s not found. Skipping.\n", Sys.time(), file_01_name))
}

# ===================================================================
# 3. Process File 02: Statistical Testing Delta AUC
# ===================================================================
file_02_name <- "02_Statistical_Testing_Delta_AUC.csv"
file_02_in <- file.path(path_input_dir, file_02_name)
file_02_out <- file.path(path_output_dir, file_02_name)

if (file.exists(file_02_in)) {
    cat(sprintf("[%s] Processing: %s\n", Sys.time(), file_02_name))
    df_02 <- read.csv(file_02_in, stringsAsFactors = FALSE)
    
    # Map columns and sort logically
    df_02 <- df_02 %>% 
        mutate(
            Reference_Tool = map_tool_name(Reference_Tool),
            Compared_Tool  = map_tool_name(Compared_Tool)
        ) %>%
        arrange(Fold, Stratum_Type, Stratum_Name, desc(Delta_AUC)) # Sort by effect size
    
    write.csv(df_02, file = file_02_out, row.names = FALSE, quote = TRUE)
    cat(sprintf("[%s] Successfully saved mapped %s\n", Sys.time(), file_02_name))
} else {
    cat(sprintf("[%s] WARNING: %s not found. Skipping.\n", Sys.time(), file_02_name))
}

# ===================================================================
# 4. Process File 03: Tool Stability Across Folds
# ===================================================================
file_03_name <- "03_Tool_Stability_Across_Folds.csv"
file_03_in <- file.path(path_input_dir, file_03_name)
file_03_out <- file.path(path_output_dir, file_03_name)

if (file.exists(file_03_in)) {
    cat(sprintf("[%s] Processing: %s\n", Sys.time(), file_03_name))
    df_03 <- read.csv(file_03_in, stringsAsFactors = FALSE)
    
    # Map 'Tool' column (Stability is already sorted by CV% from previous step, but we can enforce it)
    df_03 <- df_03 %>% 
        mutate(Tool = map_tool_name(Tool)) %>%
        arrange(AUROC_CV_Across_Folds)
    
    write.csv(df_03, file = file_03_out, row.names = FALSE, quote = TRUE)
    cat(sprintf("[%s] Successfully saved mapped %s\n", Sys.time(), file_03_name))
} else {
    cat(sprintf("[%s] WARNING: %s not found. Skipping.\n", Sys.time(), file_03_name))
}

cat(sprintf("[%s] >>> Bootstrap Table Generation Complete!\n", Sys.time()))