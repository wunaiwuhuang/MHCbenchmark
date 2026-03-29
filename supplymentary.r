path_sup<-"/home/wuguojia/biocode/mhc_benchmark/supplementary/"
path_test<-"/data1/wuguojia/data/mhc_benchmark/testbase/"
path_compare<-"/data1/wuguojia/data/mhc_benchmark/testbase/result_compare/"
path_speedbase<-"/data1/wuguojia/data/mhc_benchmark/speedbase/"
path_speed <- "/home/wuguojia/biocode/mhc_benchmark/speed_command/"
path_attentionbase<-"/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/"
path_attentionresult<-"/data1/wuguojia/data/mhc_benchmark/attentionbase/result/"
path_data <- "/data1/wuguojia/data/mhc_benchmark/database/extract_database/"
name_mapping <- c(
  "acme" = "ACME",
  "bigmhc" = "BigMHC",
  "capsnetmhc_an" = "CapsNet-MHC_AN",
  "capsnetmhc_ie" = "CapsNet-MHC_IE",
  "consensus" = "IEDBconsensus2.18",
  "deepattentionpan" = "DeepAttentionpan",
  "deephlapan" = "DeepHLApan",
  "deepnetbim" = "DeepNetBim",
  "mhcflurry_ba" = "MHCflurry2.0_BA",
  "mhcflurry_ps" = "MHCflurry2.0_PS",
  "mixmhcpred" = "MixMHCpred3.0",
  "netmhccons" = "NetMHCcons1.1",
  "netmhcpan_ba" = "NetMHCpan4.1_BA",
  "netmhcpan_el" = "NetMHCpan4.1_EL",
  "netmhcstabpan" = "NetMHCstabpan1.0",
  "stmhcpan" = "STMHCpan",
  "transphla" = "TransPHLA"
)
################################ supplementary data1
# summary of validation dataset
    load(paste0(path_test,"TEST.Rdata"))
    df<-h2ltest_mhci[,1:4]/2
    df<-cbind(df,df)
    df$SUM <- rowSums(df)
    col_names <- colnames(df)
    reordered_cols <- unlist(lapply(unique(col_names), function(x) which(col_names == x)))
    df <- df[, reordered_cols]
    write.csv(df,file=paste0(path_sup,"supplemantarydata1.csv"))
################################ supplementary data1.1 (zenodo)
# detailed HLA-peptide pairs and tools' prediction results of validation dataset
    load(paste0(path_test,"TEST.Rdata"))
    toolname<-tools::file_path_sans_ext(basename(list.files(path_compare, recursive = TRUE, full.names = TRUE)))
    df<-test_mhci
    for(tool in toolname){load(paste0(path_compare,"/",tool,".Rdata"))
        all<-all_info$all
        all<-all[,c("allele","peptide","affinity","bind_result_tool")]
        colnames(all)<-c("hlatype","antigen_peptide",paste0(tool,"_quantitative"),paste0(tool,"_binary"))
        df <- left_join(df, all, by = c("hlatype", "antigen_peptide"))
    }
    write.csv(df,file=paste0(path_sup,"supplemantarydata1.1.csv"))
    #replace name
    df <- read.csv(paste0(path_sup, "supplemantarydata1.1.csv"), check.names = FALSE)
    colnames(df) <- sapply(colnames(df), function(x) {
        #base_name <- gsub("_.*$", "", x)  # 第一个下划线之前
        base_name <- gsub("_[^_]*$", "", x)  # 最后一个下划线之前
        if (base_name %in% names(name_mapping)) {
            official_name <- name_mapping[[base_name]]
            sub(base_name, official_name, x)  # 替换基础名称为官方名称
        } else {
            x  # 保留原始名称
        }
    })
    print(colnames(df))
    write.csv(df,file=paste0(path_sup,"supplemantarydata1.1.csv"))
################################ supplementary data2
# multiple metrics performance of predictors on all samples
    # deal data
    df<-read.csv(paste0(path_test,"/all_performance.csv"))
    #sensitivity = recall
    #abbreviation: sensitivity(Sn),specificity(Sp),precision(prec),f1_score(F1),accuracy(ACC),Matthews Correlation Coefficient(MCC)
    df<-df[,c("toolname","AUROC","AUPRC","sensitivity","specificity","precision","f1_score","accuracy","mcc")]
    colnames(df)<-c("toolname","AUROC","AUPRC","Sn","Sp","precision","F1-score","Accuracy","MCC")
    #replace name
    df$toolname <- sapply(df$toolname, function(x) if (x %in% names(name_mapping)) name_mapping[[x]] else x)
    write.csv(df,file=paste0(path_sup,"supplemantarydata2.csv"))
