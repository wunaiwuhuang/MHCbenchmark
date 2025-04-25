################################################################
################################
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
    path_test <- "/data1/wuguojia/data/mhc_benchmark/testbase"
    path_result<-"/data1/wuguojia/data/mhc_benchmark/testbase/result"
    path_compare<-"/data1/wuguojia/data/mhc_benchmark/testbase/result_compare"
    load(paste0(path_test,"/TEST.Rdata"))
################################################################

################################################################
################################ AUROC for all
    file <- list.files(path_compare, recursive = TRUE, full.names = TRUE)
    for(i in 1:length(file)){
        all_info<-list()
        len_info<-list()
        hla_info<-list()
        single_info<-list()
        ################################
        load(file[i])
        all<-do.call(rbind,tool_result)
        all_roc_bi<-roc(response=all$bind_result_base,predictor = all$bind_result_tool)
        all_roc_qu<-roc(response=all$bind_result_base,predictor = all$affinity)
        ################################
        all_info<-list(all=all,all_roc_bi = all_roc_bi,all_roc_qu = all_roc_qu)
        single_info<-list(tool_result=tool_result)
        save(all_info,len_info,hla_info,single_info,file=paste0(path_compare,"/",basename(file[[i]])))}
################################ AUROC for length
    file <- list.files(path_compare, recursive = TRUE, full.names = TRUE)
    file <- file[!grepl("deepnetbim", file)] #this one is totally garbage
    for(i in 1:length(file)){
        len_auroc<-list()
        name<-gsub("\\..*","",basename(file[i]))
        load(file[i]);all <- all_info$all
        for(len in c(8,9,10,11)){
            df<-all %>% filter(antigen_peptide_length==len)
            len_auroc[[paste0(name,"_",len)]]<-roc(response=df$bind_result_base,predictor = df$affinity)}
        ################################
        len_info<-list(len_auroc=len_auroc)
        save(all_info,len_info,hla_info,single_info,file=paste0(path_compare,"/",basename(file[[i]])))}
################################ AUROC for allele
    file <- list.files(path_compare, recursive = TRUE, full.names = TRUE)
    file <- file[!grepl("deepnetbim", file)] #this one is totally garbage
    for(i in 1:length(file)){
        hla_auroc<-list()
        name<-gsub("\\..*","",basename(file[i]))
        load(file[i]);all <- all_info$all
        for(hla in unique(all$allele)){
            df<-all %>% filter(allele==hla)
            if(nrow(df)>0){hla_auroc[[paste0(name,"_",hla)]]<-roc(response=df$bind_result_base,predictor = df$affinity)}}
        ################################
        hla_info<-list(hla_auroc=hla_auroc)
        save(all_info,len_info,hla_info,single_info,file=paste0(path_compare,"/",basename(file[[i]])))}
################################ AUROC for single
    file <- list.files(path_compare, recursive = TRUE, full.names = TRUE)
    file <- file[!grepl("deepnetbim", file)] #this one is totally garbage
    for(i in 1:length(file)){load(file[i])
        roclist<-list();tool_result<-single_info$tool_result
        perform_info <- data.frame( allele = character(),
                                    peptide_length = numeric(),
                                    auroc_bi = numeric(),
                                    auroc_qu = numeric(),
                                    stringsAsFactors = FALSE)
        for(k in 1:length(tool_result)){
            data<-as.data.frame(tool_result[[k]])
            allele <- unique(tool_result[[k]]$allele)
            peptide_length <- unique(tool_result[[k]]$antigen_peptide_length)
            roc_bi<-roc(response=data$bind_result_base,predictor = data$bind_result_tool)
            roc_qu<-roc(response=data$bind_result_base,predictor = data$affinity)
            roclist[[paste0(allele, "_", peptide_length, "_roc_bi")]] <- roc_bi
            roclist[[paste0(allele, "_", peptide_length, "_roc_qu")]] <- roc_qu
            perform_info <- rbind(perform_info, data.frame( 
                                    allele = allele,
                                    peptide_length = peptide_length,
                                    auroc_bi = roc_bi$auc,
                                    auroc_qu = roc_qu$auc))}
        ################################
        single_info<-list(tool_result=tool_result,roclist=roclist,perform_info=perform_info)
        save(all_info,len_info,hla_info,single_info,file=paste0(path_compare,"/",basename(file[[i]])))}
