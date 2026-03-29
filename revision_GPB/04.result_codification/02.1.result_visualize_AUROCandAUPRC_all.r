#----------------------- Configuration part
####### Library
library(data.table)  # 核心优化：使用 data.table 替代 data.frame 以提升速度和降低内存
library(dplyr)
library(boot)
library(tidyr)
library(pROC) #AUROC
library(PRROC) #AURPC
library(MLmetrics)
library(ggplot2)
library(fmsb)
library(grid)
library(tibble)
library(broom)
library(ggpubr)
library(ggsignif)
library(RColorBrewer)
library(ComplexHeatmap)
library(circlize)
library(argparse)
library(ggrastr)    
library(patchwork)  

####### outside parameter and path definition
parser <- ArgumentParser(description='处理 MHC 基准测试不同 fold 的数据')
parser$add_argument('fold', 
                    nargs = '?', 
                    default = '1_vs_1', 
                    help = '折叠名称，例如 1_vs_4, 1_vs_9 (默认: 1_vs_1)')

opt <- parser$parse_args()
fold <- opt$fold

# 增加时间戳日志函数，方便监控进度
log_msg <- function(...) {
    message(paste0("[", format(Sys.time(), "%Y-%m-%d %H:%M:%S"), "] ", ...))
}

log_msg(">>> 开始运行配置 fold: ", fold)
path_revision <- "/data1/wuguojia/data/mhc_benchmark/revision"
path_analysis <- file.path(path_revision, "04.result_analysis", fold)
path_visualize <- file.path(path_revision, "05.result_visualize", fold)

# 确保输出目录存在
if(!dir.exists(path_visualize)) dir.create(path_visualize, recursive = TRUE)

####### group info & color info & name mapping
# (此处保留你原有的 class_0, class_1, class_2, color_mapping, name_mapping 定义)
class_0<-c("consensus","netmhccons","netmhcpan_ba","netmhcpan_el","netmhcstabpan","mhcflurry_ba","mhcflurry_ps","mixmhcpred")
class_1<-c("acme","capsnetmhc_an","capsnetmhc_ie","deepattentionpan","deephlapan")
class_2<-c("bigmhc","stmhcpan","transphla")

color_mapping <- c(
    "acme" = "#1F77B4", "bigmhc" = "#FF7F0E", "capsnetmhc_an" = "#2CA02C", 
    "capsnetmhc_ie" = "#FDE725", "consensus" = "#9467BD", "deepattentionpan" = "#8C564B", 
    "deephlapan" = "#9EDAE5", "deepnetbim" = "#7F7F7F", "mhcflurry_ba" = "#17BECF", 
    "mhcflurry_ps" = "#CE6DBD", "mixmhcpred" = "#FFBB78", "netmhccons" = "#C7C7C7", 
    "netmhcpan_ba" = "#DBDB8D", "netmhcpan_el" = "#E377C2", "netmhcstabpan" = "#BCBD22", 
    "stmhcpan" = "#D62728", "transphla" = "#4B4B4B",
    "class_0" = "#C9F0C1", "class_1" = "#7ED957", "class_2" = "#145214"
)

name_mapping <- c(
    "stmhcpan" = "STMHCpan", "bigmhc" = "BigMHC", "capsnetmhc_an" = "CapsNet-MHC_AN",
    "mhcflurry_ps" = "MHCflurry2.0_PS", "netmhcpan_el" = "NetMHCpan4.1_EL",
    "mhcflurry_ba" = "MHCflurry2.0_BA", "transphla" = "TransPHLA", "netmhccons" = "NetMHCcons1.1",
    "netmhcpan_ba" = "NetMHCpan4.1_BA", "mixmhcpred" = "MixMHCpred3.0",
    "netmhcstabpan" = "NetMHCstabpan1.0", "acme" = "ACME", "consensus" = "IEDBconsensus2.18",
    "deephlapan" = "DeepHLApan", "deepattentionpan" = "DeepAttentionpan",
    "capsnetmhc_ie" = "CapsNet-MHC_IE", "deepnetbim" = "DeepNetBim"
)

