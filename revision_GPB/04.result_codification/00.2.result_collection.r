#!/usr/bin/env Rscript
library(data.table)
library(dplyr)
library(tidyr)
library(argparse)
library(parallel) # 引入并行包

# ==============================================================================
# 性能核心配置
# 1. 关闭 data.table 底层多线程，彻底防止 C 级别的 Segfault (指针越界/权限报错)
setDTthreads(1) 

# 2. 设置并行的核心数 (这里保守设置为 32 核，你可以根据 top 里的空闲核心调整)
num_cores <- 32 
# ==============================================================================

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

message(paste(">>> 当前运行配置 fold:", fold))
message(paste(">>> 并行核心数设置:", num_cores))

# 4. 路径定义
path_revision <- "/data1/wuguojia/data/mhc_benchmark/revision"
path_base <- file.path(path_revision, "02.negtive_sample_reconstruction", "retest_base", fold)
path_result <- file.path(path_revision, "02.negtive_sample_reconstruction", "retest_result", fold)
path_codify <- file.path(path_revision, "03.result_codification", fold)

if (!dir.exists(path_base)) stop(paste("路径不存在:", path_base))
load(file.path(path_base, "TEST.Rdata"))

# ==============================================================================
# 数据清洗与合并准备 (防止底层 bmerge 数据类型不匹配导致的崩溃)
setDT(test)
test[, hlatype := as.character(hlatype)]
test[, antigen_peptide := as.character(antigen_peptide)]
setkey(test, hlatype, antigen_peptide)

# --- 新增的低效工具专用 TEST 数据加载逻辑 ---
test_slow <- copy(test) # 默认情况下，test_slow 和 test 完全一致
if (fold == "1_vs_99") {
    sim_test_path <- file.path(path_result, "TEST_simulated_for_slow_tools.Rdata")
    if (file.exists(sim_test_path)) {
        sim_env <- new.env()
        load(sim_test_path, envir = sim_env)
        test_slow <- as.data.table(sim_env$test)
        
        # 赋予同样的 data.table 属性以支持快速 merge
        test_slow[, hlatype := as.character(hlatype)]
        test_slow[, antigen_peptide := as.character(antigen_peptide)]
        setkey(test_slow, hlatype, antigen_peptide)
        message(">>> [成功] 已检测到 1_vs_99，成功加载低效工具专属模拟数据: TEST_simulated_for_slow_tools.Rdata")
    } else {
        stop(paste("致命错误: 在 1_vs_99 模式下找不到低效工具模拟文件:", sim_test_path))
    }
}
# ==============================================================================

# 子路径定义
path_consensus      <- file.path(path_result, "consensus")
path_mhcflurry      <- file.path(path_result, "mhcflurry")
path_netmhcpan_ba   <- file.path(path_result, "netmhcpan_ba")
path_netmhcpan_el   <- file.path(path_result, "netmhcpan_el")
path_netmhcstabpan  <- file.path(path_result, "netmhcstabpan")
path_mixmhcpred     <- file.path(path_result, "mixmhcpred")
path_netmhccons     <- file.path(path_result, "netmhccons")
path_capsnetmhc_an  <- file.path(path_result, "capsnetmhc_an")
path_capsnetmhc_ie  <- file.path(path_result, "capsnetmhc_ie")
path_stmhcpan       <- file.path(path_result, "stmhcpan")
path_transphla      <- file.path(path_result, "transphla")
path_deepattentionpan <- file.path(path_result, "deepattentionpan")
path_acme           <- file.path(path_result, "acme")
path_deephlapan     <- file.path(path_result, "deephlapan")
path_deepnetbim     <- file.path(path_result, "deepnetbim")
path_bigmhc_el      <- file.path(path_result, "bigmhc_el")

################################################################
cat("Start processing. \n")
cat("#------------------------------------- \n")
################################################################

