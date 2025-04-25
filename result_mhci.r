################################################################
################################
    library(data.table)
    library(dplyr)
    library(tidyr)
    path_test <- "/data1/wuguojia/data/mhc_benchmark/testbase"
    path_result<-"/data1/wuguojia/data/mhc_benchmark/testbase/result"
    path_compare<-"/data1/wuguojia/data/mhc_benchmark/testbase/result_compare"
    load(paste0(path_test,"/TEST.Rdata"))
################################
    path_consensus<-paste0(path_result,"/consensus")
    path_mhcflurry<-paste0(path_result,"/mhcflurry")
    path_netmhcpan_ba<-paste0(path_result,"/netmhcpan_ba")
    path_netmhcpan_el<-paste0(path_result,"/netmhcpan_el")
    path_netmhcstabpan<-paste0(path_result,"/netmhcstabpan")
    path_mixmhcpred<-paste0(path_result,"/mixmhcpred")
    path_netmhccons<-paste0(path_result,"/netmhccons")
################################
    path_capsnetmhc_an<-paste0(path_result,"/capsnetmhc_an")
    path_capsnetmhc_ie<-paste0(path_result,"/capsnetmhc_ie")
    path_stmhcpan <- paste0(path_result,"/stmhcpan")
    path_transphla <- paste0(path_result,"/transphla")
    path_deepattentionpan <- paste0(path_result,"/deepattentionpan")
    path_acme <- paste0(path_result,"/acme")
    path_deephlapan <- paste0(path_result,"/deephlapan")
    path_deepnetbim <- paste0(path_result,"/deepnetbim")
    path_bigmhc_el <- paste0(path_result,"/bigmhc_el")
################################################################

################################################################
# ABOUT THRESHOLDS
# 基于具体allele（https://help.iedb.org/hc/en-us/articles/114094149631-HLA-Class-I-Alleles-Are-Associated-with-Peptide-Binding-Repertoires-of-Different-Size-Affinity-and-Immunogenicity-2013）计算affinity中位数并赋予二分类结果。且经检查，所有工具的rank值均基于allele设定，非整体数据计算得出。
# 首先，官方文档对于阈值的提供，未有笃定positive和negative者，只说commonly used 或者 recommandation，大于某个值有较高概率预测成功。预测工具只给出连续值作为参考，positive和negative终究需回归实验证实。鉴于多数工具均为提供recommand threshold，且实验队列样本数目已知，本benchmark持公平态度，统一规定二分类标准，如上注释所示。有官方文档者均已标注。
################################ iedb consensus
    file <- list.files(path_consensus, recursive = TRUE, full.names = TRUE)
    tool_result<-list()
    for(i in 1:length(file)){data<-fread(file[i]);name<-gsub("\\..*","",basename(file[i]));if(nrow(data)>0){tool_result[[name]]<-data}}
    #get binary results. 0=negative.
    #binding affinity threshold is not provided.
    #primary: affinity >=2 is negative
    #now: affinity>=median number is negative
    for(i in 1:length(tool_result)){
        data<-as.data.frame(tool_result[[i]][,c("allele","peptide","consensus_percentile_rank")])
        colnames(data)[1:3]<-c("allele","peptide","affinity")
        med <- median(data$affinity, na.rm = TRUE)
        data<-data%>%mutate(bind_result_tool=ifelse(affinity>=med,0,1))
        tool_result[[i]]<-data}
    valid<-list();k=1;for(i in 1:length(tool_result)){if(class(tool_result[[i]]$"affinity")=="numeric"|class(tool_result[[i]]$"affinity")=="integer"){valid[[k]]<-tool_result[[i]];k=k+1}};tool_result<-valid#some tools will generate invalid value if they meet unsuitable allele or peptide length. i must clean them out.    
    for(i in 1:length(tool_result)){data<-as.data.frame(tool_result[[i]]);data<-data%>%inner_join(test_mhci,by=c("allele"="hlatype","peptide"="antigen_peptide"))%>%rename(bind_result_base=bind_result);tool_result[[i]]<-data}#merge test and tool result
    save(tool_result,file=paste0(path_compare,"/consensus.Rdata"))
