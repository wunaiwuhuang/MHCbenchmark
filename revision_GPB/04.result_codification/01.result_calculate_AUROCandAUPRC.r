################################################################
library(data.table)
library(dplyr)
library(tidyr)
library(pROC) #AUROC
library(PRROC) #AUPRC
library(MLmetrics)
library(ggplot2)
library(grid)
library(RColorBrewer)
library(ComplexHeatmap)
library(circlize)
library(argparse)
library(parallel) # 引入并行包

# 1. 创建解析器
parser <- ArgumentParser(description='处理 MHC 基准测试不同 fold 的数据')

# 2. 添加参数
parser$add_argument('fold', 
                    nargs = '?', 
                    default = '1_vs_1', 
                    help = '折叠名称，例如 1_vs_4, 1_vs_9 (默认: 1_vs_1)')

# 3. 解析参数
opt <- parser$parse_args()
fold <- opt$fold

# ==============================================================================
# 性能核心配置
setDTthreads(1)      # 禁用底层多线程，防止 mclapply 内存踩踏
num_cores <- 32      # 开启宏观多进程并行
# ==============================================================================

message(paste(">>> 当前运行配置 fold:", fold))
message(paste(">>> 并行核心数设置:", num_cores))

# 4. 路径定义
path_revision <- "/data1/wuguojia/data/mhc_benchmark/revision"
path_codify <- file.path(path_revision, "03.result_codification", fold)
path_analysis <- file.path(path_revision, "04.result_analysis", fold)
if (!dir.exists(path_analysis)) dir.create(path_analysis, recursive = TRUE)
################################################################

################################ AUROC & AUPRC calculation part
reverse <- c("netmhcpan_el","mhcflurry_ba","netmhccons","netmhcpan_ba","mixmhcpred","netmhcstabpan","consensus","capsnetmhc_ie","deepattentionpan")

file_list <- list.files(path_codify, pattern = "_no_threshold\\.Rdata$", recursive = TRUE, full.names = TRUE)

# 核心计算函数
process_tool <- function(file_path) {
    # 创建局部独立环境，避免并行时的变量污染
    local_env <- new.env()
    load(file_path, envir = local_env)
    
    name <- gsub("\\_no_threshold.Rdata", "", basename(file_path))
    
    # 极速合并列表为 data.table
    all <- rbindlist(local_env$tool_result, use.names = TRUE, fill = TRUE)
    setnames(all, "bind_result", "bind_result_base")
    
    # 提前完成数据的整体预处理（判断翻转逻辑并提取向量）
    if(name %in% reverse) {
        all[, scores_used := -affinity]
    } else {
        all[, scores_used := affinity]
    }
    
    # 针对查询提速，设置键值
    setkey(all, allele, antigen_peptide_length)
    
    all_info <- list()
    len_info <- list(auroc = list(), auprc = list())
    hla_info <- list(auroc = list(), auprc = list())
    
    ################################ 1. Towards all stratum
    all_info$auroc <- pROC::roc(response = all$bind_result_base, predictor = all$affinity, quiet = TRUE)
    
    pos_val_all <- all$scores_used[all$bind_result_base == "positive"]
    neg_val_all <- all$scores_used[all$bind_result_base == "negative"]
    all_info$auprc <- pr.curve(scores.class0 = pos_val_all, scores.class1 = neg_val_all, curve = TRUE)
    
    ################################ 2. Towards stratum classified by length
    for(len in c(8, 9, 10, 11)) {
        df_len <- all[antigen_peptide_length == len] # data.table 原生极速切片
        if(nrow(df_len) > 0) {
            len_info$auroc[[paste0(name,"_",len)]] <- pROC::roc(response = df_len$bind_result_base, predictor = df_len$affinity, quiet = TRUE)
            
            pos_val <- df_len$scores_used[df_len$bind_result_base == "positive"]
            neg_val <- df_len$scores_used[df_len$bind_result_base == "negative"]
            len_info$auprc[[paste0(name,"_",len)]] <- pr.curve(scores.class0 = pos_val, scores.class1 = neg_val, curve = TRUE)
        } else {
            cat(paste0("length: ", len, " is not supported by ", name, "\n"))
        }
    }
    
    ################################ 3. Towards stratum classified by hlatype
    unique_hlas <- unique(all$allele)
    for(hla in unique_hlas) {
        df_hla <- all[allele == hla]
        if(nrow(df_hla) > 0) {
            hla_info$auroc[[paste0(name,"_",hla)]] <- pROC::roc(response = df_hla$bind_result_base, predictor = df_hla$affinity, quiet = TRUE)
            
            pos_val <- df_hla$scores_used[df_hla$bind_result_base == "positive"]
            neg_val <- df_hla$scores_used[df_hla$bind_result_base == "negative"]
            hla_info$auprc[[paste0(name,"_",hla)]] <- pr.curve(scores.class0 = pos_val, scores.class1 = neg_val, curve = TRUE)
        }
    }
    
    ################################ 4. Towards stratum classified by hlatype and length
    # 利用 data.table 的 by 极速聚合
    single_info_dt <- all[, .(
        auroc = as.numeric(pROC::roc(bind_result_base, affinity, quiet = TRUE)$auc),
        auprc = {
            s0 <- scores_used[bind_result_base == "positive"]
            s1 <- scores_used[bind_result_base == "negative"]
            if(length(s0) > 0 && length(s1) > 0) pr.curve(s0, s1, curve = FALSE)$auc.integral else NA_real_
        }
    ), by = .(allele, peptide_length = antigen_peptide_length)]
    
    single_info <- list(
        auroc = single_info_dt[, .(allele, peptide_length, auroc)],
        auprc = single_info_dt[, .(allele, peptide_length, auprc)]
    )
    
    ################################ save results
    save(all_info, len_info, hla_info, single_info, file = paste0(path_analysis, "/", name, "_analysis.Rdata"))
    
    return(paste0("Finished: ", name))
}

# 启动多进程并发
results <- mclapply(file_list, process_tool, mc.cores = num_cores)

cat("Whole process has been finished. \n")
cat("#------------------------------------- \n")