################################ supplementary data3
# detailed results of predictors in speed test
    log_files <- list.files(path_speed, pattern = "\\.log$", full.names = TRUE)
    log_names <- tools::file_path_sans_ext(basename(log_files))
    resources <- c(
        "User time (seconds)", "System time (seconds)", 
        "Percent of CPU this job got", 
        "Elapsed (wall clock) time (h:mm:ss or m:ss)", 
        "Average shared text size (kbytes)", 
        "Average unshared data size (kbytes)", 
        "Average stack size (kbytes)", 
        "Average total size (kbytes)", 
        "Maximum resident set size (kbytes)", 
        "Average resident set size (kbytes)", 
        "Major (requiring I/O) page faults", 
        "Minor (reclaiming a frame) page faults", 
        "Voluntary context switches", 
        "Involuntary context switches", 
        "Swaps", "File system inputs", 
        "File system outputs", 
        "Socket messages sent", 
        "Socket messages received", 
        "Signals delivered", 
        "Page size (bytes)", 
        "Exit status")
    df <- data.frame(resource = resources, stringsAsFactors = FALSE)
    for (i in seq_along(log_files)) {
        lines <- readLines(log_files[i])
        values <- rep(NA, length(resources))
        for (j in seq_along(resources)) {
            lines <- trimws(lines)
            matched_line <- grep(resources[j], lines, value = TRUE,fixed = TRUE)
            if (length(matched_line) > 0) {
            values[j] <- trimws(sub(".*: ", "", matched_line))
            }
        }
        df[[log_names[i]]] <- values
    }
    #replace name
    df$mhcflurry_ba <- df$mhcflurry
    df$mhcflurry_ps <- df$mhcflurry
    df$mhcflurry <- NULL
    colnames(df) <- sapply(colnames(df), function(x) {
        #base_name <- gsub("_.*$", "", x)  # 第一个下划线之前
        #base_name <- gsub("_[^_]*$", "", x)  # 最后一个下划线之前
        base_name <- x  # 保留全名
        if (base_name %in% names(name_mapping)) {
            official_name <- name_mapping[[base_name]]
            sub(base_name, official_name, x)  # 替换基础名称为官方名称
        } else {
            x  # 保留原始名称
        }
    })
    print(colnames(df))
    write.csv(df,file=paste0(path_sup,"supplemantarydata3.csv"))
################################ supplementary data3.1
# detailed HLA-peptide pairs and tools' prediction results of speed test dataset
    load(paste0(path_speedbase,"speed_data.Rdata"))
    df<-speed_data
    write.csv(df,file=paste0(path_sup,"supplemantarydata3.1.csv"))
################################ supplementary data4
# detailed metrics stratified by MHC and length
    toolname<-tools::file_path_sans_ext(basename(list.files(path_compare, recursive = TRUE, full.names = TRUE)))
    toolname <- toolname[toolname != "deepnetbim"]
    data<-list()
    for(tool in toolname){load(paste0(path_compare,"/",tool,".Rdata"))
        hla<-hla_info$hla_per
        hla$allele<-rownames(hla)
        hla$peptide_length<-"all"
        hla<-hla[,c("allele","peptide_length","AUROC","AUPRC","sensitivity","specificity","precision","f1_score","accuracy","mcc")]
        colnames(hla)<-c("allele","peptide_length","AUROC","AUPRC","Sn","Sp","precision","F1-score","Accuracy","MCC")
        single<-single_info$perform_info
        single<-single[,c("allele","peptide_length","auroc_qu","auprc","sensitivity","specificity","precision","f1_score","accuracy","mcc")]
        colnames(single)<-c("allele","peptide_length","AUROC","AUPRC","Sn","Sp","precision","F1-score","Accuracy","MCC")
        data[[tool]]<-rbind(hla,single)
    }
    for (name in names(data)) {
        df <- as.data.frame(data[[name]])
        for (col in 3:ncol(df)) {if (is.list(df[[col]])) {df[[col]] <- as.numeric(unlist(df[[col]]))}}
        colnames(df)[3:ncol(df)] <- paste(name, colnames(df)[3:ncol(df)], sep = "_")
        df[, 3:ncol(df)] <- round(df[, 3:ncol(df)], 3)
        data[[name]] <- df
    }
    merged_data <- data.frame()
    for (name in names(data)) {
        df <- data[[name]]
        if (nrow(merged_data) == 0) {
            merged_data <- df
        } else {
            merged_data <- full_join(merged_data, df, by = c("allele", "peptide_length"))
        }
    }
    order <- c("all", "8", "9", "10", "11")
    df <- merged_data %>% mutate(peptide_length = factor(peptide_length, levels = order)) %>% arrange(allele, peptide_length)
    write.csv(df,file=paste0(path_sup,"supplemantarydata4.csv"))
