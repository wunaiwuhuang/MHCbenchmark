#--------------------------------------------------------------
# Script: 02.3.result_visualize_AUROCandAUPRC_class.r
# Description: Visualizes overall AUROC and AUPRC aggregated 
#              by tool classes using 'single_info' to boost 
#              statistical power. Generates a side-by-side bar 
#              plot with error bars and pairwise significance.
# Output Size: Width 4, Height 3.
#--------------------------------------------------------------

message(">>> [Init] Loading required packages...")
library(data.table)
library(dplyr)
library(tidyr)
library(ggplot2)
library(patchwork)
library(ggsignif)
library(argparse)

# 1. Parse Arguments
parser <- ArgumentParser(description='Class-level Performance Visualizations')
parser$add_argument('fold', nargs = '?', default = '1_vs_1', help = 'Fold name (e.g., 1_vs_1)')
opt <- parser$parse_args()
fold <- opt$fold

message(sprintf(">>> [Config] Current fold: %s", fold))

# 2. Path definitions
path_revision <- "/data1/wuguojia/data/mhc_benchmark/revision"
path_analysis <- file.path(path_revision, "04.result_analysis", fold)
path_visualize <- file.path(path_revision, "05.result_visualize", fold)
if(!dir.exists(path_visualize)) dir.create(path_visualize, recursive = TRUE)

# 3. Group and Color Definitions
class_0 <- c("consensus","netmhccons","netmhcpan_ba","netmhcpan_el",
             "netmhcstabpan","mhcflurry_ba","mhcflurry_ps","mixmhcpred")
class_1 <- c("acme","capsnetmhc_an","capsnetmhc_ie","deepattentionpan","deephlapan")
class_2 <- c("bigmhc","stmhcpan","transphla")

color_mapping_class <- c(
    "class_0" = "#C9F0C1", # Light blue-green
    "class_1" = "#7ED957", # Bright grass green
    "class_2" = "#145214"  # Dark green
)

#==============================================================================
message(">>> [Data Prep] Extracting 'single_info' metrics for robust stats...")

files <- list.files(path_analysis, pattern = "_analysis\\.Rdata$", full.names = TRUE)

roc_list <- list()
prc_list <- list()

for (f in files) {
    load(f)
    tool_name <- gsub("\\_analysis.Rdata", "", basename(f))
    
    # Assign class based on tool name
    tool_class <- case_when(
        tool_name %in% class_0 ~ "class_0",
        tool_name %in% class_1 ~ "class_1",
        tool_name %in% class_2 ~ "class_2",
        TRUE ~ NA_character_
    )
    
    if(!is.na(tool_class)) {
        # Extract single_info AUROC
        if(!is.null(single_info$auroc)) {
            tmp_roc <- single_info$auroc
            tmp_roc$tool <- tool_name
            tmp_roc$class <- tool_class
            roc_list[[tool_name]] <- tmp_roc
        }
        # Extract single_info AUPRC
        if(!is.null(single_info$auprc)) {
            tmp_prc <- single_info$auprc
            tmp_prc$tool <- tool_name
            tmp_prc$class <- tool_class
            prc_list[[tool_name]] <- tmp_prc
        }
    }
}

# Bind and clean data (remove NA values)
df_roc <- do.call(rbind, roc_list) %>% filter(!is.na(auroc))
df_prc <- do.call(rbind, prc_list) %>% filter(!is.na(auprc))

# Lock factor levels
df_roc$class <- factor(df_roc$class, levels = c("class_0", "class_1", "class_2"))
df_prc$class <- factor(df_prc$class, levels = c("class_0", "class_1", "class_2"))

message(">>> [Stats] Calculating Mean, 95% CI, and Pairwise Significance...")

# Function to calculate mean and 95% CI
calc_summary <- function(df, metric_col) {
    df %>%
        group_by(class) %>%
        summarise(
            mean_val = mean(!!sym(metric_col), na.rm = TRUE),
            sd_val = sd(!!sym(metric_col), na.rm = TRUE),
            n = n(),
            .groups = 'drop'
        ) %>%
        mutate(
            ci_low = mean_val - qt(0.975, df = n - 1) * (sd_val / sqrt(n)),
            ci_high = mean_val + qt(0.975, df = n - 1) * (sd_val / sqrt(n))
        )
}

sum_roc <- calc_summary(df_roc, "auroc")
sum_prc <- calc_summary(df_prc, "auprc")

