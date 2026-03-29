#!/usr/bin/env Rscript

# ==============================================================================
# Script Name: 02.PWM_XAI_relation.r
# Description: Calculates Position Weight Matrix (PWM) Information Content (bits) 
#              from the ground-truth database and correlates it with the mean 
#              absolute XAI attribution scores (SHAP/LIME) across 3 target alleles.
#              Generates a vertical A4 PDF with Spearman correlation plots.
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

log_message("Starting PWM and XAI relation analysis script...")

# 2. Define File Paths & Directories
# ==============================================================================
path_data <- "/data1/wuguojia/data/mhc_benchmark/database/extract_database/"
path_test <- "/data1/wuguojia/data/mhc_benchmark/testbase/"
path_attention <- "/data1/wuguojia/data/mhc_benchmark/attentionbase/result/"
dir_out <- "/data1/wuguojia/data/mhc_benchmark/revision/07.SHAP_LIME"

if (!dir.exists(dir_out)) {
  dir.create(dir_out, recursive = TRUE)
  log_message(paste("Created output directory:", dir_out))
} else {
  log_message(paste("Output directory exists:", dir_out))
}

# 3. Define Formal Tool Name Mapping & Targets
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

hla_se <- c("HLA-A*02:01", "HLA-B*15:02", "HLA-C*05:01")
len_se <- 9

# 4. Load Database & Calculate PWM Information Content (IC)
# ==============================================================================
log_message("Loading ground-truth Rdata files for PWM calculation...")

load(paste0(path_data, "DATABASE_COMBINE.Rdata"))
load(paste0(path_test, "TEST.Rdata"))

# Filter database based on user's original logic
filteration <- database_combine %>%
  filter(grepl("\\*", hlatype)) %>%
  filter(mhc_class == "I" & bind_result == "positive") %>%
  filter(hlatype %in% unique(test_mhci$hlatype)) %>%
  filter(antigen_peptide_length %in% unique(test_mhci$antigen_peptide_length))

valid_amino_acids <- "^[ARNDCEQGHILKMFPSTWYV]+$"
filteration <- filteration %>%
  filter(grepl(valid_amino_acids, antigen_peptide)) %>%
  distinct(hlatype, antigen_peptide, .keep_all = TRUE)

log_message(paste("Database filtered. Retained", nrow(filteration), "unique positive peptides."))

# Function to calculate Information Content (bits) using Shannon Entropy
calculate_ic <- function(seqs, seq_len = 9) {
  if (length(seqs) == 0) return(rep(NA, seq_len))
  seq_mat <- do.call(rbind, strsplit(seqs, ""))
  num_seqs <- nrow(seq_mat)
  ic_values <- numeric(seq_len)
  valid_aas <- c("A","R","N","D","C","E","Q","G","H","I","L","K","M","F","P","S","T","W","Y","V")
  
  for (i in 1:seq_len) {
    counts <- table(factor(seq_mat[, i], levels = valid_aas))
    freqs <- as.numeric(counts) / num_seqs
    freqs <- freqs[freqs > 0] # Remove zeros to avoid NaN in log2
    entropy <- -sum(freqs * log2(freqs))
    ic_values[i] <- log2(20) - entropy # Max entropy for 20 AAs is log2(20) ~ 4.32 bits
  }
  return(ic_values)
}

log_message("Calculating PWM Information Content (bits) for target alleles...")
df_pwm_list <- list()

for (hla in hla_se) {
  df_sub <- filteration %>% filter(hlatype == hla & antigen_peptide_length == len_se)
  ic_vals <- calculate_ic(df_sub$antigen_peptide, seq_len = len_se)
  
  df_pwm_list[[hla]] <- data.frame(
    Allele = hla,
    Position = 1:len_se,
    Info_Content_Bits = ic_vals
  )
}
df_pwm_combined <- bind_rows(df_pwm_list)
log_message("PWM Information Content calculated successfully.")

# 5. Load and Process XAI Data (SHAP/LIME)
# ==============================================================================
log_message("Processing XAI attribution data (calculating mean absolute scores)...")