#----------------------- Visualize part
#------ 00.prepare for data
log_msg("开始扫描 analysis 目录下的 Rdata 文件...")
file_list <- list.files(path_analysis, pattern = "_analysis\\.Rdata$", recursive = TRUE, full.names = TRUE)
log_msg("共找到 ", length(file_list), " 个模型文件需要处理。")

# 使用列表暂存处理好的轻量化绘图数据
roc_draw_list <- list()
prc_draw_list <- list()

# 控制下采样阈值 (如果单个曲线点数超过10000，则等距抽样，视觉上无损且极大减小内存和PDF体积)
max_points <- 10000 

for (i in seq_along(file_list)) {
    f_path <- file_list[i]
    name <- gsub("\\_analysis.Rdata", "", basename(f_path))
    
    if (!name %in% names(name_mapping)) {
        log_msg("⚠️ 警告: Tool '", name, "' 不在 name_mapping 中，跳过。")
        next
    }
    
    log_msg(sprintf("[%d/%d] 正在加载并处理: %s", i, length(file_list), name))
    
    # 核心优化 1：使用独立环境加载数据，避免污染全局并方便一次性清理
    temp_env <- new.env()
    load(f_path, envir = temp_env)
    
    # 检查核心变量是否存在
    if (!exists("all_info", envir = temp_env)) {
        log_msg("⚠️ 警告: 未在文件中找到 all_info，跳过 ", name)
        rm(temp_env); gc()
        next
    }
    
    # 获取指标和坐标点
    auc_roc_val <- round(temp_env$all_info$auroc$auc, 4)
    auc_prc_val <- round(temp_env$all_info$auprc$auc.integral, 4)
    
    official_name <- name_mapping[name]
    curve_label_roc <- paste0("(", auc_roc_val, ") ", official_name)
    curve_label_prc <- paste0("(", auc_prc_val, ") ", official_name)
    
    # 构建 ROC 数据 (使用 data.table 提速)
    dt_roc <- data.table(
        specificity = rev(temp_env$all_info$auroc$specificities),
        sensitivity = rev(temp_env$all_info$auroc$sensitivities)
    )
    
    # 构建 PRC 数据
    dt_prc <- data.table(
        recall = temp_env$all_info$auprc$curve[, 1],
        precision = temp_env$all_info$auprc$curve[, 2]
    )
    
    # 核心优化 2：下采样（Downsampling）。百万级别的点画在图上无意义且占用巨大内存
    if (nrow(dt_roc) > max_points) {
        idx <- round(seq(1, nrow(dt_roc), length.out = max_points))
        dt_roc <- dt_roc[idx, ]
    }
    if (nrow(dt_prc) > max_points) {
        idx <- round(seq(1, nrow(dt_prc), length.out = max_points))
        dt_prc <- dt_prc[idx, ]
    }
    
    # 补充绘图所需标签
    dt_roc[, `:=`(tool = name, Curve = curve_label_roc, auc = auc_roc_val)]
    dt_prc[, `:=`(tool = name, Curve = curve_label_prc, auc = auc_prc_val)]
    
    roc_draw_list[[name]] <- dt_roc
    prc_draw_list[[name]] <- dt_prc
    
    # 核心优化 3：彻底销毁庞大的 Rdata 载入对象，强制垃圾回收
    rm(temp_env)
    gc_result <- gc(verbose = FALSE) 
    log_msg("   已释放 ", name, " 内存残留。")
    # 不再提取和保留 len_info, hla_info, single_info，因为此处绘图并未使用它们
}

log_msg("所有文件数据提取完毕，开始合并数据集...")
# 核心优化 4：使用 rbindlist 高效拼接列表
roc_draw <- rbindlist(roc_draw_list)
prc_draw <- rbindlist(prc_draw_list)