################################ mhcflurry_ba
    file <- list.files(path_mhcflurry, recursive = TRUE, full.names = TRUE)
    tool_result<-list()
    for(i in 1:length(file)){data<-fread(file[i]);name<-gsub("\\..*","",basename(file[i]));if(nrow(data)>0){tool_result[[name]]<-data}}
    #get binary results. 0=negative.
    #binding affinity rank > 2% is official recommandation. see: https://openvax.github.io/mhcflurry/commandline_tutorial.html ."The mhcflurry_affinity_percentile gives the percentile of the affinity prediction among a large number of random peptides tested on that allele (range 0 - 100). Lower is stronger. Two percent is a commonly-used threshold."
    #primary: affinity >=2 is negative
    #now: affinity>=median number is negative
    for(i in 1:length(tool_result)){
        data<-as.data.frame(tool_result[[i]][,c("allele","peptide","mhcflurry_affinity_percentile")])
        colnames(data)[1:3]<-c("allele","peptide","affinity")
        med <- median(data$affinity, na.rm = TRUE)
        data<-data%>%mutate(bind_result_tool=ifelse(affinity>=med,0,1))
        tool_result[[i]]<-data}
    valid<-list();k=1;for(i in 1:length(tool_result)){if(class(tool_result[[i]]$"affinity")=="numeric"|class(tool_result[[i]]$"affinity")=="integer"){valid[[k]]<-tool_result[[i]];k=k+1}};tool_result<-valid#some tools will generate invalid value if they meet unsuitable allele or peptide length. i must clean them out.
    for(i in 1:length(tool_result)){data<-as.data.frame(tool_result[[i]]);data<-data%>%inner_join(test_mhci,by=c("allele"="hlatype","peptide"="antigen_peptide"))%>%rename(bind_result_base=bind_result);tool_result[[i]]<-data}#merge test and tool result
    save(tool_result,file=paste0(path_compare,"/mhcflurry_ba.Rdata"))
################################ mhcflurry_ps
    file <- list.files(path_mhcflurry, recursive = TRUE, full.names = TRUE)
    tool_result<-list()
    for(i in 1:length(file)){data<-fread(file[i]);name<-gsub("\\..*","",basename(file[i]));if(nrow(data)>0){tool_result[[name]]<-data}}
    #get binary results. 0=negative.
    #binding threshold is not provided. see: https://openvax.github.io/mhcflurry/commandline_tutorial.html ."The last two columns give the antigen processing and presentation scores, respectively. These range from 0 to 1 with higher values indicating more favorable processing or presentation."
    #primary: affinity >=0.5 is positive
    #now: affinity>=median number is positive
    for(i in 1:length(tool_result)){
        data<-as.data.frame(tool_result[[i]][,c("allele","peptide","mhcflurry_presentation_score")])
        colnames(data)[1:3]<-c("allele","peptide","affinity")
        med <- median(data$affinity, na.rm = TRUE)
        data<-data%>%mutate(bind_result_tool=ifelse(affinity>=med,1,0))
        tool_result[[i]]<-data}
    valid<-list();k=1;for(i in 1:length(tool_result)){if(class(tool_result[[i]]$"affinity")=="numeric"|class(tool_result[[i]]$"affinity")=="integer"){valid[[k]]<-tool_result[[i]];k=k+1}};tool_result<-valid#some tools will generate invalid value if they meet unsuitable allele or peptide length. i must clean them out.
    for(i in 1:length(tool_result)){data<-as.data.frame(tool_result[[i]]);data<-data%>%inner_join(test_mhci,by=c("allele"="hlatype","peptide"="antigen_peptide"))%>%rename(bind_result_base=bind_result);tool_result[[i]]<-data}#merge test and tool result
    save(tool_result,file=paste0(path_compare,"/mhcflurry_ps.Rdata"))
