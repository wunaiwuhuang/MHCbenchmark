################################################################
# Script: 06.result_visualize_confusion_compare.r
# Description: Extract metrics across multiple folds (1:1, 1:4, 1:9) and 
#              generate a publication-ready comparison dot plot on A4 canvas.
# Author: Guojia Wu (Refactored/Assisted)
################################################################

library(data.table)
library(dplyr)
library(tidyr)
library(ggplot2)
library(parallel)
library(argparse)

# 1. Parse Arguments (Default is exactly what user requested)
parser <- ArgumentParser(description='Generate Multi-Fold Comparison Plot')
# parser$add_argument('folds', nargs = '*', default = c('1_vs_1', '1_vs_4', '1_vs_9'), help = 'List of folds to compare (Default: 1_vs_1 1_vs_4 1_vs_9)')
parser$add_argument('folds', nargs = '*', default = c('1_vs_1', '1_vs_4', '1_vs_9', '1_vs_99'), help = 'List of folds to compare (Default: 1_vs_1 1_vs_4 1_vs_9 1_vs_99)')
opt <- parser$parse_args()
target_folds <- opt$folds

cat(sprintf("[%s] >>> Starting Comparison Visualization for folds: %s\n", 
            Sys.time(), paste(target_folds, collapse = ", ")))

# 2. Path Definitions
path_base <- "/data1/wuguojia/data/mhc_benchmark/revision"
path_analysis <- file.path(path_base, "04.result_analysis")
path_visualize <- file.path(path_base, "05.result_visualize")

if (!dir.exists(path_visualize)) {
    dir.create(path_visualize, recursive = TRUE)
}

# 3. Formal Name Mapping
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

# 4. Helper Function: Extract Data from a Single File
extract_fold_metrics <- function(file_path, current_fold) {
    name <- gsub("_confusionMatrix\\.Rdata$", "", basename(file_path))
    
    temp_env <- new.env()
    load(file_path, envir = temp_env)
    
    if (!"all_info" %in% ls(temp_env)) return(NULL)
    
    df <- temp_env$all_info
    target_cols <- c("accuracy", "sensitivity", "specificity", "precision", 
                     "f1_score", "mcc", "comprehensive")
    
    for (col in target_cols) {
        if (!col %in% colnames(df)) df[[col]] <- NA
    }
    
    result_row <- df[, target_cols, drop = FALSE]
    result_row$Tool <- name
    result_row$Fold <- current_fold
    
    rm(temp_env)
    return(result_row)
}

# 5. Core Loop: Gather Data Across All Specified Folds
num_cores <- 20 
all_data_list <- list()

for (fold in target_folds) {
    fold_dir <- file.path(path_analysis, fold)
    files <- list.files(fold_dir, pattern = "_confusionMatrix\\.Rdata$", full.names = TRUE)
    
    if (length(files) == 0) {
        cat(sprintf("[%s] Warning: No files found in %s. Skipping.\n", Sys.time(), fold_dir))
        next
    }
    
    cat(sprintf("[%s] Extracting data from %s (%d files)...\n", Sys.time(), fold, length(files)))
    
    # Extract in parallel
    extracted <- mclapply(files, extract_fold_metrics, current_fold = fold, mc.cores = num_cores, mc.preschedule = FALSE)
    
    # Safely remove NULLs (replaces the purrr::compact requirement)
    extracted <- Filter(Negate(is.null), extracted)
    
    all_data_list <- append(all_data_list, extracted)
}

# Combine all lists into one master dataframe
master_df <- bind_rows(all_data_list)

if (nrow(master_df) == 0) {
    stop(sprintf("[%s] Error: Master dataframe is empty. No data to plot.\n", Sys.time()))
}

# -----------------------------------------------------------------
# STEP A: Data Wrangling & Formatting
# -----------------------------------------------------------------
cat(sprintf("[%s] Formatting data and applying formal names...\n", Sys.time()))

# Apply Formal Names (fallback to raw name if not found in mapping)
master_df <- master_df %>%
    mutate(Tool_Formal = ifelse(Tool %in% names(name_mapping), name_mapping[Tool], Tool))

# Convert wide format to long format for ggplot faceting
df_long <- master_df %>%
    pivot_longer(
        cols = c("accuracy", "sensitivity", "specificity", "precision", "f1_score", "mcc", "comprehensive"),
        names_to = "Metric",
        values_to = "Value"
    )

