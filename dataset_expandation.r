##################################################################
    library(data.table)
    library(tidyr)
    library(dplyr)
    library(purrr)
    library(stringr)
    library(openxlsx)
#path of databases and tools
    #################################
    path_all <- "/data1/wuguojia/data/mhc_benchmark/database/"
    path_tool <- "/data1/wuguojia/data/mhc_benchmark/toolbase/"
    path_test <- "/data1/wuguojia/data/mhc_benchmark/testbase/"
    path_extract <- paste0(path_all,"extract_database/")
    path_filter<- paste0(path_tool,"filter_toolbase/")
    #################################
    path_fasta <- paste0(path_test,"fasta/")
    path_HLA_fasta <- paste0(path_test,"HLA_fasta/")
    path_csv <- paste0(path_test,"csv/")
    path_txt_casan <- paste0(path_test,"txt_casan/")
    path_txt_casie <- paste0(path_test,"txt_casie/")
    path_csv_stmhcpan <- paste0(path_test,"csv_stmhcpan/")
    path_txt_acme <- paste0(path_test,"txt_acme/")
    path_csv_deephlapan <- paste0(path_test,"csv_deephlapan/")
    path_txt_deepnetbim <- paste0(path_test,"txt_deepnetbim/")
    path_csv_bigmhc <- paste0(path_test,"csv_bigmhc/")
#widely used functions
    hla2len <- function(x){a<-as.data.frame.matrix(table(x$hlatype,x$antigen_peptide_length));a$SUM <- rowSums(a);return(a)}
    hla2bin <- function(x){a<-as.data.frame.matrix(table(x$hlatype,x$bind_result));a$SUM <- rowSums(a);return(a)}
    len2bin <- function(x){{a<-as.data.frame.matrix(table(x$antigen_peptide_length,x$bind_result));a$SUM <- rowSums(a);return(a)}}
##################################################################

##################################################################
################################# match protein
    setwd(path_test)
    load(paste0(path_test,"FILTERATION.Rdata"))
    protein <- data.frame()
    for(i in c("filteration_mhci","filteration_mhcii")){
        x <- get(i)
        select <- c("hlatype","antigen_protein")
        if(all(select%in%colnames(x))){y<-x[,select]}
        protein <- rbind(protein,y)
    }
    protein<-distinct(protein[!(is.na(protein$antigen_protein) | trimws(protein$antigen_protein) == ""), ])
    protein$ref <- protein$antigen_protein
    protein$ref <- gsub(" isoform.*", "", protein$antigen_protein)
    protein$ref<-trimws(gsub("\\[.*\\]", "", protein$ref))
    prolist<-unique(data.frame(ref=protein[,"ref"],Sequence=NA))
    #i decide to use swiss-prot database only,for accuracy and confidence
    proref<-fread(paste0(path_test,"uniprotkb_AND_reviewed_true_2024_09_18.tsv"))%>%.[,c("Protein names","Sequence")]
    #facilitate matching
    proref <- proref %>% mutate(Sequence_length = nchar(Sequence)) %>% group_by(`Protein names`) %>% filter(Sequence_length == max(Sequence_length)) %>% ungroup() %>% dplyr::select(-Sequence_length) %>% distinct(`Protein names`,.keep_all = TRUE) 
    #match
    prolist$match <- tolower(prolist$ref)
    proref$match <- tolower(proref$`Protein names`)
    pb <- txtProgressBar(min = 0, max = 100, style = 3)
    for(i in 1:length(prolist$match)){
        current_element <- prolist$match[i]
        matching_rows <- proref %>% filter(match == current_element | grepl(current_element, match, fixed = TRUE)) %>% dplyr::select(Sequence)
        if (nrow(matching_rows) > 0) {
            max_length <- max(nchar(matching_rows$Sequence))
            longest_sequences <- matching_rows %>% filter(nchar(Sequence) == max_length)
            prolist$Sequence[i] <- longest_sequences$Sequence[1]
            }
        setTxtProgressBar(pb, (i/length(prolist$match)*100))
    }
    protein<-left_join(protein,prolist,by = "ref")
    protein<-na.omit(protein)
    save(protein,file = "protein.Rdata")
