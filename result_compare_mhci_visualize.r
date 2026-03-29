################################################################
################################
    library(data.table)
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
    path_test <- "/data1/wuguojia/data/mhc_benchmark/testbase"
    path_result<-"/data1/wuguojia/data/mhc_benchmark/testbase/result"
    path_compare<-"/data1/wuguojia/data/mhc_benchmark/testbase/result_compare"
    load(paste0(path_test,"/TEST.Rdata"))
################################ group info
    class_0<-c("consensus","netmhccons","netmhcpan_ba","netmhcpan_el","netmhcstabpan","mhcflurry_ba","mhcflurry_ps","mixmhcpred")
    class_1<-c("acme","capsnetmhc_an","capsnetmhc_ie","deepattentionpan","deephlapan")
    class_2<-c("bigmhc","stmhcpan","transphla")
################################ set color
    color_mapping <- c(
        "acme" = "#1F77B4",    # 海洋蓝
        "bigmhc" = "#FF7F0E",   # 橙色
        "capsnetmhc_an" = "#2CA02C",  # 草绿
        "capsnetmhc_ie" = "#FDE725",  # 金黄
        "consensus" = "#9467BD",  # 紫罗兰
        "deepattentionpan" = "#8C564B",  # 土棕色
        "deephlapan" = "#9EDAE5",  # 天空蓝
        "deepnetbim" = "#7F7F7F",  # 中性灰
        "mhcflurry_ba" = "#17BECF",  # 水鸭蓝
        "mhcflurry_ps" = "#CE6DBD",  # 深紫
        "mixmhcpred" = "#FFBB78",  # 柚子橙
        "netmhccons" = "#C7C7C7",  # 浅灰
        "netmhcpan_ba" = "#DBDB8D",  # 米黄色
        "netmhcpan_el" = "#E377C2",  # 桃粉色
        "netmhcstabpan" = "#BCBD22",  # 黄绿色
        "stmhcpan" = "#D62728",  # 鲜艳红
        "transphla" = "#4B4B4B",   # 深灰色
        ################################
        "class_0" = "#C9F0C1", # （非常浅的青绿）
        "class_1" = "#7ED957", # （鲜亮的草绿色）
        "class_2" = "#145214" #（非常深的墨绿色）
    )
################################################################

################################################################
################################ AUROC for all
    file <- list.files(path_compare, recursive = TRUE, full.names = TRUE)
    roc <-list()
    for(i in 1:length(file)){
        load(file[i]);name<-gsub("\\..*","",basename(file[i]))
        roc[[name]]<-all_info$all_roc_qu}#if you want to draw binary, just change qu to bi
    roc_draw<-list()
    for (i in 1:length(roc)) {
        auc_value <- round(roc[[i]]$auc, 3)  # get auc value
        roc_draw[[names(roc[i])]] <- data.frame(
            specificity = rev(roc[[i]]$specificities),
            sensitivity = rev(roc[[i]]$sensitivities),
            tool = names(roc[i]),
            Curve = paste(names(roc[i]), " (AUROC =", auc_value, ")", sep = ""),
            auc=auc_value
        )}
    roc_draw<-do.call(rbind,roc_draw)
    #let label present in auc order
    roc_draw <- roc_draw[order(-roc_draw$auc), ]
    roc_draw$Curve <- factor(roc_draw$Curve, levels = unique(roc_draw$Curve))
    # 使用 match 来获取颜色
    roc_draw$color <- color_mapping[match(roc_draw$tool, names(color_mapping))]
    # start ggplot
    ggplot(roc_draw, aes(x = 1 - specificity, y = sensitivity, color = Curve)) +
    geom_line(size = 0.5) +
    scale_color_manual(values = unique(roc_draw$color)) +  #可以再次检查一下颜色
    labs(title =NULL, x =NULL, y =NULL)+
    # labs(title = "AUROC for all samples", x = "False positive rate", y = "True positive rate") +
    theme_minimal(base_size = 14) +
    theme(
        axis.text.x=element_blank(),
        axis.text.y=element_blank(),
        legend.title = element_blank(),  
        legend.position = "none",
        #legend.position = c(1.0, 0.0),
        #legend.justification = c("right", "bottom"),
        panel.border = element_rect(color = "black", fill = NA, size = 0.5),  # 添加边框
        panel.background = element_rect(fill = "white", color = "black"))+  # 背景和边框颜色设置
    geom_abline(slope = 1, intercept = 0, linetype = "dashed", color = "gray")
################################ AUROC for length
    file <- list.files(path_compare, recursive = TRUE, full.names = TRUE)
    file <- file[!grepl("deepnetbim", file)] #this one is totally garbage
    roc_len<-list()
    for(i in 1:length(file)){load(file[i]);roc_len <- c(roc_len, len_info$len_auroc)}
    for(len in c(8,9,10,11)){
        roc_qu<-roc_len[grepl(paste0("_", len, "$"), names(roc_len))]
        names(roc_qu) <- sub("_[^_]+$", "", names(roc_qu))
        roc_draw<-list()
        for (i in 1:length(roc_qu)) {
            auc_value <- round(roc_qu[[i]]$auc, 3)  # get auc value
            roc_draw[[names(roc_qu[i])]] <- data.frame(
                specificity = rev(roc_qu[[i]]$specificities),
                sensitivity = rev(roc_qu[[i]]$sensitivities),
                Curve = paste(names(roc_qu[i]), " (AUROC =", auc_value, ")", sep = ""),
                auc=auc_value
            )}
        roc_draw<-do.call(rbind,roc_draw)
        roc_draw <- roc_draw[order(-roc_draw$auc), ]
        roc_draw$Curve <- factor(roc_draw$Curve, levels = unique(roc_draw$Curve))#let label present in auc order
        colors <- colorRampPalette(brewer.pal(9, "Set1"))(length(roc_qu))
        assign(paste0("p",len),
            ggplot(roc_draw, aes(x = 1 - specificity, y = sensitivity,  color = Curve)) +
            geom_line(size = 0.5) +
            scale_color_manual(values = colors) +
            labs(title = paste0("AUROC for ",len," mers"), x = "False positive rate", y = "True positive rate") +
            theme_minimal(base_size = 14) +
            theme(plot.title = element_text(hjust = 0.5),
                    legend.title = element_blank(),  
                    legend.position = c(1.0, 0.0),
                    legend.justification = c("right", "bottom")) +
            geom_abline(slope = 1, intercept = 0, linetype = "dashed", color = "gray"))}
    p8
################################ AUROC for allele
    file <- list.files(path_compare, recursive = TRUE, full.names = TRUE)
    file <- file[!grepl("deepnetbim", file)] #this one is totally garbage
####data table
    roc_hla<-list()
    for(i in 1:length(file)){load(file[i]);roc_hla<-c(roc_hla,hla_info$hla_auroc)}
    auroc_table <- data.frame(matrix(nrow = length(unique(all_info$all$allele)), ncol = length(file), dimnames = list(sort(unique(all_info$all$allele)), sort(gsub("\\..*", "", basename(file))))))
    for(i in 1:length(roc_hla)){
        toolname<-sub("_[^_]*$", "", names(roc_hla[i]))
        hla<-sub(".*_", "", names(roc_hla[i]))
        auroc_table[hla,toolname]<-roc_hla[[i]]$auc
    }
    auroc_table<-auroc_table %>% mutate(across(1:ncol(auroc_table), ~ round(as.numeric(.), 4)))