# Clean up Metric names for the plot labels
metric_labels <- c(
    "accuracy" = "Accuracy",
    "sensitivity" = "Sensitivity (Recall)",
    "specificity" = "Specificity",
    "precision" = "Precision",
    "f1_score" = "F1-Score",
    "mcc" = "MCC",
    "comprehensive" = "Comprehensive Score"
)
df_long$Metric <- factor(df_long$Metric, levels = names(metric_labels), labels = metric_labels)

# Order Folds logically
# df_long$Fold <- factor(df_long$Fold, levels = c("1_vs_1", "1_vs_4", "1_vs_9"))
df_long$Fold <- factor(df_long$Fold, levels = c("1_vs_1", "1_vs_4", "1_vs_9", "1_vs_99"))
# Smart Sorting: Sort Tools based on their Comprehensive Score in 1_vs_9 (the hardest task)
sort_df <- df_long %>%
    filter(Fold == "1_vs_9", Metric == "Comprehensive Score") %>%
    arrange(desc(Value))

tool_order <- sort_df$Tool_Formal
df_long$Tool_Formal <- factor(df_long$Tool_Formal, levels = tool_order)

# -----------------------------------------------------------------
# STEP B: Plotting (Cleveland Dot Plot Style)
# -----------------------------------------------------------------
cat(sprintf("[%s] Generating publication-ready plot on A4 canvas...\n", Sys.time()))

# Define distinct colors for the folds (Blue to Red gradient logic)
fold_colors <- c("1_vs_1" = "#1b9e77", "1_vs_4" = "#d95f02", "1_vs_9" = "#7570b3", "1_vs_99" = "#1F77B4")

p <- ggplot(df_long, aes(x = Tool_Formal, y = Value)) +
    # Draw vertical grey lines connecting the min and max values for each tool
    geom_line(aes(group = Tool_Formal), color = "gray70", linewidth = 1.2, alpha = 0.6) +
    # Draw the points for each fold
    geom_point(aes(color = Fold), size = 2.5, alpha = 0.9) +
    
    # Facet by metric (7 rows, 1 column)
    facet_wrap(~ Metric, ncol = 1, scales = "free_y") +
    
    # Aesthetics and scales
    scale_color_manual(values = fold_colors, name = "Data Imbalance (Fold)") +
    labs(
        title = "Model Performance Degradation Across Data Imbalance Scenarios",
        subtitle = "Points connected by vertical lines represent the range of metric variation for a single tool",
        x = "Prediction Models (Ranked by Comprehensive Score in 1_vs_9)",
        y = "Metric Value"
    ) +
    
    # Clean, academic theme
    theme_bw(base_size = 12) +
    theme(
        plot.title = element_text(face = "bold", size = 16, hjust = 0.5),
        plot.subtitle = element_text(size = 12, hjust = 0.5, color = "gray40"),
        axis.text.x = element_text(angle = 45, hjust = 1, face = "bold", color = "black"),
        axis.text.y = element_text(color = "black"),
        strip.background = element_rect(fill = "#e9ecef", color = "black"),
        strip.text = element_text(face = "bold", size = 11),
        panel.grid.major.x = element_blank(), # Remove vertical grid to highlight our custom lines
        panel.grid.minor = element_blank(),
        legend.position = "top",
        legend.title = element_text(face = "bold"),
        legend.text = element_text(size = 11)
    )

# -----------------------------------------------------------------
# STEP C: Save Output
# -----------------------------------------------------------------
# A4 dimensions in inches: 8.27 x 11.69. Using standard A4 portrait sizes.
pdf_out <- file.path(path_visualize, "metrics_comparison_across_folds_A4.pdf")
png_out <- file.path(path_visualize, "metrics_comparison_across_folds_A4.png")

ggsave(filename = pdf_out, plot = p, width = 8, height = 11, device = "pdf")
ggsave(filename = png_out, plot = p, width = 8, height = 11, dpi = 300, device = "png")

cat(sprintf("[%s] >>> Plot successfully saved to:\n  %s\n  %s\n", Sys.time(), pdf_out, png_out))
cat(sprintf("[%s] >>> All Tasks Completed Successfully.\n", Sys.time()))