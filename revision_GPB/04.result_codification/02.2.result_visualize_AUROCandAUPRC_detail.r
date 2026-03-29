#--------------------------------------------------------------
# Script: 02.2.result_visualize_AUROCandAUPRC_detail.r
# Description: Detail visualization for AUROC & AUPRC based on
#              revised data format. Generates a composite A4 
#              portrait plot using patchwork.
#--------------------------------------------------------------

message(">>> [Init] Loading required packages...")
library(data.table)
library(dplyr)
library(tidyr)
library(ggplot2)
library(patchwork)
library(ggsignif)
library(tibble)
library(argparse)
library(ggrastr)

# 1. Parse Arguments
parser <- ArgumentParser(description='Detail Visualizations for MHC Benchmark')
parser$add_argument('fold', nargs = '?', default = '1_vs_1', help = 'Fold name (e.g., 1_vs_1)')
opt <- parser$parse_args()
fold <- opt$fold

message(sprintf(">>> [Config] Current fold: %s", fold))

# 2. Path definitions
path_revision <- "/data1/wuguojia/data/mhc_benchmark/revision"
path_analysis <- file.path(path_revision, "04.result_analysis", fold)
path_visualize <- file.path(path_revision, "05.result_visualize", fold)
if(!dir.exists(path_visualize)) dir.create(path_visualize, recursive = TRUE)

# 3. Color mapping
color_mapping <- c(
    "acme" = "#1F77B4", "bigmhc" = "#FF7F0E", "capsnetmhc_an" = "#2CA02C",
    "capsnetmhc_ie" = "#FDE725", "consensus" = "#9467BD", "deepattentionpan" = "#8C564B",
    "deephlapan" = "#9EDAE5", "deepnetbim" = "#7F7F7F", "mhcflurry_ba" = "#17BECF",
    "mhcflurry_ps" = "#CE6DBD", "mixmhcpred" = "#FFBB78", "netmhccons" = "#C7C7C7",
    "netmhcpan_ba" = "#DBDB8D", "netmhcpan_el" = "#E377C2", "netmhcstabpan" = "#BCBD22",
    "stmhcpan" = "#D62728", "transphla" = "#4B4B4B"
)

# 4. Layout Heights Configuration (Top : Middle : Bottom)
# 如果发现底部的显著性标签仍然被遮挡，可以继续调大第三个数值（例如改到 1.8 或 2）
region_heights <- c(1, 1, 0.8)

# Shared Theme (No titles, no axes titles, no legends, PURE BACKGROUND)
theme_clean <- function() {
    theme_minimal(base_size = 10) +
    theme(
        axis.title = element_blank(),
        axis.text.x = element_blank(), # Will explicitly set where needed, but mostly blank
        axis.text.y = element_text(color = "black", size = 8),
        legend.position = "none",
        plot.title = element_blank(),
        panel.grid.major = element_blank(), # 去除主网格线，保证背景纯白
        panel.grid.minor = element_blank(), # 去除次网格线
        panel.border = element_rect(color="black", fill=NA, linewidth=0.5),
        panel.background = element_rect(fill="white", color="black"),
        plot.margin = margin(2, 2, 2, 2)
    )
}