####draw heatmap
    transformer<-c("acme","bigmhc","capsnetmhc_an","capsnetmhc_ie","deepattentionpan","deephlapan","stmhcpan","transphla")
    non_trans<-c("consensus","mhcflurry","mixmhcpred","netmhccons","netmhcpan_ba","netmhcpan_el","netmhcstabpan")
    anno_tool<-sort(c(transformer,non_trans))
    anno_tool<-data.frame(tool_type=factor(ifelse(anno_tool %in% transformer, "transformer", ifelse(anno_tool %in% non_trans, "non_trans", NA))))
    anno_colors<-list(tool_type=c("transformer"="#EECA40","non_trans"="#FD763F"))
    ha = HeatmapAnnotation(df= anno_tool,col = anno_colors)
    p<-Heatmap(auroc_table,
        name = "AUROC value for each hla allele",
        top_annotation = ha,
        col = colorRamp2(c(0.8,0.9,1.0),c("blue","white","red")), 
        rect_gp = gpar(col = "black"),
        show_row_names = TRUE,
        show_column_names = TRUE,
        cluster_rows = TRUE, 
        cluster_columns = TRUE, 
        use_raster = FALSE)
    draw(p,annotation_legend_side = "right",
        heatmap_legend_side = "right",
        merge_legends = TRUE)
####draw comparison scatter plot
    auc_long <- auroc_table %>%
        as.data.frame() %>%
        rownames_to_column("HLA") %>%
        pivot_longer(cols = -HLA, names_to = "tool", values_to = "AUROC")
    # display in order
    mean_auroc <- colMeans(auroc_table, na.rm = TRUE)
    auc_long <- auc_long %>% mutate(mean = mean_auroc[match(tool, names(mean_auroc))])
    auc_long <- auc_long[order(-auc_long$mean), ]
    auc_long$Model <- paste0( "(", round(auc_long$mean, 3), ")"," ",auc_long$tool)
    auc_long$Model <- factor(auc_long$Model, levels = unique(auc_long$Model))
    #auc_long$HLA <- factor(auc_long$HLA, levels = rev(unique(auc_long$HLA)))
    # 使用 match 来获取颜色
    auc_long$color <- color_mapping[match(auc_long$tool, names(color_mapping))]
    #start gglot
    ggplot(auc_long, aes(x = HLA, y = AUROC, color = Model)) +
    geom_point(size = 2, shape = 16) +
    scale_color_manual(values = unique(auc_long$color)) +
    labs(x = NULL, y = NULL, color = "Mean AUROC") +
    theme_minimal() +
    theme(
        legend.position = "none",
        panel.grid = element_blank(),
        panel.border = element_rect(color="black",fill = NA,size = 0.5),
        panel.background = element_rect(fill = "white",color = "black"),
        axis.text.x = element_text(size = 7, color ="black",angle = 90))
####draw violin plot
    plot<-list()
    for(i in c("HLA","HLA-A","HLA-B","HLA-C")){
        df <- auroc_table[grep(i, rownames(auroc_table)), ]
        auc_long <- df %>%
            as.data.frame() %>%
            rownames_to_column("HLA") %>%
            pivot_longer(cols = -HLA, names_to = "Model", values_to = "AUROC")
        # display in order
        mean_auroc <- colMeans(df, na.rm = TRUE)
        auc_long <- auc_long %>% mutate(mean = mean_auroc[match(Model, names(mean_auroc))])
        auc_long <- auc_long[order(-auc_long$mean), ]
        auc_long$Model <- factor(auc_long$Model, levels = unique(auc_long$Model))
        # 使用 match 来获取颜色
        auc_long$color <- color_mapping[match(auc_long$Model, names(color_mapping))]
        #start ggplot
        plot[[i]]<-
        ggplot(auc_long, aes(x = Model, y = AUROC, fill = Model)) +
        geom_violin(size = 0.3,trim = TRUE) +
        geom_boxplot(size = 0.2,width = 0.1, fill = "white", outlier.shape = NA) +
        scale_fill_manual(values = unique(auc_long$color)) +
        labs(y = paste0("AUROC of ",i)) +
        theme_minimal() +
        theme(
            panel.grid=element_blank(),
            panel.border=element_rect(color="black",fill = NA,size=0.5),
            panel.background = element_rect(fill = "white",color = "black"),
            axis.text.x = element_blank(),
            axis.title.x = element_blank(),
            legend.position = "none")
        pdf(paste0(path_test,"/",i,".pdf"), width = 4, height = 0.8)  # 设置文件名和页面尺寸
        print(plot[[i]])  # 将图形绘制到 PDF 中
        dev.off()  # 关闭 PDF 设备
    }
####draw bar plot
    #deal data
    auroc_df <- as.data.frame(auroc_table)
    auroc_df$hla <- rownames(auroc_df)
    auroc_long <- auroc_df %>% pivot_longer(cols = -hla, names_to = "model", values_to = "auroc") 
    summary_stats <- auroc_long %>% group_by(model) %>% summarise(mean_auroc = mean(auroc, na.rm = TRUE),ci_low = quantile(auroc, 0.025, na.rm = TRUE),
    ci_high = quantile(auroc, 0.975, na.rm = TRUE))
    # display in order
    summary_stats <- summary_stats %>% arrange(desc(mean_auroc))
    summary_stats$model <- factor(summary_stats$model, levels = summary_stats$model)
    # 使用 match 来获取颜色
    summary_stats$color <- color_mapping[match(summary_stats$model, names(color_mapping))]
    #significant test
    pairwise_test <- pairwise.wilcox.test(auroc_long$auroc, auroc_long$model, p.adjust.method = "bonferroni")
    #the p.value is 15*15, but i have 16 tools, i should complete it
    p_values <- matrix(NA, nrow = 16, ncol = 16)
    rownames(p_values) <- colnames(p_values) <- unique(auroc_long$model)
    for (i in rownames(pairwise_test$p.value)) {
        for (j in colnames(pairwise_test$p.value)) {
        p_values[i, j] <- pairwise_test$p.value[i, j]}}
    p_values[upper.tri(p_values)] <- t(p_values)[upper.tri(p_values)]
    significance_label <- function(p) {
        if (is.na(p)) return("")
        if (p < 0.001) return("***")
        if (p < 0.01) return("**")
        if (p < 0.05) return("*")
        return("")}
    significance_matrix <- apply(p_values, 1:2, significance_label)
    first_model <- as.character(summary_stats$model[1])
    significant_comparisons <- significance_matrix[first_model, ]
    significant_comparisons <- significant_comparisons[order(match(names(significant_comparisons), summary_stats$model))]# keep order
    significant_comparisons <- significant_comparisons[!is.na(significant_comparisons) & significant_comparisons != ""]
    signif_annotations <- data.frame(
        group1 = rep(first_model, length(names(significant_comparisons))),
        group2 = names(significant_comparisons),
        y_position = summary_stats$mean_auroc[1] + seq(0.05, 0.5, length.out = length(names(significant_comparisons))),
        significance = significant_comparisons)
    comparisons_list <- lapply(signif_annotations$group2, function(x) c(first_model, x))
    #draw bar plot
    p <- ggplot(summary_stats,aes(x = model, y = mean_auroc, fill = model)) +
    geom_bar(stat = "identity", color = NA) +
    coord_cartesian(ylim = c(0.65, 1.5))+
    geom_errorbar(aes(ymin = ci_low, ymax = ci_high), width = 0.2) +
    scale_fill_manual(values = unique(summary_stats$color)) +
    labs(y = NULL,title = NULL) +
    theme_minimal() +
    theme(
        panel.grid=element_blank(),
        panel.border=element_rect(color ="black",fill = NA,size = 0.5),
        panel.background = element_rect(fill = "white", color = "black"),
        axis.text.x = element_blank(),
        axis.title.x = element_blank(),
        legend.position = "none",
        plot.title = element_text(hjust = 0.5)) +
    geom_signif(
        comparisons = comparisons_list,
        annotations = signif_annotations$significance,
        y_position = signif_annotations$y_position,
        tip_length = 0.02,
        vjust = 0.4)
    pdf(paste0(path_test,"/barplot.pdf"), width = 4, height = 2)  # 设置文件名和页面尺寸
    print(p)  # 将图形绘制到 PDF 中
    dev.off()  # 关闭 PDF 设备
