#!/usr/bin/env Rscript

# ==============================================================================
# Script Name: 03.XAI_confliction.r
# Description: Quantifies the agreement between SHAP and LIME attribution scores
#              using Spearman and Kendall correlation. Automatically identifies 
#              peptide-level examples where the two XAI methods strongly disagree 
#              (e.g., conflicting P9 effects) and visualizes their attribution profiles.
# ==============================================================================

# 1. Load Required Packages
# ==============================================================================
suppressPackageStartupMessages({
  library(dplyr)
  library(tidyr)
  library(readr)
  library(ggplot2)
  library(ggpubr)
  library(ggrastr)
})

# Logging function for nohup tracking
log_message <- function(msg) {
  cat(sprintf("[%s] %s\n", format(Sys.time(), "%Y-%m-%d %H:%M:%S"), msg))
}

log_message("Starting SHAP vs LIME Conflict & Agreement analysis...")

# 2. Define File Paths & Directories
# ==============================================================================
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

# 4. Load and Process XAI Data
# ==============================================================================
log_message("Loading XAI data (length_9.csv) for agreement analysis...")

xai_files <- list.files(path = dir_xai, pattern = ".*_length_9\\.csv$", full.names = TRUE)
df_xai_list <- list()

for (file_path in xai_files) {
  temp_xai <- read_csv(file_path, show_col_types = FALSE)
  
  if (nrow(temp_xai) > 0) {
    temp_long <- temp_xai %>%
      pivot_longer(
        cols = starts_with("pos_"),
        names_to = "Position",
        values_to = "XAI_Score"
      ) %>%
      mutate(Position = as.integer(gsub("pos_", "", Position)))
    
    df_xai_list[[length(df_xai_list) + 1]] <- temp_long
  }
}

df_xai_combined <- bind_rows(df_xai_list)
log_message(paste("Loaded", nrow(df_xai_combined), "positional attribution data points."))

# Map tool names
df_xai_combined <- df_xai_combined %>%
  mutate(tool = ifelse(tool %in% names(name_mapping), name_mapping[tool], tool))

# 5. Merge SHAP and LIME side-by-side
# ==============================================================================
log_message("Aligning SHAP and LIME scores for paired comparison...")

df_shap <- df_xai_combined %>% filter(mode == "SHAP") %>% rename(SHAP_Score = XAI_Score) %>% select(-mode)
df_lime <- df_xai_combined %>% filter(mode == "LIME") %>% rename(LIME_Score = XAI_Score) %>% select(-mode)

# Inner join ensures we only compare where BOTH methods ran successfully
df_matched <- inner_join(
  df_shap, df_lime, 
  by = c("allele", "length", "peptide", "tool", "bind_result_tool", "bind_result_base", "Position")
)
log_message(paste("Successfully paired", nrow(df_matched), "SHAP/LIME positional scores."))

# 6. Global Agreement Statistics (Kendall & Spearman)
# ==============================================================================
log_message("Calculating global Kendall and Spearman correlation across tools...")

global_stats <- df_matched %>%
  group_by(tool) %>%
  summarize(
    N_Positions = n(),
    Spearman_R = round(cor(SHAP_Score, LIME_Score, method = "spearman", use = "complete.obs"), 4),
    Kendall_Tau = round(cor(SHAP_Score, LIME_Score, method = "kendall", use = "complete.obs"), 4),
    .groups = 'drop'
  ) %>%
  arrange(desc(Spearman_R))

stats_out_path <- file.path(dir_out, "04_Global_SHAP_LIME_Agreement_Stats.csv")
write_csv(global_stats, stats_out_path)
log_message(paste("Saved global agreement statistics to:", stats_out_path))

# 7. Identify Peptide-Level Disagreements
# ==============================================================================
log_message("Identifying peptide-level examples with strong SHAP/LIME conflicts...")

# Calculate agreement per peptide per tool
peptide_stats <- df_matched %>%
  group_by(tool, allele, peptide) %>%
  summarize(
    Spearman_R = cor(SHAP_Score, LIME_Score, method = "spearman", use = "complete.obs"),
    .groups = 'drop'
  ) %>%
  # Filter out NAs which might occur if variance is 0
  filter(!is.na(Spearman_R))

