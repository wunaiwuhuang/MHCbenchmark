################################################################
    library(tidyr)
    library(dplyr)
    path_speed<-"/data1/wuguojia/data/mhc_benchmark/speedbase/"
    ################################
    path_fasta <- paste0(path_speed,"fasta/")
    path_HLA_fasta <- paste0(path_speed,"HLA_fasta/")
    path_csv <- paste0(path_speed,"csv/")
    path_txt_casan <- paste0(path_speed,"txt_casan/")
    path_txt_casie <- paste0(path_speed,"txt_casie/")
    path_csv_stmhcpan <- paste0(path_speed,"csv_stmhcpan/")
    path_txt_acme <- paste0(path_speed,"txt_acme/")
    path_csv_deephlapan <- paste0(path_speed,"csv_deephlapan/")
    path_txt_deepnetbim <- paste0(path_speed,"txt_deepnetbim/")
    path_csv_bigmhc <- paste0(path_speed,"csv_bigmhc/")
################################################################

################################################################
################################ all speed test data
################################
    #阈值改了之后traindata_raw也改变了，这里还是使用原来的train_data.预想复现结果，traindata_raw用以下python代码：
    import pandas as pd
    path_test = '/data1/wuguojia/data/mhc_benchmark/testbase'
    path_attention = '/data1/wuguojia/data/mhc_benchmark/attentionbase'
    #read files
    df_1 = pd.read_csv(f'{path_test}/auroc_hla:len2tool_filter.csv')
    df_2 = pd.read_excel(f'{path_test}/TEST.xlsx', sheet_name=0)
    df_3 = pd.read_excel(f'{path_test}/TEST.xlsx', sheet_name=2)
    #left good samples
    cols_to_check = df_1.columns[3:]
    df_cleaned = df_1.dropna(subset=cols_to_check, how='any').copy()
    df_cleaned[cols_to_check] = df_cleaned[cols_to_check].apply(pd.to_numeric, errors='coerce')
    df_cleaned = df_cleaned.dropna(subset=cols_to_check, how='any')
    df_3.rename(columns={df_3.columns[0]: 'allele'}, inplace=True)
    df_merged = pd.merge(df_cleaned, df_3, left_on='allele', right_on='allele', how='inner')
    df_merged = df_merged[['allele', 'peptide_length', 'SUM']]
    df_merged['num'] = df_merged.groupby('allele')['allele'].transform('count')
    df_merged = df_merged[df_merged['num'] == 4]
    df_sorted = df_merged.sort_values(by='SUM', ascending=False)
    df_sorted = df_sorted.drop_duplicates(subset='allele')
    #generate train and test datasets
    df_all = df_2[df_2['hlatype'].isin(hla)]
    from sklearn.model_selection import train_test_split
    train_df, test_df = train_test_split(df_all, test_size=0.5, stratify=df_all[['hlatype', 'antigen_peptide_length', 'bind_result']], random_state=123)
    #i need more test_raw data to filter out test_use data,so test_size = 0.5
    #save files
    import os
    train_data_path = os.path.join(path_attention, 'traindata_raw')
    test_data_path = os.path.join(path_attention, 'testdata_raw')
    os.makedirs(train_data_path, exist_ok=True)
    os.makedirs(test_data_path, exist_ok=True)
    def save_subsets(df, folder_path, prefix):
        for (hlatype, length), group in df.groupby(['hlatype', 'antigen_peptide_length']):
            filename = f"{hlatype}_{length}.csv"
            group.to_csv(os.path.join(folder_path, filename), index=False)
    save_subsets(train_df, train_data_path, "train")
    save_subsets(test_df, test_data_path, "test")
    hla_a = df_sorted.loc[df_sorted['allele'].str.contains('HLA-A'), 'allele'].head(5)
    hla_b = df_sorted.loc[df_sorted['allele'].str.contains('HLA-B'), 'allele'].head(5)
    hla = pd.concat([hla_a, hla_b], ignore_index=True)