################################ AUROC for single
    file <- list.files(path_compare, recursive = TRUE, full.names = TRUE)
    file <- file[!grepl("deepnetbim", file)] #this one is totally garbage
####data table
    info <- list()
    for(i in 1:length(file)){load(file[i]);name<-gsub("\\..*","",basename(file[i]));info[[name]]<-single_info$perform_info}
    auroc_table <- do.call(rbind, lapply(info, function(df) df[, c("allele", "peptide_length")])) %>% distinct()
    for (i in seq_along(info)) {
        df <- info[[i]];temp_df <- auroc_table %>% left_join(df[, c("allele", "peptide_length", "auroc_qu")], by = c("allele", "peptide_length")) %>% mutate(auroc_qu = ifelse(is.na(auroc_qu), "", auroc_qu));auroc_table[[names(info)[i]]] <- temp_df$auroc_qu}
    auroc_table$type<-paste0(auroc_table$allele,"_",auroc_table$peptide_length)
    rownames(auroc_table)<-auroc_table$type
    auroc_table <- subset(auroc_table, select = -c(type))
    auroc_table <- auroc_table %>% mutate(across(3:ncol(auroc_table), ~ round(as.numeric(.), 4)))
    write.csv(auroc_table,file=paste0(path_test,"/auroc_hla:len2tool_full.csv"))
    for(hla in rownames(h2ltest_mhci)){
        for(len in colnames(h2ltest_mhci)[1:(ncol(h2ltest_mhci)-1)]){
            selectrow <- which(auroc_table$allele == hla & auroc_table$peptide_length == len)
            if(h2ltest_mhci[hla,len]<100){auroc_table[selectrow,3:ncol(auroc_table)]<-"/"}
        }
    }
    write.csv(auroc_table,file=paste0(path_test,"/auroc_hla:len2tool_filter.csv"))
####draw heatmaps
    transformer<-c("acme","bigmhc","capsnetmhc_an","capsnetmhc_ie","deepattentionpan","deephlapan","stmhcpan","transphla")
    non_trans<-c("consensus","mhcflurry","mixmhcpred","netmhccons","netmhcpan_ba","netmhcpan_el","netmhcstabpan")
    anno_tool<-sort(c(transformer,non_trans))
    anno_tool<-data.frame(tool_type=factor(ifelse(anno_tool %in% transformer, "transformer", ifelse(anno_tool %in% non_trans, "non_trans", NA))))
    anno_colors<-list(tool_type=c("transformer"="#EECA40","non_trans"="#FD763F"))
    ha = HeatmapAnnotation(df= anno_tool,col = anno_colors)
    for(i in c(8,9,10,11)){
        auroc_table<-read.csv(paste0(path_test,"/auroc_hla:len2tool_filter.csv"))
        auroc_table<-auroc_table %>% filter(peptide_length == i)
        rownames(auroc_table)<-auroc_table[,1]
        auroc_table<-auroc_table[,-c(1:3)]
        auroc_table<- auroc_table %>% filter(acme != "/")%>%mutate(across(1:ncol(auroc_table), ~ round(as.numeric(.), 4))) %>% as.matrix()
        title<-paste0("Heatmap of AUROC values-",i," mer")
        assign(paste0("p",i),
            Heatmap(auroc_table,
            name = title,
            top_annotation = ha,
            col = colorRamp2(c(0.8,0.9,1.0),c("blue","white","red")), 
            rect_gp = gpar(col = "black"),
            show_row_names = TRUE,
            show_column_names = TRUE,
            cluster_rows = TRUE, 
            cluster_columns = TRUE, 
            use_raster = FALSE))     
    }
    draw(p8,annotation_legend_side = "right",
        heatmap_legend_side = "right",
        merge_legends = TRUE)
####draw line plots
    #deal data
    auroc_table<-list()
    for(name in names(info)){
        df<-info[[name]]%>%.[,c("peptide_length","auroc_qu")]
        df$"tool"<-name
        auroc_table<-append(auroc_table,list(df))
    }
    auroc_table<-do.call(rbind,auroc_table)
    summary_stats <- auroc_table %>% 
        group_by(tool, peptide_length) %>% 
        summarise(
            mean_auroc = mean(auroc_qu, na.rm = TRUE),
            ci_low = mean(auroc_qu, na.rm = TRUE) - qt(0.975, df = n() - 1) * sd(auroc_qu, na.rm = TRUE) / sqrt(n()),
            ci_high = mean(auroc_qu, na.rm = TRUE) + qt(0.975, df = n() - 1) * sd(auroc_qu, na.rm = TRUE) / sqrt(n()),
            .groups = 'drop' ) %>%
        left_join(
            auroc_table %>%
            group_by(tool) %>%
            summarise(average = mean(auroc_qu, na.rm = TRUE), .groups = 'drop') %>%
            arrange(desc(average)),
            by = "tool" ) %>%
        # display in order
        arrange(desc(average))
    summary_stats$model <- paste0(summary_stats$tool, " (", round(summary_stats$average, 4), ")")
    summary_stats$model <- factor(summary_stats$model, levels = unique(summary_stats$model))
    # 使用 match 来获取颜色
    summary_stats$color <- color_mapping[match(summary_stats$tool, names(color_mapping))]
    #draw plot
    p <- ggplot(summary_stats, aes(x = peptide_length, y = mean_auroc, color = model, group = model)) +
    geom_line(size = 0.2) +
    geom_point(size = 3) +
    scale_color_manual(values = unique(summary_stats$color)) +
    labs(title = NULL,x = NULL,y = NULL,color = "Mean AUROC") +
    theme_minimal() +
    theme(
        legend.position = "none",
        panel.grid = element_blank(),
        panel.border = element_rect(color="black",fill = NA,size = 0.5),
        panel.background = element_rect(fill = "white",color = "black"),
        #axis.text.x = element_text(size = 7, color ="black"),
        axis.text.x = element_blank(),
        axis.text.y = element_blank())
    pdf(paste0(path_test,"/output_plots.pdf"), width = 4, height = 4)  # 设置文件名和页面尺寸
    print(p)  # 将图形绘制到 PDF 中
    dev.off()  # 关闭 PDF 设备