################################# split sequence
    load(paste0(path_test,"FILTERATION.Rdata"))
    load(paste0(path_test,"protein.Rdata"))
    seq<-protein[,c("hlatype","Sequence")]
    seq_mhci<-seq %>% filter(hlatype %in% unique(filteration_mhci$hlatype)) %>% distinct(Sequence,.keep_all=TRUE)
    seq_mhcii<-seq %>% filter(hlatype %in% unique(filteration_mhcii$hlatype)) %>% distinct(Sequence,.keep_all=TRUE)
    split_string <- function(string, x) {
        starts <- seq(1,nchar(string), by = x)
        substrings <- sapply(starts, function(start) str_sub(string, start, start + x - 1))
        return(substrings)
    }    
    for(i in c("_mhci","_mhcii")){
        temp_seq <- get(paste0("seq",i))
        temp_fil <- get(paste0("filteration",i))
        split <- unique(temp_fil$antigen_peptide_length)
        # temp_seq <- temp_seq %>% group_by(hlatype) %>% slice_max(order_by = nchar(Sequence), n = 100) %>% ungroup()
        temp <- map_dfr(split, function(x) {
            temp_seq %>% mutate(peptide = lapply(Sequence, split_string, x = x)) %>% unnest(cols = peptide ) %>% mutate(antigen_peptide_length=nchar(peptide))}) 
        temp <- temp %>% filter(antigen_peptide_length>=min(split))
        assign(paste0("negative",i),temp)
        assign(paste0("h2l_negative",i),hla2len(temp))
    }
    save(negative_mhci,negative_mhcii,h2l_negative_mhci,h2l_negative_mhcii,file = "raw_negative.Rdata")
################################# filter negative peptide
    load(paste0(path_filter,"TOOL_COMBINE.Rdata"))
    load(paste0(path_extract,"DATABASE_COMBINE.Rdata"))
    load(paste0(path_test,"raw_negative.Rdata"))
    total <- data.frame(
        hlatype = c(database_combine$hlatype,tool_combine$hlatype),
        antigen_peptide = c(database_combine$antigen_peptide,tool_combine$antigen_peptide))
    for(i in c("negative_mhci","negative_mhcii")){
        temp <- get(i)
        temp <- data.frame(
            hlatype=temp$hlatype,
            antigen_peptide=temp$peptide)
            temp$antigen_peptide_length<-nchar(temp$antigen_peptide)
        temp <- anti_join(temp,total,by=c("hlatype", "antigen_peptide"))
        #delete unnatural peptide
        valid_amino_acids <- "^[ARNDCEQGHILKMFPSTWYV]+$"
        temp <- temp[grepl(valid_amino_acids, temp$antigen_peptide), ]
        temp <- distinct(temp)
        assign(i,temp)
        assign(paste0("h2l_",i),hla2len(temp))
    }
    save(negative_mhci,negative_mhcii,h2l_negative_mhci,h2l_negative_mhcii,file = "ripe_negative.Rdata")
