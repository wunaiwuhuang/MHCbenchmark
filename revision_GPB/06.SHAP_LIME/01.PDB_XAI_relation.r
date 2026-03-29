#!/usr/bin/env Rscript

# ==============================================================================
# Script Name: 01.PDB_XAI_relation.r
# Description: Merges PDB ensemble ddG data with XAI attribution scores (SHAP/LIME).
#              Maps tool names to formal names and generates TWO vertical A4 pages:
#              Page 1: Scatter + Spearman (SHAP top, LIME bottom)
#              Page 2: Boxplot + Wilcoxon (SHAP top, LIME bottom)
# ==============================================================================

# 1. Load Required Packages
# ==============================================================================
suppressPackageStartupMessages({
  library(dplyr)
  library(tidyr)
  library(readr)
  library(ggplot2)
  library(ggpubr)
})

# Logging function for nohup tracking
log_message <- function(msg) {
  cat(sprintf("[%s] %s\n", format(Sys.time(), "%Y-%m-%d %H:%M:%S"), msg))
}

log_message("Starting PDB and XAI relation analysis script...")

# 2. Define File Paths & Directories
# ==============================================================================
dir_pdb <- "/data1/wuguojia/data/mhc_benchmark/revision/06.PDB_construction/reviewer_response_outputs"
dir_xai <- "/data1/wuguojia/data/mhc_benchmark/attentionbase/result"
dir_out <- "/data1/wuguojia/data/mhc_benchmark/revision/07.SHAP_LIME"

if (!dir.exists(dir_out)) {
  dir.create(dir_out, recursive = TRUE)
  log_message(paste("Created output directory:", dir_out))
} else {
  log_message(paste("Output directory exists:", dir_out))
}

# 3. Define Formal Tool Name Mapping
# ==============================================================================
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

# 4. Load and Process ddG Data from PDB Ensembles
# ==============================================================================
log_message("Processing PDB ddG data...")

peptide_map <- list(
  "01" = "NAAERRGPL",
  "02" = "HVEKLARTL",
  "03" = "SLIARLERL"
)

df_ddg_list <- list()

for (sample_id in names(peptide_map)) {
  file_path <- file.path(dir_pdb, paste0(sample_id, "_raw_combined.csv"))
  if (file.exists(file_path)) {
    temp_df <- read_csv(file_path, show_col_types = FALSE)
    summary_df <- temp_df %>%
      group_by(Index) %>%
      summarize(Mean_ddG = mean(InterDDG, na.rm = TRUE), .groups = 'drop') %>%
      mutate(
        Peptide = peptide_map[[sample_id]],
        Sample_ID = sample_id,
        Position = as.integer(Index)
      ) %>%
      select(Sample_ID, Peptide, Position, Mean_ddG)
    df_ddg_list[[sample_id]] <- summary_df
  }
}

df_ddg_combined <- bind_rows(df_ddg_list)
log_message(paste("Successfully aggregated ddG data for", nrow(df_ddg_combined), "positions."))

# 5. Load and Process XAI Data (SHAP/LIME)
# ==============================================================================
log_message("Processing XAI attribution data...")

xai_files <- list.files(path = dir_xai, pattern = ".*_length_9\\.csv$", full.names = TRUE)

target_peptides <- unname(unlist(peptide_map))
df_xai_list <- list()

for (file_path in xai_files) {
  temp_xai <- read_csv(file_path, show_col_types = FALSE)
  temp_filtered <- temp_xai %>% filter(peptide %in% target_peptides)
  
  if (nrow(temp_filtered) > 0) {
    temp_long <- temp_filtered %>%
      pivot_longer(
        cols = starts_with("pos_"),
        names_to = "Position",
        values_to = "XAI_Score"
      ) %>%
      mutate(
        Position = as.integer(gsub("pos_", "", Position)),
        Peptide = peptide
      ) %>%
      select(mode, tool, Peptide, Position, XAI_Score)
    df_xai_list[[length(df_xai_list) + 1]] <- temp_long
  }
}

df_xai_combined <- bind_rows(df_xai_list)
log_message("Successfully processed XAI data.")

# 6. Merge, Map Names, and Apply Biophysical Threshold
# ==============================================================================
log_message("Merging data and applying formal tool names...")

final_df <- df_xai_combined %>%
  inner_join(df_ddg_combined, by = c("Peptide", "Position")) %>%
  mutate(
    # Apply formal name mapping. If not found in mapping, keep original name.
    tool = ifelse(tool %in% names(name_mapping), name_mapping[tool], tool),
    
    # Apply threshold
    Residue_Type = ifelse(Mean_ddG >= 4.184, "Critical (\U2265 4.184)", "Non-Critical (< 4.184)"),
    Residue_Type = factor(Residue_Type, levels = c("Non-Critical (< 4.184)", "Critical (\U2265 4.184)"))
  )

write_csv(final_df, file.path(dir_out, "merged_ddG_XAI_data.csv"))
log_message("Saved analytical dataset.")

# 7. Visualization Setups
# ==============================================================================
log_message("Generating subplots for vertical A4 layouts...")