################################################################

################################################################
reverse<-c("netmhcpan_el","mhcflurry_ba","netmhccons","netmhcpan_ba","mixmhcpred","netmhcstabpan","consensus","capsnetmhc_ie","deepattentionpan")#these tool affinity is rank, so smaller means good
################################ AUPRC for all
    file <- list.files(path_compare, recursive = TRUE, full.names = TRUE)
    for(i in 1:length(file)){load(file[i])
        all<-all_info$all
        scores <- all$affinity
        labels <- all$bind_result_base
        if(sub("\\.Rdata$", "", basename(file[i]))%in%reverse){
            pos_val<-scores[labels == "negative"]
            neg_val<-scores[labels == "positive"]}else{
                pos_val<-scores[labels == "positive"]
                neg_val<-scores[labels == "negative"]}
        all_prc<- pr.curve(scores.class0 = pos_val,
                        scores.class1 = neg_val, 
                        curve = TRUE)
        ################################
        all_info<-c(all_info,list(all_prc=all_prc))
        save(all_info,len_info,hla_info,single_info,file=paste0(path_compare,"/",basename(file[[i]])))}
################################ AUPRC for length
    file <- list.files(path_compare, recursive = TRUE, full.names = TRUE)
    file <- file[!grepl("deepnetbim", file)] #this one is totally garbage
    for(i in 1:length(file)){
        len_auprc<-list()
        name<-gsub("\\..*","",basename(file[i]))
        load(file[i]);all <- all_info$all
        for(len in c(8,9,10,11)){
            df<-all %>% filter(antigen_peptide_length==len)
            scores <- df$affinity
            labels <- df$bind_result_base
            if(sub("\\.Rdata$", "", basename(file[i]))%in%reverse){
            pos_val<-scores[labels == "negative"]
            neg_val<-scores[labels == "positive"]}else{
                pos_val<-scores[labels == "positive"]
                neg_val<-scores[labels == "negative"]}
            len_auprc[[paste0(name,"_",len)]]<-pr.curve(scores.class0 = pos_val,scores.class1 = neg_val,curve = TRUE)}
        ################################
        len_info<-c(len_info,list(len_auprc=len_auprc))
        save(all_info,len_info,hla_info,single_info,file=paste0(path_compare,"/",basename(file[[i]])))}
################################ AUPRC for allele
    file <- list.files(path_compare, recursive = TRUE, full.names = TRUE)
    file <- file[!grepl("deepnetbim", file)] #this one is totally garbage
    for(i in 1:length(file)){
        hla_auprc<-list()
        name<-gsub("\\..*","",basename(file[i]))
        load(file[i]);all <- all_info$all
        for(hla in unique(all$allele)){
            df<-all %>% filter(allele==hla)
            scores <- df$affinity
            labels <- df$bind_result_base
            if(sub("\\.Rdata$", "", basename(file[i]))%in%reverse){
            pos_val<-scores[labels == "negative"]
            neg_val<-scores[labels == "positive"]}else{
                pos_val<-scores[labels == "positive"]
                neg_val<-scores[labels == "negative"]}
            if(nrow(df)>0){hla_auprc[[paste0(name,"_",hla)]]<-pr.curve(scores.class0 = pos_val,scores.class1 = neg_val,curve = TRUE)}}
        ################################
        hla_info<-c(hla_info,list(hla_auprc=hla_auprc))
        save(all_info,len_info,hla_info,single_info,file=paste0(path_compare,"/",basename(file[[i]])))}
