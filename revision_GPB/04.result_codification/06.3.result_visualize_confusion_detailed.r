################################################################
# Script: 06.3.result_visualize_confusion_detailed.r
# Description: Extract detailed confusion metrics & AUROC/AUPRC, 
#              process across multiple folds in parallel, and plot 
#              them on a vertically arranged A4 layout.
# Author: Guojia Wu & AI Assistant
################################################################

library(data.table)
library(dplyr)
library(tidyr)
library(ggplot2)
library(grid)
library(ggpubr)
library(parallel)
library(argparse)
library(pROC)

# 1. Parse Arguments
parser <- ArgumentParser(description='Generate Detailed Confusion Metrics Plots (Parallel Folds)')
parser$add_argument('fold', nargs = '?', default = 'all', 
                    help = 'Fold name to process (e.g., 1_vs_9), or "all" for all folds (Default: all)')
parser$add_argument('--cores', type = 'integer', default = 4,
                    help = 'Number of cores for parallel fold processing (Default: 4)')
opt <- parser$parse_args()

target_fold <- opt$fold
num_cores <- opt$cores

cat(sprintf("[%s] >>> Starting Detailed Visualization Pipeline. Target Fold: %s, Cores: %d\n", Sys.time(), target_fold, num_cores))

# 2. Path Definitions
path_base <- "/data1/wuguojia/data/mhc_benchmark/revision"
path_analysis <- file.path(path_base, "04.result_analysis")
path_visualize <- file.path(path_base, "05.result_visualize")

if (target_fold == "all") {
    all_dirs <- list.dirs(path_analysis, full.names = FALSE, recursive = FALSE)
    valid_folds <- all_dirs[nchar(all_dirs) > 0]
} else {
    valid_folds <- c(target_fold)
}

# 3. Group Info & Definitions
class_0 <- c("consensus","netmhccons","netmhcpan_ba","netmhcpan_el","netmhcstabpan","mhcflurry_ba","mhcflurry_ps","mixmhcpred")
class_1 <- c("acme","capsnetmhc_an","capsnetmhc_ie","deepattentionpan","deephlapan")
class_2 <- c("bigmhc","stmhcpan","transphla")

class_info <- list(class_0 = class_0, class_1 = class_1, class_2 = class_2)

color_mapping <- c(
    "acme" = "#1F77B4", "bigmhc" = "#FF7F0E", "capsnetmhc_an" = "#2CA02C", 
    "capsnetmhc_ie" = "#FDE725", "consensus" = "#9467BD", "deepattentionpan" = "#8C564B", 
    "deephlapan" = "#9EDAE5", "deepnetbim" = "#7F7F7F", "mhcflurry_ba" = "#17BECF", 
    "mhcflurry_ps" = "#CE6DBD", "mixmhcpred" = "#FFBB78", "netmhccons" = "#C7C7C7", 
    "netmhcpan_ba" = "#DBDB8D", "netmhcpan_el" = "#E377C2", "netmhcstabpan" = "#BCBD22", 
    "stmhcpan" = "#D62728", "transphla" = "#4B4B4B",
    "class_0" = "#C9F0C1", "class_1" = "#7ED957", "class_2" = "#145214"
)

sorted_tools <- c(class_0, class_1, class_2)

# Strictly defined target metrics and mapping for display
internal_metrics <- c("auroc", "auprc", "f1_score", "accuracy", "mcc", "precision", "sensitivity", "specificity")
display_metrics <- c("AUROC", "AUPRC", "F1-score", "Accuracy", "MCC", "Precision", "Sn", "Sp")

# Function to map bubble size safely (Logistic Function)
size_mapping <- function(score) {
    score[is.na(score)] <- 0
    min_size <- 2; max_size <- 5
    midpoint <- 0.75; steepness <- 20   
    weight <- 1 / (1 + exp(-steepness * (score - midpoint)))
    return(min_size + (max_size - min_size) * weight)
}

