library(ComplexHeatmap)
library(circlize)
library(grid)
library(tools)

# =====================================================================
# 1. Configuration & Path Definitions
# =====================================================================
# 输入输出路径配置
path_speed <- "/home/wuguojia/biocode/mhc_benchmark/speed_command/"
path_output <- "/data1/wuguojia/data/mhc_benchmark/revision/05.result_visualize/Resource_construction"

if (!dir.exists(path_output)) {
  dir.create(path_output, recursive = TRUE)
  cat(sprintf("[%s] Created output directory: %s\n", Sys.time(), path_output))
}

cat(sprintf("[%s] >>> Starting Resource Visualization Pipeline (Old Data)... \n", Sys.time()))

# =====================================================================
# 2. Extract Data (Original Method)
# =====================================================================
log_files <- list.files(path_speed, pattern = "\\.log$", full.names = TRUE)
log_names <- tools::file_path_sans_ext(basename(log_files))
keywords <- c("User time", "System time", "Elapsed \\(wall clock\\) time", 
              "Percent of CPU this job got", "Maximum resident set size")

log_contents <- setNames(lapply(log_files, function(file) {
    lines <- readLines(file)
    filtered_lines <- lines[grep(paste(keywords, collapse = "|"), lines)]
    filtered_lines <- gsub("^\t+", "", filtered_lines)
    return(filtered_lines)
}), log_names)

cpu_data <- numeric()
memory_data <- numeric()
time_data <- numeric()

for (name in names(log_contents)) {
    log_entry <- log_contents[[name]]
    
    # CPU: 注意，为保持热图内直接显示真实百分比数字，这里不再除以100
    cpu_line <- log_entry[grep("Percent of CPU this job got", log_entry)]
    cpu_percent <- as.numeric(gsub(".*: ([0-9.]+)%.*", "\\1", cpu_line)) 
    
    # Memory: 转换为GB
    memory_line <- log_entry[grep("Maximum resident set size", log_entry)]
    memory_gb <- as.numeric(gsub(".*: ([0-9.]+).*", "\\1", memory_line)) / (1024 * 1024)
    
    # Time: 转换为分钟
    time_line <- log_entry[grep("Elapsed \\(wall clock\\) time", log_entry)]
    time_str <- gsub(".*: ([0-9:.]+)", "\\1", time_line)
    time_parts <- as.numeric(unlist(strsplit(time_str, ":")))
    if (length(time_parts) == 3) {
        time_minutes <- time_parts[1] * 60 + time_parts[2] + time_parts[3] / 60
    } else if (length(time_parts) == 2) {
        time_minutes <- time_parts[1] + time_parts[2] / 60
    } else {
        time_minutes <- NA 
    }
    
    cpu_data <- c(cpu_data, round(cpu_percent, 2))
    memory_data <- c(memory_data, round(memory_gb, 2))
    time_data <- c(time_data, round(time_minutes, 2))
}

data <- data.frame(
    CPU = cpu_data,
    Memory = memory_data,
    Time = time_data,
    row.names = names(log_contents)
)

# =====================================================================
# 3. Process & Format Data
# =====================================================================
# 将 mhcflurry 拆分为 ps 和 ba
if ("mhcflurry" %in% rownames(data)) {
    data["mhcflurry_ps", ] <- data["mhcflurry", ]
    data["mhcflurry_ba", ] <- data["mhcflurry", ]
}

# 设定的行顺序
custom_tool_order <- c(
  "stmhcpan","bigmhc","mhcflurry_ps","netmhcpan_el","capsnetmhc_an", 
  "mhcflurry_ba","mixmhcpred","transphla","netmhcpan_ba", "netmhccons",
  "acme","netmhcstabpan","deepattentionpan","capsnetmhc_ie","consensus",
  "deephlapan", "deepnetbim"
)

# 过滤并排序
data <- data[custom_tool_order, ]

# 正式名称映射字典
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

# 修改行名
rownames(data) <- name_mapping[rownames(data)]

# =====================================================================
# 4. Heatmap Functions
# =====================================================================
# 定义通用的单列热图生成函数
create_column_heatmap <- function(mat, col_name, unit_label, legend_title, base_color = "#E68A8A") {
  # 计算分位数以获得更好的颜色过渡效果
  q_low  <- quantile(mat, probs = 1/3, na.rm = TRUE)
  q_mid  <- quantile(mat, probs = 1/2, na.rm = TRUE)
  q_high <- quantile(mat, probs = 2/3, na.rm = TRUE)
  
  if (q_low == q_high) {
    q_low <- min(mat, na.rm=T)
    q_high <- max(mat, na.rm=T)
  }

  col_fun <- colorRamp2(
    c(q_low, q_mid, q_high), 
    c("#6699CC", "white", base_color)
  )
  
  Heatmap(
    mat,
    name = legend_title,              # 右侧图例名称
    col = col_fun,
    cluster_rows = FALSE,
    cluster_columns = FALSE,
    width = unit(1.5, "cm"),
    show_column_names = TRUE,
    column_labels = col_name,
    column_names_side = "bottom",     # 列名放在下方
    column_names_rot = 0,             # 列名不旋转
    column_names_gp = gpar(fontsize = 8),  # 列名字号 8
    row_names_gp = gpar(fontsize = 8),     # 行名字号 8
    rect_gp = gpar(col = "white", lwd = 2),
    border = TRUE,
    cell_fun = function(j, i, x, y, width, height, fill) {
      val <- mat[i, j]
      # 为格式化文字添加空格以免拥挤
      txt <- sprintf("%.2f %s", val, unit_label)
      # 热图内数字字号 7
      grid.text(txt, x, y, gp = gpar(fontsize = 7, col = "black"))
    }
  )
}

# 将每一列转化为单列矩阵
mat_cpu <- as.matrix(data[, "CPU", drop = FALSE])
mat_mem <- as.matrix(data[, "Memory", drop = FALSE])
mat_time <- as.matrix(data[, "Time", drop = FALSE])

# 生成分块热图
ht_cpu  <- create_column_heatmap(mat_cpu, "CPU", "%", "CPU (%)")
ht_mem  <- create_column_heatmap(mat_mem, "Memory", "GB", "Peak RSS (GB)")
ht_time <- create_column_heatmap(mat_time, "Time", "m", "Wall Time (min)")

# 将热图拼接到一起 (列名从左到右: CPU, Memory, Time)
ht_list <- ht_cpu + ht_mem + ht_time

# =====================================================================
# 5. Save Output
# =====================================================================
pdf_out <- file.path(path_output, "heatmap_resources_old.pdf")
png_out <- file.path(path_output, "heatmap_resources_old.png")

# 保存为 PDF
pdf(pdf_out, width = 6, height = 3.5)
draw(ht_list, ht_gap = unit(5, "mm")) # 调整列之间的空隙
dev.off()

# 保存为 PNG
png(png_out, width = 6, height = 3.5, units = "in", res = 300)
draw(ht_list, ht_gap = unit(5, "mm"))
dev.off()

cat(sprintf("[%s] >>> Task completed successfully. Plots saved to %s\n", Sys.time(), path_output))