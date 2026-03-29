#!/usr/bin/env Rscript

# ==============================================================================
# Script Name: 01.PDB_XAI_stability_plot.r
# Description: Combines PDB structural stability (InterDDG) and XAI stability
#              (SHAP/LIME) into a standard Portrait A4 plot (Top-Bottom).
#              Panel A: PDB InterDDG | Panel B: XAI (SHAP & LIME).
# ==============================================================================

suppressPackageStartupMessages({
  library(dplyr)
  library(ggplot2)
  library(stringr)
  library(readr)
  library(tidyr)
  library(patchwork) 
})

log_msg <- function(...) {
  cat(sprintf("[%s] %s\n", format(Sys.time(), "%Y-%m-%d %H:%M:%S"), paste0(...)))
}

log_msg("=== Starting Combined PDB & XAI Stability Plot Generation (Portrait) ===")

# ==============================================================================
# Directories & Configuration
# ==============================================================================
dir_pdb <- "/data1/wuguojia/data/mhc_benchmark/revision/06.PDB_construction"
dir_xai <- "/data1/wuguojia/data/mhc_benchmark/attentionbase/result"
dir_out <- "/data1/wuguojia/data/mhc_benchmark/revision/07.SHAP_LIME"

sample_info <- list(
  "01" = "HLA-A*02:01_NAAERRGPL",
  "02" = "HLA-B*15:02_HVEKLARTL",
  "03" = "HLA-C*05:01_SLIARLERL"
)
target_peptides <- c("NAAERRGPL", "HVEKLARTL", "SLIARLERL")

if (!dir.exists(dir_out)) dir.create(dir_out, recursive = TRUE)

# ==============================================================================
# Part 1: Process PDB Stability Data (Panel A)
# ==============================================================================
log_msg("--- [1/3] Processing PDB Stability Data ---")

df_pdb_list <- list()

for (dir_name in names(sample_info)) {
  sample_label <- sample_info[[dir_name]]
  balas_dir <- file.path(dir_pdb, dir_name, "scan_results", "alaScan", "results")
  
  if (!dir.exists(balas_dir)) next
  bals_files <- list.files(balas_dir, pattern = ".*_ChC_pdb_L00001_S0001_C0000\\.bals$", full.names = TRUE)
  if (length(bals_files) == 0) next
  
  allele <- str_split(sample_label, "_")[[1]][1]
  peptide <- str_split(sample_label, "_")[[1]][2]
  facet_label <- paste0(allele, "\n(", peptide, ")")
  
  sample_data_list <- lapply(bals_files, function(file) {
    col_names <- c("Index", "Number", "Name", "Chain", "InterDG", "InterDDG", "NormTerDDG", "IntraDG", "IntraDDG", "NormTraDDG", "ChainAtoms")
    read.table(file, comment.char = "#", col.names = col_names, fill = TRUE)
  })
  
  combined_df <- bind_rows(sample_data_list)
  
  summary_df <- combined_df %>%
    group_by(Index, Name) %>%
    summarise(
      Mean_InterDDG = mean(InterDDG, na.rm = TRUE),
      SD_InterDDG = sd(InterDDG, na.rm = TRUE),
      .groups = "drop"
    ) %>%
    mutate(Facet_Label = facet_label, Metric = "PDB Stability (InterDDG)")
  
  df_pdb_list[[sample_label]] <- summary_df
}

df_pdb_combined <- bind_rows(df_pdb_list)

p_pdb <- ggplot(df_pdb_combined, aes(x = factor(Index), y = Mean_InterDDG)) +
  geom_hline(yintercept = 0, color = "black", linewidth = 0.6) +
  geom_col(fill = "#009E73", color = "black", width = 0.5, alpha = 0.85) + 
  geom_errorbar(aes(ymin = Mean_InterDDG - SD_InterDDG, ymax = Mean_InterDDG + SD_InterDDG), width = 0.2, color = "black", linewidth = 0.5) +
  facet_grid(Facet_Label ~ Metric, scales = "free_y") +
  labs(x = "Amino Acid Position (P1 - P9)", y = expression(paste("Mean ", Delta, Delta, "G (BUDE)"))) +
  theme_bw(base_size = 12) +
  theme(
    axis.title = element_text(size = 12, face = "bold"),
    axis.text = element_text(size = 10, color = "black"),
    strip.text.x = element_text(size = 13, face = "bold", color = "black"),
    strip.text.y = element_text(size = 10, face = "bold", color = "black", angle = -90),
    strip.background = element_rect(fill = "#EFEFEF", color = "black", linewidth = 1),
    panel.border = element_rect(color = "black", fill = NA, linewidth = 1),
    panel.grid.major.x = element_blank()
  )

