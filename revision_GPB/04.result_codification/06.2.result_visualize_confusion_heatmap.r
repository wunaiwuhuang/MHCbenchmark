################################################################
# Script: 06.result_visualize_confusion.r
# Description: Extract overall confusion matrix metrics and generate 
#              a publication-ready heatmap ordered by Comprehensive Score.
#              (Updated: Formal names, compact sizes, specific metric order)
# Author: Guojia Wu (Refactored/Assisted)
################################################################

library(data.table)
library(dplyr)
library(parallel)
library(argparse)
library(ComplexHeatmap)
library(circlize)
library(grid)

# 1. Parse Arguments
parser <- ArgumentParser(description='Generate Heatmap for Confusion Matrix Metrics')
parser$add_argument('fold', nargs = '?', default = 'all', 
                    help = 'Fold name to process (e.g., 1_vs_9), or "all" for all folds (Default: all)')
opt <- parser$parse_args()
target_fold <- opt$fold

cat(sprintf("[%s] >>> Starting Heatmap Visualization Pipeline for fold: %s\n", Sys.time(), target_fold))

# 2. Path Definitions
path_base <- "/data1/wuguojia/data/mhc_benchmark/revision"
path_analysis <- file.path(path_base, "04.result_analysis")
path_visualize <- file.path(path_base, "05.result_visualize")

# 3. Formal Name Mapping
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

# 4. Explicit Directory Mapping
if (target_fold == "all") {
    all_dirs <- list.dirs(path_analysis, full.names = FALSE, recursive = FALSE)
    valid_folds <- all_dirs[all_dirs != ""]
} else {
    valid_folds <- c(target_fold)
}

if (length(valid_folds) == 0) {
    stop(sprintf("[%s] Error: No valid fold directories found in %s\n", Sys.time(), path_analysis))
}

# 5. Helper Function: Extract Data from a Single File
extract_metrics <- function(file_path) {
    name <- gsub("_confusionMatrix\\.Rdata$", "", basename(file_path))
    
    temp_env <- new.env()
    load(file_path, envir = temp_env)
    
    if (!"all_info" %in% ls(temp_env)) return(NULL)
    
    df <- temp_env$all_info
    
    # Target core columns needed for the updated requirement
    target_cols <- c("comprehensive", "mcc", "f1_score", "accuracy", "precision", "sensitivity", "specificity")
    
    for (col in target_cols) {
        if (!col %in% colnames(df)) df[[col]] <- NA
    }
    
    result_row <- df[, target_cols, drop = FALSE]
    result_row$Tool <- name
    
    rm(temp_env)
    return(result_row)
}

# 6. Core Loop: Process Each Fold and Draw Heatmap
num_cores <- 20 