# Function to calculate pairwise Wilcoxon test with Bonferroni correction
get_significance <- function(df, metric) {
    ptest <- pairwise.wilcox.test(df[[metric]], df$class, p.adjust.method = "bonferroni")
    p_matrix <- ptest$p.value
    
    # Extract strictly required pairs
    p_vals <- c(
        p_matrix["class_1", "class_0"],
        p_matrix["class_2", "class_1"],
        p_matrix["class_2", "class_0"]
    )
    p_vals[is.na(p_vals)] <- 1 # Handle NA defaults
    
    stars <- case_when(
        p_vals < 0.001 ~ "***",
        p_vals < 0.01  ~ "**",
        p_vals < 0.05  ~ "*",
        TRUE           ~ "ns"
    )
    
    list(
        comparisons = list(c("class_0", "class_1"), c("class_1", "class_2"), c("class_0", "class_2")),
        annotations = stars
    )
}

sig_roc <- get_significance(df_roc, "auroc")
sig_prc <- get_significance(df_prc, "auprc")

# Dynamic y-positions for brackets (compact spacing)
y_max_roc <- max(sum_roc$ci_high, na.rm = TRUE)
y_pos_roc <- y_max_roc + c(0.03, 0.06, 0.10)

y_max_prc <- max(sum_prc$ci_high, na.rm = TRUE)
y_pos_prc <- y_max_prc + c(0.04, 0.08, 0.13)

#==============================================================================
message(">>> [Plotting] Constructing Bar Plots with Error Bars and Stats...")

theme_small <- function() {
    theme_minimal(base_size = 9) +
    theme(
        plot.title = element_text(hjust = 0.5, face = "bold", size = 10),
        axis.title.x = element_blank(),
        axis.text.x = element_text(angle = 45, hjust = 1, color = "black", size = 8),
        axis.text.y = element_text(color = "black", size = 8),
        panel.grid.major.x = element_blank(),
        panel.grid.minor = element_blank(),
        panel.border = element_rect(color = "black", fill = NA, linewidth = 0.6),
        panel.background = element_rect(fill = "white", color = "black"),
        legend.position = "none"
    )
}

# 1. AUROC Plot
p_roc <- ggplot(sum_roc, aes(x = class, y = mean_val, fill = class)) +
    geom_bar(stat = "identity", color = "black", linewidth = 0.3, width = 0.7) +
    geom_errorbar(aes(ymin = ci_low, ymax = ci_high), width = 0.2, linewidth = 0.5) +
    geom_signif(
        comparisons = sig_roc$comparisons,
        annotations = sig_roc$annotations,
        y_position = y_pos_roc,
        tip_length = 0.02,
        vjust = 0.4,
        textsize = 2.5,
        size = 0.3
    ) +
    scale_fill_manual(values = color_mapping_class) +
    scale_x_discrete(labels = c("class_0" = "Class 0", "class_1" = "Class 1", "class_2" = "Class 2")) +
    coord_cartesian(ylim = c(0.5, max(y_pos_roc) + 0.02)) +
    labs(title = "AUROC", y = "Score") +
    theme_small()

# 2. AUPRC Plot
p_prc <- ggplot(sum_prc, aes(x = class, y = mean_val, fill = class)) +
    geom_bar(stat = "identity", color = "black", linewidth = 0.3, width = 0.7) +
    geom_errorbar(aes(ymin = ci_low, ymax = ci_high), width = 0.2, linewidth = 0.5) +
    geom_signif(
        comparisons = sig_prc$comparisons,
        annotations = sig_prc$annotations,
        y_position = y_pos_prc,
        tip_length = 0.02,
        vjust = 0.4,
        textsize = 2.5,
        size = 0.3
    ) +
    scale_fill_manual(values = color_mapping_class) +
    scale_x_discrete(labels = c("class_0" = "Class 0", "class_1" = "Class 1", "class_2" = "Class 2")) +
    coord_cartesian(ylim = c(0.0, max(y_pos_prc) + 0.03)) +
    labs(title = "AUPRC", y = "Score") +
    theme_small()

# Combine using patchwork
p_combined <- p_roc + p_prc + plot_layout(ncol = 2)

#==============================================================================
message(">>> [Export] Saving the combined plot to PDF (4x3 inches)...")

output_pdf <- file.path(path_visualize, paste0("AUROC_AUPRC_Class_", fold, ".pdf"))
ggsave(filename = output_pdf, plot = p_combined, width = 4, height = 3, dpi = 300)

message(">>> [Done] Script finished successfully. Output saved to: ", output_pdf)