################################ iedb consensus (低效工具：使用 test_slow)
    cat(paste0("dealing with results in: ", path_consensus, "\n"))
    file <- list.files(path_consensus, recursive = TRUE, full.names = TRUE)
    if(length(file) >=1){
        tool_result <- mclapply(file, function(f) {
            dt <- fread(f)
            if(nrow(dt) == 0) return(NULL)
            dt <- dt[, .(allele = as.character(allele), peptide = as.character(peptide), affinity = consensus_percentile_rank)]
            if(class(dt$affinity) != "numeric" && class(dt$affinity) != "integer") return(NULL)
            merge(dt, test_slow, by.x = c("allele", "peptide"), by.y = c("hlatype", "antigen_peptide"), all = FALSE)
        }, mc.cores = num_cores)
        names(tool_result) <- gsub("\\..*","",basename(file))
        tool_result <- Filter(Negate(is.null), tool_result)
        save(tool_result,file=paste0(path_codify,"/consensus_no_threshold.Rdata"))
        cat(paste0("results in for iedb consensus have been done. \n"))        
    }else{cat(paste0(path_consensus, " do not have files.\n"))}

################################ mhcflurry_ba (高效工具：使用 test)
    cat(paste0("dealing with results in: ", path_mhcflurry, "\n"))
    file <- list.files(path_mhcflurry, recursive = TRUE, full.names = TRUE)
    if(length(file) >=1){
        tool_result <- mclapply(file, function(f) {
            dt <- fread(f)
            if(nrow(dt) == 0) return(NULL)
            dt <- dt[, .(allele = as.character(allele), peptide = as.character(peptide), affinity = mhcflurry_affinity_percentile)]
            if(class(dt$affinity) != "numeric" && class(dt$affinity) != "integer") return(NULL)
            merge(dt, test, by.x = c("allele", "peptide"), by.y = c("hlatype", "antigen_peptide"), all = FALSE)
        }, mc.cores = num_cores)
        names(tool_result) <- gsub("\\..*","",basename(file))
        tool_result <- Filter(Negate(is.null), tool_result)
        save(tool_result,file=paste0(path_codify,"/mhcflurry_ba_no_threshold.Rdata"))
        cat(paste0("results in for mhcflurry_ba have been done. \n"))
    }else{cat(paste0(path_mhcflurry, " do not have files.\n"))}

################################ mhcflurry_ps (高效工具：使用 test)
    cat(paste0("dealing with results in: ", path_mhcflurry, "\n"))
    file <- list.files(path_mhcflurry, recursive = TRUE, full.names = TRUE)
    if(length(file) >=1){
        tool_result <- mclapply(file, function(f) {
            dt <- fread(f)
            if(nrow(dt) == 0) return(NULL)
            dt <- dt[, .(allele = as.character(allele), peptide = as.character(peptide), affinity = mhcflurry_presentation_score)]
            if(class(dt$affinity) != "numeric" && class(dt$affinity) != "integer") return(NULL)
            merge(dt, test, by.x = c("allele", "peptide"), by.y = c("hlatype", "antigen_peptide"), all = FALSE)
        }, mc.cores = num_cores)
        names(tool_result) <- gsub("\\..*","",basename(file))
        tool_result <- Filter(Negate(is.null), tool_result)
        save(tool_result,file=paste0(path_codify,"/mhcflurry_ps_no_threshold.Rdata"))
        cat(paste0("results in for mhcflurry_ps have been done. \n"))
    }else{cat(paste0(path_mhcflurry, " do not have files.\n"))}

################################ netmhcpan_ba (低效工具：使用 test_slow)
    cat(paste0("dealing with results in: ", path_netmhcpan_ba, "\n"))
    file <- list.files(path_netmhcpan_ba, recursive = TRUE, full.names = TRUE)
    if(length(file) >=1){
        tool_result <- mclapply(file, function(f) {
            dt <- fread(f)
            if(nrow(dt) == 0) return(NULL)
            dt <- dt[, .(allele = as.character(allele), peptide = as.character(peptide), affinity = rank)]
            if(class(dt$affinity) != "numeric" && class(dt$affinity) != "integer") return(NULL)
            merge(dt, test_slow, by.x = c("allele", "peptide"), by.y = c("hlatype", "antigen_peptide"), all = FALSE)
        }, mc.cores = num_cores)
        names(tool_result) <- gsub("\\..*","",basename(file))
        tool_result <- Filter(Negate(is.null), tool_result)
        save(tool_result,file=paste0(path_codify,"/netmhcpan_ba_no_threshold.Rdata"))
        cat(paste0("results in for netmhcpan_ba have been done. \n"))
    }else{cat(paste0(path_netmhcpan_ba, " do not have files.\n"))}

