library(data.table)
library(dplyr)
library(stringr)
library(ComplexHeatmap)
library(circlize)
library(grid)

# =====================================================================
# 1. Configuration & Path Definitions
# =====================================================================
path_input <- "/home/wuguojia/biocode/mhc_benchmark/revision_GPB/03.performance_command"
path_output <- "/data1/wuguojia/data/mhc_benchmark/revision/05.result_visualize/Resource_construction"

# Define the custom order for the tools (Rows in the heatmap).
# You can modify this array to change the display order.
custom_tool_order <- c(
  "stmhcpan","mhcflurry","netmhcpan_el","bigmhc","capsnetmhc_an", "transphla","netmhcpan_ba","mixmhcpred", "netmhccons","acme","netmhcstabpan","consensus","deepattentionpan","capsnetmhc_ie","deephlapan", "deepnetbim")

cat(sprintf("[%s] >>> Starting Resource Visualization Pipeline\n", Sys.time()))

# Create output directory if it doesn't exist
if (!dir.exists(path_output)) {
  dir.create(path_output, recursive = TRUE)
  cat(sprintf("[%s] Created output directory: %s\n", Sys.time(), path_output))
}

# =====================================================================
# 2. Helper Functions for Data Parsing
# =====================================================================
# Convert CPU string (e.g., "1304.22%") to numeric
parse_cpu <- function(cpu_str) {
  as.numeric(gsub("%", "", cpu_str))
}

# Convert Memory string (e.g., "3368.95 MB") to numeric GB for better readability
parse_memory_to_gb <- function(mem_str) {
  mb_val <- as.numeric(stringr::str_extract(mem_str, "[0-9.]+"))
  return(mb_val / 1024)
}

# Convert Time string (e.g., "120h 49m 59s") to total hours numeric
parse_time_to_hours <- function(time_str) {
  h <- as.numeric(stringr::str_extract(time_str, "\\d+(?=h)"))
  m <- as.numeric(stringr::str_extract(time_str, "\\d+(?=m)"))
  s <- as.numeric(stringr::str_extract(time_str, "\\d+(?=s)"))
  
  # Replace NAs with 0 for missing units
  h[is.na(h)] <- 0
  m[is.na(m)] <- 0
  s[is.na(s)] <- 0
  
  return(h + (m / 60) + (s / 3600))
}

# =====================================================================
# 3. Helper Function for Single Column Heatmap Generation
# =====================================================================
# Creates a heatmap for a single metric so each has its own color scale
create_column_heatmap <- function(mat, title, unit_label, base_color = "#E68A8A") {
  #min_val <- min(mat, na.rm = TRUE)
  #max_val <- max(mat, na.rm = TRUE)
  #mid_val <- (min_val + max_val) / 2
  q_low  <- quantile(mat, probs = 1/3, na.rm = TRUE)
  q_mid  <- quantile(mat, probs = 1/2, na.rm = TRUE)
  q_high <- quantile(mat, probs = 2/3, na.rm = TRUE)
  # Color mapping: Blue (Low) -> White (Mid) -> Red (High resource usage)
  col_fun <- colorRamp2(
    c(q_low, q_mid, q_high), 
    c("#6699CC", "white", base_color)
  )
  
  Heatmap(
    mat,
    name = title,
    col = col_fun,
    cluster_rows = FALSE,
    cluster_columns = FALSE,
    width = unit(4, "cm"),
    column_names_rot = 0,
    column_names_centered = TRUE,
    column_title = title,
    column_title_gp = gpar(fontsize = 12, fontface = "bold"),
    show_column_names = FALSE,
    
    # Render actual formatted values inside the cells
    cell_fun = function(j, i, x, y, width, height, fill) {
      val <- mat[i, j]
      txt <- sprintf("%.2f %s", val, unit_label)
      # Keep text black for readability, or adjust based on background color intensity
      grid.text(txt, x, y, gp = gpar(fontsize = 10, col = "black"))
    },
    rect_gp = gpar(col = "white", lwd = 2),
    border = TRUE
  )
}