####draw bar plot
    #deal data
    auroc_table<-read.csv(paste0(path_test,"/auroc_hla:len2tool_full.csv"))
    auroc_df <- as.data.frame(auroc_table)[4:ncol(auroc_table)]
    auroc_df$hla <- rownames(auroc_df)
    auroc_long <- auroc_df %>% pivot_longer(cols = -hla, names_to = "model", values_to = "auroc") 
    summary_stats <- auroc_long %>% group_by(model) %>% summarise(mean_auroc = mean(auroc, na.rm = TRUE),ci_low = quantile(auroc, 0.025, na.rm = TRUE),
    ci_high = quantile(auroc, 0.975, na.rm = TRUE))
    # display in order
    summary_stats <- summary_stats %>% arrange(desc(mean_auroc))
    summary_stats$model <- factor(summary_stats$model, levels = summary_stats$model)
    # 使用 match 来获取颜色
    summary_stats$color <- color_mapping[match(summary_stats$model, names(color_mapping))]
    #significant test
    pairwise_test <- pairwise.wilcox.test(auroc_long$auroc, auroc_long$model, p.adjust.method = "bonferroni")
    #the p.value is 15*15, but i have 16 tools, i should complete it
    p_values <- matrix(NA, nrow = 16, ncol = 16)
    rownames(p_values) <- colnames(p_values) <- unique(auroc_long$model)
    for (i in rownames(pairwise_test$p.value)) {
        for (j in colnames(pairwise_test$p.value)) {
        p_values[i, j] <- pairwise_test$p.value[i, j]}}
    p_values[upper.tri(p_values)] <- t(p_values)[upper.tri(p_values)]
    significance_label <- function(p) {
        if (is.na(p)) return("")
        if (p < 0.001) return("***")
        if (p < 0.01) return("**")
        if (p < 0.05) return("*")
        return("")}
    significance_matrix <- apply(p_values, 1:2, significance_label)
    first_model <- as.character(summary_stats$model[1])
    significant_comparisons <- significance_matrix[first_model, ]
    significant_comparisons <- significant_comparisons[order(match(names(significant_comparisons), summary_stats$model))]# keep order
    significant_comparisons <- significant_comparisons[!is.na(significant_comparisons) & significant_comparisons != ""]
    signif_annotations <- data.frame(
        group1 = rep(first_model, length(names(significant_comparisons))),
        group2 = names(significant_comparisons),
        y_position = summary_stats$mean_auroc[1] + seq(0.05, 0.5, length.out = length(names(significant_comparisons))),
        significance = significant_comparisons)
    comparisons_list <- lapply(signif_annotations$group2, function(x) c(first_model, x))
    #draw bar plot
    p <- ggplot(summary_stats,aes(x = model, y = mean_auroc, fill = model)) +
    geom_bar(stat = "identity", color = NA) +
    coord_cartesian(ylim = c(0.65, 1.5))+
    geom_errorbar(aes(ymin = ci_low, ymax = ci_high), width = 0.2) +
    scale_fill_manual(values = unique(summary_stats$color)) +
    labs(title =NULL,y =NULL) +
    theme_minimal() +
    theme(
        panel.grid=element_blank(),
        panel.border=element_rect(color ="black",fill = NA,size = 0.5),
        panel.background = element_rect(fill = "white", color = "black"),
        axis.text.x = element_blank(),
        axis.title.x = element_blank(),
        legend.position = "none",
        plot.title = element_text(hjust = 0.5)) +
    geom_signif(
        comparisons = comparisons_list,
        annotations = signif_annotations$significance,
        y_position = signif_annotations$y_position,
        tip_length = 0.02,
        vjust = 0.4)
    pdf(paste0(path_test,"/barplot.pdf"), width = 4, height = 2)  # 设置文件名和页面尺寸
    print(p)  # 将图形绘制到 PDF 中
    dev.off()  # 关闭 PDF 设备
################################################################

################################################################
################################ AUPRC for all
    file <- list.files(path_compare, recursive = TRUE, full.names = TRUE)
    prc <-list()
    for(i in 1:length(file)){
        load(file[i]);name<-gsub("\\..*","",basename(file[i]))
        prc[[name]]<-all_info$all_prc}
    prc_draw<-list()
    for (i in 1:length(prc)) {
        auc_value <- round(prc[[i]]$auc.integral, 3)
        prc_draw[[gsub("_allprc", "", names(prc[i]))]] <- data.frame(
            recall = prc[[i]]$curve[, 1],
            precision = prc[[i]]$curve[, 2],
            Curve = paste(gsub("_allprc", "", names(prc[i])), " (AUPRC =", auc_value, ")", sep = ""),
            auc = auc_value,
            tool = names(prc[i])
        )
    }
    prc_draw<-do.call(rbind,prc_draw)
    #let label present in auc order
    prc_draw <- prc_draw[order(-prc_draw$auc), ]
    prc_draw$Curve <- factor(prc_draw$Curve, levels = unique(prc_draw$Curve))
    # 使用 match 来获取颜色
    prc_draw$color <- color_mapping[match(prc_draw$tool, names(color_mapping))]
    # start ggplot
    ggplot(prc_draw, aes(x = recall, y = precision, color = Curve)) +
    geom_line(size = 0.5) +
    scale_color_manual(values = unique(prc_draw$color)) +  #可以再次检查一下颜色
    labs(title =NULL, x =NULL, y =NULL)+
    # labs(title = "AUPRC for all samples", x = "False positive rate", y = "True positive rate") +
    theme_minimal(base_size = 14) +
    theme(
        axis.text.x=element_blank(),
        axis.text.y=element_blank(),
        legend.title = element_blank(),  
        legend.position = "none",
        #legend.position = c(1.0, 0.0),
        #legend.justification = c("right", "bottom"),
        panel.border = element_rect(color = "black", fill = NA, size = 0.5),  # 添加边框
        panel.background = element_rect(fill = "white", color = "black"))+  # 背景和边框颜色设置
    geom_abline(slope = 1, intercept = 0, linetype = "dashed", color = "gray")
################################ AUPRC for length
    file <- list.files(path_compare, recursive = TRUE, full.names = TRUE)
    file <- file[!grepl("deepnetbim", file)] #this one is totally garbage
    prc_len<-list()
    for(i in 1:length(file)){load(file[i]);prc_len <- c(prc_len, len_info$len_auprc)}
    for(len in c(8,9,10,11)){
        prc<-prc_len[grepl(paste0("_", len, "$"), names(prc_len))]
        names(prc) <- sub("_[^_]+$", "", names(prc))
        prc_draw<-list()
        for (i in 1:length(prc)) {
            auc_value <- round(prc[[i]]$auc.integral, 3)
            prc_draw[[gsub("_allprc", "", names(prc[i]))]] <- data.frame(
                recall = prc[[i]]$curve[, 1],
                precision = prc[[i]]$curve[, 2],
                Curve = paste(gsub("_allprc", "", names(prc[i])), " (AUPRC =", auc_value, ")", sep = ""),
                auc = auc_value
            )
        }
        prc_draw <- do.call(rbind, prc_draw)
        prc_draw <- prc_draw[order(-prc_draw$auc), ]
        prc_draw$Curve <- factor(prc_draw$Curve, levels = unique(prc_draw$Curve))  
        colors <- colorRampPalette(brewer.pal(9, "Set1"))(length(prc))
        assign(paste0("p",len),
            ggplot(prc_draw, aes(x = recall, y = precision, color = Curve)) +
            geom_line(size = 0.5) +
            scale_color_manual(values = colors) +
            labs(title = paste0("AUPRC for " ,len," mers"), x = "Recall", y = "Precision") +
            theme_minimal(base_size = 14) +
            theme(plot.title = element_text(hjust = 0.5),
                legend.title = element_blank(),
                legend.position = c(1.0, 0.0),
                legend.justification = c("right", "bottom")))}
    p8