################################
    #(collect from attentionbase/traindata_raw & attentionbase/testdata_raw, i divide them in same percentile, so select 50 samples respectively)    
    set.seed(20030622)
    train_file_path <- "/data1/wuguojia/data/mhc_benchmark/attentionbase/traindata_raw"
    test_file_path <- "/data1/wuguojia/data/mhc_benchmark/attentionbase/testdata_raw"
    train_csv_files <- list.files(train_file_path, pattern = "\\.csv$", full.names = TRUE)
    test_csv_files <- list.files(test_file_path, pattern = "\\.csv$", full.names = TRUE)
    all_csv_files <- c(train_csv_files, test_csv_files)
    combined_data <- list()
    for (file in all_csv_files) {
        data <- read.csv(file)
        if (nrow(data) >= 50) {
            sampled_data <- data[sample(nrow(data), 50), ]
        } else {
            sampled_data <- data
        }
        combined_data[[file]] <- sampled_data
    }
    speed_data <- do.call(rbind, combined_data)%>%.[,2:5]
    rownames(speed_data) <- NULL
    save(speed_data,file=paste0(path_speed,"speed_data.Rdata"))
################################ fasta format
    load(paste0(path_speed,"speed_data.Rdata"))
    for(hla in unique(speed_data$hlatype)){
        for(len in unique(speed_data$antigen_peptide_length)){
            sub <- speed_data %>% filter(hlatype == hla & antigen_peptide_length == as.numeric(len))
            hla <- gsub("/","-",hla)#linux don't allow '/' 
            f <- file(paste0(path_fasta,hla,"_",len,".fasta"), open = "w")
            for (k in 1:nrow(sub)) {
                description <- paste0(">", sub$hlatype[k], " ",sub$antigen_peptide_length[k], " ",sub$bind_result[k], "\n")
                cat(description, file = f)
                cat(sub$antigen_peptide[k],file = f)
                if(k<nrow(sub)){cat("\n",file=f)}
            }
            close(f)
        }
    }
    files <- list.files(sub("/$", "", path_fasta), recursive = TRUE, full.names = TRUE,pattern = "^HLA")
    archive_mhci <- files[!grepl("HLA-D",files)]
    write.table(archive_mhci,file=paste0(path_fasta,"archive_mhci.txt"),col.names = F,row.names = F,quote = F)
################################ fasta-HLA pseudosequence-format
    load(paste0(path_speed,"speed_data.Rdata"))
    hlamhci01<-"/data1/wuguojia/data/mhc_benchmark/database/HLAallele_sequence/MHC_pseudo.dat"
    hlamhci02<-"/data1/wuguojia/data/mhc_benchmark/database/HLAallele_sequence/MHC_pseudo.dat"
    seq1<-rbind(read.table(hlamhci01, header = FALSE, sep = "", stringsAsFactors = FALSE),read.table(hlamhci02, header = FALSE, sep = "", stringsAsFactors = FALSE))
    seq1$V1<-gsub("[^a-zA-Z0-9]", "", seq1$V1)
    seq1<-seq1 %>% distinct() %>% filter(grepl("^HLA",V1)) %>% distinct(V1,.keep_all=TRUE)
    setdiff(gsub("[^a-zA-Z0-9]","",unique(speed_data$hlatype)),seq1$V1)
    speed_data$V1<-gsub("[^a-zA-Z0-9]", "", speed_data$hlatype)
    speed_data<-left_join(speed_data,seq1,by="V1")
    for(hla in unique(speed_data$hlatype)){
        for(len in unique(speed_data$antigen_peptide_length)){
            sub <- speed_data %>% filter(hlatype == hla & antigen_peptide_length == as.numeric(len))
            hla <- gsub("/","-",hla)#linux don't allow '/' 
            f <- file(paste0(path_HLA_fasta,hla,"_",len,".fasta"), open = "w")
            for (k in 1:nrow(sub)) {
                description <- paste0(">", sub$hlatype[k], "\n")
                cat(description, file = f)
                cat(sub$V2[k], file = f)
                if (k < nrow(sub)) {cat("\n", file = f)}
            }
            close(f)
        }
    }
    files <- list.files(sub("/$", "", path_HLA_fasta), recursive = TRUE, full.names = TRUE,pattern = "^HLA")
    archive_mhci <- files[!grepl("HLA-D",files)]
    write.table(archive_mhci,file=paste0(path_HLA_fasta,"archive_mhci.txt"),col.names = F,row.names = F,quote = F)