################################# combine positive and negative
    load(paste0(path_test,"FILTERATION.Rdata"))
    load(paste0(path_test,"ripe_negative.Rdata"))
    #mhci
    select <- rownames(h2lfilteration_mhci %>% filter(rowSums(h2lfilteration_mhci[, 1:(ncol(h2lfilteration_mhci)-1)] >= 50) >= 2))
    test_mhci<-filteration_mhci[filteration_mhci$hlatype %in% select,]
    #mhcii
    select <- rownames(h2lfilteration_mhcii %>% filter(rowSums(h2lfilteration_mhcii[,1:(ncol(h2lfilteration_mhcii)-1)] >= 100)>= 5))
    select <- setdiff(select,c("HLA-DPB1*11:01","HLA-DRA*01:01/DRB1*01:01","HLA-DRA*01:01/DRB1*04:04","HLA-DRA*01:01/DRB1*14:54","HLA-DRB1*15:02","HLA-A*26:08"))#"HLA-A*26:08" 8 mer contain only one negtive item ,quite strange, so i remove it.
    test_mhcii<-filteration_mhcii[filteration_mhcii$hlatype %in% select,]
    for(i in c("test_mhci","test_mhcii")){assign(paste0("h2l",i),hla2len(get(i)));assign(paste0("h2b",i),hla2bin(get(i)));assign(paste0("l2b",i),len2bin(get(i)))}
    #extract negative items and combine
    for(i in c("_mhci","_mhcii")){
        extract <- list();k=1
        temp_pos <- get(paste0("test",i))
        temp_neg <- get(paste0("negative",i))
        temp_sel <- get(paste0("h2ltest",i))
        for(m in 1:nrow(temp_sel)){
            hla <- rownames(temp_sel)[m]
            for(n in 1:(ncol(temp_sel)-1)){
                len <- colnames(temp_sel)[n]
                num <- temp_sel[hla,len]
                neg <- temp_neg %>% filter(hlatype == hla & antigen_peptide_length == as.numeric(len))
                extract[[k]] <- neg[1:as.numeric(num),]
                k=k+1
            }
        }
        neg_sel <- do.call(rbind,extract)
        neg_sel$bind_result="negative"
        assign(paste0("test",i),data.frame(
            hlatype=c(temp_pos$"hlatype",neg_sel$"hlatype"),
            antigen_peptide=c(temp_pos$"antigen_peptide",neg_sel$"antigen_peptide"),
            antigen_peptide_length=c(temp_pos$"antigen_peptide_length",neg_sel$"antigen_peptide_length"),
            bind_result=c(temp_pos$"bind_result",neg_sel$"bind_result")
            ))
    }
    for(i in c("test_mhci","test_mhcii")){assign(paste0("h2l",i),hla2len(get(i)));assign(paste0("h2b",i),hla2bin(get(i)));assign(paste0("l2b",i),len2bin(get(i)))}
    save(test_mhci,test_mhcii,h2ltest_mhci,h2ltest_mhcii,h2btest_mhci,h2btest_mhcii,l2btest_mhci,l2btest_mhcii,file=paste0(path_test,"TEST.Rdata"))
################################# modify test data
    load(paste0(path_test,"TEST.Rdata"))
    for(i in c("_mhci","_mhcii")){
        temp_tes <- get(paste0("test",i))
        temp_sel <- get(paste0("h2btest",i))
        select <- rownames(temp_sel)[abs(temp_sel$"negative" - temp_sel$"positive") <=10]
        assign(paste0("test",i),temp_tes %>% filter(hlatype %in% select))
    }
    for(i in c("test_mhci","test_mhcii")){assign(paste0("h2l",i),hla2len(get(i)));assign(paste0("h2b",i),hla2bin(get(i)));assign(paste0("l2b",i),len2bin(get(i)))}
    save(test_mhci,test_mhcii,h2ltest_mhci,h2ltest_mhcii,h2btest_mhci,h2btest_mhcii,l2btest_mhci,l2btest_mhcii,file=paste0(path_test,"TEST.Rdata"))
    #write excel file
    files = c("test_mhci","test_mhcii","h2ltest_mhci","h2ltest_mhcii","h2btest_mhci","h2btest_mhcii","l2btest_mhci","l2btest_mhcii")
    wb <- createWorkbook()
    for (sheet_name in files) {
    addWorksheet(wb, sheet_name)
    writeData(wb, sheet_name, get(sheet_name),rowNames = TRUE)
    }
    saveWorkbook(wb, "TEST.xlsx", overwrite = TRUE)