# Helper to safely extract AUC values
get_auc <- function(obj) { if(!is.null(obj) && !is.na(obj)) as.numeric(obj$auc) else NA_real_ }
get_auprc <- function(obj) { if(!is.null(obj) && !is.na(obj)) as.numeric(obj$auc.integral) else NA_real_ }

# 4. Core Processing Function (Per Fold)
process_fold <- function(fold) {
    cat(sprintf("[%s] [Fold: %s] Starting data extraction...\n", Sys.time(), fold))
    fold_dir_in <- file.path(path_analysis, fold)
    plot_dir_out <- file.path(path_visualize, fold)
    
    if (!dir.exists(plot_dir_out)) dir.create(plot_dir_out, recursive = TRUE)
    
    # Get all valid tool names by matching *_confusionMatrix.Rdata
    files_cm <- list.files(fold_dir_in, pattern = "_confusionMatrix\\.Rdata$", full.names = TRUE)
    files_cm <- files_cm[!grepl("deepnetbim", files_cm)] 
    
    if (length(files_cm) == 0) {
        cat(sprintf("[%s] Warning: No valid files found in %s. Skipping.\n", Sys.time(), fold))
        return(NULL)
    }
    
    tools <- gsub("_confusionMatrix\\.Rdata$", "", basename(files_cm))
    
    # ==========================================
    # STEP A: Joint Data Extraction
    # ==========================================
    data_list <- lapply(tools, function(name) {
        file_cm <- file.path(fold_dir_in, paste0(name, "_confusionMatrix.Rdata"))
        file_an <- file.path(fold_dir_in, paste0(name, "_analysis.Rdata"))
        
        if(!file.exists(file_an)) return(NULL) # Skip if analysis file is missing
        
        env_cm <- new.env(); load(file_cm, envir = env_cm)
        env_an <- new.env(); load(file_an, envir = env_an)
        
        # 1. Overall
        df_all <- data.frame(
            Group = "all", Tool = name,
            accuracy = env_cm$all_info$accuracy, sensitivity = env_cm$all_info$sensitivity,
            specificity = env_cm$all_info$specificity, precision = env_cm$all_info$precision,
            f1_score = env_cm$all_info$f1_score, mcc = env_cm$all_info$mcc,
            auroc = get_auc(env_an$all_info$auroc), auprc = get_auprc(env_an$all_info$auprc)
        )
        
        # 2. Length (8, 9, 10, 11)
        df_len_list <- list()
        for (l in 8:11) {
            cm_sub <- env_cm$len_info[env_cm$len_info$antigen_peptide_length == l, ]
            if (nrow(cm_sub) > 0) {
                auroc_val <- get_auc(env_an$len_info$auroc[[paste0(name, "_", l)]])
                auprc_val <- get_auprc(env_an$len_info$auprc[[paste0(name, "_", l)]])
                df_len_list[[as.character(l)]] <- data.frame(
                    Group = paste0("len_", l), Tool = name,
                    accuracy = cm_sub$accuracy, sensitivity = cm_sub$sensitivity,
                    specificity = cm_sub$specificity, precision = cm_sub$precision,
                    f1_score = cm_sub$f1_score, mcc = cm_sub$mcc,
                    auroc = auroc_val, auprc = auprc_val
                )
            }
        }
        df_len <- bind_rows(df_len_list)
        
        # 3. MHC (HLA-A, HLA-B, HLA-C means)
        df_hla_list <- list()
        cm_hlas <- env_cm$hla_info
        if(!is.null(cm_hlas) && nrow(cm_hlas) > 0) {
            for (i in 1:nrow(cm_hlas)) {
                h <- cm_hlas$allele[i]
                auroc_val <- get_auc(env_an$hla_info$auroc[[paste0(name, "_", h)]])
                auprc_val <- get_auprc(env_an$hla_info$auprc[[paste0(name, "_", h)]])
                df_hla_list[[h]] <- data.frame(
                    allele = h, accuracy = cm_hlas$accuracy[i], sensitivity = cm_hlas$sensitivity[i],
                    specificity = cm_hlas$specificity[i], precision = cm_hlas$precision[i],
                    f1_score = cm_hlas$f1_score[i], mcc = cm_hlas$mcc[i],
                    auroc = auroc_val, auprc = auprc_val
                )
            }
        }
        df_hla_raw <- bind_rows(df_hla_list)
        
        df_mhc <- data.frame()
        if (nrow(df_hla_raw) > 0) {
            df_mhc <- df_hla_raw %>%
                mutate(Group = case_when(
                    grepl("^HLA-A", allele) ~ "hla_a", grepl("^HLA-B", allele) ~ "hla_b",
                    grepl("^HLA-C", allele) ~ "hla_c", TRUE ~ NA_character_
                )) %>%
                filter(!is.na(Group)) %>%
                group_by(Group) %>%
                summarise(across(all_of(internal_metrics), function(x) mean(x, na.rm = TRUE)), .groups = "drop") %>%
                mutate(Tool = name)
        }
        
        bind_rows(df_all, df_len, df_mhc)
    })
    
    combined_data <- bind_rows(data_list)
    
    # Assign tool class
    combined_data$class <- sapply(combined_data$Tool, function(t) {
        for(cls in names(class_info)) { if(t %in% class_info[[cls]]) return(cls) }
        return(NA)
    })
    
    # ==========================================
    # STEP B: Data Formatting & Factoring
    # ==========================================
    data_long <- combined_data %>%
        pivot_longer(cols = all_of(internal_metrics), names_to = "Metric_Internal", values_to = "Score") %>%
        filter(is.finite(Score)) %>%
        mutate(
            Tool = factor(Tool, levels = rev(sorted_tools)),
            # Rename internal metric to display metric mapping
            Metric = case_when(
                Metric_Internal == "auroc" ~ "AUROC",
                Metric_Internal == "auprc" ~ "AUPRC",
                Metric_Internal == "f1_score" ~ "F1-score",
                Metric_Internal == "accuracy" ~ "Accuracy",
                Metric_Internal == "mcc" ~ "MCC",
                Metric_Internal == "precision" ~ "Precision",
                Metric_Internal == "sensitivity" ~ "Sn",
                Metric_Internal == "specificity" ~ "Sp"
            ),
            Metric = factor(Metric, levels = display_metrics)
        )
        
    write.csv(data_long, file = file.path(plot_dir_out, paste0("perfor_long_detailed_", fold, ".csv")), row.names = FALSE)
    
    # ==========================================
    # STEP C: Plot Generation
    # ==========================================
    cat(sprintf("[%s] [Fold: %s] Generating plots...\n", Sys.time(), fold))
    
    # --- 1. Plot Len ---
    df_len_plot <- data_long %>% filter(grepl("len_", Group)) %>%
        mutate(Group_Metric = factor(paste(Metric, Group, sep = "_"), 
               levels = paste(rep(display_metrics, each=4), rep(8:11, length(display_metrics)), sep="_len_")))
               
    plot_len <- ggplot(df_len_plot, aes(x = Group_Metric, y = Tool)) +
        geom_point(aes(size = size_mapping(Score), fill = Score), shape = 21, color = "black") +
        scale_size_identity() +
        scale_fill_gradient(low = "darkblue", high = "lightblue", name = "Score") +
        labs(title = paste("Length Metrics -", fold), x = NULL, y = NULL) +
        theme_minimal() +
        theme(panel.grid = element_blank(),
              axis.text.x = element_text(angle = 45, hjust = 1, size = 9),
              axis.text.y = element_blank(),
              axis.ticks.y = element_blank(),
              legend.position = "bottom", legend.direction = "horizontal",
              plot.margin = margin(5, 5, 15, 5))
              
    # --- 2. Plot MHC ---
    df_mhc_plot <- data_long %>% filter(grepl("hla_", Group)) %>%
        mutate(Group_Metric = factor(paste(Metric, Group, sep = "_"), 
               levels = paste(rep(display_metrics, each=3), rep(c("hla_a","hla_b","hla_c"), length(display_metrics)), sep="_")))
               
    plot_mhc <- ggplot(df_mhc_plot, aes(x = Group_Metric, y = Tool)) +
        geom_point(aes(size = size_mapping(Score), fill = Score), shape = 21, color = "black") +
        scale_size_identity() +
        scale_fill_gradient(low = "darkred", high = "#FFCCCC", name = "Score") +
        labs(title = paste("MHC Allele Metrics -", fold), x = NULL, y = NULL) +
        theme_minimal() +
        theme(panel.grid = element_blank(),
              axis.text.x = element_text(angle = 45, hjust = 1, size = 9),
              axis.text.y = element_blank(),
              axis.ticks.y = element_blank(),
              legend.position = "bottom", legend.direction = "horizontal",
              plot.margin = margin(5, 5, 15, 5))
              
    # --- 3. Plot 02 (Class Comparison across 8 Groups) ---
    target_groups <- c("all", "hla_a", "hla_b", "hla_c", "len_8", "len_9", "len_10", "len_11")
    
    # Find top 3 tools per class based on 'AUROC' in 'all' group
    setool <- data_long %>% 
        filter(Metric == "AUROC" & Group == "all" & !is.na(class)) %>%
        group_by(class) %>% arrange(desc(Score)) %>% slice_head(n = 3)
        
    df_plot02 <- data_long %>%
        filter(Tool %in% setool$Tool & Group %in% target_groups) %>%
        group_by(class, Metric, Group) %>%
        summarise(median_value = median(Score, na.rm = TRUE), .groups = "drop") %>%
        arrange(Group, Metric, desc(median_value)) %>%
        group_by(Group, Metric) %>%
        mutate(y_order = max(row_number()) - row_number() + 1) %>%
        ungroup() %>%
        mutate(Group = factor(Group, levels = target_groups))
        
    plot02 <- ggplot(df_plot02, aes(x = Metric, y = y_order, color = class, shape = class)) +
        scale_shape_manual(values = c(15, 15, 15, 15)) +
        geom_point(size = 3) + 
        scale_color_manual(values = color_mapping) +
        facet_grid(Group ~ .) +
        labs(title = "Class Medians", x = NULL, y = NULL) +
        theme_minimal() +
        theme(panel.grid = element_blank(),
              axis.text.x = element_text(angle = 45, hjust = 1, size = 9),
              axis.text.y = element_blank(), axis.ticks.y = element_blank(),
              strip.text.y = element_text(angle = 0, size = 8),
              legend.position = "bottom", legend.direction = "horizontal",
              plot.margin = margin(5, 5, 15, 5))

    # ==========================================
    # STEP D: Assembly and Export (A4 Layout)
    # ==========================================
    # Compose layout: Left vs Right width -> 4:1
    bottom_row <- ggarrange(plot_mhc, plot02, ncol = 2, widths = c(4, 1), common.legend = FALSE)
    final_plot <- ggarrange(plot_len, bottom_row, nrow = 2, heights = c(1, 1), common.legend = FALSE)
    
    pdf_out <- file.path(plot_dir_out, paste0("detailed_confusion_metrics", fold, ".pdf"))
    png_out <- file.path(plot_dir_out, paste0("detailed_confusion_metrics", fold, ".png"))
    
    # Prevent multi-threading Cairo crashes with bitmapType safely set
    options(bitmapType='cairo') 
    ggsave(pdf_out, plot = final_plot, width = 8.27, height = 11.69, units = "in", dpi = 300)
    ggsave(png_out, plot = final_plot, width = 8.27, height = 11.69, units = "in", dpi = 300, bg = "white")
    
    cat(sprintf("[%s] [Fold: %s] Success! Saved to %s\n", Sys.time(), fold, plot_dir_out))
    return(TRUE)
}

# 5. Launch Parallel Execution Over Folds
cat(sprintf("[%s] Launching parallel processing over %d folds...\n", Sys.time(), length(valid_folds)))
results <- mclapply(valid_folds, process_fold, mc.cores = num_cores)

cat(sprintf("[%s] >>> All Detailed Visualization Tasks Completed Successfully.\n", Sys.time()))