################################ AUPRC for allele
    file <- list.files(path_compare, recursive = TRUE, full.names = TRUE)
    file <- file[!grepl("deepnetbim", file)] #this one is totally garbage
####data table
    auprc_table <- data.frame(matrix(nrow = length(unique(all_info$all$allele)), ncol = length(file), dimnames = list(sort(unique(all_info$all$allele)), sort(gsub("\\..*", "", basename(file))))))
    prc_hla<-list()
    for(i in 1:length(file)){load(file[i]);prc_hla<-c(prc_hla,hla_info$hla_auprc)}
    for(i in 1:length(prc_hla)){
        toolname<-sub("_[^_]*$", "", names(prc_hla[i]))
        hla<-sub(".*_", "", names(prc_hla[i]))
        auprc_table[hla,toolname]<-prc_hla[[i]]$auc.integral
    }
    auprc_table<-auprc_table %>% mutate(across(1:ncol(auprc_table), ~ round(as.numeric(.), 4)))
####draw comparison scatter plot
    auc_long <- auprc_table %>%
        as.data.frame() %>%
        rownames_to_column("HLA") %>%
        pivot_longer(cols = -HLA, names_to = "tool", values_to = "AUPRC")
    # display in order
    mean_auprc <- colMeans(auprc_table, na.rm = TRUE)
    auc_long <- auc_long %>% mutate(mean = mean_auprc[match(tool, names(mean_auprc))])
    auc_long <- auc_long[order(-auc_long$mean), ]
    auc_long$Model <- paste0(auc_long$tool, " (", round(auc_long$mean, 4), ")")
    auc_long$Model <- factor(auc_long$Model, levels = unique(auc_long$Model))
    # 使用 match 来获取颜色
    auc_long$color <- color_mapping[match(auc_long$tool, names(color_mapping))]
    #start gglot
    ggplot(auc_long, aes(x = HLA, y = AUPRC, color = Model)) +
    geom_point(size = 2, shape = 16) +
    scale_color_manual(values = unique(auc_long$color)) +
    labs(x = NULL, y = NULL, color = "Mean AUPRC") +
    theme_minimal() +
    theme(
        legend.position = "none",
        panel.grid = element_blank(),
        panel.border = element_rect(color="black",fill = NA,size = 0.5),
        panel.background = element_rect(fill = "white",color = "black"),
        axis.text.x = element_text(size = 7, color ="black",angle = 90))
####draw violin plot
    plot<-list()
    for(i in c("HLA","HLA-A","HLA-B","HLA-C")){
        df <- auprc_table[grep(i, rownames(auprc_table)), ]
        auc_long <- df %>%
            as.data.frame() %>%
            rownames_to_column("HLA") %>%
            pivot_longer(cols = -HLA, names_to = "Model", values_to = "AUPRC")
        # display in order
        mean_auprc <- colMeans(df, na.rm = TRUE)
        auc_long <- auc_long %>% mutate(mean = mean_auprc[match(Model, names(mean_auprc))])
        auc_long <- auc_long[order(-auc_long$mean), ]
        auc_long$Model <- factor(auc_long$Model, levels = unique(auc_long$Model))
        # 使用 match 来获取颜色
        auc_long$color <- color_mapping[match(auc_long$Model, names(color_mapping))]
        #start ggplot
        plot[[i]]<-
        ggplot(auc_long, aes(x = Model, y = AUPRC, fill = Model)) +
        geom_violin(size = 0.3,trim = TRUE) +
        geom_boxplot(size = 0.2,width = 0.1, fill = "white", outlier.shape = NA) +
        scale_fill_manual(values = unique(auc_long$color)) +
        labs(y = paste0("AUPRC of ",i)) +
        theme_minimal() +
        theme(
            panel.grid=element_blank(),
            panel.border=element_rect(color="black",fill = NA,size=0.5),
            panel.background = element_rect(fill = "white",color = "black"),
            axis.text.x = element_blank(),
            axis.title.x = element_blank(),
            legend.position = "none")
        pdf(paste0(path_test,"/",i,".pdf"), width = 4, height = 0.8)  # 设置文件名和页面尺寸
        print(plot[[i]])  # 将图形绘制到 PDF 中
        dev.off()  # 关闭 PDF 设备
    }
####draw bar plot
    #deal data
    auprc_df <- as.data.frame(auprc_table)
    auprc_df$hla <- rownames(auprc_df)
    auprc_long <- auprc_df %>% pivot_longer(cols = -hla, names_to = "model", values_to = "auprc") 
    summary_stats <- auprc_long %>% group_by(model) %>% summarise(mean_auprc = mean(auprc, na.rm = TRUE),ci_low = quantile(auprc, 0.025, na.rm = TRUE),
    ci_high = quantile(auprc, 0.975, na.rm = TRUE))
    # display in order
    summary_stats <- summary_stats %>% arrange(desc(mean_auprc))
    summary_stats$model <- factor(summary_stats$model, levels = summary_stats$model)
    # 使用 match 来获取颜色
    summary_stats$color <- color_mapping[match(summary_stats$model, names(color_mapping))]
    #significant test
    pairwise_test <- pairwise.wilcox.test(auprc_long$auprc, auprc_long$model, p.adjust.method = "bonferroni")
    #the p.value is 15*15, but i have 16 tools, i should complete it
    p_values <- matrix(NA, nrow = 16, ncol = 16)
    rownames(p_values) <- colnames(p_values) <- unique(auroc_long$model)
    for (i in rownames(pairwise_test$p.value)) {
        for (j in colnames(pairwise_test$p.value)) {
        p_values[i, j] <- pairwise_test$p.value[i, j]}}
    p_values[upper.tri(p_values)] <- t(p_values)[upper.tri(p_values)]
    significance_label <- function(p) {
        if (is.na(p)) return("")
        if (p < 0.001) return("***")
        if (p < 0.01) return("**")
        if (p < 0.05) return("*")
        return("")}
    significance_matrix <- apply(p_values, 1:2, significance_label)
    first_model <- as.character(summary_stats$model[1])
    significant_comparisons <- significance_matrix[first_model, ]
    significant_comparisons <- significant_comparisons[order(match(names(significant_comparisons), summary_stats$model))]# keep order
    significant_comparisons <- significant_comparisons[!is.na(significant_comparisons) & significant_comparisons != ""]
    signif_annotations <- data.frame(
        group1 = rep(first_model, length(names(significant_comparisons))),
        group2 = names(significant_comparisons),
        y_position = summary_stats$mean_auprc[1] + seq(0.05, 0.5, length.out = length(names(significant_comparisons))),
        significance = significant_comparisons)
    comparisons_list <- lapply(signif_annotations$group2, function(x) c(first_model, x))
    #draw bar plot
    p <- ggplot(summary_stats,aes(x = model, y = mean_auprc, fill = model)) +
    geom_bar(stat = "identity", color = NA) +
    coord_cartesian(ylim = c(0.65, 1.5))+
    geom_errorbar(aes(ymin = ci_low, ymax = ci_high), width = 0.2) +
    scale_fill_manual(values = unique(summary_stats$color)) +
    labs(y = NULL,title = NULL) +
    theme_minimal() +
    theme(
        panel.grid=element_blank(),
        panel.border=element_rect(color ="black",fill = NA,size = 0.5),
        panel.background = element_rect(fill = "white", color = "black"),
        axis.text.x = element_blank(),
        axis.title.x = element_blank(),
        legend.position = "none",
        plot.title = element_text(hjust = 0.5)) +
    geom_signif(
        comparisons = comparisons_list,
        annotations = signif_annotations$significance,
        y_position = signif_annotations$y_position,
        tip_length = 0.02,
        vjust = 0.4)
    pdf(paste0(path_test,"/barplot.pdf"), width = 4, height = 2)  # 设置文件名和页面尺寸
    print(p)  # 将图形绘制到 PDF 中
    dev.off()  # 关闭 PDF 设备