################################# save as suitable format
### fasta format
    load(paste0(path_test,"TEST.Rdata"))
    for(i in c("_mhci","_mhcii")){
        temp_tes <- get(paste0("test",i))
        temp_sel <- get(paste0("h2ltest",i))
        for(m in 1:nrow(temp_sel)){
            for(n in 1:(ncol(temp_sel)-1)){
                hla <- rownames(temp_sel)[m]
                len <- colnames(temp_sel)[n]
                num <- temp_sel[hla,len]
                if(num != 0){
                    sub <- temp_tes %>% filter(hlatype == hla & antigen_peptide_length == as.numeric(len))
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
        }
    }
    files <- list.files(sub("/$", "", path_fasta), recursive = TRUE, full.names = TRUE,pattern = "^HLA")
    archive_mhci <- files[!grepl("HLA-D",files)]
    archive_mhcii <- files[grepl("HLA-D",files)]
    write.table(archive_mhci,file=paste0(path_fasta,"archive_mhci.txt"),col.names = F,row.names = F,quote = F)
    write.table(archive_mhcii,file=paste0(path_fasta,"archive_mhcii.txt"),col.names = F,row.names = F,quote = F)
### fasta-HLA pseudosequence-format
    #mhci info come from netmhcpan4.1 training data; mhcii info come from netmhciipan4.3 training data
    load(paste0(path_test,"TEST.Rdata"))
    hlamhci01<-"/data1/wuguojia/data/mhc_benchmark/database/HLAallele_sequence/MHC_pseudo.dat"
    hlamhci02<-"/data1/wuguojia/data/mhc_benchmark/database/HLAallele_sequence/MHC_pseudo.dat"
    hlamhcii01<-"/data1/wuguojia/data/mhc_benchmark/database/HLAallele_sequence/pseudosequence.2023.dat"
    hlamhcii02<-"/data1/wuguojia/data/mhc_benchmark/database/HLAallele_sequence/pseudosequence.2016.all.X.dat"
    seq1<-rbind(read.table(hlamhci01, header = FALSE, sep = "", stringsAsFactors = FALSE),read.table(hlamhci02, header = FALSE, sep = "", stringsAsFactors = FALSE))
    seq2<-rbind(read.table(hlamhcii01, header = FALSE, sep = "", stringsAsFactors = FALSE),read.table(hlamhcii02, header = FALSE, sep = "", stringsAsFactors = FALSE))
    #mhci match sequences
    seq1$V1<-gsub("[^a-zA-Z0-9]", "", seq1$V1)
    seq1<-seq1 %>% distinct() %>% filter(grepl("^HLA",V1)) %>% distinct(V1,.keep_all=TRUE)
    setdiff(gsub("[^a-zA-Z0-9]","",unique(test_mhci$hlatype)),seq1$V1)
    #mhcii match sequences
    seq2$V1<-gsub("[^a-zA-Z0-9]", "", seq2$V1)
    seq2$V1 <- ifelse(startsWith(seq2$V1, "D"),paste0("HLA", seq2$V1), seq2$V1)
    seq2<-seq2 %>% distinct() %>% distinct(V1,.keep_all=TRUE)
    setdiff(gsub("[^a-zA-Z0-9]","",unique(test_mhcii$hlatype)),seq2$V1)
    #write fasta files
    hlaseq<-rbind(seq1,seq2)
    test_mhci$V1<-gsub("[^a-zA-Z0-9]", "", test_mhci$hlatype)
    test_mhcii$V1<-gsub("[^a-zA-Z0-9]", "", test_mhcii$hlatype)
    test_mhci<-left_join(test_mhci,hlaseq,by="V1")
    test_mhcii<-left_join(test_mhcii,hlaseq,by="V1")
    for(i in c("_mhci","_mhcii")){
        temp_tes <- get(paste0("test",i))
        temp_sel <- get(paste0("h2ltest",i))
        for(m in 1:nrow(temp_sel)){
            for(n in 1:(ncol(temp_sel)-1)){
                hla <- rownames(temp_sel)[m]
                len <- colnames(temp_sel)[n]
                num <- temp_sel[hla,len]
                if(num != 0){
                    sub <- temp_tes %>% filter(hlatype == hla & antigen_peptide_length == as.numeric(len))
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
        }
    }
    files <- list.files(sub("/$", "", path_HLA_fasta), recursive = TRUE, full.names = TRUE,pattern = "^HLA")
    archive_mhci <- files[!grepl("HLA-D",files)]
    archive_mhcii <- files[grepl("HLA-D",files)]
    write.table(archive_mhci,file=paste0(path_HLA_fasta,"archive_mhci.txt"),col.names = F,row.names = F,quote = F)
    write.table(archive_mhcii,file=paste0(path_HLA_fasta,"archive_mhcii.txt"),col.names = F,row.names = F,quote = F)
### csv format
    load(paste0(path_test,"TEST.Rdata"))
    for(i in c("_mhci","_mhcii")){
        temp_tes <- get(paste0("test",i))
        temp_sel <- get(paste0("h2ltest",i))
        for(m in 1:nrow(temp_sel)){
            for(n in 1:(ncol(temp_sel)-1)){
                hla <- rownames(temp_sel)[m]
                len <- colnames(temp_sel)[n]
                num <- temp_sel[hla,len]
                if(num != 0){
                    sub <- temp_tes %>% filter(hlatype == hla & antigen_peptide_length == as.numeric(len))
                    sub <- sub[,c("hlatype","antigen_peptide")]
                    colnames(sub) <- c("allele","peptide")#mhcflurry use
                    hla <- gsub("/","-",hla)#linux don't allow '/' 
                    write.csv(sub,file=paste0(path_csv, hla, "_", len, ".csv"),row.names=FALSE)
                }
            }
        }
    }
    files <- list.files(sub("/$", "", path_csv), recursive = TRUE, full.names = TRUE,pattern = "^HLA")
    archive_mhci <- files[!grepl("HLA-D",files)]
    archive_mhcii <- files[grepl("HLA-D",files)]
    write.table(archive_mhci,file=paste0(path_csv,"archive_mhci.txt"),col.names = F,row.names = F,quote = F)
    write.table(archive_mhcii,file=paste0(path_csv,"archive_mhcii.txt"),col.names = F,row.names = F,quote = F)
### txt format CapsNet-MHC Anthem model
    load(paste0(path_test,"TEST.Rdata"))
    for(i in c("_mhci","_mhcii")){
        temp_tes <- get(paste0("test",i))
        temp_sel <- get(paste0("h2ltest",i))
        for(m in 1:nrow(temp_sel)){
            for(n in 1:(ncol(temp_sel)-1)){
                hla <- rownames(temp_sel)[m]
                len <- colnames(temp_sel)[n]
                num <- temp_sel[hla,len]
                if(num != 0){
                    sub <- temp_tes %>% filter(hlatype == hla & antigen_peptide_length == as.numeric(len))
                    sub <- data.frame(HLA=sub$"hlatype",peptide=sub$"antigen_peptide",Label="none",length=sub$"antigen_peptide_length")
                    hla <- gsub("/","-",hla)#linux don't allow '/' 
                    write.table(sub,file=paste0(path_txt_casan, hla, "_", len, ".txt"),row.names=FALSE,quote=FALSE,sep='\t')
                }
            }
        }
    }
    files <- list.files(sub("/$", "", path_txt_casan), recursive = TRUE, full.names = TRUE,pattern = "^HLA")
    archive_mhci <- files[!grepl("HLA-D",files)]
    archive_mhcii <- files[grepl("HLA-D",files)]
    write.table(archive_mhci,file=paste0(path_txt_casan,"archive_mhci.txt"),col.names = F,row.names = F,quote = F)
    write.table(archive_mhcii,file=paste0(path_txt_casan,"archive_mhcii.txt"),col.names = F,row.names = F,quote = F)
### txt format CapsNet-MHC iedb model
    load(paste0(path_test,"TEST.Rdata"))
    for(i in c("_mhci","_mhcii")){
        temp_tes <- get(paste0("test",i))
        temp_sel <- get(paste0("h2ltest",i))
        for(m in 1:nrow(temp_sel)){
            for(n in 1:(ncol(temp_sel)-1)){
                hla <- rownames(temp_sel)[m]
                len <- colnames(temp_sel)[n]
                num <- temp_sel[hla,len]
                if(num != 0){
                    sub <- temp_tes %>% filter(hlatype == hla & antigen_peptide_length == as.numeric(len))
                    sub <- data.frame(Date=0,`IEDB reference`=0,Allele=sub$"hlatype",`Peptide length`=sub$"antigen_peptide_length",`Measurement type`=0,`Peptide seq`=sub$"antigen_peptide",`Measurement value`=0,`NetMHCpan 2.8`=0,`NetMHCpan 3.0`=0,`NetMHCpan 4.0`=0,SMM=0,`ANN 3.4`=0,`ANN 4.0`=0,ARB=0,SMMPMBEC=0,`IEDB Consensus`=0,NetMHCcons=0,PickPocket=0,check.names = FALSE)
                    hla <- gsub("/","-",hla)#linux don't allow '/' 
                    write.table(sub,file=paste0(path_txt_casie, hla, "_", len, ".txt"),row.names=FALSE,quote=FALSE,sep='\t')
                }
            }
        }
    }
    files <- list.files(sub("/$", "", path_txt_casie), recursive = TRUE, full.names = TRUE,pattern = "^HLA")
    archive_mhci <- files[!grepl("HLA-D",files)]
    archive_mhcii <- files[grepl("HLA-D",files)]
    write.table(archive_mhci,file=paste0(path_txt_casie,"archive_mhci.txt"),col.names = F,row.names = F,quote = F)
    write.table(archive_mhcii,file=paste0(path_txt_casie,"archive_mhcii.txt"),col.names = F,row.names = F,quote = F)
### csv format for stmhcpan
    load(paste0(path_test,"TEST.Rdata"))
    for(i in c("_mhci","_mhcii")){
        temp_tes <- get(paste0("test",i))
        temp_sel <- get(paste0("h2ltest",i))
        for(m in 1:nrow(temp_sel)){
            for(n in 1:(ncol(temp_sel)-1)){
                hla <- rownames(temp_sel)[m]
                len <- colnames(temp_sel)[n]
                num <- temp_sel[hla,len]
                if(num != 0){
                    sub <- temp_tes %>% filter(hlatype == hla & antigen_peptide_length == as.numeric(len))
                    sub <- data.frame(allele=sub$"hlatype",peptide=sub$"antigen_peptide",label="none",length=sub$"antigen_peptide_length")
                    hla <- gsub("/","-",hla)#linux don't allow '/' 
                    write.csv(sub,file=paste0(path_csv_stmhcpan, hla, "_", len, ".csv"),row.names=FALSE)
                }
            }
        }
    }
    files <- list.files(sub("/$", "", path_csv_stmhcpan), recursive = TRUE, full.names = TRUE,pattern = "^HLA")
    archive_mhci <- files[!grepl("HLA-D",files)]
    archive_mhcii <- files[grepl("HLA-D",files)]
    write.table(archive_mhci,file=paste0(path_csv_stmhcpan,"archive_mhci.txt"),col.names = F,row.names = F,quote = F)
    write.table(archive_mhcii,file=paste0(path_csv_stmhcpan,"archive_mhcii.txt"),col.names = F,row.names = F,quote = F)
### txt format for acme
    load(paste0(path_test,"TEST.Rdata"))
    for(i in c("_mhci","_mhcii")){
        temp_tes <- get(paste0("test",i))
        temp_sel <- get(paste0("h2ltest",i))
        for(m in 1:nrow(temp_sel)){
            for(n in 1:(ncol(temp_sel)-1)){
                hla <- rownames(temp_sel)[m]
                len <- colnames(temp_sel)[n]
                num <- temp_sel[hla,len]
                if(num != 0){
                    sub <- temp_tes %>% filter(hlatype == hla & antigen_peptide_length == as.numeric(len))
                    sub <- sub[,c("antigen_peptide","hlatype")]
                    sub$hlatype<-gsub("HLA-", "", sub$hlatype)
                    hla <- gsub("/","-",hla)#linux don't allow '/' 
                    write.table(sub,file=paste0(path_txt_acme, hla, "_", len, ".txt"),row.names=FALSE,quote=FALSE,sep='\t', col.names=FALSE)
                }
            }
        }
    }
    files <- list.files(sub("/$", "", path_txt_acme), recursive = TRUE, full.names = TRUE,pattern = "^HLA")
    archive_mhci <- files[!grepl("HLA-D",files)]
    archive_mhcii <- files[grepl("HLA-D",files)]
    write.table(archive_mhci,file=paste0(path_txt_acme,"archive_mhci.txt"),col.names = F,row.names = F,quote = F)
    write.table(archive_mhcii,file=paste0(path_txt_acme,"archive_mhcii.txt"),col.names = F,row.names = F,quote = F)
### csv format for deephlapan
    load(paste0(path_test,"TEST.Rdata"))
    for(i in c("_mhci","_mhcii")){
        temp_tes <- get(paste0("test",i))
        temp_sel <- get(paste0("h2ltest",i))
        for(m in 1:nrow(temp_sel)){
            for(n in 1:(ncol(temp_sel)-1)){
                hla <- rownames(temp_sel)[m]
                len <- colnames(temp_sel)[n]
                num <- temp_sel[hla,len]
                if(num != 0){
                    sub <- temp_tes %>% filter(hlatype == hla & antigen_peptide_length == as.numeric(len))
                    sub <- data.frame(Annotation=sub$"bind_result",HLA=gsub("\\*","",sub$"hlatype"),peptide=sub$"antigen_peptide")
                    hla <- gsub("/","-",hla)#linux don't allow '/' 
                    write.csv(sub,file=paste0(path_csv_deephlapan, hla, "_", len, ".csv"),row.names=FALSE)
                }
            }
        }
    }
    files <- list.files(sub("/$", "", path_csv_deephlapan), recursive = TRUE, full.names = TRUE,pattern = "^HLA")
    archive_mhci <- files[!grepl("HLA-D",files)]
    archive_mhcii <- files[grepl("HLA-D",files)]
    write.table(archive_mhci,file=paste0(path_csv_deephlapan,"archive_mhci.txt"),col.names = F,row.names = F,quote = F)
    write.table(archive_mhcii,file=paste0(path_csv_deephlapan,"archive_mhcii.txt"),col.names = F,row.names = F,quote = F)
### txt format for deepnetbim
    load(paste0(path_test,"TEST.Rdata"))
    for(i in c("_mhci","_mhcii")){
        temp_tes <- get(paste0("test",i))
        temp_sel <- get(paste0("h2ltest",i))
        for(m in 1:nrow(temp_sel)){
            for(n in 1:(ncol(temp_sel)-1)){
                hla <- rownames(temp_sel)[m]
                len <- colnames(temp_sel)[n]
                num <- temp_sel[hla,len]
                if(num != 0){
                    sub <- temp_tes %>% filter(hlatype == hla & antigen_peptide_length == as.numeric(len))
                    sub <- sub[,c("hlatype","antigen_peptide")]
                    sub$hlatype<-gsub("\\*", "", sub$hlatype)
                    colnames(sub)<-c("mhc","sequence")
                    hla <- gsub("/","-",hla)#linux don't allow '/' 
                    write.table(sub,file=paste0(path_txt_deepnetbim, hla, "_", len, ".txt"),row.names=FALSE,quote=FALSE,sep='\t')
                }
            }
        }
    }
    files <- list.files(sub("/$", "", path_txt_deepnetbim), recursive = TRUE, full.names = TRUE,pattern = "^HLA")
    archive_mhci <- files[!grepl("HLA-D",files)]
    archive_mhcii <- files[grepl("HLA-D",files)]
    write.table(archive_mhci,file=paste0(path_txt_deepnetbim,"archive_mhci.txt"),col.names = F,row.names = F,quote = F)
    write.table(archive_mhcii,file=paste0(path_txt_deepnetbim,"archive_mhcii.txt"),col.names = F,row.names = F,quote = F)
### csv format for bigmhc
    load(paste0(path_test,"TEST.Rdata"))
    for(i in c("_mhci","_mhcii")){
        temp_tes <- get(paste0("test",i))
        temp_sel <- get(paste0("h2ltest",i))
        for(m in 1:nrow(temp_sel)){
            for(n in 1:(ncol(temp_sel)-1)){
                hla <- rownames(temp_sel)[m]
                len <- colnames(temp_sel)[n]
                num <- temp_sel[hla,len]
                if(num != 0){
                    sub <- temp_tes %>% filter(hlatype == hla & antigen_peptide_length == as.numeric(len))
                    sub <- sub[,c("hlatype","antigen_peptide")]
                    sub <- data.frame(mhc=sub$"hlatype",pep=sub$"antigen_peptide",tgt="none")
                    hla <- gsub("/","-",hla)#linux don't allow '/' 
                    write.csv(sub,file=paste0(path_csv_bigmhc, hla, "_", len, ".csv"),row.names=FALSE)
                }
            }
        }
    }
    files <- list.files(sub("/$", "", path_csv_bigmhc), recursive = TRUE, full.names = TRUE,pattern = "^HLA")
    archive_mhci <- files[!grepl("HLA-D",files)]
    archive_mhcii <- files[grepl("HLA-D",files)]
    write.table(archive_mhci,file=paste0(path_csv_bigmhc,"archive_mhci.txt"),col.names = F,row.names = F,quote = F)
    write.table(archive_mhcii,file=paste0(path_csv_bigmhc,"archive_mhcii.txt"),col.names = F,row.names = F,quote = F)