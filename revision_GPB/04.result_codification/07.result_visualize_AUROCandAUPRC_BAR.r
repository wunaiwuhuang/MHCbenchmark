#!/usr/bin/env Rscript
################################################################
# Script Name: 07.result_visualize_AUROCandAUPRC_BAR.R
# Description: Generates side-by-side plots (AUROC & AUPRC) 
#              with overall exact metrics and bootstrap 95% CIs.
#              Outputs TWO versions:
#              1. Zoomed-in Bar Plot (using coord_cartesian)
#              2. Point-and-Error-Bar Plot (Statistically safer)
#              * X-axis automatically sorted in descending order.
################################################################

# Load required libraries
suppressPackageStartupMessages({
    library(ggplot2)
    library(dplyr)
    library(tidyr)
    library(argparse)
    library(patchwork)
})

# 1. Create parser and add arguments
parser <- ArgumentParser(description='Generate AUROC & AUPRC Plots with Bootstrap Error Bars')
parser$add_argument('fold', 
                    nargs = '?', 
                    default = '1_vs_1', 
                    help = 'Fold name, e.g., 1_vs_4, 1_vs_9 (Default: 1_vs_1)')

opt <- parser$parse_args()
fold <- opt$fold

# 2. Path definitions
path_revision <- "/data1/wuguojia/data/mhc_benchmark/revision"
path_analysis <- file.path(path_revision, "04.result_analysis", fold)
path_bootstrap <- file.path(path_revision, "05.result_visualize", "Bootstrap_result", "01_Individual_Metrics_with_CI.csv")
path_output <- file.path(path_revision, "05.result_visualize", fold)

# Ensure output directory exists
dir.create(path_output, showWarnings = FALSE, recursive = TRUE)

message(sprintf("[%s] >>> Starting Visualization Script...", Sys.time()))
message(sprintf("[%s] >>> Current configuration fold: %s", Sys.time(), fold))

# 3. Define Color Mapping
color_mapping <- c(
    "acme" = "#1F77B4", "bigmhc" = "#FF7F0E", "capsnetmhc_an" = "#2CA02C",
    "capsnetmhc_ie" = "#FDE725", "consensus" = "#9467BD", "deepattentionpan" = "#8C564B",
    "deephlapan" = "#9EDAE5", "deepnetbim" = "#7F7F7F", "mhcflurry_ba" = "#17BECF",
    "mhcflurry_ps" = "#CE6DBD", "mixmhcpred" = "#FFBB78", "netmhccons" = "#C7C7C7",
    "netmhcpan_ba" = "#DBDB8D", "netmhcpan_el" = "#E377C2", "netmhcstabpan" = "#BCBD22",
    "stmhcpan" = "#D62728", "transphla" = "#4B4B4B"
)

# 4. Load Bootstrap CI Data
message(sprintf("[%s] >>> Loading bootstrap CI data...", Sys.time()))
if (!file.exists(path_bootstrap)) stop(sprintf("Bootstrap file not found: %s", path_bootstrap))
df_ci <- read.csv(path_bootstrap, stringsAsFactors = FALSE)
df_ci_fold <- df_ci %>% filter(Fold == fold)
if (nrow(df_ci_fold) == 0) stop(sprintf("No bootstrap data found for fold: %s", fold))

# 5. Extract Overall Metrics from _analysis.Rdata files
message(sprintf("[%s] >>> Extracting overall metrics...", Sys.time()))
analysis_files <- list.files(path_analysis, pattern = "_analysis\\.Rdata$", full.names = TRUE)
if (length(analysis_files) == 0) stop(sprintf("No '_analysis.Rdata' files found in: %s", path_analysis))

overall_metrics_list <- list()
for (file in analysis_files) {
    tool_name <- gsub("_analysis\\.Rdata$", "", basename(file))
    env <- new.env()
    load(file, envir = env)
    
    overall_metrics_list[[tool_name]] <- data.frame(
        Tool = tool_name,
        Overall_AUROC = as.numeric(env$all_info$auroc$auc),
        Overall_AUPRC = as.numeric(env$all_info$auprc$auc.integral),
        stringsAsFactors = FALSE
    )
}
df_overall <- do.call(rbind, overall_metrics_list)

# 6. Merge Metrics and Calculate Dynamic Y-Axis Limits
message(sprintf("[%s] >>> Calculating dynamic y-axis limits...", Sys.time()))
df_plot <- merge(df_overall, df_ci_fold, by = "Tool")

# Calculate dynamic limits: [max(0, min-0.1), min(1, max+0.1)]
ylim_roc <- c(max(0, min(df_plot$AUROC_CI_Lower, na.rm = TRUE) - 0.1),
              min(1, max(df_plot$AUROC_CI_Upper, na.rm = TRUE) + 0.1))