################################ AUPRC for single
    file <- list.files(path_compare, recursive = TRUE, full.names = TRUE)
    file <- file[!grepl("deepnetbim", file)] #this one is totally garbage
####data table
    info <- list()
    for(i in 1:length(file)){load(file[i]);name<-gsub("\\..*","",basename(file[i]));info[[name]]<-single_info$perform_info}
    auprc_table <- do.call(rbind, lapply(info, function(df) df[, c("allele", "peptide_length")])) %>% distinct()
    for (i in seq_along(info)) {
        df <- info[[i]];temp_df <- auprc_table %>% left_join(df[, c("allele", "peptide_length", "auprc")], by = c("allele", "peptide_length")) %>% mutate(auprc = ifelse(is.na(auprc), "", auprc));auprc_table[[names(info)[i]]] <- temp_df$auprc}
    auprc_table$type<-paste0(auprc_table$allele,"_",auprc_table$peptide_length)
    rownames(auprc_table)<-auprc_table$type
    auprc_table <- subset(auprc_table, select = -c(type))
    auprc_table <- auprc_table %>% mutate(across(3:ncol(auprc_table), ~ round(as.numeric(.), 4)))
    write.csv(auprc_table,file=paste0(path_test,"/auprc_hla:len2tool_full.csv"))
    for(hla in rownames(h2ltest_mhci)){
        for(len in colnames(h2ltest_mhci)[1:(ncol(h2ltest_mhci)-1)]){
            selectrow <- which(auprc_table$allele == hla & auprc_table$peptide_length == len)
            if(h2ltest_mhci[hla,len]<100){auprc_table[selectrow,3:ncol(auprc_table)]<-"/"}
        }
    }
    write.csv(auprc_table,file=paste0(path_test,"/auprc_hla:len2tool_filter.csv"))
####draw line plots
    #deal data
    auprc_table<-list()
    for(name in names(info)){
        df<-info[[name]]%>%.[,c("peptide_length","auprc")]
        df$"tool"<-name
        auprc_table<-append(auprc_table,list(df))
    }
    auprc_table<-do.call(rbind,auprc_table)
    summary_stats <- auprc_table %>% 
        group_by(tool, peptide_length) %>% 
        summarise(
            mean_auprc = mean(auprc, na.rm = TRUE),
            ci_low = mean(auprc, na.rm = TRUE) - qt(0.975, df = n() - 1) * sd(auprc, na.rm = TRUE) / sqrt(n()),
            ci_high = mean(auprc, na.rm = TRUE) + qt(0.975, df = n() - 1) * sd(auprc, na.rm = TRUE) / sqrt(n()),
            .groups = 'drop' ) %>%
        left_join(
            auprc_table %>%
            group_by(tool) %>%
            summarise(average = mean(auprc, na.rm = TRUE), .groups = 'drop') %>%
            arrange(desc(average)),
            by = "tool" ) %>%
        # display in order
        arrange(desc(average))
    summary_stats$model <- paste0(summary_stats$tool, " (", round(summary_stats$average, 4), ")")
    summary_stats$model <- factor(summary_stats$model, levels = unique(summary_stats$model))
    # 使用 match 来获取颜色
    summary_stats$color <- color_mapping[match(summary_stats$tool, names(color_mapping))]
    #draw plot
    p <- ggplot(summary_stats, aes(x = peptide_length, y = mean_auprc, color = model, group = model)) +
    geom_line(size = 0.2) +
    geom_point(size = 3) +
    scale_color_manual(values = unique(summary_stats$color)) +
    labs(title = NULL,x = NULL,y = NULL,color = "Mean AUPRC") +
    theme_minimal() +
    theme(
        legend.position = "none",
        panel.grid = element_blank(),
        panel.border = element_rect(color="black",fill = NA,size = 0.5),
        panel.background = element_rect(fill = "white",color = "black"),
        #axis.text.x = element_text(size = 7, color ="black"),
        axis.text.x = element_blank(),
        axis.text.y = element_blank())
    pdf(paste0(path_test,"/output_plots.pdf"), width = 4, height = 4)  # 设置文件名和页面尺寸
    print(p)  # 将图形绘制到 PDF 中
    dev.off()  # 关闭 PDF 设备
####draw bar plot
    #deal data
    auprc_table<-read.csv(paste0(path_test,"/auprc_hla:len2tool_full.csv"))
    auprc_df <- as.data.frame(auprc_table)[4:ncol(auprc_table)]
    auprc_df$hla <- rownames(auprc_df)
    auprc_long <- auprc_df %>% pivot_longer(cols = -hla, names_to = "model", values_to = "auprc") 
    summary_stats <- auprc_long %>% group_by(model) %>% summarise(mean_auprc = mean(auprc, na.rm = TRUE),ci_low = quantile(auprc, 0.025, na.rm = TRUE),
    ci_high = quantile(auprc, 0.975, na.rm = TRUE))
    # display in order
    summary_stats <- summary_stats %>% arrange(desc(mean_auprc))
    summary_stats$model <- factor(summary_stats$model, levels = summary_stats$model)
    # 使用 match 来获取颜色
    summary_stats$color <- color_mapping[match(summary_stats$model, names(color_mapping))]
    #significant test
    pairwise_test <- pairwise.wilcox.test(auprc_long$auprc, auprc_long$model, p.adjust.method = "bonferroni")
    #the p.value is 15*15, but i have 16 tools, i should complete it
    p_values <- matrix(NA, nrow = 16, ncol = 16)
    rownames(p_values) <- colnames(p_values) <- unique(auroc_long$model)
    for (i in rownames(pairwise_test$p.value)) {
        for (j in colnames(pairwise_test$p.value)) {
        p_values[i, j] <- pairwise_test$p.value[i, j]}}
    p_values[upper.tri(p_values)] <- t(p_values)[upper.tri(p_values)]
    significance_label <- function(p) {
        if (is.na(p)) return("")
        if (p < 0.001) return("***")
        if (p < 0.01) return("**")
        if (p < 0.05) return("*")
        return("")}
    significance_matrix <- apply(p_values, 1:2, significance_label)
    first_model <- as.character(summary_stats$model[1])
    significant_comparisons <- significance_matrix[first_model, ]
    significant_comparisons <- significant_comparisons[order(match(names(significant_comparisons), summary_stats$model))]# keep order
    significant_comparisons <- significant_comparisons[!is.na(significant_comparisons) & significant_comparisons != ""]
    signif_annotations <- data.frame(
        group1 = rep(first_model, length(names(significant_comparisons))),
        group2 = names(significant_comparisons),
        y_position = summary_stats$mean_auprc[1] + seq(0.05, 0.5, length.out = length(names(significant_comparisons))),
        significance = significant_comparisons)
    comparisons_list <- lapply(signif_annotations$group2, function(x) c(first_model, x))
    #draw bar plot
    p <- ggplot(summary_stats,aes(x = model, y = mean_auprc, fill = model)) +
    geom_bar(stat = "identity", color = NA) +
    coord_cartesian(ylim = c(0.65, 1.5))+
    geom_errorbar(aes(ymin = ci_low, ymax = ci_high), width = 0.2) +
    scale_fill_manual(values = unique(summary_stats$color)) +
    labs(title = NULL,y = NULL) +
    theme_minimal() +
    theme(
        panel.grid=element_blank(),
        panel.border=element_rect(color ="black",fill = NA,size = 0.5),
        panel.background = element_rect(fill = "white", color = "black"),
        axis.text.x = element_blank(),
        axis.title.x = element_blank(),
        legend.position = "none",
        plot.title = element_text(hjust = 0.5)) +
    geom_signif(
        comparisons = comparisons_list,
        annotations = signif_annotations$significance,
        y_position = signif_annotations$y_position,
        tip_length = 0.02,
        vjust = 0.4)
    pdf(paste0(path_test,"/barplot.pdf"), width = 4, height = 2)  # 设置文件名和页面尺寸
    print(p)  # 将图形绘制到 PDF 中
    dev.off()  # 关闭 PDF 设备