################################ netmhcpan_el (低效工具：使用 test_slow)
    cat(paste0("dealing with results in: ", path_netmhcpan_el, "\n"))
    file <- list.files(path_netmhcpan_el, recursive = TRUE, full.names = TRUE)
    if(length(file) >=1){
        tool_result <- mclapply(file, function(f) {
            dt <- fread(f)
            if(nrow(dt) == 0) return(NULL)
            dt <- dt[, .(allele = as.character(allele), peptide = as.character(peptide), affinity = rank)]
            if(class(dt$affinity) != "numeric" && class(dt$affinity) != "integer") return(NULL)
            merge(dt, test_slow, by.x = c("allele", "peptide"), by.y = c("hlatype", "antigen_peptide"), all = FALSE)
        }, mc.cores = num_cores)
        names(tool_result) <- gsub("\\..*","",basename(file))
        tool_result <- Filter(Negate(is.null), tool_result)
        save(tool_result,file=paste0(path_codify,"/netmhcpan_el_no_threshold.Rdata"))
        cat(paste0("results in for netmhcpan_el have been done. \n"))
    }else{cat(paste0(path_netmhcpan_el, " do not have files.\n"))}

################################ netmhcstabpan (低效工具：使用 test_slow)
    cat(paste0("dealing with results in: ", path_netmhcstabpan, "\n"))
    file <- list.files(path_netmhcstabpan, recursive = TRUE, full.names = TRUE)
    if(length(file) >=1){
        tool_result <- mclapply(file, function(f) {
            dt <- fread(f)
            if(nrow(dt) == 0) return(NULL)
            dt <- dt[, .(allele = as.character(allele), peptide = as.character(peptide), affinity = rank)]
            if(class(dt$affinity) != "numeric" && class(dt$affinity) != "integer") return(NULL)
            merge(dt, test_slow, by.x = c("allele", "peptide"), by.y = c("hlatype", "antigen_peptide"), all = FALSE)
        }, mc.cores = num_cores)
        names(tool_result) <- gsub("\\..*","",basename(file))
        tool_result <- Filter(Negate(is.null), tool_result)
        save(tool_result,file=paste0(path_codify,"/netmhcstabpan_no_threshold.Rdata"))
        cat(paste0("results in for netmhcstabpan have been done. \n"))
    }else{cat(paste0(path_netmhcstabpan, " do not have files.\n"))}

################################ mixmhcpred (高效工具：使用 test)
    cat(paste0("dealing with results in: ", path_mixmhcpred, "\n"))
    file <- list.files(path_mixmhcpred, recursive = TRUE, full.names = TRUE)
    if(length(file) >=1){
        tool_result <- mclapply(file, function(f) {
            dt <- fread(f)
            if(nrow(dt) == 0) return(NULL)
            name <- gsub("\\..*","",basename(f))
            setnames(dt, 1:6, c("peptide","Score_bestAllele","allele","affinity","Score_allele","%Rank_allele"))
            dt[, allele := as.character(gsub("_.*","",name))]
            dt[, peptide := as.character(peptide)]
            dt <- dt[, .(allele, peptide, affinity)]
            if(class(dt$affinity) != "numeric" && class(dt$affinity) != "integer") return(NULL)
            merge(dt, test, by.x = c("allele", "peptide"), by.y = c("hlatype", "antigen_peptide"), all = FALSE)
        }, mc.cores = num_cores)
        names(tool_result) <- gsub("\\..*","",basename(file))
        tool_result <- Filter(Negate(is.null), tool_result)
        save(tool_result,file=paste0(path_codify,"/mixmhcpred_no_threshold.Rdata"))
        cat(paste0("results in for mixmhcpred have been done. \n"))
    }else{cat(paste0(path_mixmhcpred, " do not have files.\n"))}