# Helper function to create barplots with significance
# Helper function to create barplots with significance
generate_barplot <- function(df_long, metric_col) {
    summary_stats <- df_long %>% 
        group_by(model) %>% 
        summarise(
            mean_val = mean(!!sym(metric_col), na.rm = TRUE),
            ci_low = quantile(!!sym(metric_col), 0.025, na.rm = TRUE),
            ci_high = quantile(!!sym(metric_col), 0.975, na.rm = TRUE),
            .groups = 'drop'
        ) %>%
        arrange(desc(mean_val))
    
    summary_stats$model <- factor(summary_stats$model, levels = summary_stats$model)
    df_long$model <- factor(df_long$model, levels = summary_stats$model)
    
    # Pairwise significance
    pairwise_test <- pairwise.wilcox.test(df_long[[metric_col]], df_long$model, p.adjust.method = "bonferroni")
    first_model <- as.character(summary_stats$model[1])
    
    # Extract p-values for the best model vs others
    p_values <- pairwise_test$p.value
    sig_annotations <- data.frame(group2 = character(), p_val = numeric(), stringsAsFactors = FALSE)
    
    for(mod in colnames(p_values)) {
        if(first_model %in% rownames(p_values)) {
            val <- p_values[first_model, mod]
            if(!is.na(val)) sig_annotations <- rbind(sig_annotations, data.frame(group2 = mod, p_val = val))
        }
    }
    for(mod in rownames(p_values)) {
        if(first_model %in% colnames(p_values)) {
            val <- p_values[mod, first_model]
            if(!is.na(val)) sig_annotations <- rbind(sig_annotations, data.frame(group2 = mod, p_val = val))
        }
    }
    
    sig_annotations <- sig_annotations %>%
        mutate(
            sig = case_when(
                p_val < 0.001 ~ "***", p_val < 0.01 ~ "**", p_val < 0.05 ~ "*", TRUE ~ ""
            )
        ) %>%
        filter(sig != "")
    
    comparisons_list <- lapply(sig_annotations$group2, function(x) c(first_model, x))
    
    y_start <- max(summary_stats$ci_high, na.rm = TRUE) + 0.02
    y_positions <- seq(y_start, by = 0.035, length.out = nrow(sig_annotations))
    
    # --- [新增逻辑：动态计算 Y 轴下限] ---
    # 获取误差棒下限的最小值
    min_val <- min(summary_stats$ci_low, na.rm = TRUE)
    # 计算下界：取 0 和 (min_val - 0.1) 中的较大者
    y_min <- max(0, min_val - 0.1)
    
    p <- ggplot(summary_stats, aes(x = model, y = mean_val, fill = model)) +
        geom_bar(stat = "identity", color = NA) +
        geom_errorbar(aes(ymin = ci_low, ymax = ci_high), width = 0.2) +
        scale_fill_manual(values = color_mapping) +
        # --- [修改：应用动态下限和固定的上限 1.50] ---
        coord_cartesian(ylim = c(y_min, 1.50)) + 
        theme_clean()
    
    if(nrow(sig_annotations) > 0) {
        p <- p + geom_signif(
            comparisons = comparisons_list,
            annotations = sig_annotations$sig,
            y_position = y_positions,
            tip_length = 0.01,
            vjust = 0.4,
            textsize = 3
        )
    }
    return(p)
}

#==============================================================================
message(">>> [Data Prep] Loading and assembling data...")
files <- list.files(path_analysis, pattern = "_analysis\\.Rdata$", full.names = TRUE)

auc_hla_list <- list()
prc_hla_list <- list()
auc_sin_list <- list()
prc_sin_list <- list()

for (f in files) {
    load(f)
    tool_name <- gsub("\\_analysis.Rdata", "", basename(f))
    
    # 1. Allele Data Extraction
    if (!is.null(hla_info$auroc) && length(hla_info$auroc) > 0) {
        hla_auc <- sapply(names(hla_info$auroc), function(k) hla_info$auroc[[k]]$auc)
        hla_names <- sub(paste0("^", tool_name, "_"), "", names(hla_auc))
        auc_hla_list[[tool_name]] <- data.frame(HLA = hla_names, AUROC = as.numeric(hla_auc), tool = tool_name)
    }
    if (!is.null(hla_info$auprc) && length(hla_info$auprc) > 0) {
        hla_prc <- sapply(names(hla_info$auprc), function(k) hla_info$auprc[[k]]$auc.integral)
        hla_names <- sub(paste0("^", tool_name, "_"), "", names(hla_prc))
        prc_hla_list[[tool_name]] <- data.frame(HLA = hla_names, AUPRC = as.numeric(hla_prc), tool = tool_name)
    }
    
    # 2. Single Data Extraction
    if (!is.null(single_info$auroc)) {
        df <- single_info$auroc %>% mutate(tool = tool_name)
        auc_sin_list[[tool_name]] <- df
    }
    if (!is.null(single_info$auprc)) {
        df <- single_info$auprc %>% mutate(tool = tool_name)
        prc_sin_list[[tool_name]] <- df
    }
}