################################################################

################################################################
################################ performance for all
#### draw heatmap
    file <- list.files(path_compare, recursive = TRUE, full.names = TRUE)
    # deal data
    per_table<-read.csv(paste0(path_test,"/all_performance.csv"))
    #sensitivity = recall
    #abbreviation: sensitivity(Sn),specificity(Sp),precision(prec),f1_score(F1),accuracy(ACC),Matthews Correlation Coefficient(MCC)
    df<-per_table[,c("toolname","sensitivity","specificity","precision","f1_score","accuracy","mcc")]
    df_anno <- df[, -1] # 去掉toolname列
    colnames(df_anno)<-c("Sn","Sp","precision","F1-score","Accuracy","MCC")
    # 按列标准化:归一化到 [0, 1]
    normalize <- function(x) {return((x - min(x)) / (max(x) - min(x))) }
    df_draw <- as.data.frame(lapply(df_anno, normalize))
    Heatmap(
        df_draw,
        col=colorRamp2(c(0.6,0.8,1), c("#CFE8F3", "#FDFDFD", "#FFCFCF")),
        border = TRUE,
        border_gp = gpar(col = "black"),
        cell_fun = function(j, i, x, y, width, height, fill) {
            #add number
            grid.text(sprintf("%.3f", df_anno[i, j]), x, y, gp = gpar(fontsize = 10))
            #add border
            grid.rect(x, y, width = width, height = height, gp = gpar(col = "grey", lwd = 0.5, fill = NA))},
        column_title = "Performance metrics of candidate predictors",
        column_labels = colnames(df_anno),
        column_names_rot = 0,
        column_names_gp = gpar(fontsize = 10),
        row_labels = df$toolname,
        row_names_gp = gpar(fontsize = 10),
        cluster_rows = TRUE,
        show_row_dend = FALSE,
        cluster_columns = FALSE,
        show_heatmap_legend = FALSE)   
################################ performance for single
    file <- list.files(path_compare, recursive = TRUE, full.names = TRUE)
    file <- file[!grepl("deepnetbim", file)] #this one is totally garbage
#### load data
    df<-list()
    for(name in file){
        load(name)
        df[[paste0(tools::file_path_sans_ext(basename(name)))]]<-single_info$perform_info}
    # calculate mhc type
    classification <- c("auroc_qu", "auprc", "f1_score")
    ranking <- c("accuracy", "mcc", "precision", "sensitivity", "specificity")
    per_index <- c(classification, ranking)
    # Initialize the list to store results
    data_mhc <- list()
    # Loop over each item in df
    for (name in names(df)) {
        # Initialize a data frame with NA values for each per_index
        temp <- data.frame(all = rep(NA, length(per_index)), 
                        hla_a = rep(NA, length(per_index)), 
                        hla_b = rep(NA, length(per_index)), 
                        hla_c = rep(NA, length(per_index)))
        rownames(temp) <- per_index
        # Extract subsets of data
        data_all <- df[[name]][, per_index, drop = FALSE]
        data_a <- df[[name]][grep("^HLA-A", df[[name]]$allele), per_index, drop = FALSE]
        data_b <- df[[name]][grep("^HLA-B", df[[name]]$allele), per_index, drop = FALSE]
        data_c <- df[[name]][grep("^HLA-C", df[[name]]$allele), per_index, drop = FALSE]
        # List of data subsets and their corresponding column names in temp
        data_list <- list(all = data_all, hla_a = data_a, hla_b = data_b, hla_c = data_c)
        # Calculate the mean for each subset and fill in temp
        for (appendix in names(data_list)) {
            data <- as.matrix(data_list[[appendix]])
            if (nrow(data) > 0) {
                # Calculate the column means
                col_means <- colMeans(data, na.rm = TRUE)
                # Assign the means to the correct column in temp
                temp[rownames(temp) %in% names(col_means), appendix] <- col_means
            }
        }
        # Store the result in data_mhc
        data_mhc[[name]] <- temp
    }
    # calculate length type
    classification <- c("auroc_qu", "auprc", "f1_score")
    ranking <- c("accuracy", "mcc", "precision", "sensitivity", "specificity")
    per_index <- c(classification, ranking)
    # Initialize the list to store results
    data_len <- list()
    # Loop over each item in df
    for (name in names(df)) {
        # Initialize a data frame with NA values for each per_index
        temp <- data.frame(len_8 = rep(NA, length(per_index)), 
                        len_9 = rep(NA, length(per_index)), 
                        len_10 = rep(NA, length(per_index)), 
                        len_11 = rep(NA, length(per_index)))
        rownames(temp) <- per_index
        # Extract subsets of data
        data_8 <- df[[name]][grep("8", df[[name]]$peptide_length), per_index, drop = FALSE]
        data_9 <- df[[name]][grep("9", df[[name]]$peptide_length), per_index, drop = FALSE]
        data_10 <- df[[name]][grep("10", df[[name]]$peptide_length), per_index, drop = FALSE]
        data_11 <- df[[name]][grep("11", df[[name]]$peptide_length), per_index, drop = FALSE]
        # List of data subsets and their corresponding column names in temp
        data_list <- list(len_8 = data_8, len_9 = data_9 ,len_10 = data_10 ,len_11 = data_11)
        # Calculate the mean for each subset and fill in temp
        for (appendix in names(data_list)) {
            data <- as.matrix(data_list[[appendix]])
            if (nrow(data) > 0) {
                # Calculate the column means
                col_means <- colMeans(data, na.rm = TRUE)
                # Assign the means to the correct column in temp
                temp[rownames(temp) %in% names(col_means), appendix] <- col_means
            }
        }
        # Store the result in data_len
        data_len[[name]] <- temp
    }
