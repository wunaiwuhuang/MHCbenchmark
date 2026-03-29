#!/usr/bin/env Rscript

# ==============================================================================
# Script Name: 04.SHAP_Summary_Barplot.r
# Description: Generates a 3x2 grid summary barplot for the 3 case-study peptides.
#              Rows = Peptides (Samples), Columns = XAI Method (SHAP vs LIME).
#              Calculates mean scores across tools with standard deviation (SD) 
#              error bars to demonstrate consensus and answer the reviewer's
#              request for "ablation/SHAP summary barplots".
# ==============================================================================

# 1. Load Required Packages
# ==============================================================================
suppressPackageStartupMessages({
  library(dplyr)
  library(tidyr)
  library(readr)
  library(ggplot2)
})

# Logging function for nohup tracking
log_message <- function(msg) {
  cat(sprintf("[%s] %s\n", format(Sys.time(), "%Y-%m-%d %H:%M:%S"), msg))
}

log_message("Starting highly-condensed SHAP/LIME Summary Barplot generation...")

# 2. Define File Paths & Directories
# ==============================================================================
dir_xai <- "/data1/wuguojia/data/mhc_benchmark/attentionbase/result"
dir_out <- "/data1/wuguojia/data/mhc_benchmark/revision/07.SHAP_LIME"

if (!dir.exists(dir_out)) {
  dir.create(dir_out, recursive = TRUE)
  log_message(paste("Created output directory:", dir_out))
}

# Define the 3 case-study peptides and their corresponding alleles
target_peptides <- c("NAAERRGPL", "HVEKLARTL", "SLIARLERL")

# 3. Load and Process XAI Data
# ==============================================================================
log_message("Loading positional XAI data (length_9.csv)...")

xai_files <- list.files(path = dir_xai, pattern = ".*_length_9\\.csv$", full.names = TRUE)
df_xai_list <- list()

for (file_path in xai_files) {
  temp_xai <- read_csv(file_path, show_col_types = FALSE)
  
  # Filter only for our 3 target case-study peptides
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
        # Create a newline-separated label for the row strips (makes it fit better vertically)
        Facet_Label = paste0(allele, "\n(", peptide, ")")
      )
    
    df_xai_list[[length(df_xai_list) + 1]] <- temp_long
  }
}

df_xai_combined <- bind_rows(df_xai_list)
log_message("Successfully loaded and filtered data for the 3 case-study peptides.")

# 4. Calculate Summary Statistics (Mean & SD across tools)
# ==============================================================================
log_message("Calculating Mean and SD across all evaluated tools for each position...")

df_summary <- df_xai_combined %>%
  group_by(mode, Facet_Label, Position) %>%
  summarize(
    Mean_Score = mean(XAI_Score, na.rm = TRUE),
    SD_Score = sd(XAI_Score, na.rm = TRUE),
    .groups = 'drop'
  )

# Ensure 'mode' is a factor so SHAP always appears on the left and LIME on the right
df_summary$mode <- factor(df_summary$mode, levels = c("SHAP", "LIME"))

# Save the raw summary numbers for your reference
stats_out_path <- file.path(dir_out, "05_SHAP_LIME_Summary_Stats.csv")
write_csv(df_summary, stats_out_path)
log_message(paste("Saved statistical summary to:", stats_out_path))

# 5. Build the 3x2 Grid Visualization
# ==============================================================================
log_message("Generating 3x2 grid Barplots with Error Bars...")

p_grid <- ggplot(df_summary, aes(x = factor(Position), y = Mean_Score, fill = mode)) +
  geom_hline(yintercept = 0, color = "black", linewidth = 0.6) + # Baseline
  geom_col(color = "black", width = 0.6, alpha = 0.85) +
  geom_errorbar(
    aes(ymin = Mean_Score - SD_Score, ymax = Mean_Score + SD_Score), 
    width = 0.25, color = "black", linewidth = 0.5
  ) +
  # This is the magic line: Rows = Facet_Label (Peptides), Columns = mode (SHAP/LIME)
  facet_grid(Facet_Label ~ mode, scales = "free_y") +
  
  # Color coding: Red/Orange for SHAP, Blue for LIME
  scale_fill_manual(values = c("SHAP" = "#D55E00", "LIME" = "#0072B2")) +
  
  labs(
    title = "Summary of Positional Attribution Scores for Case-Study Peptides",
    subtitle = "Bars represent the mean attribution score across top-performing tools; error bars indicate \u00b11 SD",
    x = "Amino Acid Position (P1 - P9)",
    y = "Mean Attribution Score"
  ) +
  theme_bw(base_size = 12) +
  theme(
    legend.position = "none", # Legend is redundant because column strips say SHAP/LIME
    plot.title = element_text(size = 14, face = "bold", hjust = 0.5),
    plot.subtitle = element_text(size = 10, hjust = 0.5, color = "grey40"),
    axis.title = element_text(size = 12, face = "bold"),
    axis.text = element_text(size = 10, color = "black"),
    
    # Customize the Strip (Facet) Backgrounds and Text
    strip.text.x = element_text(size = 13, face = "bold", color = "black"), # SHAP and LIME titles
    strip.text.y = element_text(size = 10, face = "bold", color = "black", angle = -90), # Peptide titles
    strip.background = element_rect(fill = "#EFEFEF", color = "black", linewidth = 1),
    
    panel.border = element_rect(color = "black", fill = NA, linewidth = 1),
    panel.grid.major.x = element_blank() # Remove vertical grid lines for a cleaner barplot look
  )

# 6. Output to PDF
# ==============================================================================
out_pdf <- file.path(dir_out, "05_SHAP_LIME_Summary_Grid.pdf")

# Saving as a standard A4 portrait PDF (width 8.27, height 11.69)
ggsave(filename = out_pdf, plot = p_grid, width = 8, height = 8, device = "pdf")

log_message(paste("Saved perfectly aligned 3x2 Grid Plot to:", out_pdf))
log_message("All tasks completed successfully! Ready for submission.")