# =====================================================================
# 4. Main Execution Loop
# =====================================================================
# Find all summary_*.csv files in the input directory
csv_files <- list.files(path_input, pattern = "^summary.*\\.csv$", full.names = TRUE)

if (length(csv_files) == 0) {
  stop(sprintf("[%s] Error: No summary CSV files found in %s\n", Sys.time(), path_input))
}

for (file_path in csv_files) {
  file_name <- basename(file_path)
  # Extract fold identifier (e.g., "1_vs_9" from "summary_1_vs_9.csv")
  fold_name <- stringr::str_match(file_name, "summary_(.*)\\.csv")[,2]
  if (is.na(fold_name)) fold_name <- "overall" 
  
  cat(sprintf("[%s] Processing file: %s (Fold: %s)\n", Sys.time(), file_name, fold_name))
  
  # Read and parse data
  df <- fread(file_path) %>% as.data.frame()
  
  # Filter to custom tools and apply custom order
  df <- df %>% filter(Tool %in% custom_tool_order)
  df$Tool <- factor(df$Tool, levels = custom_tool_order)
  df <- df %>% arrange(Tool)
  
  # Extract and clean metrics
  df_clean <- data.frame(
    Tool = df$Tool,
    Avg_CPU = parse_cpu(df$Average_CPU_usage),
    Peak_RSS_GB = parse_memory_to_gb(df$Peak_RSS),
    Wall_Time_H = parse_time_to_hours(df$Total_wall_time)
  )
  rownames(df_clean) <- df_clean$Tool
  
  # Create matrices for each column
  mat_cpu <- as.matrix(df_clean[, "Avg_CPU", drop = FALSE])
  mat_mem <- as.matrix(df_clean[, "Peak_RSS_GB", drop = FALSE])
  mat_time <- as.matrix(df_clean[, "Wall_Time_H", drop = FALSE])
  
  # Generate individual heatmaps
  ht_cpu <- create_column_heatmap(mat_cpu, "Avg CPU", "%")
  ht_mem <- create_column_heatmap(mat_mem, "Peak RSS", "GB")
  ht_time <- create_column_heatmap(mat_time, "Total Time", "h")
  
  # Combine heatmaps side-by-side
  # The row names will automatically be placed on the far left by ComplexHeatmap
  ht_list <- ht_cpu + ht_mem + ht_time
  
  # =====================================================================
  # 5. Save Output
  # =====================================================================
  pdf_out <- file.path(path_output, paste0("heatmap_resources_", fold_name, ".pdf"))
  png_out <- file.path(path_output, paste0("heatmap_resources_", fold_name, ".png"))
  
  # Draw and save PDF
  pdf(pdf_out, width = 12, height = 8)
  draw(ht_list, 
       column_title = sprintf("Resource Usage Overview (Fold: %s)", fold_name),
       column_title_gp = gpar(fontsize = 16, fontface = "bold"),
       padding = unit(c(2, 2, 2, 2), "cm"),
       ht_gap = unit(5, "mm")) # Gap between the metric columns
  dev.off()
  
  # Draw and save PNG
  png(png_out, width = 12, height = 8, units = "in", res = 300)
  draw(ht_list, 
       column_title = sprintf("Resource Usage Overview (Fold: %s)", fold_name),
       column_title_gp = gpar(fontsize = 16, fontface = "bold"),
       padding = unit(c(2, 2, 2, 2), "cm"),
       ht_gap = unit(5, "mm"))
  dev.off()
  
  cat(sprintf("[%s] >>> Saved heatmaps for fold %s\n", Sys.time(), fold_name))
}

cat(sprintf("[%s] >>> All tasks completed successfully. Plots are in %s\n", Sys.time(), path_output))