for (fold in valid_folds) {
    fold_dir_in <- file.path(path_analysis, fold)
    plot_dir_out <- file.path(path_visualize, fold)
    
    if (!dir.exists(plot_dir_out)) {
        dir.create(plot_dir_out, recursive = TRUE)
        cat(sprintf("[%s] Created output directory: %s\n", Sys.time(), plot_dir_out))
    }
    
    cat(sprintf("[%s] Processing fold: %s\n", Sys.time(), fold))
    files <- list.files(fold_dir_in, pattern = "_confusionMatrix\\.Rdata$", full.names = TRUE)
    
    if (length(files) == 0) {
        cat(sprintf("[%s] Warning: No files found in %s. Skipping.\n", Sys.time(), fold_dir_in))
        next
    }
    
    cat(sprintf("[%s] Extracting data from %d files using %d cores...\n", Sys.time(), length(files), num_cores))
    extracted_list <- mclapply(files, extract_metrics, mc.cores = num_cores, mc.preschedule = FALSE)
    
    # Remove NULLs dynamically without relying on purrr
    extracted_list <- Filter(Negate(is.null), extracted_list)
    metrics_df <- bind_rows(extracted_list) 
    
    if (nrow(metrics_df) == 0) {
        cat(sprintf("[%s] Warning: Extracted dataframe is empty. Skipping plot.\n", Sys.time()))
        next
    }
    
    # -----------------------------------------------------------------
    # STEP A: Data Formatting, Mapping, and Sorting
    # -----------------------------------------------------------------
    # 1. Apply formal tool names
    metrics_df <- metrics_df %>%
        mutate(Tool = ifelse(Tool %in% names(name_mapping), name_mapping[Tool], Tool))
    
    # 2. Sort from highest to lowest Comprehensive score
    metrics_df <- metrics_df %>%
        arrange(desc(comprehensive))
    
    # 3. Rename columns to formal presentation names
    metrics_df <- metrics_df %>%
        rename(
            `Comprehensive` = comprehensive,
            `MCC`           = mcc,
            `F1-score`      = f1_score,
            `Accuracy`      = accuracy,
            `Precision`     = precision,
            `Sn`            = sensitivity,
            `Sp`            = specificity
        )
    
    # Convert to matrix
    rownames_tools <- metrics_df$Tool
    col_order <- c("Comprehensive", "MCC", "F1-score", "Accuracy", "Precision", "Sn", "Sp")
    metrics_matrix <- as.matrix(metrics_df[, col_order])
    rownames(metrics_matrix) <- rownames_tools
    
    # -----------------------------------------------------------------
    # STEP B: Heatmap Visualization Parameters
    # -----------------------------------------------------------------
    min_val <- min(metrics_matrix, na.rm = TRUE)
    max_val <- max(metrics_matrix, na.rm = TRUE)
    mid_val <- (min_val + max_val) / 2
    
    #col_fun <- colorRamp2(c(min_val, mid_val, max_val), c("#313695", "white", "#a50026"))
    #col_fun <- colorRamp2(c(0,0.8,1), c("#CFE8F3", "#FDFDFD", "#FFCFCF"))
    col_fun <- colorRamp2(
        c(0.5, 0.7, 0.95), 
        c("#6699CC", "white", "#E68A8A") 
    )
    
    ht <- Heatmap(
        metrics_matrix,
        name = "Value",
        col = col_fun,
        
        # Row parameters
        cluster_rows = FALSE,      
        row_names_side = "left",
        row_names_gp = gpar(fontsize = 8, fontface = "bold"), # Reduced to 8
        
        # Column parameters
        cluster_columns = FALSE,   
        column_names_side = "bottom", # Moved to bottom
        column_names_rot = 0,         # Rotation set to 0 (horizontal)
        column_names_gp = gpar(fontsize = 8), # Reduced to 8
        
        # Cell parameters
        cell_fun = function(j, i, x, y, width, height, fill) {
            # White text for dark backgrounds, Black for light backgrounds
            # text_color <- ifelse(metrics_matrix[i, j] > mid_val + (max_val-mid_val)*0.5 | metrics_matrix[i, j] < mid_val - (mid_val-min_val)*0.5, "white", "black")
            text_color <- ifelse(metrics_matrix[i, j] > mid_val + (max_val-mid_val)*0.5 | metrics_matrix[i, j] < mid_val - (mid_val-min_val)*0.5, "black", "black")            
            grid.text(sprintf("%.3f", metrics_matrix[i, j]), x, y, 
                      gp = gpar(fontsize = 7, col = text_color)) # Internal text reduced to 7
        },
        
        rect_gp = gpar(col = "white", lwd = 1.5), 
        border = TRUE,
        column_title = sprintf("Tool Performance Overview (Fold: %s)", fold),
        column_title_gp = gpar(fontsize = 12, fontface = "bold")
    )
    
    # -----------------------------------------------------------------
    # STEP C: Save Plot (Shrunk Canvas)
    # -----------------------------------------------------------------
    pdf_out <- file.path(plot_dir_out, paste0("heatmap_metrics_overall_", fold, ".pdf"))
    png_out <- file.path(plot_dir_out, paste0("heatmap_metrics_overall_", fold, ".png"))
    
    # Shrunk the overall canvas width and height for a more compact look
    pdf(pdf_out, width = 6.5, height = 4.5)
    draw(ht, padding = unit(c(1, 1, 1, 1), "cm"))
    dev.off()
    
    png(png_out, width = 6.5, height = 4.5, units = "in", res = 300)
    draw(ht, padding = unit(c(1, 1, 1, 1), "cm"))
    dev.off()
    
    cat(sprintf("[%s] >>> Heatmap saved successfully to %s\n", Sys.time(), plot_dir_out))
}

cat(sprintf("[%s] >>> All Heatmap Visualization Tasks Completed Successfully.\n", Sys.time()))