################################ netmhccons (低效工具：使用 test_slow)
    cat(paste0("dealing with results in: ", path_netmhccons, "\n"))
    file <- list.files(path_netmhccons, recursive = TRUE, full.names = TRUE)
    if(length(file) >=1){
        tool_result <- mclapply(file, function(f) {
            dt <- fread(f)
            if(nrow(dt) == 0) return(NULL)
            dt <- dt[, .(allele = as.character(allele), peptide = as.character(peptide), affinity = rank)]
            if(class(dt$affinity) != "numeric" && class(dt$affinity) != "integer") return(NULL)
            merge(dt, test_slow, by.x = c("allele", "peptide"), by.y = c("hlatype", "antigen_peptide"), all = FALSE)
        }, mc.cores = num_cores)
        names(tool_result) <- gsub("\\..*","",basename(file))
        tool_result <- Filter(Negate(is.null), tool_result)
        save(tool_result,file=paste0(path_codify,"/netmhccons_no_threshold.Rdata"))
        cat(paste0("results in for netmhccons have been done. \n"))
    }else{cat(paste0(path_netmhccons, " do not have files.\n"))}

################################ capsnetmhc_an (高效工具：使用 test)
    cat(paste0("dealing with results in: ", path_capsnetmhc_an, "\n"))
    file <- list.files(path_capsnetmhc_an, recursive = TRUE, full.names = TRUE)
    if(length(file) >=1){
        tool_result <- mclapply(file, function(f) {
            dt <- fread(f)
            if(nrow(dt) == 0) return(NULL)
            dt <- dt[, c(1, 2, 5), with = FALSE]
            setnames(dt, c("allele", "peptide", "affinity"))
            dt[, allele := as.character(allele)]
            dt[, peptide := as.character(peptide)]
            if(class(dt$affinity) != "numeric" && class(dt$affinity) != "integer") return(NULL)
            merge(dt, test, by.x = c("allele", "peptide"), by.y = c("hlatype", "antigen_peptide"), all = FALSE)
        }, mc.cores = num_cores)
        names(tool_result) <- gsub("\\..*","",basename(file))
        tool_result <- Filter(Negate(is.null), tool_result)
        save(tool_result,file=paste0(path_codify,"/capsnetmhc_an_no_threshold.Rdata"))
        cat(paste0("results in for capsnetmhc_an have been done. \n"))
    }else{cat(paste0(path_capsnetmhc_an, " do not have files.\n"))}

################################ capsnetmhc_ie (高效工具：使用 test)
    cat(paste0("dealing with results in: ", path_capsnetmhc_ie, "\n"))
    file <- list.files(path_capsnetmhc_ie, recursive = TRUE, full.names = TRUE)
    if(length(file) >=1){
        tool_result <- mclapply(file, function(f) {
            dt <- fread(f)
            if(nrow(dt) == 0) return(NULL)
            dt <- dt[, .(allele = as.character(Allele), peptide = as.character(`Peptide seq`), affinity = our_method_ic50)]
            if(class(dt$affinity) != "numeric" && class(dt$affinity) != "integer") return(NULL)
            merge(dt, test, by.x = c("allele", "peptide"), by.y = c("hlatype", "antigen_peptide"), all = FALSE)
        }, mc.cores = num_cores)
        names(tool_result) <- gsub("\\..*","",basename(file))
        tool_result <- Filter(Negate(is.null), tool_result)
        save(tool_result,file=paste0(path_codify,"/capsnetmhc_ie_no_threshold.Rdata"))
        cat(paste0("results in for capsnetmhc_ie have been done. \n"))
    }else{cat(paste0(path_capsnetmhc_ie, " do not have files.\n"))}