################################ netmhcpan_ba
    file <- list.files(path_netmhcpan_ba, recursive = TRUE, full.names = TRUE)
    tool_result<-list()
    for(i in 1:length(file)){data<-fread(file[i]);name<-gsub("\\..*","",basename(file[i]));if(nrow(data)>0){tool_result[[name]]<-data}}
    #get binary results. 0=negative.
    #binding affinity rank > 2% is official recommandation. see: https://academic.oup.com/nar/article/48/W1/W449/5837056
    #primary: affinity >=2 is negative
    #now: affinity>=median number is negative
    for(i in 1:length(tool_result)){
        data<-as.data.frame(tool_result[[i]][,c("allele","peptide","rank")])
        colnames(data)[1:3]<-c("allele","peptide","affinity")
        med <- median(data$affinity, na.rm = TRUE)
        data <- data%>%mutate(bind_result_tool=ifelse(affinity>=med,0,1))
        tool_result[[i]]<-data}
    valid<-list();k=1;for(i in 1:length(tool_result)){if(class(tool_result[[i]]$"affinity")=="numeric"|class(tool_result[[i]]$"affinity")=="integer"){valid[[k]]<-tool_result[[i]];k=k+1}};tool_result<-valid#some tools will generate invalid value if they meet unsuitable allele or peptide length. i must clean them out.
    for(i in 1:length(tool_result)){data<-as.data.frame(tool_result[[i]]);data<-data%>%inner_join(test_mhci,by=c("allele"="hlatype","peptide"="antigen_peptide"))%>%rename(bind_result_base=bind_result);tool_result[[i]]<-data}#merge test and tool result
    save(tool_result,file=paste0(path_compare,"/netmhcpan_ba.Rdata"))
################################ netmhcpan_el
    file <- list.files(path_netmhcpan_el, recursive = TRUE, full.names = TRUE)
    tool_result<-list()
    for(i in 1:length(file)){data<-fread(file[i]);name<-gsub("\\..*","",basename(file[i]));if(nrow(data)>0){tool_result[[name]]<-data}}
    #get binary results. 0=negative.
    #binding affinity rank > 2% is official recommandation. see: https://academic.oup.com/nar/article/48/W1/W449/5837056
    #primary: affinity >=2 is negative
    #now: affinity>=median number is negative
    for(i in 1:length(tool_result)){
        data<-as.data.frame(tool_result[[i]][,c("allele","peptide","rank")])
        colnames(data)[1:3]<-c("allele","peptide","affinity")
        med <- median(data$affinity, na.rm = TRUE)
        data<-data%>%mutate(bind_result_tool=ifelse(affinity>=med,0,1))
        tool_result[[i]]<-data}
    valid<-list();k=1;for(i in 1:length(tool_result)){if(class(tool_result[[i]]$"affinity")=="numeric"|class(tool_result[[i]]$"affinity")=="integer"){valid[[k]]<-tool_result[[i]];k=k+1}};tool_result<-valid#some tools will generate invalid value if they meet unsuitable allele or peptide length. i must clean them out.
    for(i in 1:length(tool_result)){data<-as.data.frame(tool_result[[i]]);data<-data%>%inner_join(test_mhci,by=c("allele"="hlatype","peptide"="antigen_peptide"))%>%rename(bind_result_base=bind_result);tool_result[[i]]<-data}#merge test and tool result
    save(tool_result,file=paste0(path_compare,"/netmhcpan_el.Rdata"))