################################ csv format
    load(paste0(path_speed,"speed_data.Rdata"))
    for(hla in unique(speed_data$hlatype)){
        for(len in unique(speed_data$antigen_peptide_length)){
            sub <- speed_data %>% filter(hlatype == hla & antigen_peptide_length == as.numeric(len))
            sub <- sub[,c("hlatype","antigen_peptide")]
            colnames(sub) <- c("allele","peptide")#mhcflurry use
            hla <- gsub("/","-",hla)#linux don't allow '/' 
            write.csv(sub,file=paste0(path_csv, hla, "_", len, ".csv"),row.names=FALSE)
        }
    }
    files <- list.files(sub("/$", "", path_csv), recursive = TRUE, full.names = TRUE,pattern = "^HLA")
    archive_mhci <- files[!grepl("HLA-D",files)]
    write.table(archive_mhci,file=paste0(path_csv,"archive_mhci.txt"),col.names = F,row.names = F,quote = F)
################################ txt format CapsNet-MHC Anthem model
    load(paste0(path_speed,"speed_data.Rdata"))
    for(hla in unique(speed_data$hlatype)){
        for(len in unique(speed_data$antigen_peptide_length)){
            sub <- speed_data %>% filter(hlatype == hla & antigen_peptide_length == as.numeric(len))
            sub <- data.frame(HLA=sub$"hlatype",peptide=sub$"antigen_peptide",Label="none",length=sub$"antigen_peptide_length")
            hla <- gsub("/","-",hla)#linux don't allow '/' 
            write.table(sub,file=paste0(path_txt_casan, hla, "_", len, ".txt"),row.names=FALSE,quote=FALSE,sep='\t')
        }
    }
    files <- list.files(sub("/$", "", path_txt_casan), recursive = TRUE, full.names = TRUE,pattern = "^HLA")
    archive_mhci <- files[!grepl("HLA-D",files)]
    write.table(archive_mhci,file=paste0(path_txt_casan,"archive_mhci.txt"),col.names = F,row.names = F,quote = F)
################################ txt format CapsNet-MHC iedb model
    load(paste0(path_speed,"speed_data.Rdata"))
    for(hla in unique(speed_data$hlatype)){
        for(len in unique(speed_data$antigen_peptide_length)){
            sub <- speed_data %>% filter(hlatype == hla & antigen_peptide_length == as.numeric(len))
            sub <- data.frame(Date=0,`IEDB reference`=0,Allele=sub$"hlatype",`Peptide length`=sub$"antigen_peptide_length",`Measurement type`=0,`Peptide seq`=sub$"antigen_peptide",`Measurement value`=0,`NetMHCpan 2.8`=0,`NetMHCpan 3.0`=0,`NetMHCpan 4.0`=0,SMM=0,`ANN 3.4`=0,`ANN 4.0`=0,ARB=0,SMMPMBEC=0,`IEDB Consensus`=0,NetMHCcons=0,PickPocket=0,check.names = FALSE)
            hla <- gsub("/","-",hla)#linux don't allow '/' 
            write.table(sub,file=paste0(path_txt_casie, hla, "_", len, ".txt"),row.names=FALSE,quote=FALSE,sep='\t')
        }
    }
    files <- list.files(sub("/$", "", path_txt_casie), recursive = TRUE, full.names = TRUE,pattern = "^HLA")
    archive_mhci <- files[!grepl("HLA-D",files)]
    write.table(archive_mhci,file=paste0(path_txt_casie,"archive_mhci.txt"),col.names = F,row.names = F,quote = F)
################################ csv format for stmhcpan
    load(paste0(path_speed,"speed_data.Rdata"))
    for(hla in unique(speed_data$hlatype)){
        for(len in unique(speed_data$antigen_peptide_length)){
            sub <- speed_data %>% filter(hlatype == hla & antigen_peptide_length == as.numeric(len))
            sub <- data.frame(allele=sub$"hlatype",peptide=sub$"antigen_peptide",label="none",length=sub$"antigen_peptide_length")
            hla <- gsub("/","-",hla)#linux don't allow '/' 
            write.csv(sub,file=paste0(path_csv_stmhcpan, hla, "_", len, ".csv"),row.names=FALSE)
        }
    }
    files <- list.files(sub("/$", "", path_csv_stmhcpan), recursive = TRUE, full.names = TRUE,pattern = "^HLA")
    archive_mhci <- files[!grepl("HLA-D",files)]
    write.table(archive_mhci,file=paste0(path_csv_stmhcpan,"archive_mhci.txt"),col.names = F,row.names = F,quote = F)