################################ AUPRC for single
    file <- list.files(path_compare, recursive = TRUE, full.names = TRUE)
    file <- file[!grepl("deepnetbim", file)] #this one is totally garbage
    for(i in 1:length(file)){load(file[i])
        prclist<-list();tool_result<-single_info$tool_result
        perform_info <- single_info$perform_info
        perform_info$auprc <- NA
        for(k in 1:length(tool_result)){
            df<-as.data.frame(tool_result[[k]])
            allele <- unique(df$allele)
            peptide_length <- unique(df$antigen_peptide_length)
            scores <- df$affinity
            labels <- df$bind_result_base
            if(sub("\\.Rdata$", "", basename(file[i]))%in%reverse){
            pos_val<-scores[labels == "negative"]
            neg_val<-scores[labels == "positive"]}else{
                pos_val<-scores[labels == "positive"]
                neg_val<-scores[labels == "negative"]}
            if(nrow(df)>0){prclist[[paste0(allele, "_", peptide_length)]]<-pr.curve(scores.class0 = pos_val,scores.class1 = neg_val,curve = TRUE)}
            n <- which(perform_info$allele==allele & perform_info$peptide_length== peptide_length)
            perform_info$auprc[n]<-prclist[[paste0(allele, "_", peptide_length)]]$auc.integral}
        ################################
        single_info<-list(tool_result=single_info$tool_result,roclist=single_info$roclist,prclist=prclist,perform_info=perform_info)
        save(all_info,len_info,hla_info,single_info,file=paste0(path_compare,"/",basename(file[[i]])))}
################################################################

################################################################
################################ formulation
    #https://cran.r-project.org/web/packages/MLmetrics/MLmetrics.pdf
    #some data should calculated by myself to avoid error message
    calculate_mcc <- function(TP, TN, FP, FN) {TP <- as.numeric(TP);TN <- as.numeric(TN);FP <- as.numeric(FP);FN <- as.numeric(FN);(TP * TN - FP * FN) / sqrt((TP + FP) * (TP + FN) * (TN + FP) * (TN + FN))}
    calculate_other <- function(TP, TN, FP, FN, metric) {switch(metric,Recall = TP / (TP + FN),Precision = TP / (TP + FP),Sensitivity = TP / (TP + FN),Specificity = TN / (TN + FP),F1_Score = 2 * (TP / (TP + FP) * (TP / (TP + FN))) / ((TP / (TP + FP)) + (TP / (TP + FN))))}
################################ Performance for all
    file <- list.files(path_compare, recursive = TRUE, full.names = TRUE)
    # calculate
    for(i in 1:length(file)){load(file[i])
        all <- all_info$all %>% mutate(bind_result_base = case_when(bind_result_base == "positive" ~ 1, bind_result_base == "negative" ~ 0, TRUE ~ NA))
        y_true<-all$bind_result_base
        y_pred<-all$bind_result_tool
        con_matrix <- as.data.frame(ConfusionMatrix(y_pred, y_true))
        con_matrix <- con_matrix %>% complete(y_true = factor(c(0, 1)), y_pred = factor(c(0, 1)), fill = list(Freq = 0)) #make sure the frame is complete
        TP = con_matrix %>% filter(y_true == 1 & y_pred == 1) %>% .$Freq
        TN = con_matrix %>% filter(y_true == 0 & y_pred == 0) %>% .$Freq
        FP = con_matrix %>% filter(y_true == 0 & y_pred == 1) %>% .$Freq
        FN = con_matrix %>% filter(y_true == 1 & y_pred == 0) %>% .$Freq
        ################################
        all_info <- c(all_info,list(
            con_matrix=con_matrix,TP=TP,TN=TN,FP=FP,FN=FN,
            mcc = calculate_mcc(TP, TN, FP, FN),
            accuracy = Accuracy(y_true, y_pred),
            f1_score = F1_Score(y_true, y_pred, positive = 1),
            gainAUC = GainAUC(y_pred, y_true),
            gini = Gini(y_pred, y_true),
            ks_stat = KS_Stat(y_pred, y_true),
            liftAUC = LiftAUC(y_pred, y_true),
            logloss = LogLoss(y_pred, y_true),
            prAUC = PRAUC(y_pred, y_true),
            precision = Precision(y_true, y_pred, positive = 1),
            recall = Recall(y_true, y_pred, positive = 1),
            zerooneloss = ZeroOneLoss(y_pred, y_true),
            sensitivity = Sensitivity(y_true, y_pred, positive = 1),
            specificity = Specificity(y_true, y_pred, positive = 1)))
        save(all_info,len_info,hla_info,single_info,file=paste0(path_compare,"/",basename(file[[i]])))}
    # data table
    info <- list();for(i in 1:length(file)){load(file[i]);name<-gsub("\\..*","",basename(file[i]));info[[name]]<-all_info}
    per_all<-data.frame(toolname=character(),stringsAsFactors = FALSE)
    for(i in 1:length(info)){per_all<-rbind(per_all,data.frame(toolname=names(info[i])))}
    for(i in 1:length(info)){
        per_all$"AUROC"[i] <- info[[i]]$all_roc_qu$auc
        per_all$"AUPRC"[i] <- info[[i]]$all_prc$auc.integral
        per_all$"TP"[i] <- info[[i]]$TP
        per_all$"TN"[i] <- info[[i]]$TN
        per_all$"FP"[i] <- info[[i]]$FP
        per_all$"FN"[i] <- info[[i]]$FN
        per_all$"mcc"[i] <- info[[i]]$mcc
        per_all$"accuracy"[i] <- info[[i]]$accuracy
        per_all$"f1_score"[i] <- info[[i]]$f1_score
        per_all$"gainAUC"[i] <- info[[i]]$gainAUC
        per_all$"gini"[i] <- info[[i]]$gini
        per_all$"ks_stat"[i] <- info[[i]]$ks_stat
        per_all$"liftAUC"[i] <- info[[i]]$liftAUC
        per_all$"logloss"[i] <- info[[i]]$logloss
        per_all$"prAUC"[i] <- info[[i]]$prAUC
        per_all$"precision"[i] <- info[[i]]$precision
        per_all$"recall"[i] <- info[[i]]$recall
        per_all$"zerooneloss"[i] <- info[[i]]$zerooneloss
        per_all$"sensitivity"[i] <- info[[i]]$sensitivity
        per_all$"specificity"[i] <- info[[i]]$specificity}
    write.csv(per_all,file=paste0(path_test,"/all_performance.csv"))