################################ netmhcstabpan
    file <- list.files(path_netmhcstabpan, recursive = TRUE, full.names = TRUE)
    tool_result<-list()
    for(i in 1:length(file)){data<-fread(file[i]);name<-gsub("\\..*","",basename(file[i]));if(nrow(data)>0){tool_result[[name]]<-data}}
    #get binary results. 0=negative.
    #binding affinity threshold is not provided.
    #primary: affinity>=2 is negative
    #now: affinity>=median number is negative
    for(i in 1:length(tool_result)){
        data<-as.data.frame(tool_result[[i]][,c("allele","peptide","rank")])
        colnames(data)[1:3]<-c("allele","peptide","affinity")
        med <- median(data$affinity, na.rm = TRUE)
        data<-data%>%mutate(bind_result_tool=ifelse(affinity>=med,0,1))
        tool_result[[i]]<-data}
    valid<-list();k=1;for(i in 1:length(tool_result)){if(class(tool_result[[i]]$"affinity")=="numeric"|class(tool_result[[i]]$"affinity")=="integer"){valid[[k]]<-tool_result[[i]];k=k+1}};tool_result<-valid#some tools will generate invalid value if they meet unsuitable allele or peptide length. i must clean them out.
    for(i in 1:length(tool_result)){data<-as.data.frame(tool_result[[i]]);data<-data%>%inner_join(test_mhci,by=c("allele"="hlatype","peptide"="antigen_peptide"))%>%rename(bind_result_base=bind_result);tool_result[[i]]<-data}#merge test and tool result
    save(tool_result,file=paste0(path_compare,"/netmhcstabpan.Rdata"))
################################ mixmhcpred
    file <- list.files(path_mixmhcpred, recursive = TRUE, full.names = TRUE)
    tool_result<-list()
    for(i in 1:length(file)){data<-fread(file[i]);colnames(data)<-c("peptide","Score_bestAllele","allele","%Rank_bestAllele","Score_allele","%Rank_allele");name<-gsub("\\..*","",basename(file[i]));data$allele<-gsub("_.*","",name);if(nrow(data)>0){tool_result[[name]]<-data}}
    #get binary results. 0=negative.
    #binding affinity threshold is not provided.
    #primary: affinity>=2 is negative
    #now: affinity>=median number is negative
    for(i in 1:length(tool_result)){
        data<-as.data.frame(tool_result[[i]][,c("allele","peptide","%Rank_bestAllele")])
        colnames(data)[1:3]<-c("allele","peptide","affinity")
        med <- median(data$affinity, na.rm = TRUE)
        data<-data %>% mutate(bind_result_tool=ifelse(affinity>=med,0,1))
        tool_result[[i]]<-data}
    valid<-list();k=1;for(i in 1:length(tool_result)){if(class(tool_result[[i]]$"affinity")=="numeric"|class(tool_result[[i]]$"affinity")=="integer"){valid[[k]]<-tool_result[[i]];k=k+1}};tool_result<-valid#some tools will generate invalid value if they meet unsuitable allele or peptide length. i must clean them out.
    for(i in 1:length(tool_result)){data<-as.data.frame(tool_result[[i]]);data<-data%>%inner_join(test_mhci,by=c("allele"="hlatype","peptide"="antigen_peptide"))%>%rename(bind_result_base=bind_result);tool_result[[i]]<-data}#merge test and tool result
    save(tool_result,file=paste0(path_compare,"/mixmhcpred.Rdata"))
################################ netmhccons
    file <- list.files(path_netmhccons, recursive = TRUE, full.names = TRUE)
    tool_result<-list()
    for(i in 1:length(file)){data<-fread(file[i]);name<-gsub("\\..*","",basename(file[i]));if(nrow(data)>0){tool_result[[name]]<-data}}
    #get binary results. 0=negative.
    #binding affinity threshold is not provided.
    #primary: affinity>=2 is negative
    #now: affinity>=median number is negative
    for(i in 1:length(tool_result)){
        data<-as.data.frame(tool_result[[i]][,c("allele","peptide","rank")])
        colnames(data)[1:3]<-c("allele","peptide","affinity")
        med <- median(data$affinity, na.rm = TRUE)
        data <- data%>%mutate(bind_result_tool=ifelse(affinity>=med,0,1))
        tool_result[[i]]<-data}
    valid<-list();k=1;for(i in 1:length(tool_result)){if(class(tool_result[[i]]$"affinity")=="numeric"|class(tool_result[[i]]$"affinity")=="integer"){valid[[k]]<-tool_result[[i]];k=k+1}};tool_result<-valid#some tools will generate invalid value if they meet unsuitable allele or peptide length. i must clean them out.
    for(i in 1:length(tool_result)){data<-as.data.frame(tool_result[[i]]);data<-data%>%inner_join(test_mhci,by=c("allele"="hlatype","peptide"="antigen_peptide"))%>%rename(bind_result_base=bind_result);tool_result[[i]]<-data}#merge test and tool result
    save(tool_result,file=paste0(path_compare,"/netmhccons.Rdata"))