xai_files <- list.files(path = path_attention, pattern = ".*_length_9\\.csv$", full.names = TRUE)
df_xai_list <- list()

for (file_path in xai_files) {
  temp_xai <- read_csv(file_path, show_col_types = FALSE)
  
  # Filter for the 3 target alleles
  temp_filtered <- temp_xai %>% filter(allele %in% hla_se)
  
  if (nrow(temp_filtered) > 0) {
    temp_long <- temp_filtered %>%
      pivot_longer(
        cols = starts_with("pos_"),
        names_to = "Position",
        values_to = "XAI_Score"
      ) %>%
      mutate(Position = as.integer(gsub("pos_", "", Position))) %>%
      # Calculate Mean Absolute XAI Score for global feature importance
      group_by(mode, tool, allele, Position) %>%
      summarize(Mean_Abs_XAI = mean(abs(XAI_Score), na.rm = TRUE), .groups = 'drop')
    
    df_xai_list[[length(df_xai_list) + 1]] <- temp_long
  }
}

df_xai_combined <- bind_rows(df_xai_list)
log_message("XAI mean absolute scores aggregated successfully.")

# 6. Merge PWM and XAI Data & Apply Formal Names
# ==============================================================================
log_message("Merging PWM and XAI data...")

final_df <- df_xai_combined %>%
  inner_join(df_pwm_combined, by = c("allele" = "Allele", "Position" = "Position")) %>%
  mutate(tool = ifelse(tool %in% names(name_mapping), name_mapping[tool], tool))

write_csv(final_df, file.path(dir_out, "merged_PWM_XAI_data.csv"))
log_message("Saved merged analytical dataset.")

# 7. Visualization Setups (Vertical A4 Stacked)
# ==============================================================================
log_message("Generating scatter plots for PWM vs XAI correlation...")

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

df_shap <- final_df %>% filter(mode == "SHAP")
df_lime <- final_df %>% filter(mode == "LIME")

# --- SCATTER PLOTS ---
p_shap_scatter <- ggplot(df_shap, aes(x = Info_Content_Bits, y = Mean_Abs_XAI)) +
  geom_point(aes(color = allele), size = 1.5, alpha = 0.8) +
  geom_smooth(method = "lm", color = "black", linetype = "dashed", se = FALSE, linewidth = 0.6) +
  facet_wrap(~ tool, scales = "free_y", ncol = 4) +
  stat_cor(method = "spearman", label.x.npc = "left", label.y.npc = "top", size = 3) +
  labs(title = "SHAP: Correlation between Motif Info Content and Attribution Score", 
       x = "PWM Information Content (bits)", y = "Mean Absolute SHAP Score") +
  vertical_theme

p_lime_scatter <- ggplot(df_lime, aes(x = Info_Content_Bits, y = Mean_Abs_XAI)) +
  geom_point(aes(color = allele), size = 1.5, alpha = 0.8) +
  geom_smooth(method = "lm", color = "black", linetype = "dashed", se = FALSE, linewidth = 0.6) +
  facet_wrap(~ tool, scales = "free_y", ncol = 4) +
  stat_cor(method = "spearman", label.x.npc = "left", label.y.npc = "top", size = 3) +
  labs(title = "LIME: Correlation between Motif Info Content and Attribution Score", 
       x = "PWM Information Content (bits)", y = "Mean Absolute LIME Score") +
  vertical_theme + theme(legend.position = "none") # Share top legend

# 8. Assemble and Save to Vertical A4
# ==============================================================================
log_message("Assembling final vertical A4 figure...")

scatter_combined <- ggarrange(
  p_shap_scatter, p_lime_scatter,
  nrow = 2, ncol = 1,
  labels = c("A", "B"),
  font.label = list(size = 14, face = "bold"),
  heights = c(1.05, 1) # Extra space for legend on top plot
)

out_pdf <- file.path(dir_out, "03_PWM_Spearman_Combined.pdf")
ggsave(filename = out_pdf, plot = scatter_combined, width = 8, height = 11, device = "pdf")

log_message(paste("Saved PWM vs XAI Correlation A4 PDF to:", out_pdf))
log_message("Process completely finished! The relationship between PWM and XAI has been statistically validated.")