################################ stmhcpan (高效工具：使用 test)
    cat(paste0("dealing with results in: ", path_stmhcpan, "\n"))
    file <- list.files(path_stmhcpan, recursive = TRUE, full.names = TRUE)
    if(length(file) >=1){
        tool_result <- mclapply(file, function(f) {
            dt <- fread(f)
            if(nrow(dt) == 0) return(NULL)
            dt <- dt[, .(allele = as.character(allele), peptide = as.character(peptide), affinity = presentation)]
            dt[, allele := gsub("(HLA-[A-Z])(\\d{2})(\\d{2})", "\\1*\\2:\\3", allele)]
            if(class(dt$affinity) != "numeric" && class(dt$affinity) != "integer") return(NULL)
            merge(dt, test, by.x = c("allele", "peptide"), by.y = c("hlatype", "antigen_peptide"), all = FALSE)
        }, mc.cores = num_cores)
        names(tool_result) <- gsub("\\..*","",basename(file))
        tool_result <- Filter(Negate(is.null), tool_result)
        save(tool_result,file=paste0(path_codify,"/stmhcpan_no_threshold.Rdata"))
        cat(paste0("results in for stmhcpan have been done. \n"))
    }else{cat(paste0(path_stmhcpan, " do not have files.\n"))}

################################ transphla (高效工具：使用 test)
    cat(paste0("dealing with results in: ", path_transphla, "\n"))
    file <- list.files(path_transphla, recursive = TRUE, full.names = TRUE)
    if(length(file) >=1){
        tool_result <- mclapply(file, function(f) {
            dt <- fread(f)
            if(nrow(dt) == 0) return(NULL)
            dt <- dt[, .(allele = as.character(HLA), peptide = as.character(peptide), affinity = y_prob)]
            if(class(dt$affinity) != "numeric" && class(dt$affinity) != "integer") return(NULL)
            merge(dt, test, by.x = c("allele", "peptide"), by.y = c("hlatype", "antigen_peptide"), all = FALSE)
        }, mc.cores = num_cores)
        names(tool_result) <- gsub("\\..*","",basename(file))
        tool_result <- Filter(Negate(is.null), tool_result)
        save(tool_result,file=paste0(path_codify,"/transphla_no_threshold.Rdata"))
        cat(paste0("results in for transphla have been done. \n"))
    }else{cat(paste0(path_transphla, " do not have files.\n"))}

################################ deepattentionpan (高效工具：使用 test)
    cat(paste0("dealing with results in: ", path_deepattentionpan, "\n"))
    file <- list.files(path_deepattentionpan, recursive = TRUE, full.names = TRUE)
    if(length(file) >=1){
        tool_result <- mclapply(file, function(f) {
            dt <- fread(f)
            if(nrow(dt) == 0) return(NULL)
            dt <- dt[, .(allele = as.character(Allele), peptide = as.character(`Peptide seq`), affinity = our_method_ic50)]
            if(class(dt$affinity) != "numeric" && class(dt$affinity) != "integer") return(NULL)
            merge(dt, test, by.x = c("allele", "peptide"), by.y = c("hlatype", "antigen_peptide"), all = FALSE)
        }, mc.cores = num_cores)
        names(tool_result) <- gsub("\\..*","",basename(file))
        tool_result <- Filter(Negate(is.null), tool_result)
        save(tool_result,file=paste0(path_codify,"/deepattentionpan_no_threshold.Rdata"))
        cat(paste0("results in for deepattentionpan have been done. \n"))
    }else{cat(paste0(path_deepattentionpan, " do not have files.\n"))}

################################ acme (高效工具：使用 test)
    cat(paste0("dealing with results in: ", path_acme, "\n"))
    file <- list.files(path_acme, recursive = TRUE, full.names = TRUE)
    if(length(file) >=1){
        tool_result <- mclapply(file, function(f) {
            dt <- fread(f)
            if(nrow(dt) == 0) return(NULL)
            setnames(dt, 1:3, c("peptide","allele","affinity"))
            dt <- dt[, .(allele = as.character(allele), peptide = as.character(peptide), affinity)]
            dt[, allele := paste0("HLA-", allele)]
            if(class(dt$affinity) != "numeric" && class(dt$affinity) != "integer") return(NULL)
            merge(dt, test, by.x = c("allele", "peptide"), by.y = c("hlatype", "antigen_peptide"), all = FALSE)
        }, mc.cores = num_cores)
        names(tool_result) <- gsub("\\..*","",basename(file))
        tool_result <- Filter(Negate(is.null), tool_result)
        save(tool_result,file=paste0(path_codify,"/acme_no_threshold.Rdata"))
        cat(paste0("results in for acme have been done. \n"))
    }else{cat(paste0(path_acme, " do not have files.\n"))}