################################ Performance for length
    file <- list.files(path_compare, recursive = TRUE, full.names = TRUE)
    file <- file[!grepl("deepnetbim", file)] #this one is totally garbage
    # calculate
    for(i in 1:length(file)){load(file[i])
        columns <- c("AUROC","AUPRC","TP", "TN", "FP", "FN", "mcc", "accuracy","f1_score", "gainAUC", "gini", "ks_stat", "liftAUC", "logloss", "prAUC", "precision", "recall", "zerooneloss", "sensitivity", "specificity")
        rows <- sapply(names(len_info$len_auroc), function(x) sub(".*_", "", x))
        df <- data.frame(matrix(NA, nrow = length(rows), ncol = length(columns)));colnames(df) <- columns;rownames(df) <- rows
        for(len in as.numeric(rows)){
            all <- all_info$all %>% filter(antigen_peptide_length==len) %>% mutate(bind_result_base = case_when(bind_result_base == "positive" ~ 1, bind_result_base == "negative" ~ 0, TRUE ~ NA))
            y_true<-all$bind_result_base
            y_pred<-all$bind_result_tool
            con_matrix <- as.data.frame(ConfusionMatrix(y_pred, y_true))
            con_matrix <- con_matrix %>% complete(y_true = factor(c(0, 1)), y_pred = factor(c(0, 1)), fill = list(Freq = 0)) #make sure the frame is complete
            TP=con_matrix%>%filter(y_true == 1 & y_pred == 1) %>% .$Freq
            TN=con_matrix%>%filter(y_true == 0 & y_pred == 0) %>% .$Freq
            FP=con_matrix%>%filter(y_true == 0 & y_pred == 1) %>% .$Freq
            FN=con_matrix%>%filter(y_true == 1 & y_pred == 0) %>% .$Freq
            n <- which(rownames(df)== len)
                temp_roc<-len_info$len_auroc[grep(len, names(len_info$len_auroc),fixed = TRUE)]
                temp_prc<-len_info$len_auprc[grep(len, names(len_info$len_auprc),fixed = TRUE)]
                df$"AUROC"[n] <- lapply(temp_roc, function(x) x$auc)
                df$"AUPRC"[n] <- lapply(temp_prc, function(x) x$auc.integral)
                df$"TP"[n] <- TP
                df$"TN"[n] <- TN
                df$"FP"[n] <- FP
                df$"FN"[n] <- FN
                df$"mcc"[n] <- calculate_mcc(TP, TN, FP, FN)
                df$"accuracy"[n] <- Accuracy(y_true, y_pred)
                df$"f1_score"[n] <- calculate_other(TP, TN, FP, FN, metric = "F1_Score")
                df$"gainAUC"[n] <- GainAUC(y_pred, y_true)
                df$"gini"[n] <- Gini(y_pred, y_true)
                df$"ks_stat"[n] <- KS_Stat(y_pred, y_true)
                df$"liftAUC"[n] <- LiftAUC(y_pred, y_true)
                df$"logloss"[n] <- LogLoss(y_pred, y_true)
                df$"prAUC"[n] <- PRAUC(y_pred, y_true)
                df$"precision"[n] <- calculate_other(TP, TN, FP, FN, metric = "Precision")
                df$"recall"[n] <- calculate_other(TP, TN, FP, FN, metric = "Recall")
                df$"zerooneloss"[n] <- ZeroOneLoss(y_pred, y_true)
                df$"sensitivity"[n] <- calculate_other(TP, TN, FP, FN, metric = "Sensitivity")
                df$"specificity"[n] <- calculate_other(TP, TN, FP, FN, metric = "Specificity")}
        ################################
        len_info<-list(len_auroc=len_info$len_auroc,len_auprc=len_info$len_auprc,len_per=df)
        save(all_info,len_info,hla_info,single_info,file=paste0(path_compare,"/",basename(file[[i]])))}