################################ supplementary data5
# list of attention_test dataset
    csv_files <- list.files(path_attentionbase, pattern = "\\.csv$", full.names = TRUE)
    df <- do.call(rbind, lapply(csv_files, function(file) {read.csv(file, stringsAsFactors = FALSE)}))
    #replace name
    colnames(df) <- sapply(colnames(df), function(x) {
        #base_name <- gsub("_.*$", "", x)  # 第一个下划线之前
        #base_name <- gsub("_[^_]*$", "", x)  # 最后一个下划线之前
        base_name <- x #保留全名
        if (base_name %in% names(name_mapping)) {
            official_name <- name_mapping[[base_name]]
            sub(base_name, official_name, x)  # 替换基础名称为官方名称
        } else {
            x  # 保留原始名称
        }
    })
    print(colnames(df))
    write.csv(df,file=paste0(path_sup,"supplemantarydata5.csv"))
################################ supplementary data5.1
# results of LIME and SHAP for each peptides
    csv_files <- list.files(path_attentionresult, pattern = "\\.csv$", full.names = TRUE)
    df <- do.call(rbind, lapply(csv_files, function(file) {read.csv(file, stringsAsFactors = FALSE)}))
    #replace name
    df$tool <- sapply(df$tool, function(x) {
        #base_name <- gsub("_.*$", "", x)  # 第一个下划线之前
        #base_name <- gsub("_[^_]*$", "", x)  # 最后一个下划线之前
        base_name <- x #保留全名
        if (base_name %in% names(name_mapping)) {
            official_name <- name_mapping[[base_name]]
            sub(base_name, official_name, x)  # 替换基础名称为官方名称
        } else {
            x  # 保留原始名称
        }
    })
    print(unique(df$tool))
    write.csv(df,file=paste0(path_sup,"supplemantarydata5.1.csv"))
################################ supplementary data5.2
# motif dataset for all alleles
    load(paste0(path_data,"DATABASE_COMBINE.Rdata"))
    load(paste0(path_test,"TEST.Rdata"))
    filteration<-database_combine
    #retain test data
    filteration<-filteration[grep("\\*", filteration$hlatype), ]%>%filter(mhc_class=="I"&bind_result=="positive")%>%filter(hlatype%in%unique(test_mhci$hlatype))%>%filter(antigen_peptide_length%in%unique(test_mhci$antigen_peptide_length))
    #delete unnatural peptide
    valid_amino_acids <- "^[ARNDCEQGHILKMFPSTWYV]+$"
    filteration <- filteration[grepl(valid_amino_acids, filteration$antigen_peptide), ]
    #remove redundant peptide
    filteration<-filteration %>% distinct(hlatype,antigen_peptide,.keep_all = TRUE)
    df<-filteration[,c(2,3,4)]
    write.csv(df,file=paste0(path_sup,"supplemantarydata5.2.csv"))
################################ supplementary fig1
# motif of all alleles, continued by supplementary data9
    plogo<-list();
    for(hla in sort(unique(filteration$hlatype))){
        for(len in sort(unique(filteration$antigen_peptide_length))){
            df<-filteration %>% filter(hlatype==hla&antigen_peptide_length ==len&bind_result=="positive")
            plogo[[paste0(hla,"_",len)]]<-ggplot() +
            geom_logo(df$antigen_peptide, method = "bits", seq_type = "aa") +
            theme_logo() +
            ggtitle(paste0(hla,"  ",len,"-mer")) +
            labs(y = "bits") +
            theme_minimal(base_size = 15) +
            theme(
                panel.grid=element_blank(),
                panel.border=element_rect(color ="black",fill = NA,size = 0.5),
                panel.background = element_rect(fill = "white", color = "black"),
                plot.title = element_text(hjust = 0.5,size = 12),
                axis.text.x = element_text(angle = 0, hjust = 1, size = 12),
                axis.text.y = element_text(size = 12),
                legend.position = "none")
        }
    }
    ncol <- 4
    nrow <- 4
    pdf(paste0(path_sup,"supplementaryfigure1.pdf"), width = 16, height = 10)
    for (i in seq(1, length(plogo), by = ncol * nrow)) {
        plots_to_plot <- plogo[i:min(i + ncol * nrow - 1, length(plogo))]
        grid.arrange(grobs = plots_to_plot, ncol = ncol)
    }
    dev.off()