# Select the top 8 MOST CONFLICTING examples (Lowest Spearman R) across major tools
# To ensure variety, we pick the worst agreement case from 8 different tools
conflict_examples <- peptide_stats %>%
  group_by(tool) %>%
  slice_min(order_by = Spearman_R, n = 1) %>%
  ungroup() %>%
  arrange(Spearman_R) %>%
  head(8)

log_message("Extracted top 8 conflict examples for visualization.")

# Prepare data for line plots of these specific examples
df_conflict_plot <- df_matched %>%
  inner_join(conflict_examples %>% select(tool, peptide, Spearman_R), by = c("tool", "peptide")) %>%
  pivot_longer(cols = c("SHAP_Score", "LIME_Score"), names_to = "Method", values_to = "Score") %>%
  mutate(
    Method = gsub("_Score", "", Method),
    Facet_Label = paste0(tool, "\n", peptide, "\n(R = ", round(Spearman_R, 2), ")")
  )

# 8. Visualization Setup (Vertical A4 Stacked)
# ==============================================================================
log_message("Generating comprehensive A4 figure for reviewer...")

vertical_theme <- theme_bw(base_size = 10) +
  theme(
    legend.position = "bottom",
    plot.title = element_text(size = 12, face = "bold", hjust = 0.5),
    axis.title = element_text(size = 10),
    axis.text.x = element_text(size = 9),
    axis.text.y = element_text(size = 9),
    strip.text = element_text(size = 8, face = "bold"),
    strip.background = element_rect(fill = "grey90", color = "black", linewidth = 0.5)
  )

# --- PLOT A: Global Scatter Plot ---
p_global_scatter <- ggplot(df_matched, aes(x = SHAP_Score, y = LIME_Score)) +
  rasterise(geom_point(alpha = 0.3, size = 0.5, color = "grey30")) +
  geom_smooth(method = "lm", color = "red", linetype = "dashed", se = FALSE, linewidth = 0.6) +
  facet_wrap(~ tool, scales = "free", ncol = 4) +
  stat_cor(method = "spearman", label.x.npc = "left", label.y.npc = "top", size = 2.5, color = "darkblue") +
  labs(
    title = "Global Agreement between SHAP and LIME Attribution Scores",
    subtitle = "Spearman correlation calculated across all positional attributions",
    x = "SHAP Score", y = "LIME Score"
  ) +
  vertical_theme

# --- PLOT B: Conflict Examples (Attribution Profiles) ---
p_conflict_lines <- ggplot(df_conflict_plot, aes(x = Position, y = Score, color = Method, group = Method)) +
  geom_hline(yintercept = 0, linetype = "solid", color = "grey80", linewidth = 0.5) +
  geom_line(linewidth = 0.8) +
  geom_point(size = 2) +
  facet_wrap(~ Facet_Label, scales = "free_y", ncol = 4) +
  scale_color_manual(values = c("SHAP" = "#F8766D", "LIME" = "#619CFF")) +
  scale_x_continuous(breaks = 1:9) +
  labs(
    title = "Peptide-Level Examples of SHAP vs LIME Disagreement",
    subtitle = "Showcasing divergent positional importance (e.g., contrasting P9 effects) in low-correlation cases",
    x = "Amino Acid Position (1 to 9)", y = "Attribution Score"
  ) +
  vertical_theme +
  theme(panel.grid.minor.x = element_blank())

# 9. Assemble and Save to Vertical A4
# ==============================================================================
log_message("Assembling final vertical A4 figure...")

conflict_master_plot <- ggarrange(
  p_global_scatter, p_conflict_lines,
  nrow = 2, ncol = 1,
  labels = c("A", "B"),
  font.label = list(size = 14, face = "bold"),
  heights = c(1.2, 1) # Give global scatter slightly more room
)

out_pdf <- file.path(dir_out, "04_XAI_Agreement_Conflict_Combined.pdf")
ggsave(filename = out_pdf, plot = conflict_master_plot, width = 8, height = 11, device = "pdf")

log_message(paste("Saved Master A4 PDF to:", out_pdf))
log_message("Analysis finished successfully! Check the CSV for hard numbers and the PDF for visualizations.")