#### save data
    # data_mhc
    data_long <- do.call(rbind, lapply(names(data_mhc), function(tool_name) {
        df <- data_mhc[[tool_name]]
        df$Tool <- tool_name
        df$Metric <- rownames(df)
        reshape2::melt(df, id.vars = c("Tool", "Metric"), variable.name = "Group", value.name = "Score")
    }))
    data_long <- data_long %>% filter(is.finite(Score))
    data_long$Task <- ifelse(data_long$Metric %in% classification, "Classification", "Ranking")
    write.csv(data_long,file=paste0(path_test,"/perfor_long_mhc.csv"),row.names=FALSE)
    # data_len
    data_long <- do.call(rbind, lapply(names(data_len), function(tool_name) {
        df <- data_len[[tool_name]]
        df$Tool <- tool_name
        df$Metric <- rownames(df)
        reshape2::melt(df, id.vars = c("Tool", "Metric"), variable.name = "Group", value.name = "Score")
    }))
    data_long <- data_long %>% filter(is.finite(Score))
    data_long$Task <- ifelse(data_long$Metric %in% classification, "Classification", "Ranking")
    write.csv(data_long,file=paste0(path_test,"/perfor_long_len.csv"),row.names=FALSE)
#### draw heatmap
    sorted_tools<-c(class_0,class_1,class_2,class_3)
    size_mapping <- function(score) {
        ifelse(score <= 0.8,
            3 + (score - 0.6) * 10 ,
            ifelse(score <= 0.9,
                    5 + (score - 0.8) * 30,
                    8 + (score - 0.9) * 10))}    
    # data_mhc
    df<-read.csv(paste0(path_test,"/perfor_long_mhc.csv"))
    df$Tool <- factor(df$Tool, levels = rev(sorted_tools))
    df<-df%>%filter(Group != "all")%>% mutate(Group_Metric = paste( Metric,Group, sep = "_"))
    plot_mhc <-
        ggplot(df,  aes(x = Group_Metric, y = Tool)) +
        geom_point(aes(size = size_mapping(Score), fill = Score), shape = 21, color = "black") +
        scale_size_identity() +
        scale_fill_gradient(low = "darkred", high = "#FFCCCC") +
        labs(title = "Classification Metrics by Tool", x = "Group_Metric", y = "Tool") +
        theme_minimal() +
        theme(
            panel.grid = element_blank(),  # 取消网格线
            axis.text.x = element_text(angle = 45, hjust = 1, size = 8),
            axis.title.x = element_blank(),
            axis.title.y = element_blank(),
            #axis.text.y = element_blank(),
            legend.position = "none")
    plot_mhc
    # data_len
    df<-read.csv(paste0(path_test,"/perfor_long_len.csv"))
    df$Tool <- factor(df$Tool, levels = rev(sorted_tools))
    df<-df%>%mutate(Group_Metric = paste(Metric, Group, sep = "_"))
    metrics <- unique(df$Metric);levels_order <- c()
    for (metric in metrics) {levels_order <- c(levels_order, paste0(metric, "_len_", 8:11))}
    df$Group_Metric <- factor(df$Group_Metric, levels = levels_order)
    plot_len <-
        ggplot(df,  aes(x = Group_Metric, y = Tool)) +
        geom_point(aes(size = size_mapping(Score), fill = Score), shape = 21, color = "black") +
        scale_size_identity() +
        scale_fill_gradient(low = "darkblue", high = "lightblue") +
        labs(title = "Classification Metrics by Tool", x = "Group_Metric", y = "Tool") +
        theme_minimal() +
        theme(
            panel.grid = element_blank(),  # 取消网格线
            axis.text.x = element_text(angle = 45, hjust = 1, size = 8),
            axis.title.x = element_blank(),
            axis.title.y = element_blank(),
            #axis.text.y = element_blank(),
            legend.position = "none")
    plot_len
#### draw line plot
    # calculation
    df0<-read.csv(paste0(path_test,"/perfor_long_mhc.csv"))
    df1<-read.csv(paste0(path_test,"/perfor_long_len.csv"))
    data<-rbind(df0,df1);result<-list()
    class_info<-list(class_0=class_0,class_1=class_1,class_2=class_2)
    data$class<-sapply(data$Tool,function(tool){
        class_name<-NA
        for(class_id in names(class_info)){
            if(tool%in%class_info[[class_id]]){
                class_name<-class_id
                break
            }
        }
        return(class_name)
    })
    #from each class , we select auroc_qu highest three tools as presentatives , to calculate tool-type comparation.
    setool<-data%>%filter(Metric=="auroc_qu"&Group=="all")%>%group_by(class) %>%arrange(desc(Score)) %>%slice_head(n = 3)
    data<-data[data$Tool %in% setool$Tool,]
    for(group in unique(data$"Group")){
        df<-data[data$"Group"==group,]
        group_result<-df %>% group_by(class,Metric)%>%summarise(
            median_value = median(Score, na.rm = TRUE),
            ci95_lower = boot.ci(boot(data = Score, statistic = function(x, idx) median(x[idx]), R = 1000), type = "bca")$bca[4],
            ci95_upper = boot.ci(boot(data = Score, statistic = function(x, idx) median(x[idx]), R = 1000), type = "bca")$bca[5],
        .groups = "drop"
        )
        result[[group]] <- group_result
    }
    # draw line plot
    plot01<-list()
    for(group in names(result)){
        df<-result[[group]]
        plot01[[group]]<-
        ggplot(df, aes(x = Metric, y = median_value, color = class, group = class)) +
        geom_line(size = 0.5) +
        geom_point(size = 1.5) +
        scale_color_manual(values = color_mapping[df$class]) +
        labs(title = NULL,
            x = NULL,
            y = group,
            color = "tool type") +
        theme_minimal() +
        theme(
            #axis.text.x = element_blank(),
            axis.text.x = element_text(angle = 0, hjust = 1),
            legend.position = "none"
            )
    }
    grid.arrange(grobs = plot01[5:8], ncol = 1)
    # draw dot plot
    plot02<-list()
    metric_order <- c("auroc_qu", "auprc", "f1_score", "accuracy",
                  "mcc", "precision", "sensitivity", "specificity")
    for(group in names(result)){
        df<-result[[group]]
        df <- df %>% mutate(Metric = factor(Metric, levels = metric_order)) %>% arrange(Metric, desc(median_value)) %>% group_by(Metric) %>% mutate(y_order = max(row_number()) - row_number() + 1)
        plot02[[group]]<-
        ggplot(df, aes(x = Metric, y = y_order, color = class, shape = class)) +
        scale_shape_manual(values = c(15, 15, 15, 15)) +  # 使用正方形作为形状
        geom_point(size = 12) +
        scale_color_manual(values = color_mapping[df$class]) +
        labs(x = NULL, y = group) +
        theme_minimal() +
        theme(
            legend.position="none",
            #axis.text.x = element_blank(),
            axis.text.x = element_text(angle = 45, hjust = 1),
            panel.grid = element_blank())
    }                  
    pdf(paste0(path_test,"/output_plots.pdf"), width = 6, height = 20)
    grid.arrange(grobs = plot02, ncol = 1)
    dev.off()
################k################################################