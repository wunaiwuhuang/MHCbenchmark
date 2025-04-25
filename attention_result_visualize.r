##################################################################
    library(dplyr)
    library(ComplexHeatmap)
    library(grid)
    library(gridExtra)
################################# load data
    path_test<-"/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/"
    path_result<-"/data1/wuguojia/data/mhc_benchmark/attentionbase/result/"
    path_attention<-"/data1/wuguojia/data/mhc_benchmark/attentionbase/"
    test_files<-list.files(path=path_test,full.names=TRUE,recursive=TRUE,pattern="\\.csv$")
    result_files<-list.files(path=path_result,full.names=TRUE,recursive=FALSE,pattern="\\.csv$")
    #test
    df<-list();for(file in test_files){df[[file]]<-read.csv(file)}
    df<-do.call(rbind,df);rownames(df)<-NULL
    #result
    res<-list();for(file in result_files){res[[file]]<-read.csv(file)}
    #draw
    draw<-list()
#### HLA-A*02:01
    part1<-c("stmhcpan")
    part2<-c("netmhcpan_ba","mhcflurry_ba")
    draw[[1]] <- df[apply(df, 1, function(row) {
        part1_vals <- row[part1]
        part2_vals <- row[part2]
        allele_match <- row["hlatype"] == "HLA-A*02:01"
        #variance
        variance_match <- row["variance"] > 0.2
        #antigen_peptide
        peptide_match <- grepl("[LVIA]$", row["antigen_peptide"])
        #filter
        allele_match && variance_match && peptide_match && all(part1_vals == 1) && all(part2_vals == 0)}),]
#### HLA-B*15:02
    part1<-c("bigmhc","stmhcpan")
    part2<-c("transphla","capsnetmhc_an")
    draw[[2]] <- df[apply(df, 1, function(row) {
        part1_vals <- row[part1]
        part2_vals <- row[part2]
        allele_match <- row["hlatype"] == "HLA-B*15:02"
        #variance
        variance_match <- row["variance"] > 0.2
        #antigen_peptide
        peptide_match <- grepl("^[A-Z]([LVQPIFM])[A-Z]{6}[YLFM]$", row["antigen_peptide"])
        #filter
        allele_match && variance_match && peptide_match && all(part1_vals == 1) && all(part2_vals == 0)}),]
#### HLA-C*05:01
    part1<-c("mhcflurry_ps","stmhcpan")
    part2<-c("bigmhc","mhcflurry_ba")
    draw[[3]] <- df[apply(df, 1, function(row) {
        part1_vals <- row[part1]
        part2_vals <- row[part2]
        allele_match <- row["hlatype"] == "HLA-C*05:01"
        #variance
        variance_match <- row["variance"] > 0.2
        #antigen_peptide
        peptide_match <- grepl("[LVFIM]$", row["antigen_peptide"])
        #filter
        allele_match && variance_match && peptide_match && all(part1_vals == 1) && all(part2_vals == 0)}),]
### HLA-A*02:01 + NAAERRGPL
    draw[[4]] <- df[apply(df, 1, function(row) {
        allele_match <- row["hlatype"] == "HLA-A*02:01"
        peptide_match<-row["antigen_peptide"] == "NAAERRGPL"
        allele_match && peptide_match}),]
#### HLA-B*15:02 + HVEKLARTL
    draw[[5]] <- df[apply(df, 1, function(row) {
        allele_match <- row["hlatype"] == "HLA-B*15:02"
        peptide_match<-row["antigen_peptide"] == "HVEKLARTL"
        allele_match && peptide_match}),]
#### HLA-C*05:01 + SLIARLERL
    draw[[6]] <- df[apply(df, 1, function(row) {
        allele_match <- row["hlatype"] == "HLA-C*05:01"
        peptide_match<-row["antigen_peptide"] == "SLIARLERL"
        allele_match && peptide_match}),]        
###########################################################

################################# single peptide - multi tools
    for(num in 1:3){
        # load data
        data<-draw[[num]][,c("hlatype","antigen_peptide","fn_contribute","variance")]
        data <- data[order(-data$fn_contribute, -data$variance), ]
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
        pdf(paste0("/data1/wuguojia/data/mhc_benchmark/attentionbase/attention_",num,".pdf"), width = 12, height = 3) #此处调整热图尺寸。预定每页三列两行
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
    }
