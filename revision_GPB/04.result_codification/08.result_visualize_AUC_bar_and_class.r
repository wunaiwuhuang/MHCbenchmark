#!/usr/bin/env Rscript
################################################################################
# Script Name: 08.result_visualize_AUC_bar_and_class.r
# Description: Generates a composite plot (8x4 inches) for AUROC & AUPRC metrics.
#              The layout is divided vertically into Area A (Left, ~3/4) and 
#              Area B (Right, ~1/4).
#              - Area A: 4x2 grid of Zoomed-in Tool Bar plots + right legend.
#              - Area B: 4x2 grid of Class Bar plots with significance + bottom legend.
#              Folds plotted: 1_vs_1, 1_vs_4, 1_vs_9, 1_vs_99.
################################################################################

# 1. Initialization and Library Loading
suppressPackageStartupMessages({
    library(ggplot2)
    library(dplyr)
    library(tidyr)
    library(patchwork)
    library(ggsignif)
    library(cowplot) # Used for extracting legends
})

message(sprintf("[%s] >>> [Init] Starting Visualization Script...", Sys.time()))

# 2. Path Definitions
path_revision <- "/data1/wuguojia/data/mhc_benchmark/revision"
path_bootstrap <- file.path(path_revision, "05.result_visualize", "Bootstrap_result", "01_Individual_Metrics_with_CI.csv")
path_output_dir <- file.path(path_revision, "05.result_visualize")

if (!dir.exists(path_output_dir)) dir.create(path_output_dir, recursive = TRUE, showWarnings = FALSE)

# 3. Configurations: Folds, Mappings, and Colors
folds_to_plot <- c("1_vs_1", "1_vs_4", "1_vs_9", "1_vs_99")

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

color_mapping_raw <- c(
    "acme" = "#1F77B4", "bigmhc" = "#FF7F0E", "capsnetmhc_an" = "#2CA02C",
    "capsnetmhc_ie" = "#FDE725", "consensus" = "#9467BD", "deepattentionpan" = "#8C564B",
    "deephlapan" = "#9EDAE5", "deepnetbim" = "#7F7F7F", "mhcflurry_ba" = "#17BECF",
    "mhcflurry_ps" = "#CE6DBD", "mixmhcpred" = "#FFBB78", "netmhccons" = "#C7C7C7",
    "netmhcpan_ba" = "#DBDB8D", "netmhcpan_el" = "#E377C2", "netmhcstabpan" = "#BCBD22",
    "stmhcpan" = "#D62728", "transphla" = "#4B4B4B"
)

# Convert color mapping keys to formal names for easier plotting
color_mapping_formal <- setNames(color_mapping_raw, name_mapping[names(color_mapping_raw)])

class_0 <- c("consensus","netmhccons","netmhcpan_ba","netmhcpan_el","netmhcstabpan","mhcflurry_ba","mhcflurry_ps","mixmhcpred")
class_1 <- c("acme","capsnetmhc_an","capsnetmhc_ie","deepattentionpan","deephlapan")
class_2 <- c("bigmhc","stmhcpan","transphla")

color_mapping_class <- c("class_0" = "#C9F0C1", "class_1" = "#7ED957", "class_2" = "#145214")
class_labels <- c("class_0" = "Class 0", "class_1" = "Class 1", "class_2" = "Class 2")

# 4. Helper Functions for Data Processing
message(sprintf("[%s] >>> [Setup] Loading Bootstrap CI data...", Sys.time()))
if (!file.exists(path_bootstrap)) stop("Bootstrap CSV not found!")
df_ci_all <- read.csv(path_bootstrap, stringsAsFactors = FALSE)

calc_summary <- function(df, metric_col) {
    df %>% group_by(class) %>% summarise(
        mean_val = mean(!!sym(metric_col), na.rm = TRUE),
        sd_val = sd(!!sym(metric_col), na.rm = TRUE),
        n = n(), .groups = 'drop'
    ) %>% mutate(
        ci_low = mean_val - qt(0.975, df = n - 1) * (sd_val / sqrt(n)),
        ci_high = mean_val + qt(0.975, df = n - 1) * (sd_val / sqrt(n))
    )
}

get_significance <- function(df, metric) {
    ptest <- suppressWarnings(pairwise.wilcox.test(df[[metric]], df$class, p.adjust.method = "bonferroni"))
    p_matrix <- ptest$p.value
    
    safe_extract <- function(r, c) {
        if(r %in% rownames(p_matrix) && c %in% colnames(p_matrix)) {
            v <- p_matrix[r, c]
            return(ifelse(is.na(v), 1, v))
        }
        return(1)
    }
    p_vals <- c(safe_extract("class_1", "class_0"), safe_extract("class_2", "class_1"), safe_extract("class_2", "class_0"))
    
    stars <- case_when(p_vals < 0.001 ~ "***", p_vals < 0.01 ~ "**", p_vals < 0.05 ~ "*", TRUE ~ "ns")
    list(comparisons = list(c("class_0", "class_1"), c("class_1", "class_2"), c("class_0", "class_2")), annotations = stars)
}

