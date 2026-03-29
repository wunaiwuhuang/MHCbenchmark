################################################################
# Script: 05.result_threshold_selection04.r
# Description: Visualize the Comprehensive Score across thresholds for all tools.
#              Generates a publication-ready facet plot highlighting the 
#              optimal threshold and stability zone.
#              UPDATED: Layout 3 cols, Font size 8, A4 fit, AND Formal Tool Names.
# Author: Guojia Wu (Refactored/Assisted)
################################################################

library(data.table)
library(dplyr)
library(ggplot2)
library(argparse)

# 1. Parse Arguments
parser <- ArgumentParser(description='Plot Comprehensive Score vs Threshold')
parser$add_argument('fold', nargs = '?', default = '1_vs_9', 
                    help = 'Fold name, e.g., 1_vs_4, 1_vs_9 (Default: 1_vs_9)')
opt <- parser$parse_args()
fold <- opt$fold

cat(sprintf("[%s] >>> Starting Visualization Pipeline for fold: %s\n", Sys.time(), fold))

# 2. Path Definitions
path_base <- "/data1/wuguojia/data/mhc_benchmark/revision/03.result_codification"
path_input <- file.path(path_base, "threshold_selection")
path_final <- file.path(path_input, "final")

if (!dir.exists(path_final)) {
    dir.create(path_final, recursive = TRUE)
}

# 3. Find all target files
files <- list.files(path_input, pattern = "_result_list\\.Rdata$", full.names = TRUE)

if (length(files) == 0) {
    stop(sprintf("[%s] Error: No files found in %s\n", Sys.time(), path_input))
}

cat(sprintf("[%s] Found %d tool result files to process for plotting.\n", Sys.time(), length(files)))

# ---------------------------------------------------------
# NEW: Define Name Mapping for Formal Tool Names
# ---------------------------------------------------------
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

# 4. Data Gathering Loop
plot_data_list <- list()
max_points_list <- list()

for (file_path in files) {
    # Extract raw name from filename
    raw_name <- gsub("_result_list\\.Rdata$", "", basename(file_path))
    cat(sprintf("[%s] Loading data for plotting: %s\n", Sys.time(), raw_name))
    
    # Load data
    temp_env <- new.env()
    load(file_path, envir = temp_env)
    df <- temp_env$final_result_df
    
    # Handle NA values
    df[is.na(df)] <- 0
    
    # Calculate metrics
    df <- df %>%
        mutate(
            balanced_accuracy = (sensitivity + specificity) / 2,
            normalized_mcc = (mcc + 1) / 2,
            comprehensive = 0.4 * normalized_mcc + 0.3 * f1_score + 0.3 * balanced_accuracy,
            Tool = raw_name # Temporarily use raw name
        )
    
    # Find max point and 90% stability line
    max_score <- max(df$comprehensive, na.rm = TRUE)
    optimal_idx <- which.max(df$comprehensive)
    
    max_df <- data.frame(
        Tool = raw_name,
        opt_thresh = df$threshold[optimal_idx],
        max_comp = max_score,
        line_90 = max_score * 0.9
    )
    
    plot_data_list[[raw_name]] <- df[, c("Tool", "threshold", "comprehensive")]
    max_points_list[[raw_name]] <- max_df
    
    rm(temp_env, df)
}

# Combine all data into master dataframes
master_plot_df <- bind_rows(plot_data_list)
master_max_df <- bind_rows(max_points_list)

# ---------------------------------------------------------
# NEW: Apply Formal Names to the Master Dataframes
# ---------------------------------------------------------
# Replace raw names with formal names using the mapping
# If a name is not in the mapping, it keeps the original (safe fallback)
master_plot_df$Tool <- recode(master_plot_df$Tool, !!!name_mapping)
master_max_df$Tool <- recode(master_max_df$Tool, !!!name_mapping)

# Ensure Tool is a factor with levels ordered by the formal names (optional, but good for consistency)
# This ensures the facet order matches the mapping order if desired, or alphabetical of formal names
master_plot_df$Tool <- factor(master_plot_df$Tool, levels = unique(master_plot_df$Tool))
master_max_df$Tool <- factor(master_max_df$Tool, levels = levels(master_plot_df$Tool))

cat(sprintf("[%s] >>> Data aggregation and renaming complete. Starting ggplot2 rendering...\n", Sys.time()))

# 5. Plotting (Publication-Ready Facet Grid - A4 Optimized)
p <- ggplot(master_plot_df, aes(x = threshold, y = comprehensive)) +
    # The 90% stability threshold line (red dashed)
    geom_hline(data = master_max_df, aes(yintercept = line_90), 
               color = "firebrick", linetype = "dashed", alpha = 0.6) +
    # The main performance curve
    geom_line(color = "black", linewidth = 0.6) +
    # Vertical line to pinpoint the exact optimal threshold
    geom_vline(data = master_max_df, aes(xintercept = opt_thresh), 
               color = "red", linetype = "dotted", alpha = 0.8) +
    # The peak point
    geom_point(data = master_max_df, aes(x = opt_thresh, y = max_comp), 
               color = "red", size = 1.5) +
    # Facet by tool (Now using Formal Names), 3 columns
    facet_wrap(~ Tool, scales = "free_x", ncol = 3) +
    # Labels and theme
    labs(
        title = "Comprehensive Performance Score vs. Decision Threshold",
        subtitle = "Red dot indicates optimal threshold; Red dashed line represents the 90% stability zone",
        x = "Candidate Thresholds (Tool-specific scale)",
        y = "Comprehensive Score"
    ) +
    theme_bw(base_size = 8) +
    theme(
        strip.background = element_rect(fill = "#f0f0f0", color = "black"),
        strip.text = element_text(face = "bold", size = 9),
        axis.text.x = element_text(angle = 0, hjust = 0.5, size = 7),
        axis.text.y = element_text(size = 7),
        plot.title = element_text(face = "bold", hjust = 0.5, size = 10),
        plot.subtitle = element_text(hjust = 0.5, color = "gray30", size = 8),
        axis.title = element_text(size = 8),
        panel.grid.minor = element_blank(),
        plot.margin = margin(5, 5, 5, 5, "pt")
    )

# 6. Save Outputs
pdf_output_file <- file.path(path_final, "comprehensive_score_curves_A4.pdf")
ggsave(filename = pdf_output_file, plot = p, width = 19.5, height = 28, units = "cm", device = "pdf")
cat(sprintf("[%s] >>> Success: PDF plot saved to %s\n", Sys.time(), pdf_output_file))

png_output_file <- file.path(path_final, "comprehensive_score_curves_A4.png")
ggsave(filename = png_output_file, plot = p, width = 19.5, height = 28, units = "cm", dpi = 300, device = "png")
cat(sprintf("[%s] >>> Success: PNG plot saved to %s\n", Sys.time(), png_output_file))

cat(sprintf("[%s] >>> All visualization tasks completed successfully.\n", Sys.time()))