################################ capsnetmhc_an
    file <- list.files(path_capsnetmhc_an, recursive = TRUE, full.names = TRUE)
    tool_result<-list()
    for(i in 1:length(file)){data<-fread(file[i]);name<-gsub("\\..*","",basename(file[i]));if(nrow(data)>0){tool_result[[name]]<-data}}
    #get binary results. 0=negative.
    #binding threshold is not provided.
    #primary: affinity >=0.5 is positive
    #now: affinity>=median number is positive
    for(i in 1:length(tool_result)){
        data<-as.data.frame(tool_result[[i]][,c(1,2,5)])
        colnames(data)[1:3]<-c("allele","peptide","affinity")
        med <- median(data$affinity, na.rm = TRUE)
        data <- data%>%mutate(bind_result_tool=ifelse(affinity>=med,1,0))
        tool_result[[i]]<-data}#get binary results. 0=negative. author didnit give a threshold, 0.5 is my personal set.
    valid<-list();k=1;for(i in 1:length(tool_result)){if(class(tool_result[[i]]$"affinity")=="numeric"|class(tool_result[[i]]$"affinity")=="integer"){valid[[k]]<-tool_result[[i]];k=k+1}};tool_result<-valid#some tools will generate invalid value if they meet unsuitable allele or peptide length. i must clean them out.
    for(i in 1:length(tool_result)){data<-as.data.frame(tool_result[[i]]);data<-data%>%inner_join(test_mhci,by=c("allele"="hlatype","peptide"="antigen_peptide"))%>%rename(bind_result_base=bind_result);tool_result[[i]]<-data}#merge test and tool result
    save(tool_result,file=paste0(path_compare,"/capsnetmhc_an.Rdata"))
################################ capsnetmhc_ie
    file <- list.files(path_capsnetmhc_ie, recursive = TRUE, full.names = TRUE)
    tool_result<-list()
    for(i in 1:length(file)){data<-fread(file[i]);name<-gsub("\\..*","",basename(file[i]));if(nrow(data)>0){tool_result[[name]]<-data}}
    #get binary results. 0=negative.
    #binding threshold is not provided.
    #primary: affinity >=10000 is negative
    #now: affinity>=median number is negative
    for(i in 1:length(tool_result)){
        data<-as.data.frame(tool_result[[i]][,c("Allele","Peptide seq","our_method_ic50")])
        colnames(data)[1:3]<-c("allele","peptide","affinity")
        med <- median(data$affinity, na.rm = TRUE)
        data <- data%>%mutate(bind_result_tool=ifelse(affinity>=med,0,1))
        tool_result[[i]]<-data}
    #for(i in 1:length(tool_result)){print(class(tool_result[[i]]$"affinity"));print(i)}
    #View(tool_result[[]])
    valid<-list();k=1;for(i in 1:length(tool_result)){if(class(tool_result[[i]]$"affinity")=="numeric"|class(tool_result[[i]]$"affinity")=="integer"){valid[[k]]<-tool_result[[i]];k=k+1}};tool_result<-valid#some tools will generate invalid value if they meet unsuitable allele or peptide length. i must clean them out.
    for(i in 1:length(tool_result)){data<-as.data.frame(tool_result[[i]]);data<-data%>%inner_join(test_mhci,by=c("allele"="hlatype","peptide"="antigen_peptide"))%>%rename(bind_result_base=bind_result);tool_result[[i]]<-data}#merge test and tool result
    save(tool_result,file=paste0(path_compare,"/capsnetmhc_ie.Rdata"))