# 5. Helper Functions for Plotting
# Shared minimalist theme for all tight subplots
theme_tight <- theme_classic(base_size = 7) +
    theme(
        axis.title = element_blank(),
        axis.text.x = element_blank(),
        axis.ticks.x = element_blank(),
        axis.text.y = element_text(size = 5.5, color = "black"),
        plot.margin = margin(1, 2, 1, 2),
        legend.position = "none",
        panel.background = element_rect(fill = "white", color = NA),
        plot.background = element_rect(fill = "white", color = NA)
    )

plot_tool <- function(df, metric_col, ci_low, ci_high, ylim) {
    ggplot(df, aes(x = reorder(Formal_Tool, -!!sym(metric_col)), y = !!sym(metric_col), fill = Formal_Tool)) +
        geom_col(color = "black", linewidth = 0.15) + 
        geom_errorbar(aes(ymin = !!sym(ci_low), ymax = !!sym(ci_high)), width = 0.3, linewidth = 0.3) +
        scale_fill_manual(values = color_mapping_formal) +
        scale_y_continuous(expand = c(0, 0)) +
        coord_cartesian(ylim = ylim) + 
        theme_tight
}

plot_class <- function(sum_df, sig_list, metric_col, is_roc = TRUE) {
    y_max <- max(sum_df$ci_high, na.rm = TRUE)
    step <- ifelse(is_roc, 0.025, 0.035) 
    y_pos <- y_max + c(1, 2, 3) * step
    y_limit_top <- max(y_pos) + step
    
    ylim_bottom <- ifelse(is_roc, 0.5, 0.0)
    
    ggplot(sum_df, aes(x = class, y = mean_val, fill = class)) +
        geom_bar(stat = "identity", color = "black", linewidth = 0.2, width = 0.6) +
        geom_errorbar(aes(ymin = ci_low, ymax = ci_high), width = 0.2, linewidth = 0.4) +
        geom_signif(
            comparisons = sig_list$comparisons,
            annotations = sig_list$annotations,
            y_position = y_pos, tip_length = 0.015, vjust = 0.4, textsize = 2, size = 0.2
        ) +
        scale_fill_manual(values = color_mapping_class) +
        coord_cartesian(ylim = c(ylim_bottom, y_limit_top)) +
        theme_tight
}

# 6. Main Data Processing and Plot Generation Loop
A_plots <- list()
B_plots <- list()

for (f in folds_to_plot) {
    message(sprintf("[%s] >>> [Data Processing] Extracting metrics for fold: %s", Sys.time(), f))
    
    path_analysis <- file.path(path_revision, "04.result_analysis", f)
    analysis_files <- list.files(path_analysis, pattern = "_analysis\\.Rdata$", full.names = TRUE)
    
    if(length(analysis_files) == 0) stop(sprintf("No Rdata files found for %s", f))
    
    df_ci_fold <- df_ci_all %>% filter(Fold == f)
    
    overall_list <- list()
    roc_list <- list()
    prc_list <- list()
    
    for (file in analysis_files) {
        tool_raw <- gsub("_analysis\\.Rdata$", "", basename(file))
        formal_name <- ifelse(tool_raw %in% names(name_mapping), name_mapping[[tool_raw]], tool_raw)
        
        env <- new.env()
        load(file, envir = env)
        
        # Tool-level (Overall)
        overall_list[[tool_raw]] <- data.frame(
            Tool = tool_raw,
            Formal_Tool = formal_name,
            Overall_AUROC = as.numeric(env$all_info$auroc$auc),
            Overall_AUPRC = as.numeric(env$all_info$auprc$auc.integral),
            stringsAsFactors = FALSE
        )
        
        # Class-level (Single Info)
        tool_class <- case_when(tool_raw %in% class_0 ~ "class_0", tool_raw %in% class_1 ~ "class_1", tool_raw %in% class_2 ~ "class_2", TRUE ~ NA_character_)
        if(!is.na(tool_class)) {
            if(!is.null(env$single_info$auroc)) {
                tmp_roc <- env$single_info$auroc
                tmp_roc$class <- tool_class
                roc_list[[tool_raw]] <- tmp_roc
            }
            if(!is.null(env$single_info$auprc)) {
                tmp_prc <- env$single_info$auprc
                tmp_prc$class <- tool_class
                prc_list[[tool_raw]] <- tmp_prc
            }
        }
    }
    
    # ---- Construct Area A (Tool Plots) ----
    df_overall <- do.call(rbind, overall_list)
    df_plot_tool <- merge(df_overall, df_ci_fold, by = "Tool")
    
    ylim_roc <- c(max(0, min(df_plot_tool$AUROC_CI_Lower, na.rm = TRUE) - 0.1), min(1, max(df_plot_tool$AUROC_CI_Upper, na.rm = TRUE) + 0.1))
    ylim_prc <- c(max(0, min(df_plot_tool$AUPRC_CI_Lower, na.rm = TRUE) - 0.1), min(1, max(df_plot_tool$AUPRC_CI_Upper, na.rm = TRUE) + 0.1))
    
    p_auroc_tool <- plot_tool(df_plot_tool, "Overall_AUROC", "AUROC_CI_Lower", "AUROC_CI_Upper", ylim_roc)
    p_auprc_tool <- plot_tool(df_plot_tool, "Overall_AUPRC", "AUPRC_CI_Lower", "AUPRC_CI_Upper", ylim_prc)
    
    A_plots[[paste(f, "ROC")]] <- p_auroc_tool
    A_plots[[paste(f, "PRC")]] <- p_auprc_tool
    
    # ---- Construct Area B (Class Plots) ----
    df_roc_class <- do.call(rbind, roc_list) %>% filter(!is.na(auroc))
    df_prc_class <- do.call(rbind, prc_list) %>% filter(!is.na(auprc))
    
    df_roc_class$class <- factor(df_roc_class$class, levels = c("class_0", "class_1", "class_2"))
    df_prc_class$class <- factor(df_prc_class$class, levels = c("class_0", "class_1", "class_2"))
    
    sum_roc <- calc_summary(df_roc_class, "auroc")
    sum_prc <- calc_summary(df_prc_class, "auprc")
    
    sig_roc <- get_significance(df_roc_class, "auroc")
    sig_prc <- get_significance(df_prc_class, "auprc")
    
    p_auroc_class <- plot_class(sum_roc, sig_roc, "auroc", is_roc = TRUE)
    p_auprc_class <- plot_class(sum_prc, sig_prc, "auprc", is_roc = FALSE)
    
    B_plots[[paste(f, "ROC")]] <- p_auroc_class
    B_plots[[paste(f, "PRC")]] <- p_auprc_class
}