################################ Performance for allele
    file <- list.files(path_compare, recursive = TRUE, full.names = TRUE)
    file <- file[!grepl("deepnetbim", file)] #this one is totally garbage
    # calculate
    for(i in 1:length(file)){load(file[i])
        columns <- c("AUROC","AUPRC","TP", "TN", "FP", "FN", "mcc", "accuracy","f1_score", "gainAUC", "gini", "ks_stat", "liftAUC", "logloss", "prAUC", "precision", "recall", "zerooneloss", "sensitivity", "specificity")
        rows <- sapply(names(hla_info$hla_auroc), function(x) sub(".*_", "", x))
        df <- data.frame(matrix(NA, nrow = length(rows), ncol = length(columns)));colnames(df) <- columns;rownames(df) <- rows
        for(hla in rows){
            all <- all_info$all %>% filter(allele==hla) %>% mutate(bind_result_base = case_when(bind_result_base == "positive" ~ 1, bind_result_base == "negative" ~ 0, TRUE ~ NA))
            y_true<-all$bind_result_base
            y_pred<-all$bind_result_tool
            con_matrix <- as.data.frame(ConfusionMatrix(y_pred, y_true))
            con_matrix <- con_matrix %>% complete(y_true = factor(c(0, 1)), y_pred = factor(c(0, 1)), fill = list(Freq = 0)) #make sure the frame is complete
            TP=con_matrix%>%filter(y_true == 1 & y_pred == 1) %>% .$Freq
            TN=con_matrix%>%filter(y_true == 0 & y_pred == 0) %>% .$Freq
            FP=con_matrix%>%filter(y_true == 0 & y_pred == 1) %>% .$Freq
            FN=con_matrix%>%filter(y_true == 1 & y_pred == 0) %>% .$Freq
            n <- which(rownames(df)== hla)
                temp_roc<-hla_info$hla_auroc[grep(hla, names(hla_info$hla_auroc),fixed = TRUE)]
                temp_prc<-hla_info$hla_auprc[grep(hla, names(hla_info$hla_auprc),fixed = TRUE)]
                df$"AUROC"[n] <- lapply(temp_roc, function(x) x$auc)
                df$"AUPRC"[n] <- lapply(temp_prc, function(x) x$auc.integral)
                df$"TP"[n] <- TP
                df$"TN"[n] <- TN
                df$"FP"[n] <- FP
                df$"FN"[n] <- FN
                df$"mcc"[n] <- calculate_mcc(TP, TN, FP, FN)
                df$"accuracy"[n] <- Accuracy(y_true, y_pred)
                df$"f1_score"[n] <- calculate_other(TP, TN, FP, FN, metric = "F1_Score")
                df$"gainAUC"[n] <- GainAUC(y_pred, y_true)
                df$"gini"[n] <- Gini(y_pred, y_true)
                df$"ks_stat"[n] <- KS_Stat(y_pred, y_true)
                df$"liftAUC"[n] <- LiftAUC(y_pred, y_true)
                df$"logloss"[n] <- LogLoss(y_pred, y_true)
                df$"prAUC"[n] <- PRAUC(y_pred, y_true)
                df$"precision"[n] <- calculate_other(TP, TN, FP, FN, metric = "Precision")
                df$"recall"[n] <- calculate_other(TP, TN, FP, FN, metric = "Recall")
                df$"zerooneloss"[n] <- ZeroOneLoss(y_pred, y_true)
                df$"sensitivity"[n] <- calculate_other(TP, TN, FP, FN, metric = "Sensitivity")
                df$"specificity"[n] <- calculate_other(TP, TN, FP, FN, metric = "Specificity")}
        ################################
        hla_info<-list(hla_auroc=hla_info$hla_auroc,hla_auprc=hla_info$hla_auprc,hla_per=df)
        save(all_info,len_info,hla_info,single_info,file=paste0(path_compare,"/",basename(file[[i]])))}