# Clean and readable theme for vertical stacked plots
vertical_theme <- theme_bw(base_size = 10) +
  theme(
    legend.position = "bottom",
    plot.title = element_text(size = 12, face = "bold", hjust = 0.5),
    axis.title = element_text(size = 10),
    axis.text.x = element_text(size = 9, angle = 0, hjust = 1),
    axis.text.y = element_text(size = 9),
    strip.text = element_text(size = 9, face = "bold"),
    strip.background = element_rect(fill = "grey90", color = "black", linewidth = 0.5)
  )

# Separate SHAP and LIME data
df_shap <- final_df %>% filter(mode == "SHAP")
df_lime <- final_df %>% filter(mode == "LIME")

# --- SCATTER PLOTS (Spearman) ---
p_shap_scatter <- ggplot(df_shap, aes(x = Mean_ddG, y = XAI_Score)) +
  geom_point(aes(color = Peptide), size = 1.5, alpha = 0.7) +
  geom_smooth(method = "lm", color = "black", linetype = "dashed", se = FALSE, linewidth = 0.6) +
  facet_wrap(~ tool, scales = "free_y", ncol = 4) +
  stat_cor(method = "spearman", label.x.npc = "left", label.y.npc = "top", size = 3) +
  labs(title = "SHAP: Correlation between Computed \U0394\U0394G and Attribution Score", 
       x = "Computed Mean \U0394\U0394G (kJ/mol)", y = "SHAP Score") +
  vertical_theme

p_lime_scatter <- ggplot(df_lime, aes(x = Mean_ddG, y = XAI_Score)) +
  geom_point(aes(color = Peptide), size = 1.5, alpha = 0.7) +
  geom_smooth(method = "lm", color = "black", linetype = "dashed", se = FALSE, linewidth = 0.6) +
  facet_wrap(~ tool, scales = "free_y", ncol = 4) +
  stat_cor(method = "spearman", label.x.npc = "left", label.y.npc = "top", size = 3) +
  labs(title = "LIME: Correlation between Computed \U0394\U0394G and Attribution Score", 
       x = "Computed Mean \U0394\U0394G (kJ/mol)", y = "LIME Score") +
  vertical_theme + theme(legend.position = "none") # Share top legend

# --- BOXPLOTS (Wilcoxon) ---
p_shap_box <- ggplot(df_shap, aes(x = Residue_Type, y = XAI_Score, fill = Residue_Type)) +
  geom_boxplot(alpha = 0.7, outlier.shape = NA, linewidth = 0.5) +
  geom_jitter(width = 0.2, size = 1.2, color = "black", alpha = 0.5) +
  facet_wrap(~ tool, scales = "free_y", ncol = 4) +
  stat_compare_means(method = "wilcox.test", label = "p.format", size = 3.2, vjust = -0.5) +
  scale_fill_manual(values = c("Non-Critical (< 4.184)" = "#619CFF", "Critical (\U2265 4.184)" = "#F8766D")) +
  labs(title = "SHAP: Attribution Score Distribution by Energetic Importance", 
       x = "Biophysical Importance (Computed \U0394\U0394G)", y = "SHAP Score") +
  vertical_theme

p_lime_box <- ggplot(df_lime, aes(x = Residue_Type, y = XAI_Score, fill = Residue_Type)) +
  geom_boxplot(alpha = 0.7, outlier.shape = NA, linewidth = 0.5) +
  geom_jitter(width = 0.2, size = 1.2, color = "black", alpha = 0.5) +
  facet_wrap(~ tool, scales = "free_y", ncol = 4) +
  stat_compare_means(method = "wilcox.test", label = "p.format", size = 3.2, vjust = -0.5) +
  scale_fill_manual(values = c("Non-Critical (< 4.184)" = "#619CFF", "Critical (\U2265 4.184)" = "#F8766D")) +
  labs(title = "LIME: Attribution Score Distribution by Energetic Importance", 
       x = "Biophysical Importance (Computed \U0394\U0394G)", y = "LIME Score") +
  vertical_theme + theme(legend.position = "none") # Share top legend

# 8. Assemble and Save to Vertical A4
# ==============================================================================
log_message("Assembling final vertical A4 figures...")

# Page 1: Scatter Combined (SHAP top, LIME bottom)
scatter_combined <- ggarrange(
  p_shap_scatter, p_lime_scatter,
  nrow = 2, ncol = 1,
  labels = c("A", "B"),
  font.label = list(size = 14, face = "bold"),
  heights = c(1.05, 1) # Give top plot slightly more space for the legend
)
out_scatter <- file.path(dir_out, "01_Scatter_Spearman_Combined.pdf")
# A4 Portrait: width 8, height 11
ggsave(filename = out_scatter, plot = scatter_combined, width = 8, height = 11, device = "pdf")
log_message(paste("Saved Scatter Combined A4 PDF to:", out_scatter))

# Page 2: Boxplot Combined (SHAP top, LIME bottom)
box_combined <- ggarrange(
  p_shap_box, p_lime_box,
  nrow = 2, ncol = 1,
  labels = c("A", "B"),
  font.label = list(size = 14, face = "bold"),
  heights = c(1.05, 1) # Give top plot slightly more space for the legend
)
out_box <- file.path(dir_out, "02_Boxplot_Wilcoxon_Combined.pdf")
ggsave(filename = out_box, plot = box_combined, width = 8, height = 11, device = "pdf")
log_message(paste("Saved Boxplot Combined A4 PDF to:", out_box))

log_message("Process completely finished! Both standard vertical A4 figures are ready.")