################################ deephlapan (高效工具：使用 test)
    cat(paste0("dealing with results in: ", path_deephlapan, "\n"))
    file <- list.files(path_deephlapan, recursive = TRUE, full.names = TRUE)
    if(length(file) >=1){
        tool_result <- mclapply(file, function(f) {
            dt <- fread(f)
            if(nrow(dt) == 0) return(NULL)
            dt <- dt[, c(2, 3, 4), with = FALSE]
            setnames(dt, c("allele", "peptide", "affinity"))
            dt[, allele := as.character(allele)]
            dt[, peptide := as.character(peptide)]
            dt[, allele := gsub("(HLA-[A-Z])(\\d{2}:\\d{2})", "\\1*\\2", allele)]
            if(class(dt$affinity) != "numeric" && class(dt$affinity) != "integer") return(NULL)
            merge(dt, test, by.x = c("allele", "peptide"), by.y = c("hlatype", "antigen_peptide"), all = FALSE)
        }, mc.cores = num_cores)
        names(tool_result) <- gsub("\\..*","",basename(file))
        tool_result <- Filter(Negate(is.null), tool_result)
        save(tool_result,file=paste0(path_codify,"/deephlapan_no_threshold.Rdata"))
        cat(paste0("results in for deephlapan have been done. \n"))
    }else{cat(paste0(path_deephlapan, " do not have files.\n"))}

################################ deepnetbim (低效工具：使用 test_slow)
    cat(paste0("dealing with results in: ", path_deepnetbim, "\n"))
    file <- list.files(path_deepnetbim, recursive = TRUE, full.names = TRUE)
    if(length(file) >=1){
        tool_result <- mclapply(file, function(f) {
            dt <- fread(f)
            if(nrow(dt) == 0) return(NULL)
            dt <- dt[, .(allele = as.character(mhc), peptide = as.character(sequence), affinity = pred_affinity)]
            dt[, allele := gsub("(HLA-[A-Z])(\\d{2}:\\d{2})", "\\1*\\2", allele)]
            if(class(dt$affinity) != "numeric" && class(dt$affinity) != "integer") return(NULL)
            merge(dt, test_slow, by.x = c("allele", "peptide"), by.y = c("hlatype", "antigen_peptide"), all = FALSE)
        }, mc.cores = num_cores)
        names(tool_result) <- gsub("\\..*","",basename(file))
        tool_result <- Filter(Negate(is.null), tool_result)
        save(tool_result,file=paste0(path_codify,"/deepnetbim_no_threshold.Rdata"))
        cat(paste0("results in for deepnetbim have been done. \n"))
    }else{cat(paste0(path_deepnetbim, " do not have files.\n"))}

################################ bigmhc_el (高效工具：使用 test)
    cat(paste0("dealing with results in: ", path_bigmhc_el, "\n"))
    file <- list.files(path_bigmhc_el, recursive = TRUE, full.names = TRUE)
    if(length(file) >=1){
        tool_result <- mclapply(file, function(f) {
            dt <- fread(f)
            if(nrow(dt) == 0) return(NULL)
            dt <- dt[, .(allele = as.character(mhc), peptide = as.character(pep), affinity = BigMHC_EL)]
            if(class(dt$affinity) != "numeric" && class(dt$affinity) != "integer") return(NULL)
            merge(dt, test, by.x = c("allele", "peptide"), by.y = c("hlatype", "antigen_peptide"), all = FALSE)
        }, mc.cores = num_cores)
        names(tool_result) <- gsub("\\..*","",basename(file))
        tool_result <- Filter(Negate(is.null), tool_result)
        save(tool_result,file=paste0(path_codify,"/bigmhc_no_threshold.Rdata"))
        cat(paste0("results in for bigmhc have been done. \n"))
    }else{cat(paste0(path_bigmhc_el, " do not have files.\n"))}

################################################################
cat("Whole process has been finished. \n")
cat("#------------------------------------- \n")