################################# peptide length - multi tools
    Allele <- c("HLA-A*02:01","HLA-B*15:02","HLA-C*05:01")
    Mode <- "LIME" #SHAP
    Bind <- "positive"
    len=9
    #deal data
    draw_list <- list()
    for(hla in Allele){
        for (df in res) {
        filtered_df <- df %>% filter(allele == hla, mode == Mode, bind_result_base == Bind)
        if (nrow(filtered_df) > 0) {
            #all data
            temp<-filtered_df 
            # temp <- filtered_df%>%filter(bind_result_tool==1)#predicted positive
            # temp <- filtered_df%>%filter(bind_result_tool==0)#predicted negative 
            draw_list[[hla]] <- bind_rows(draw_list[[hla]], temp)
        }}}
    for(i in 1:length(draw_list)){
        df<-draw_list[[i]]
        df<-df[,5:(5+unique(df$length))]#contain toolname and attention
        df <- df %>% group_by(tool) %>% summarise(across(everything(),  median, na.rm = TRUE)) 
        draw_list[[i]]<-df}
    #draw heatmap
    order <- c("netmhcpan_el","netmhcpan_ba","mhcflurry_ps","mhcflurry_ba","capsnetmhc_an","bigmhc","stmhcpan","transphla")
    # 打开一个 PDF 文件设备，准备将所有热图保存到一个文件中
    pdf(paste0(path_attention,"attention_of_all_",Mode,".pdf"), width = 6, height = 3)
    # 定义每页的布局：三列两行
    page_layout <- grid.layout(nrow = 2, ncol = 3, heights = unit(rep(1, 2), "null"), widths = unit(rep(1, 3), "null"))
    # 初始化页面计数器和布局位置计数器
    layout_counter <- 1
    grid.newpage()
    pushViewport(viewport(layout = page_layout))
    # 迭代绘制每个热图
    for(i in 1:length(draw_list)){
        df<-as.data.frame(draw_list[[i]])
        df <- df %>% mutate(tool = factor(tool, levels = order)) %>% arrange(tool) # reorder
        input<-as.matrix(df[,-1])
        ht <-Heatmap(
            input,
            col = colorRamp2(c(-0.35, 0, 0.2), c("#A0C8E3", "#FDFDFD", "#FF8A8A")),
            border = TRUE,
            border_gp = gpar(col = "black"),
            cell_fun = function(j, i, x, y, width, height, fill) {
                #add number
                grid.text(sprintf("%.2f", input[i, j]), x, y, gp = gpar(fontsize = 5))
                #add border
                grid.rect(x, y, width = width, height = height, gp = gpar(col = "grey", lwd = 0.5, fill = NA))},
            column_title = names(draw_list)[i],
            column_labels = 1:as.numeric(len),
            column_names_rot = 0,
            column_names_gp = gpar(fontsize = 7),
            row_labels = NULL,
            row_names_gp = gpar(fontsize = 7),
            cluster_rows = FALSE,
            cluster_columns = FALSE,
            show_heatmap_legend = FALSE)
        # 计算当前热图的行和列位置
        row_pos <- ceiling(layout_counter / 3) # 计算当前行位置
        col_pos <- layout_counter %% 3         # 计算当前列位置
        if (col_pos == 0) col_pos <- 3         # 调整列位置
        # 绘制热图到指定位置
        pushViewport(viewport(layout.pos.row = row_pos, layout.pos.col = col_pos))
        draw(ht, newpage = FALSE)
        popViewport()
        # 更新布局位置计数器
        layout_counter <- layout_counter + 1
        # 检查是否需要开始新的一页
        if (layout_counter > 6) {
            layout_counter <- 1
            grid.newpage()
            pushViewport(viewport(layout = page_layout))
        }
    }
    # 关闭 PDF 文件设备
    dev.off()
################################# selected peptide -multi tools
    data<-do.call(rbind,draw[4:6])
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
        draw_df[[i]]<-matched_rows
    }
    #draw heatmap
    order <- c("netmhcpan_el","netmhcpan_ba","mhcflurry_ps","mhcflurry_ba","capsnetmhc_an","bigmhc","stmhcpan","transphla")
    # 打开一个 PDF 文件设备，准备将所有热图保存到一个文件中
    pdf(paste0(path_attention,"attention_of_selected_peptides.pdf"), width = 6, height = 3)
    # 定义每页的布局：三列两行
    page_layout <- grid.layout(nrow = 2, ncol = 3, heights = unit(rep(1, 2), "null"), widths = unit(rep(1, 3), "null"))
    # 初始化页面计数器和布局位置计数器
    layout_counter <- 1
    grid.newpage()
    pushViewport(viewport(layout = page_layout))
    # 迭代绘制每个热图
    for(i in 1:length(draw_df)){
        for(Mode in c("LIME","SHAP")){
            df<-as.data.frame(draw_df[[i]])
            df <- df[df$mode == Mode, ]
            df <- df %>% mutate(tool = factor(tool, levels = order)) %>% arrange(tool) # reorder
            input <- as.matrix(df[, grep("^pos_[1-9]$", colnames(df))])        
            ht <-Heatmap(
                input,
                col = colorRamp2(c(-0.35, 0, 0.2), c("#A0C8E3", "#FDFDFD", "#FF8A8A")),
                border = TRUE,
                border_gp = gpar(col = "black"),
                cell_fun = function(j, i, x, y, width, height, fill) {
                    #add number
                    grid.text(sprintf("%.2f", input[i, j]), x, y, gp = gpar(fontsize = 5))
                    #add border
                    grid.rect(x, y, width = width, height = height, gp = gpar(col = "grey", lwd = 0.5, fill = NA))},
                column_title = paste0(Mode," for ",unique(draw_df[[i]]$allele)),
                column_title_gp = gpar(fontsize = 7),
                column_labels = 1:9,
                column_names_rot = 0,
                column_names_gp = gpar(fontsize = 7),
                row_labels = NULL,
                row_names_gp = gpar(fontsize = 7),
                cluster_rows = FALSE,
                cluster_columns = FALSE,
                show_heatmap_legend = FALSE)
            # 计算当前热图的行和列位置
            row_pos <- ceiling(layout_counter / 3) # 计算当前行位置
            col_pos <- layout_counter %% 3         # 计算当前列位置
            if (col_pos == 0) col_pos <- 3         # 调整列位置
            # 绘制热图到指定位置
            pushViewport(viewport(layout.pos.row = row_pos, layout.pos.col = col_pos))
            draw(ht, newpage = FALSE)
            popViewport()
            # 更新布局位置计数器
            layout_counter <- layout_counter + 1
            # 检查是否需要开始新的一页
            if (layout_counter > 6) {
                layout_counter <- 1
                grid.newpage()
                pushViewport(viewport(layout = page_layout))
            }
        }
    }
    # 关闭 PDF 文件设备
    dev.off()
###########################################################