# 清理不再需要的中间列表
rm(roc_draw_list, prc_draw_list)
gc()

log_msg("数据合并完成。开始准备图层映射...")

# 转换因子类型并按 AUC 降序排列锁定图例
roc_draw <- roc_draw[order(-auc)]
roc_draw[, Curve := factor(Curve, levels = unique(Curve))]
roc_draw[, tool := factor(tool, levels = unique(tool))]

prc_draw <- prc_draw[order(-auc)]
prc_draw[, Curve := factor(Curve, levels = unique(Curve))]
prc_draw[, tool := factor(tool, levels = unique(tool))]

plot_colors <- color_mapping[levels(roc_draw$tool)]
plot_colors_prc <- color_mapping[levels(prc_draw$tool)]

#------ AUROC part
log_msg("正在绘制 AUROC 曲线...")
p_roc <- ggplot(roc_draw, aes(x = 1 - specificity, y = sensitivity)) +
    rasterise(geom_line(aes(color = tool, group = tool), linewidth = 0.6), dpi = 300) + 
    scale_color_manual(
        name = "Performance (AUROC)",
        values = plot_colors, 
        labels = levels(roc_draw$Curve)
    ) +
    labs(x = "1 - Specificity (False Positive Rate)", 
         y = "Sensitivity (True Positive Rate)",
         title = "AUROC") +
    theme_minimal(base_size = 14) +
    theme(
        plot.title = element_text(hjust = 0.5, face = "bold"),
        axis.text = element_text(color = "black"), 
        axis.title.x = element_text(margin = margin(t = 10)),
        axis.title.y = element_text(margin = margin(r = 10)),
        legend.title = element_text(face = "bold", size = 8),
        legend.text = element_text(size = 8),
        legend.position = "bottom",
        legend.box.spacing = unit(0.1, "cm"),      
        panel.border = element_rect(color = "black", fill = NA, linewidth = 0.8),
        panel.background = element_rect(fill = "white", color = "black")
    ) +
    guides(color = guide_legend(ncol = 1)) +
    geom_abline(slope = 1, intercept = 0, linetype = "dashed", color = "gray50", linewidth = 0.8)

#------ AUPRC part
log_msg("正在绘制 AUPRC 曲线...")
p_prc <- ggplot(prc_draw, aes(x = recall, y = precision)) +
    rasterise(geom_line(aes(color = tool, group = tool), linewidth = 0.6), dpi = 300) + 
    scale_color_manual(
        name = "Performance (AUPRC)",
        values = plot_colors_prc, 
        labels = levels(prc_draw$Curve)
    ) +
    labs(x = "Recall (True Positive Rate)", 
         y = "Precision (Positive Predictive Value)",
         title = "AUPRC") +
    theme_minimal(base_size = 14) +
    theme(
        plot.title = element_text(hjust = 0.5, face = "bold"),
        axis.text = element_text(color = "black"), 
        axis.title.x = element_text(margin = margin(t = 10)),
        axis.title.y = element_text(margin = margin(r = 10)),
        legend.title = element_text(face = "bold", size = 8),
        legend.text = element_text(size = 8),
        legend.position = "bottom",
        legend.box.spacing = unit(0.1, "cm"),      
        panel.border = element_rect(color = "black", fill = NA, linewidth = 0.8),
        panel.background = element_rect(fill = "white", color = "black")
    ) +
    guides(color = guide_legend(ncol = 1)) +
    geom_abline(slope = 1, intercept = 0, linetype = "dashed", color = "gray50", linewidth = 0.8)

#------ 合并与保存
log_msg("正在拼图并输出到 PDF 文件...")
p_combined <- p_roc + p_prc
output_file <- file.path(path_visualize, paste0("AUROC_AUPRC_ALL_", fold, ".pdf"))
ggsave(filename = output_file, plot = p_combined, width = 8, height = 10, dpi = 300)

log_msg("🎉 运行完成！结果已保存至: ", output_file)