df_auc_hla <- do.call(rbind, auc_hla_list)
df_prc_hla <- do.call(rbind, prc_hla_list)
df_auc_sin <- do.call(rbind, auc_sin_list)
df_prc_sin <- do.call(rbind, prc_sin_list)

#==============================================================================
message(">>> [Plotting] Generating TOP region plots (Scatter & Line)...")

# --- Scatter Plot (AUROC Allele) ---
mean_auc <- df_auc_hla %>% group_by(tool) %>% summarise(mean_v = mean(AUROC, na.rm=TRUE)) %>% arrange(desc(mean_v))
df_auc_hla$tool <- factor(df_auc_hla$tool, levels = mean_auc$tool)

p_roc_scatter <- ggplot(df_auc_hla, aes(x = HLA, y = AUROC, color = tool)) +
    rasterise(geom_point(size = 1.5, shape = 16, alpha = 0.7), dpi=300) +
    scale_color_manual(values = color_mapping) +
    theme_clean() +
    theme(axis.text.x = element_blank()) # Specifically requested no labels

# --- Scatter Plot (AUPRC Allele) ---
mean_prc <- df_prc_hla %>% group_by(tool) %>% summarise(mean_v = mean(AUPRC, na.rm=TRUE)) %>% arrange(desc(mean_v))
df_prc_hla$tool <- factor(df_prc_hla$tool, levels = mean_prc$tool)

p_prc_scatter <- ggplot(df_prc_hla, aes(x = HLA, y = AUPRC, color = tool)) +
    rasterise(geom_point(size = 1.5, shape = 16, alpha = 0.7), dpi=300) +
    scale_color_manual(values = color_mapping) +
    theme_clean() +
    theme(axis.text.x = element_blank())

# --- Line Plot (AUROC Single) ---
df_auc_sin_sum <- df_auc_sin %>% group_by(tool, peptide_length) %>% 
    summarise(mean_val = mean(auroc, na.rm=TRUE), .groups='drop')
df_auc_sin_sum$tool <- factor(df_auc_sin_sum$tool, levels = mean_auc$tool)

p_roc_line <- ggplot(df_auc_sin_sum, aes(x = peptide_length, y = mean_val, color = tool, group = tool)) +
    geom_line(linewidth = 0.4) + geom_point(size = 1.5) +
    scale_color_manual(values = color_mapping) +
    theme_clean() + theme(axis.text.x = element_blank())

# --- Line Plot (AUPRC Single) ---
df_prc_sin_sum <- df_prc_sin %>% group_by(tool, peptide_length) %>% 
    summarise(mean_val = mean(auprc, na.rm=TRUE), .groups='drop')
df_prc_sin_sum$tool <- factor(df_prc_sin_sum$tool, levels = mean_prc$tool)

p_prc_line <- ggplot(df_prc_sin_sum, aes(x = peptide_length, y = mean_val, color = tool, group = tool)) +
    geom_line(linewidth = 0.4) + geom_point(size = 1.5) +
    scale_color_manual(values = color_mapping) +
    theme_clean() + theme(axis.text.x = element_blank())


#==============================================================================
message(">>> [Plotting] Generating MIDDLE region plots (Violins)...")