# ==============================================================================
# Part 2: Process XAI Data (Panel B)
# ==============================================================================
log_msg("--- [2/3] Processing XAI (SHAP/LIME) Data ---")

xai_files <- list.files(path = dir_xai, pattern = ".*_length_9\\.csv$", full.names = TRUE)
df_xai_list <- list()

for (file_path in xai_files) {
  temp_xai <- read_csv(file_path, show_col_types = FALSE)
  temp_filtered <- temp_xai %>% filter(peptide %in% target_peptides)
  
  if (nrow(temp_filtered) > 0) {
    temp_long <- temp_filtered %>%
      pivot_longer(cols = starts_with("pos_"), names_to = "Position", values_to = "XAI_Score") %>%
      mutate(
        Position = as.integer(gsub("pos_", "", Position)),
        Facet_Label = paste0(allele, "\n(", peptide, ")")
      )
    df_xai_list[[length(df_xai_list) + 1]] <- temp_long
  }
}

df_xai_combined <- bind_rows(df_xai_list)

df_xai_summary <- df_xai_combined %>%
  group_by(mode, Facet_Label, Position) %>%
  summarize(Mean_Score = mean(XAI_Score, na.rm = TRUE), SD_Score = sd(XAI_Score, na.rm = TRUE), .groups = 'drop')

df_xai_summary$mode <- factor(df_xai_summary$mode, levels = c("SHAP", "LIME"))

p_xai <- ggplot(df_xai_summary, aes(x = factor(Position), y = Mean_Score, fill = mode)) +
  geom_hline(yintercept = 0, color = "black", linewidth = 0.6) +
  geom_col(color = "black", width = 0.6, alpha = 0.85) +
  geom_errorbar(aes(ymin = Mean_Score - SD_Score, ymax = Mean_Score + SD_Score), width = 0.25, color = "black", linewidth = 0.5) +
  facet_grid(Facet_Label ~ mode, scales = "free_y") +
  scale_fill_manual(values = c("SHAP" = "#D55E00", "LIME" = "#0072B2")) +
  labs(x = "Amino Acid Position (P1 - P9)", y = "Mean Attribution Score") +
  theme_bw(base_size = 12) +
  theme(
    legend.position = "none",
    axis.title = element_text(size = 12, face = "bold"),
    axis.text = element_text(size = 10, color = "black"),
    strip.text.x = element_text(size = 13, face = "bold", color = "black"),
    # 恢复了此处的 Y 轴标签，因为现在是上下排布，必需保留
    strip.text.y = element_text(size = 10, face = "bold", color = "black", angle = -90),
    strip.background = element_rect(fill = "#EFEFEF", color = "black", linewidth = 1),
    panel.border = element_rect(color = "black", fill = NA, linewidth = 1),
    panel.grid.major.x = element_blank()
  )

# ==============================================================================
# Part 3: Combine Plots (Portrait A4)
# ==============================================================================
log_msg("--- [3/3] Assembling and Saving Final Portrait Plot ---")

# 使用 / 进行上下拼接
final_plot <- p_pdb / p_xai + 
  plot_layout(heights = c(1, 1)) + # 均分上下高度
  plot_annotation(
    tag_levels = 'A', # 自动添加大写字母 A 和 B 作为子图序号
    title = "Structural Stability vs. XAI Attribution Consensus",
    theme = theme(
      plot.title = element_text(size = 16, face = "bold", hjust = 0.5),
      plot.tag = element_text(size = 18, face = "bold") # A 和 B 的字体大小
    )
  )

out_pdf <- file.path(dir_out, "PDB_XAI_stability.pdf")

# Standard A4 Portrait dimensions (Width = 8.27, Height = 11.69 inches)
ggsave(filename = out_pdf, plot = final_plot, width = 8, height = 11, device = "pdf", dpi = 300)

log_msg("SUCCESS: Saved combined plot to -> ", out_pdf)
log_msg("=== Pipeline Finished ===")