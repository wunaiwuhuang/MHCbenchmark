#this program aims to select peptides from traindata_raw file
    library(dplyr)
    library(gridExtra)
    library(ggseqlogo)
    path_attention<-"/data1/wuguojia/data/mhc_benchmark/attentionbase/"
    path_compare<-"/data1/wuguojia/data/mhc_benchmark/testbase/result_compare/"
    path_trainraw<-"/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_raw/"
    path_testuse<-"/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_use/"
################################# extract meaningful data
    toolname<-c("mhcflurry_ba","mhcflurry_ps","netmhcpan_ba","netmhcpan_el","capsnetmhc_an","transphla","stmhcpan","bigmhc")
    # add bind results and variance 
    filelist<-list.files(path_trainraw, pattern = "\\.csv$", full.names = TRUE)
    test<-list()
    for(i in 1:length(filelist)){
        df<-read.csv(filelist[i])
        for(tool in toolname){load(paste0(path_compare,"/",tool,".Rdata"))
            all<-all_info$all
            all<-all[,c("allele","peptide","bind_result_tool")]
            colnames(all)<-c("hlatype","antigen_peptide",tool)
            df <- left_join(df, all, by = c("hlatype", "antigen_peptide"))
        }
        df$variance<-apply(df[, (ncol(df)-length(toolname)+1):ncol(df)], 1, var) #calculate variance
        test[[i]]<-df
    }
    # add FN contribution column
    calculate_fn <- function(data) {
        fn_values <- sapply(data[, c("mhcflurry_ba", "mhcflurry_ps", 
                                        "netmhcpan_ba", "netmhcpan_el", 
                                        "capsnetmhc_an", "transphla", 
                                        "stmhcpan", "bigmhc")], function(tool_col) {
            fn_count <- sum(tool_col == 0 & data$bind_result == 'positive')
            total_count <- sum(data$bind_result == 'positive')
            fn_ratio <- ifelse(total_count > 0, fn_count / total_count, 0)
            return(fn_ratio)
        })
        return(fn_values)
    }# a function to calculate FN ratio
    for(i in 1:length(test)){
        df<-test[[i]]
        fn<-calculate_fn(df)
        # Determine the indices of the top 2 and bottom 2 'fn' values
        top2_indices <- order(fn, decreasing = TRUE)[1:2]
        bottom2_indices <- order(fn, decreasing = FALSE)[1:2]
        # Assign weights to the top 2 and bottom 4 tools
        weights <- rep(1, length(fn))
        weights[top2_indices] <- 2
        weights[bottom2_indices] <- 2
        # Determine the indices of the top 2 and bottom 2 'fn' values
        top4_name <- names(fn[order(fn, decreasing = TRUE)[1:4]])
        bottom4_name <- names(fn[order(fn, decreasing = FALSE)[1:4]])
        # Compute the fn_contribute using vectorized operations
        for(j in 1:nrow(df)){
            tool_values <- df[j, names(fn)]
            weight_contribution <- sum(weights[names(fn) %in% bottom4_name & tool_values == 1]) + sum(weights[names(fn) %in% top4_name & tool_values == 0]) - sum(weights[names(fn) %in% bottom4_name & tool_values == 0]) - sum(weights[names(fn) %in% top4_name & tool_values == 1])
            df$fn_contribute[j] <- weight_contribution
        }
        test[[i]]<-df
    }
    # select usable dataset
    test01<-list()
    for(i in 1:length(test)){
        df<-test[[i]]
        df<-df%>%filter(variance>0 & fn_contribute>2)
        test01[[i]]<-df
    }
    # save data
    save(test,test01,file=paste0(path_attention,"test_selection.Rdata"))
################################# generate global motif
    # generate PWM
    amino_acids <- c("A", "R", "N", "D", "C", "E", "Q", "G", "H", "I", 
                 "L", "K", "M", "F", "P", "S", "T", "W", "Y", "V")
    calculate_pwm <- function(sequences) {
        pwm <- matrix(0, nrow = length(amino_acids), ncol = 9,dimnames = list(amino_acids, paste0("Pos", 1:9)))
        for (seq in sequences) {
            chars <- strsplit(seq, split = "")[[1]]
            for (pos in seq_along(chars)) {
            aa <- chars[pos]
            pwm[aa, pos] <- pwm[aa, pos] + 1
            }
        }
        pwm <- pwm / length(sequences)
        return(pwm)
    }
    overall_pwm<-list()
    for(i in 1:length(test)){overall_pwm[[i]]<-calculate_pwm(test[[i]]$antigen_peptide)}#ground truth