# 7. Generate Decoupled Legends
message(sprintf("[%s] >>> [Layout] Generating distinct legends...", Sys.time()))

# Dummy plot for Area A Legend (Vertical, all tools)
dummy_A <- ggplot(data.frame(Tool = names(color_mapping_formal), Val = 1), aes(x = Tool, y = Val, fill = Tool)) +
    geom_col() +
    scale_fill_manual(values = color_mapping_formal) +
    theme_void() +
    theme(
        legend.position = "right",
        legend.title = element_blank(),
        legend.text = element_text(size = 6),
        legend.key.size = unit(0.3, "cm")
    ) + guides(fill = guide_legend(ncol = 1))

# Wrap in suppressWarnings to keep nohup logs clean
legend_A <- wrap_elements(suppressWarnings(get_legend(dummy_A)))

# Dummy plot for Area B Legend (Horizontal, classes)
dummy_B <- ggplot(data.frame(Class = names(class_labels), Val = 1), aes(x = Class, y = Val, fill = Class)) +
    geom_col() +
    scale_fill_manual(values = color_mapping_class, labels = class_labels) +
    theme_void() +
    theme(
        legend.position = "bottom",
        legend.title = element_blank(),
        legend.text = element_text(size = 7),
        legend.key.size = unit(0.35, "cm")
    ) + guides(fill = guide_legend(nrow = 1))

legend_B <- wrap_elements(suppressWarnings(get_legend(dummy_B)))

# 8. Assembly with Patchwork
message(sprintf("[%s] >>> [Layout] Assembling final grid (8x4)...", Sys.time()))

# Area A: 4x2 Plot Grid + Legend on the right
# MUST use wrap_elements() on grid_A to prevent it from flattening into 8 separate panels
grid_A <- wrap_plots(A_plots, ncol = 2)
area_A <- wrap_elements(grid_A) + legend_A + plot_layout(ncol = 2, widths = c(4.5, 1.5))

# Area B: 4x2 Plot Grid + Legend on the bottom
# MUST use wrap_elements() on grid_B
grid_B <- wrap_plots(B_plots, ncol = 2)
area_B <- wrap_elements(grid_B) + legend_B + plot_layout(ncol = 1, heights = c(7.5, 0.5))

# Combine Area A and Area B side-by-side
# Wrap both areas again to ensure they behave as exactly 2 distinct columns
final_plot <- wrap_elements(area_A) + wrap_elements(area_B) + plot_layout(ncol = 2, widths = c(3, 1))

# 9. Output to PDF
out_pdf <- file.path(path_output_dir, "08_AUROC_AUPRC_Combined_Bar_and_Class.pdf")
ggsave(filename = out_pdf, plot = final_plot, width = 8, height = 4, device = "pdf")

message(sprintf("[%s] >>> [Done] Output saved successfully to: %s", Sys.time(), out_pdf))