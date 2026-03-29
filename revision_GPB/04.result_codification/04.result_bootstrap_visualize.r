#!/usr/bin/env Rscript
################################################################
# Script Name: 04.result_bootstrap_visualize.r
# Description: Visualizes the output from the statistical analysis 
#              CSV files into an integrated A4 portrait figure (PDF).
#              Excludes the 1_vs_99 fold, maps official tool names,
#              forces Arial font for Adobe Illustrator compatibility,
#              and sets X-axis text horizontally.
################################################################

library(ggplot2)
library(dplyr)
library(tidyr)
library(patchwork)
library(scales)

# 1. Configuration & Mapping
work_dir <- "/data1/wuguojia/data/mhc_benchmark/revision/05.result_visualize/Bootstrap_result"
output_file <- "05_Integrated_Statistical_Report.pdf"

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

# Helper function to map names
map_formal_names <- function(x) {
    mapped <- name_mapping[as.character(x)]
    return(ifelse(is.na(mapped), as.character(x), mapped))
}

# Standard theme settings (Forced Arial, flat x-axis, Legend hidden globally)
theme_a4 <- function() {
  theme_bw(base_family = "Arial") +
  theme(
    text = element_text(size = 9, family = "Arial"),
    title = element_text(size = 10, face = "bold", family = "Arial"),
    axis.title = element_text(size = 9, face = "bold", family = "Arial"),
    axis.text.y = element_text(size = 8, family = "Arial"),
    axis.text.x = element_text(size = 8, angle = 0, hjust = 0.5, family = "Arial"), # Angle 0 for horizontal, centered
    strip.text = element_text(size = 9, face = "bold", family = "Arial"),
    legend.position = "none" # Default no legend
  )
}

message(sprintf("[%s] >>> Setting working directory...", Sys.time()))
setwd(work_dir)

################################################################
# 2. Data Loading, Filtering & Name Mapping
################################################################
message(sprintf("[%s] >>> Loading, filtering, and mapping formal names...", Sys.time()))

df_metrics <- read.csv("01_Individual_Metrics_with_CI.csv", check.names = FALSE) %>% 
  filter(Fold != "1_vs_99") %>%
  mutate(Tool = map_formal_names(Tool))

df_delta <- read.csv("02_Statistical_Testing_Delta_AUC.csv", check.names = FALSE) %>% 
  filter(Fold != "1_vs_99") %>%
  mutate(Compared_Tool = map_formal_names(Compared_Tool),
         Reference_Tool = map_formal_names(Reference_Tool))

df_stability <- read.csv("03_Tool_Stability_Across_Folds.csv", check.names = FALSE) %>%
  mutate(Tool = map_formal_names(Tool))

# Create a master factor level for Tools based on overall performance to align all Y-axes perfectly
master_tool_order <- df_metrics %>%
  filter(Fold == "1_vs_1") %>% 
  group_by(Tool) %>%
  summarise(score = mean(AUROC_Mean, na.rm=TRUE)) %>%
  arrange(score) %>%
  pull(Tool)

best_ref_tool <- unique(df_delta$Reference_Tool)[1]

################################################################
# 3. Plot A: Performance Metrics
################################################################
message(sprintf("[%s] >>> Creating Plot A: Performance Metrics...", Sys.time()))

df_metrics_long <- df_metrics %>%
  select(Fold, Tool, starts_with("AUROC_"), starts_with("AUPRC_")) %>%
  pivot_longer(cols = starts_with("AU"), 
               names_to = c("Metric", ".value"), 
               names_pattern = "(AUROC|AUPRC)_(.*)") %>%
  mutate(
    Metric = factor(Metric, levels=c("AUROC", "AUPRC")),
    Fold = factor(Fold, levels=c("1_vs_1", "1_vs_4", "1_vs_9")),
    Tool = factor(Tool, levels = master_tool_order)
  )

plot_a <- ggplot(df_metrics_long, aes(x = Mean, y = Tool)) +
  geom_point(size=1.2) +
  geom_errorbarh(aes(xmin = CI_Lower, xmax = CI_Upper), height = 0.2) +
  facet_grid(Fold ~ Metric, scales = "free_x") + 
  theme_a4() +
  labs(title = "A. Performance Metrics (Mean with 95% CI)", x = "Value", y = "Tool")

################################################################
# 4. Plot B: Delta AUROC Effect Size 
################################################################
message(sprintf("[%s] >>> Creating Plot B: Delta AUROC...", Sys.time()))

df_delta_plot <- df_delta %>%
  mutate(
    Fold = factor(Fold, levels=c("1_vs_1", "1_vs_4", "1_vs_9")),
    Compared_Tool = factor(Compared_Tool, levels = master_tool_order)
  )

plot_b <- ggplot(df_delta_plot, aes(x = Delta_AUC, y = Compared_Tool)) +
  geom_point(color = "darkred", size=1.2) +
  geom_errorbarh(aes(xmin = Delta_CI_Lower, xmax = Delta_CI_Upper), height = 0.2, color = "darkred") +
  geom_vline(xintercept = 0, linetype = "dashed", color = "gray50") +
  geom_text(aes(x = Delta_CI_Upper + 0.005, label = Significance), 
            size = 3, hjust = 0, vjust = 0.5, color = "black", family = "Arial") +
  facet_grid(. ~ Fold) +
  scale_x_continuous(labels = label_number(accuracy = 0.01)) +
  theme_a4() +
  labs(title = paste0("B. Effect Size vs Best Tool per Fold (Ref: ", best_ref_tool, ")"), 
       x = "Delta AUROC (Mean with 95% CI)", y = "Tool")

################################################################
# 5. Plot C: Model Stability
################################################################
message(sprintf("[%s] >>> Creating Plot C: Stability...", Sys.time()))

df_stability_sorted <- df_stability %>% 
  mutate(Tool = factor(Tool, levels = master_tool_order)) %>%
  filter(!is.na(Tool)) 

plot_c <- ggplot(df_stability_sorted, aes(x = AUROC_CV_Across_Folds, y = Tool)) +
  geom_segment(aes(x=0, xend=AUROC_CV_Across_Folds, y=Tool, yend=Tool), color="gray70") +
  geom_point(aes(color = AUROC_CV_Across_Folds), size = 3) +
  scale_color_gradient(low = "royalblue", high = "red", name = "CV(%)") + 
  scale_x_continuous(labels = label_percent(scale=1)) +
  theme_a4() +
  theme(
    legend.position = "right",
    legend.title = element_text(size=8, face="bold", family="Arial"),
    legend.text = element_text(size=8, family="Arial"),
    legend.key.height = unit(0.5, "cm")
  ) +
  labs(title = "C. Cross-Fold Stability (AUROC Variation)", 
       x = "Coefficient of Variation (CV %)", y = "Tool")

################################################################
# 6. Assembly (PDF)
################################################################
message(sprintf("[%s] >>> Assembling A4 PDF...", Sys.time()))

combined_plot <- (plot_a / plot_b / plot_c) +
  plot_layout(heights = c(2.5, 1, 1.2)) 

# Explicitly use cairo_pdf which is better at embedding fonts for Illustrator
ggsave(output_file, combined_plot, width = 8, height = 11, device = cairo_pdf)

message(sprintf("[%s] >>> Success! Output saved to %s", Sys.time(), output_file))