generate_violin <- function(df, metric, group_pattern) {
    if (group_pattern != "All") {
        df <- df[grep(group_pattern, df$HLA), ]
    }
    # Calculate means to sort factors
    mean_val <- df %>% group_by(tool) %>% summarise(m = mean(!!sym(metric), na.rm=TRUE)) %>% arrange(desc(m))
    df$tool <- factor(df$tool, levels = mean_val$tool)
    
    ggplot(df, aes(x = tool, y = !!sym(metric), fill = tool)) +
        geom_violin(linewidth = 0.3, trim = TRUE) +
        geom_boxplot(width = 0.1, fill = "white", outlier.shape = NA, linewidth=0.2) +
        scale_fill_manual(values = color_mapping) +
        theme_clean() + theme(axis.text.x = element_blank())
}

# AUROC Violins
p_roc_v_all <- generate_violin(df_auc_hla, "AUROC", "All")
p_roc_v_A   <- generate_violin(df_auc_hla, "AUROC", "HLA-A")
p_roc_v_B   <- generate_violin(df_auc_hla, "AUROC", "HLA-B")
p_roc_v_C   <- generate_violin(df_auc_hla, "AUROC", "HLA-C")

# AUPRC Violins
p_prc_v_all <- generate_violin(df_prc_hla, "AUPRC", "All")
p_prc_v_A   <- generate_violin(df_prc_hla, "AUPRC", "HLA-A")
p_prc_v_B   <- generate_violin(df_prc_hla, "AUPRC", "HLA-B")
p_prc_v_C   <- generate_violin(df_prc_hla, "AUPRC", "HLA-C")

#==============================================================================
message(">>> [Plotting] Generating BOTTOM region plots (Bars)...")

df_auc_hla_renamed <- df_auc_hla %>% rename(model = tool, val = AUROC)
df_prc_hla_renamed <- df_prc_hla %>% rename(model = tool, val = AUPRC)
df_auc_sin_renamed <- df_auc_sin %>% rename(model = tool, val = auroc)
df_prc_sin_renamed <- df_prc_sin %>% rename(model = tool, val = auprc)

p_roc_bar_allele <- generate_barplot(df_auc_hla_renamed, "val")
p_roc_bar_single <- generate_barplot(df_auc_sin_renamed, "val")

p_prc_bar_allele <- generate_barplot(df_prc_hla_renamed, "val")
p_prc_bar_single <- generate_barplot(df_prc_sin_renamed, "val")

#==============================================================================
message(">>> [Layout] Assembling the final A4 plot...")

# TOP REGION
top_left <- (p_roc_scatter / p_prc_scatter)
top_right <- (p_roc_line / p_prc_line)
top_region <- (top_left | top_right) + plot_layout(widths = c(3.5, 1))

# MIDDLE REGION
mid_left <- (p_roc_v_all / p_roc_v_A / p_roc_v_B / p_roc_v_C) + plot_layout(ncol = 1)
mid_right <- (p_prc_v_all / p_prc_v_A / p_prc_v_B / p_prc_v_C) + plot_layout(ncol = 1)
mid_region <- (mid_left | mid_right) + plot_layout(widths = c(1, 1))

# BOTTOM REGION
bot_left <- (p_roc_bar_allele / p_roc_bar_single) + plot_layout(ncol = 1)
bot_right <- (p_prc_bar_allele / p_prc_bar_single) + plot_layout(ncol = 1)
bot_region <- (bot_left | bot_right) + plot_layout(widths = c(1, 1))

# FINAL ASSEMBLY
# 这里应用了顶部设置的 region_heights 比例参数
final_plot <- (top_region / mid_region / bot_region) + plot_layout(heights = region_heights)

#==============================================================================
message(">>> [Export] Saving to PDF...")
output_pdf <- file.path(path_visualize, paste0("AUROC_AUPRC_Detail_", fold, ".pdf"))
ggsave(filename = output_pdf, plot = final_plot, width = 7, height = 9, dpi = 300)

message(">>> [Done] Script finished successfully. Output saved to: ", output_pdf)