ylim_prc <- c(max(0, min(df_plot$AUPRC_CI_Lower, na.rm = TRUE) - 0.1),
              min(1, max(df_plot$AUPRC_CI_Upper, na.rm = TRUE) + 0.1))

message(sprintf("[%s] >>> AUROC Y-axis range: [%.4f, %.4f]", Sys.time(), ylim_roc[1], ylim_roc[2]))
message(sprintf("[%s] >>> AUPRC Y-axis range: [%.4f, %.4f]", Sys.time(), ylim_prc[1], ylim_prc[2]))

# 7. Common Theme Setup
common_theme <- theme_classic() +
    theme(
        legend.position = "none",
        axis.title.x = element_blank(),
        axis.text.x = element_blank(),
        axis.ticks.x = element_blank(),
        axis.title.y = element_text(size = 8, face = "bold"),
        axis.text.y = element_text(size = 8, color = "black"),
        plot.title = element_text(hjust = 0.5, face = "bold", size = 8),
        panel.background = element_rect(fill = "white", color = NA),
        plot.background = element_rect(fill = "white", color = NA)
    )

# ==============================================================================
# VERSION 1: ZOOMED-IN BAR PLOT
# ==============================================================================
message(sprintf("[%s] >>> Generating Zoomed-in Bar Plots...", Sys.time()))

# 使用 reorder(Tool, -Overall_AUROC) 按 AUROC 从大到小排列
bar_auroc <- ggplot(df_plot, aes(x = reorder(Tool, -Overall_AUROC), y = Overall_AUROC, fill = Tool)) +
    geom_col(color = "black", size = 0.2) + 
    geom_errorbar(aes(ymin = AUROC_CI_Lower, ymax = AUROC_CI_Upper), width = 0.3, size = 0.5) +
    scale_fill_manual(values = color_mapping) +
    scale_y_continuous(expand = c(0, 0)) +
    coord_cartesian(ylim = ylim_roc) + 
    labs(y = NULL, title = "AUROC") +
    common_theme

# 使用 reorder(Tool, -Overall_AUPRC) 按 AUPRC 从大到小排列
bar_auprc <- ggplot(df_plot, aes(x = reorder(Tool, -Overall_AUPRC), y = Overall_AUPRC, fill = Tool)) +
    geom_col(color = "black", size = 0.2) + 
    geom_errorbar(aes(ymin = AUPRC_CI_Lower, ymax = AUPRC_CI_Upper), width = 0.3, size = 0.5) +
    scale_fill_manual(values = color_mapping) +
    scale_y_continuous(expand = c(0, 0)) +
    coord_cartesian(ylim = ylim_prc) +
    labs(y = NULL, title = "AUPRC") +
    common_theme

bar_combined <- bar_auroc | bar_auprc
out_bar <- file.path(path_output, sprintf("AUROC_AUPRC_ZoomedBar_%s.pdf", fold))
ggsave(filename = out_bar, plot = bar_combined, width = 4, height = 1.2, device = "pdf")
message(sprintf("[%s] >>> Saved Bar Plot to: %s", Sys.time(), out_bar))

# ==============================================================================
# VERSION 2: POINT AND ERROR-BAR PLOT
# ==============================================================================
message(sprintf("[%s] >>> Generating Point-and-Error-Bar Plots...", Sys.time()))

point_auroc <- ggplot(df_plot, aes(x = reorder(Tool, -Overall_AUROC), y = Overall_AUROC, fill = Tool)) +
    geom_errorbar(aes(ymin = AUROC_CI_Lower, ymax = AUROC_CI_Upper), width = 0.5, size = 1, color = "black") +
    geom_point(shape = 21, size = 2, color = "black", stroke = 0) +
    scale_fill_manual(values = color_mapping) +
    scale_y_continuous(expand = c(0, 0)) +
    coord_cartesian(ylim = ylim_roc) + 
    labs(y = NULL, title = "AUROC") +
    common_theme

point_auprc <- ggplot(df_plot, aes(x = reorder(Tool, -Overall_AUPRC), y = Overall_AUPRC, fill = Tool)) +
    geom_errorbar(aes(ymin = AUPRC_CI_Lower, ymax = AUPRC_CI_Upper), width = 0.5, size = 1, color = "black") +
    geom_point(shape = 21, size = 2, color = "black", stroke = 0) +
    scale_fill_manual(values = color_mapping) +
    scale_y_continuous(expand = c(0, 0)) +
    coord_cartesian(ylim = ylim_prc) +
    labs(y = NULL, title = "AUPRC") +
    common_theme

point_combined <- point_auroc | point_auprc
out_point <- file.path(path_output, sprintf("AUROC_AUPRC_PointCI_%s.pdf", fold))
ggsave(filename = out_point, plot = point_combined, width = 4, height = 1.2, device = "pdf")
message(sprintf("[%s] >>> Saved Point Plot to: %s", Sys.time(), out_point))

message(sprintf("[%s] >>> All visualization processes completed successfully!", Sys.time()))