################################ supplementary fig2
# heatmap for all peptides SHAP and LIME
    test_files<-list.files(path=path_attentionbase,full.names=TRUE,recursive=TRUE,pattern="\\.csv$")
    result_files<-list.files(path=path_attentionresult,full.names=TRUE,recursive=FALSE,pattern="\\.csv$")
    #test
    df<-list();for(file in test_files){df[[file]]<-read.csv(file)}
    df<-do.call(rbind,df);rownames(df)<-NULL
    #result
    res<-list();for(file in result_files){res[[file]]<-read.csv(file)}
    # load data
    data<-df[,c("hlatype","antigen_peptide")]
    draw_df<-list()
    for(i in 1:nrow(data)){
        hla<-data$"hlatype"[i]
        pep<-data$"antigen_peptide"[i]
        matched_rows <- data.frame()
        #read result files
        for (x in res) {
            matching_rows <- x %>% filter(allele == hla & peptide == pep)
            if (nrow(matching_rows) > 0) {
                matched_rows <- bind_rows(matched_rows, matching_rows)}}
        draw_df[[i]]<-matched_rows}
    # draw heatmap
    # 打开一个 PDF 文件设备，准备将多个热图保存到同一个文件中
    pdf(paste0(path_sup,"supplementaryfigure2.pdf"), width = 12, height = 3) #此处调整热图尺寸。预定每页三列两行
    order <- c("netmhcpan_el","netmhcpan_ba","mhcflurry_ps","mhcflurry_ba","capsnetmhc_an","bigmhc","stmhcpan","transphla")
    # 初始化页面计数器和布局位置计数器
    page_counter <- 1
    layout_counter <- 1
    # 迭代每个数据框和模式
    for (k in 1:length(draw_df)) {
    temp <- draw_df[[k]]
    for (cmode in unique(temp$mode)) {
        temp_df <- temp %>% filter(mode == cmode)
        temp_df <- temp_df %>% mutate(tool = factor(tool, levels = order)) %>% arrange(tool) # reorder
        title <- paste0(cmode, " for ", unique(temp_df$allele),"+",unique(temp_df$peptide))
        aa <- strsplit(unique(temp_df$peptide), split = "")[[1]]
        input <- as.matrix(temp_df[5:(4 + length(aa))])
        ht <- Heatmap(
            input,
            col = colorRamp2(c(-0.35, 0, 0.20), c("#A0C8E3", "#FDFDFD", "#FF8A8A")),
            border = TRUE,
            border_gp = gpar(col = "black"),
            cell_fun = function(j, i, x, y, width, height, fill) {grid.text(sprintf("%.2f", input[i, j]), x, y, gp = gpar(fontsize = 5))},
            column_title = title,
            column_title_gp = gpar(fontsize = 7),
            column_labels = aa,
            column_names_rot = 0,
            column_names_gp = gpar(fontsize = 7),
            row_labels = temp_df$tool,
            row_names_gp = gpar(fontsize = 7),
            cluster_rows = FALSE,
            cluster_columns = FALSE,
            show_heatmap_legend = FALSE)    
        # 此处必须先打印ht ！！！不能将ht 存储在列表里后续再打印。因为ht中cell_fun只是记录了状态与函数，并没有记录下数值和内容。当展示的时候才会在环境变量中查找input变量，将值赋予过去。如此一来input在不断更新，所有的热图的值都是同一套，直接就GG了。我也试过将不同input纳入列表，同时将cell_fun更改目标对象为特定input，无效。
        # 创建新页面或在当前页面添加热图
        if (layout_counter == 1) {
        # 创建新页面
        grid.newpage()
        pushViewport(viewport(layout = grid.layout(2, 3, heights = unit(rep(1, 2), "null"), widths = unit(rep(1, 3), "null")))) # 改为3列
        }  
        # 计算当前热图的行和列位置
        row_pos <- ceiling(layout_counter / 3) # 更新行计算
        col_pos <- layout_counter %% 3 # 更新列计算
        if (col_pos == 0) col_pos <- 3 
        # 将热图绘制到指定位置，调整每个热图的宽度和高度
        pushViewport(viewport(layout.pos.row = row_pos, layout.pos.col = col_pos)) # 修改热图尺寸为5英寸
        draw(ht, newpage = FALSE)
        popViewport()
        # 更新布局位置计数器
        layout_counter <- layout_counter + 1
        # 检查是否需要开始新的一页
        if (layout_counter > 6) { # 更新为6，因为现在是3列
        layout_counter <- 1
        page_counter <- page_counter + 1
        }
    }
    }
    # 关闭 PDF 文件设备
    dev.off()
################################