################################ stmhcpan
    file <- list.files(path_stmhcpan, recursive = TRUE, full.names = TRUE)
    tool_result<-list()
    for(i in 1:length(file)){data<-fread(file[i]);name<-gsub("\\..*","",basename(file[i]));if(nrow(data)>0){tool_result[[name]]<-data}}
    #get binary results. 0=negative.
    #binding threshold is not provided.
    #primary: affinity >=0.5 is positive
    #now: affinity>=median number is positive
    for(i in 1:length(tool_result)){
        data<-as.data.frame(tool_result[[i]][,c("allele","peptide","presentation")])
        colnames(data)[1:3]<-c("allele","peptide","affinity")
        med <- median(data$affinity, na.rm = TRUE)
        data <- data%>%mutate(bind_result_tool=ifelse(affinity>=med,1,0))
        data$"allele"<-gsub("(HLA-[A-Z])(\\d{2})(\\d{2})", "\\1*\\2:\\3", data$"allele")
        tool_result[[i]]<-data}
    valid<-list();k=1;for(i in 1:length(tool_result)){if(class(tool_result[[i]]$"affinity")=="numeric"|class(tool_result[[i]]$"affinity")=="integer"){valid[[k]]<-tool_result[[i]];k=k+1}};tool_result<-valid#some tools will generate invalid value if they meet unsuitable allele or peptide length. i must clean them out.
    for(i in 1:length(tool_result)){data<-as.data.frame(tool_result[[i]]);data<-data%>%inner_join(test_mhci,by=c("allele"="hlatype","peptide"="antigen_peptide"))%>%rename(bind_result_base=bind_result);tool_result[[i]]<-data}#merge test and tool result
    save(tool_result,file=paste0(path_compare,"/stmhcpan.Rdata"))
################################ transphla
    file <- list.files(path_transphla, recursive = TRUE, full.names = TRUE)
    tool_result<-list()
    for(i in 1:length(file)){data<-fread(file[i]);name<-gsub("\\..*","",basename(file[i]));if(nrow(data)>0){tool_result[[name]]<-data}}
    #get binary results. 0=negative.
    #binding affinity is recommanded to be 0.5. see:https://github.com/a96123155/TransPHLA-AOMP "threshold: type = float, default = 0.5, help = the threshold to define predicted binder, float from 0 - 1, the recommended value is 0.5"
    #primary: affinity >=0.5 is positive
    #now: affinity>=median number is positive
    for(i in 1:length(tool_result)){
        data<-as.data.frame(tool_result[[i]][,c("HLA","peptide","y_prob")])
        colnames(data)[1:3]<-c("allele","peptide","affinity")
        med <- median(data$affinity, na.rm = TRUE)
        data <- data%>%mutate(bind_result_tool=ifelse(affinity>=med,1,0))
        tool_result[[i]]<-data}
    valid<-list();k=1;for(i in 1:length(tool_result)){if(class(tool_result[[i]]$"affinity")=="numeric"|class(tool_result[[i]]$"affinity")=="integer"){valid[[k]]<-tool_result[[i]];k=k+1}};tool_result<-valid#some tools will generate invalid value if they meet unsuitable allele or peptide length. i must clean them out.
    for(i in 1:length(tool_result)){data<-as.data.frame(tool_result[[i]]);data<-data%>%inner_join(test_mhci,by=c("allele"="hlatype","peptide"="antigen_peptide"))%>%rename(bind_result_base=bind_result);tool_result[[i]]<-data}#merge test and tool result
    save(tool_result,file=paste0(path_compare,"/transphla.Rdata"))