################################ txt format for acme
    load(paste0(path_speed,"speed_data.Rdata"))
    for(hla in unique(speed_data$hlatype)){
        for(len in unique(speed_data$antigen_peptide_length)){
            sub <- speed_data %>% filter(hlatype == hla & antigen_peptide_length == as.numeric(len))
            sub <- sub[,c("antigen_peptide","hlatype")]
            sub$hlatype<-gsub("HLA-", "", sub$hlatype)
            hla <- gsub("/","-",hla)#linux don't allow '/' 
            write.table(sub,file=paste0(path_txt_acme, hla, "_", len, ".txt"),row.names=FALSE,quote=FALSE,sep='\t', col.names=FALSE)
        }
    }
    files <- list.files(sub("/$", "", path_txt_acme), recursive = TRUE, full.names = TRUE,pattern = "^HLA")
    archive_mhci <- files[!grepl("HLA-D",files)]
    write.table(archive_mhci,file=paste0(path_txt_acme,"archive_mhci.txt"),col.names = F,row.names = F,quote = F)
################################ csv format for deephlapan
    load(paste0(path_speed,"speed_data.Rdata"))
    for(hla in unique(speed_data$hlatype)){
        for(len in unique(speed_data$antigen_peptide_length)){
            sub <- speed_data %>% filter(hlatype == hla & antigen_peptide_length == as.numeric(len))
            sub <- data.frame(Annotation=sub$"bind_result",HLA=gsub("\\*","",sub$"hlatype"),peptide=sub$"antigen_peptide")
            hla <- gsub("/","-",hla)#linux don't allow '/' 
            write.csv(sub,file=paste0(path_csv_deephlapan, hla, "_", len, ".csv"),row.names=FALSE)
        }
    }
    files <- list.files(sub("/$", "", path_csv_deephlapan), recursive = TRUE, full.names = TRUE,pattern = "^HLA")
    archive_mhci <- files[!grepl("HLA-D",files)]
    write.table(archive_mhci,file=paste0(path_csv_deephlapan,"archive_mhci.txt"),col.names = F,row.names = F,quote = F)
################################ txt format for deepnetbim
    load(paste0(path_speed,"speed_data.Rdata"))
    for(hla in unique(speed_data$hlatype)){
        for(len in unique(speed_data$antigen_peptide_length)){
            sub <- speed_data %>% filter(hlatype == hla & antigen_peptide_length == as.numeric(len))
            sub <- sub[,c("hlatype","antigen_peptide")]
            sub$hlatype<-gsub("\\*", "", sub$hlatype)
            colnames(sub)<-c("mhc","sequence")
            hla <- gsub("/","-",hla)#linux don't allow '/' 
            write.table(sub,file=paste0(path_txt_deepnetbim, hla, "_", len, ".txt"),row.names=FALSE,quote=FALSE,sep='\t')
        }
    }
    files <- list.files(sub("/$", "", path_txt_deepnetbim), recursive = TRUE, full.names = TRUE,pattern = "^HLA")
    archive_mhci <- files[!grepl("HLA-D",files)]
    write.table(archive_mhci,file=paste0(path_txt_deepnetbim,"archive_mhci.txt"),col.names = F,row.names = F,quote = F)
################################ csv format for bigmhc
    load(paste0(path_speed,"speed_data.Rdata"))
    for(hla in unique(speed_data$hlatype)){
        for(len in unique(speed_data$antigen_peptide_length)){
            sub <- speed_data %>% filter(hlatype == hla & antigen_peptide_length == as.numeric(len))
            sub <- sub[,c("hlatype","antigen_peptide")]
            sub <- data.frame(mhc=sub$"hlatype",pep=sub$"antigen_peptide",tgt="none")
            hla <- gsub("/","-",hla)#linux don't allow '/' 
            write.csv(sub,file=paste0(path_csv_bigmhc, hla, "_", len, ".csv"),row.names=FALSE)
        }
    }
    files <- list.files(sub("/$", "", path_csv_bigmhc), recursive = TRUE, full.names = TRUE,pattern = "^HLA")
    archive_mhci <- files[!grepl("HLA-D",files)]
    write.table(archive_mhci,file=paste0(path_csv_bigmhc,"archive_mhci.txt"),col.names = F,row.names = F,quote = F)