################################ Performance for single
    file <- list.files(path_compare, recursive = TRUE, full.names = TRUE)
    file <- file[!grepl("deepnetbim", file)] #this one is totally garbage
    # calculate
    for(i in 1:length(file)){load(file[i])
        columns <- c("TP", "TN", "FP", "FN", "mcc", "accuracy","f1_score", "gainAUC", "gini", "ks_stat", "liftAUC", "logloss", "prAUC", "precision", "recall", "zerooneloss", "sensitivity", "specificity")
        df <- single_info$perform_info
        df[columns[!columns %in% names(df)]] <- NA        
        for(k in 1:length(single_info$tool_result)){
            data<-single_info$tool_result[[k]];data <- data %>% mutate(bind_result_base = case_when(bind_result_base == "positive" ~ 1, bind_result_base == "negative" ~ 0, TRUE ~ NA));y_true<-data$bind_result_base;y_pred<-data$bind_result_tool
            con_matrix <- as.data.frame(ConfusionMatrix(y_pred, y_true))
            con_matrix <- con_matrix %>% complete(y_true = factor(c(0, 1)), y_pred = factor(c(0, 1)), fill = list(Freq = 0)) #make sure the frame is complete
            TP=con_matrix%>%filter(y_true == 1 & y_pred == 1) %>% .$Freq
            TN=con_matrix%>%filter(y_true == 0 & y_pred == 0) %>% .$Freq
            FP=con_matrix%>%filter(y_true == 0 & y_pred == 1) %>% .$Freq
            FN=con_matrix%>%filter(y_true == 1 & y_pred == 0) %>% .$Freq
            hla=unique(data$allele);len=unique(data$antigen_peptide_length)
            n <- which(df$allele==hla & df$peptide_length== len)
                df$TP[n] <- TP
                df$TN[n] <- TN
                df$FP[n] <- FP
                df$FN[n] <- FN
                df$mcc[n] <- calculate_mcc(TP, TN, FP, FN)
                df$accuracy[n] <- Accuracy(y_true, y_pred)
                df$f1_score[n] <- calculate_other(TP, TN, FP, FN, metric = "F1_Score")
                df$gainAUC[n] <- GainAUC(y_pred, y_true)
                df$gini[n] <- Gini(y_pred, y_true)
                df$ks_stat[n] <- KS_Stat(y_pred, y_true)
                df$liftAUC[n] <- LiftAUC(y_pred, y_true)
                df$logloss[n] <- LogLoss(y_pred, y_true)
                df$prAUC[n] <- PRAUC(y_pred, y_true)
                df$precision[n] <- calculate_other(TP, TN, FP, FN, metric = "Precision")
                df$recall[n] <- calculate_other(TP, TN, FP, FN, metric = "Recall")
                df$zerooneloss[n] <- ZeroOneLoss(y_pred, y_true)
                df$sensitivity[n] <- calculate_other(TP, TN, FP, FN, metric = "Sensitivity")
                df$specificity[n] <- calculate_other(TP, TN, FP, FN, metric = "Specificity")}    
        ################################
        single_info$perform_info<-df
        save(all_info,len_info,hla_info,single_info,file=paste0(path_compare,"/",basename(file[[i]])))}
################################################################