################################ deepattentionpan
    file <- list.files(path_deepattentionpan, recursive = TRUE, full.names = TRUE)
    tool_result<-list()
    for(i in 1:length(file)){data<-fread(file[i]);name<-gsub("\\..*","",basename(file[i]));if(nrow(data)>0){tool_result[[name]]<-data}}
    #get binary results. 0=negative.
    #binding threshold is not provided.
    #primary: affinity >=10000 is negative
    #now: affinity>=median number is negative
    for(i in 1:length(tool_result)){
        data<-as.data.frame(tool_result[[i]][,c("Allele","Peptide seq","our_method_ic50")])
        colnames(data)[1:3]<-c("allele","peptide","affinity")
        med <- median(data$affinity, na.rm = TRUE)
        data <- data%>%mutate(bind_result_tool=ifelse(affinity>=med,0,1))
        tool_result[[i]]<-data}
    #for(i in 1:length(tool_result)){print(class(tool_result[[i]]$"affinity"));print(i)}
    #View(tool_result[[]])
    valid<-list();k=1;for(i in 1:length(tool_result)){if(class(tool_result[[i]]$"affinity")=="numeric"|class(tool_result[[i]]$"affinity")=="integer"){valid[[k]]<-tool_result[[i]];k=k+1}};tool_result<-valid#some tools will generate invalid value if they meet unsuitable allele or peptide length. i must clean them out.
    for(i in 1:length(tool_result)){data<-as.data.frame(tool_result[[i]]);data<-data%>%inner_join(test_mhci,by=c("allele"="hlatype","peptide"="antigen_peptide"))%>%rename(bind_result_base=bind_result);tool_result[[i]]<-data}#merge test and tool result
    save(tool_result,file=paste0(path_compare,"/deepattentionpan.Rdata"))
################################ acme
    file <- list.files(path_acme, recursive = TRUE, full.names = TRUE)
    tool_result<-list()
    for(i in 1:length(file)){data<-fread(file[i]);name<-gsub("\\..*","",basename(file[i]));if(nrow(data)>0){tool_result[[name]]<-data}}
    #get binary results. 0=negative.
    #binding affinity is recommanded to be 0.5. see:https://github.com/HYsxe/ACME "Peptides with scores above 0.42 can be considered to be strong binders."
    #primary: affinity >=0.42 is positive
    #now: affinity>=median number is positive
    for(i in 1:length(tool_result)){
        data<-as.data.frame(tool_result[[i]]);colnames(data)<-c("peptide","allele","affinity")
        data<-data[,c("allele","peptide","affinity")]
        data$"allele"<-paste0("HLA-",data$"allele")
        med <- median(data$affinity, na.rm = TRUE)
        data <- data%>%mutate(bind_result_tool=ifelse(affinity>=med,1,0))
        tool_result[[i]]<-data}
    valid<-list();k=1;for(i in 1:length(tool_result)){if(class(tool_result[[i]]$"affinity")=="numeric"|class(tool_result[[i]]$"affinity")=="integer"){valid[[k]]<-tool_result[[i]];k=k+1}};tool_result<-valid#some tools will generate invalid value if they meet unsuitable allele or peptide length. i must clean them out.
    for(i in 1:length(tool_result)){data<-as.data.frame(tool_result[[i]]);data<-data%>%inner_join(test_mhci,by=c("allele"="hlatype","peptide"="antigen_peptide"))%>%rename(bind_result_base=bind_result);tool_result[[i]]<-data}#merge test and tool result
    save(tool_result,file=paste0(path_compare,"/acme.Rdata"))
################################ deephlapan
    file <- list.files(path_deephlapan, recursive = TRUE, full.names = TRUE)
    tool_result<-list()
    for(i in 1:length(file)){data<-fread(file[i]);name<-gsub("\\..*","",basename(file[i]));if(nrow(data)>0){tool_result[[name]]<-data}}
    #get binary results. 0=negative.
    #binding threshold is not provided.
    #primary: affinity >=0.5 is positive
    #now: affinity>=median number is positive
    for(i in 1:length(tool_result)){
        data<-as.data.frame(tool_result[[i]][,c(2,3,4)])
        colnames(data)[1:3]<-c("allele","peptide","affinity")
        data$"allele"<-gsub("(HLA-[A-Z])(\\d{2}:\\d{2})", "\\1*\\2", data$"allele")
        med <- median(data$affinity, na.rm = TRUE)
        data <-data%>%mutate(bind_result_tool=ifelse(affinity>=med,1,0))
        tool_result[[i]]<-data}
    valid<-list();k=1;for(i in 1:length(tool_result)){if(class(tool_result[[i]]$"affinity")=="numeric"|class(tool_result[[i]]$"affinity")=="integer"){valid[[k]]<-tool_result[[i]];k=k+1}};tool_result<-valid#some tools will generate invalid value if they meet unsuitable allele or peptide length. i must clean them out.
    for(i in 1:length(tool_result)){data<-as.data.frame(tool_result[[i]]);data<-data%>%inner_join(test_mhci,by=c("allele"="hlatype","peptide"="antigen_peptide"))%>%rename(bind_result_base=bind_result);tool_result[[i]]<-data}#merge test and tool result
    save(tool_result,file=paste0(path_compare,"/deephlapan.Rdata"))
