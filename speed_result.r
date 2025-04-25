# load data
path_speed<-"/home/wuguojia/biocode/mhc_benchmark/speed_command/"
log_files <- list.files(path_speed, pattern = "\\.log$", full.names = TRUE)
log_names <- tools::file_path_sans_ext(basename(log_files))
keywords <- c("User time", "System time", "Elapsed \\(wall clock\\) time", 
              "Percent of CPU this job got", "Maximum resident set size")
log_contents <- setNames(lapply(log_files, function(file) {
    lines <- readLines(file)
    filtered_lines <- lines[grep(paste(keywords, collapse = "|"), lines)]
    filtered_lines <- gsub("^\t+", "", filtered_lines)
    return(filtered_lines)}), log_names)
# deal data
cpu_data <- numeric()
memory_data <- numeric()
time_data <- numeric()
# 遍历 log_contents 提取信息
for (name in names(log_contents)) {
    log_entry <- log_contents[[name]]
    # 提取 CPU 使用率并转换为小数
    cpu_line <- log_entry[grep("Percent of CPU this job got", log_entry)]
    cpu_percent <- as.numeric(gsub(".*: ([0-9.]+)%.*", "\\1", cpu_line)) / 100
    # 提取内存使用并转换为 GB
    memory_line <- log_entry[grep("Maximum resident set size", log_entry)]
    memory_gb <- as.numeric(gsub(".*: ([0-9.]+).*", "\\1", memory_line)) / (1024 * 1024)
    # 提取时间并转换为分钟
    time_line <- log_entry[grep("Elapsed \\(wall clock\\) time", log_entry)]
    time_str <- gsub(".*: ([0-9:.]+)", "\\1", time_line)
    # 检查时间格式并进行转换
    time_parts <- as.integer(unlist(strsplit(time_str, ":")))
    if (length(time_parts) == 3) {
    # h:mm:ss 格式
    time_minutes <- time_parts[1] * 60 + time_parts[2] + time_parts[3] / 60
    } else if (length(time_parts) == 2) {
    # m:ss 格式
    time_minutes <- time_parts[1] + time_parts[2] / 60
    } else {
    time_minutes <- NA  # 无法解析的格式
    }
    # 存储到列表中
    cpu_data <- c(cpu_data, round(cpu_percent, 3))
    memory_data <- c(memory_data, round(memory_gb, 3))
    time_data <- c(time_data, round(time_minutes, 3))
}
data <- data.frame(
    cpu = cpu_data,
    memory = memory_data,
    time = time_data,
    row.names = names(log_contents)
)
# draw heatmap
sorted_tools<-c("stmhcpan","mhcflurry_ps","bigmhc","netmhcpan_el","mhcflurry_ba","capsnetmhc_an","netmhcpan_ba","mixmhcpred","netmhccons","transphla","acme","deephlapan","netmhcstabpan","deepattentionpan","capsnetmhc_ie","consensus","deepnetbim")
data<-rbind(data,data[rownames(data)=="mhcflurry",])
rownames(data)[which(rownames(data)=="mhcflurry")]<-"mhcflurry_ps"
rownames(data)[which(rownames(data)=="mhcflurry1")]<-"mhcflurry_ba"
data<-data[order(match(rownames(data),sorted_tools)),]
normalize <- function(x) {return((x - min(x)) / (max(x) - min(x))) }
df_draw <- as.data.frame(lapply(data, normalize))
df_draw<-as.matrix(df_draw)
Heatmap(
    df_draw,
    col=colorRamp2(c(0.01,0.1,0.5), c("#CFE8F3", "#FDFDFD", "#FFCFCF")),
    border = TRUE,
    border_gp = gpar(col = "black"),
    cell_fun = function(j, i, x, y, width, height, fill) {
        #add number
        grid.text(sprintf("%.2f", data[i, j]), x, y, gp = gpar(fontsize = 10))
        #add border
        grid.rect(x, y, width = width, height = height, gp = gpar(col = "grey", lwd = 0.5, fill = NA))},
    column_title = NULL,
    column_labels = colnames(data),
    column_names_rot = 0,
    column_names_gp = gpar(fontsize = 10),
    row_labels = NULL,
    row_names_gp = gpar(fontsize = 10),
    cluster_rows = FALSE,
    cluster_columns = FALSE,
    show_heatmap_legend = FALSE)   