################################# extract similar-motif test data
    #使用 PWM 之间的欧氏距离来衡量两个motif的相似性
    similarity_metric <- function(pwm1, pwm2) {sqrt(sum((pwm1 - pwm2)^2))}
    #贪心抽样算法
    n_samples <- 100
    selected_sequences<-list()
    for(i in 1:length(test01)){
        sequences<-test01[[i]]$antigen_peptide
        num_sequences<-length(sequences)
        selected_indices <- sample(1:num_sequences, n_samples)
        selected_sequences[[i]] <- sequences[selected_indices]
        selected_pwm <- calculate_pwm(selected_sequences[[i]])
        for(k in 1:15000){ #iterate times
            candidate_index <- sample(setdiff(1:num_sequences, selected_indices), 1)
            candidate_sequences <- sequences[candidate_index]
            replace_index <- sample(1:n_samples, 1)
            new_sequences <- selected_sequences[[i]]
            new_sequences[replace_index] <- candidate_sequences
            new_pwm <- calculate_pwm(new_sequences)
            current_similarity <- similarity_metric(selected_pwm, overall_pwm[[i]])
            new_similarity <- similarity_metric(new_pwm, overall_pwm[[i]])
            if (new_similarity < current_similarity) {
                selected_indices[replace_index] <- candidate_index
                selected_sequences[[i]]<- new_sequences
                selected_pwm <- new_pwm
            }
        }
    }
################################# visualize test motif
    data <- do.call(rbind, lapply(seq_along(test01), function(i) {subset(test01[[i]], antigen_peptide %in% selected_sequences[[i]])}))
    len_se<-9
    hla_se<-c("HLA-A*02:01","HLA-B*15:02","HLA-C*05:01")
    plogo<-list();
    for(hla in hla_se){
        for(len in len_se){
            df<-data %>% filter(hlatype==hla&antigen_peptide_length ==len&bind_result=="positive")
            plogo[[paste0(hla,"_",len)]]<-ggplot() +
            geom_logo(df$antigen_peptide, method = "bits", seq_type = "aa") +
            theme_logo() +
            ggtitle(paste0(hla,"  ",len,"-mer")) +
            labs(y = NULL,x=NULL,title=NULL) +
            theme_minimal(base_size = 15) +
            theme(
                panel.grid=element_blank(),
                panel.border=element_rect(color ="black",fill = NA,size = 0.5),
                panel.background = element_rect(fill = "white", color = "black"),
                plot.title = element_text(hjust = 0.5,size = 7),
                axis.text.x = element_text(angle = 0, hjust = 1, size = 7),
                axis.text.y = element_text(size = 7),
                legend.position = "none")
        }
    }
    pdf(paste0(path_attention,"testdata_plogo.pdf"), width = 7.5, height = 1.6)
    grid.arrange(grobs = plogo, nrow = 1)
    dev.off()
################################# visualize fn ratio
    test02 <- list()
    for (i in seq_along(test01)) {
        selected_seqs <- selected_sequences[[i]]
        test02[[i]] <- test01[[i]][test01[[i]]$antigen_peptide %in% selected_seqs,]
    }
    results <- list();plot<-list()
    for(i in 1:length(test02)){
        df1 <- test01[[i]]
        df2 <- test02[[i]]
        fn_test01 <- calculate_fn(df1)
        fn_test02 <- calculate_fn(df2)
        results[[i]]<- data.frame(Tool = names(fn_test01),All = fn_test01,Test = fn_test02)
        results_long <- pivot_longer(results[[i]], 
                        cols = c("All","Test"),
                        names_to = "Dataset", 
                        values_to = "FN_Value")
        # show in order
        results_long <- results_long %>%
        group_by(Tool) %>%
        mutate(test = FN_Value[Dataset == "Test"]) %>%
        ungroup() %>%
        arrange(desc(test))
        results_long$Tool <- factor(results_long$Tool, levels = unique(results_long$Tool))
        # draw bar plots
        plot[[i]]<- ggplot(results_long, aes(x = Tool, y = FN_Value, fill = Dataset)) +
        geom_bar(stat = "identity", position = "dodge",width = 0.5) +
        scale_fill_manual(values = c("All" = "steelblue", "Test" = "firebrick"))+
        theme_minimal() +
        labs(title = NULL, x = NULL, y = NULL, fill = "Dataset") +
        theme(
            panel.grid=element_blank(),
            panel.border=element_rect(color ="black",fill = NA,size = 0.5),
            panel.background = element_rect(fill = "white", color = "black"),
            axis.text.x = element_text(angle = 45, hjust = 1),
            legend.position = "none")
        hla<-unique(test02[[i]]$hlatype)
    }        
    pdf(paste0(path_attention,"testdata_FNratio.pdf"), width = 7.5, height = 1.6)
    grid.arrange(grobs = plot, nrow = 1)
    dev.off()
################################# save data
    for(i in 1:length(test02)){df<-test02[[i]];len=unique(df$antigen_peptide_length);hla=unique(df$hlatype);write.csv(df,paste0(path_testuse,hla,"_",len,".csv"),row.names = FALSE)}