################################ deepnetbim
    file <- list.files(path_deepnetbim, recursive = TRUE, full.names = TRUE)
    tool_result<-list()
    for(i in 1:length(file)){data<-fread(file[i]);name<-gsub("\\..*","",basename(file[i]));if(nrow(data)>0){tool_result[[name]]<-data}}
    #get binary results. 0=negative.
    #binding threshold is not provided.
    #primary: affinity >=0.42 is positive
    #now: affinity>=median number is positive
    for(i in 1:length(tool_result)){
        data<-as.data.frame(tool_result[[i]][,c("mhc","sequence","pred_affinity")])
        colnames(data)[1:3]<-c("allele","peptide","affinity")
        data$"allele"<-gsub("(HLA-[A-Z])(\\d{2}:\\d{2})", "\\1*\\2", data$"allele")
        med <- median(data$affinity, na.rm = TRUE)
        data <- data%>%mutate(bind_result_tool=ifelse(affinity>=med,1,0))
        tool_result[[i]]<-data}#get binary results. 0=negative. author didnit give a threshold, 0.42 is my personal set.
    valid<-list();k=1;for(i in 1:length(tool_result)){if(class(tool_result[[i]]$"affinity")=="numeric"|class(tool_result[[i]]$"affinity")=="integer"){valid[[k]]<-tool_result[[i]];k=k+1}};tool_result<-valid#some tools will generate invalid value if they meet unsuitable allele or peptide length. i must clean them out.
    for(i in 1:length(tool_result)){data<-as.data.frame(tool_result[[i]]);data<-data%>%inner_join(test_mhci,by=c("allele"="hlatype","peptide"="antigen_peptide"))%>%rename(bind_result_base=bind_result);tool_result[[i]]<-data}#merge test and tool result
    save(tool_result,file=paste0(path_compare,"/deepnetbim.Rdata"))
################################ bigmhc_el
    file <- list.files(path_bigmhc_el, recursive = TRUE, full.names = TRUE)
    tool_result<-list()
    for(i in 1:length(file)){data<-fread(file[i]);name<-gsub("\\..*","",basename(file[i]));if(nrow(data)>0){tool_result[[name]]<-data}}
    #get binary results. 0=negative.
    #binding threshold is not provided.
    #primary: affinity >=0.42 is positive
    #now: affinity>=median number is positive
    for(i in 1:length(tool_result)){
        data<-as.data.frame(tool_result[[i]][,c("mhc","pep","BigMHC_EL")])
        colnames(data)[1:3]<-c("allele","peptide","affinity")
        med <- median(data$affinity, na.rm = TRUE)
        data <- data%>%mutate(bind_result_tool=ifelse(affinity>=med,1,0))
        tool_result[[i]]<-data}
    valid<-list();k=1;for(i in 1:length(tool_result)){if(class(tool_result[[i]]$"affinity")=="numeric"|class(tool_result[[i]]$"affinity")=="integer"){valid[[k]]<-tool_result[[i]];k=k+1}};tool_result<-valid#some tools will generate invalid value if they meet unsuitable allele or peptide length. i must clean them out.
    for(i in 1:length(tool_result)){data<-as.data.frame(tool_result[[i]]);data<-data%>%inner_join(test_mhci,by=c("allele"="hlatype","peptide"="antigen_peptide"))%>%rename(bind_result_base=bind_result);tool_result[[i]]<-data}#merge test and tool result
    save(tool_result,file=paste0(path_compare,"/bigmhc.Rdata"))
################################################################
