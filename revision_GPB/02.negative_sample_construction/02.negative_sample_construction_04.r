library(data.table)
library(tidyr)
library(dplyr)
library(purrr)
library(stringr)
# path configuration
path_retest <- "/data1/wuguojia/data/mhc_benchmark/revision/02.negtive_sample_reconstruction/"
path_retest_base <- paste0(path_retest, "retest_base/")
fold_list <- c(1,4,9,99) # folds
for(fold in fold_list){
    cat("Processing fold: 1_vs_", fold, "\n")
#------------------------- path setup
    fold_path <- paste0("1_vs_", fold, "/")
    path_data <- paste0(path_retest_base, fold_path)

    dir.create(paste0(path_data, "fasta/"), showWarnings = FALSE)
    dir.create(paste0(path_data, "HLA_fasta/"), showWarnings = FALSE)
    dir.create(paste0(path_data, "csv/"), showWarnings = FALSE)
    dir.create(paste0(path_data, "txt_casan/"), showWarnings = FALSE)
    dir.create(paste0(path_data, "txt_casie/"), showWarnings = FALSE)
    dir.create(paste0(path_data, "csv_stmhcpan/"), showWarnings = FALSE)
    dir.create(paste0(path_data, "txt_acme/"), showWarnings = FALSE)
    dir.create(paste0(path_data, "csv_deephlapan/"), showWarnings = FALSE)
    dir.create(paste0(path_data, "txt_deepnetbim/"), showWarnings = FALSE)
    dir.create(paste0(path_data, "csv_bigmhc/"), showWarnings = FALSE)

    path_fasta <- paste0(path_data, "fasta/")
    path_HLA_fasta <- paste0(path_data, "HLA_fasta/")
    path_csv <- paste0(path_data, "csv/")
    path_txt_casan <- paste0(path_data, "txt_casan/")
    path_txt_casie <- paste0(path_data, "txt_casie/")
    path_csv_stmhcpan <- paste0(path_data, "csv_stmhcpan/")
    path_txt_acme <- paste0(path_data, "txt_acme/")
    path_csv_deephlapan <- paste0(path_data, "csv_deephlapan/")
    path_txt_deepnetbim <- paste0(path_data, "txt_deepnetbim/")
    path_csv_bigmhc <- paste0(path_data, "csv_bigmhc/")

#------------------------- start data configuration
### fasta format
    load(paste0(path_data,"TEST.Rdata"))
    temp_tes <- test
    temp_sel <- summary[["hla2len"]]
    for(m in 1:nrow(temp_sel)){
        for(n in 1:(ncol(temp_sel)-1)){
            hla <- rownames(temp_sel)[m]
            len <- colnames(temp_sel)[n]
            num <- temp_sel[hla,len]
            if(num != 0){
                sub <- temp_tes %>% filter(hlatype == hla & antigen_peptide_length == as.numeric(len))
                hla <- gsub("/","-",hla)#linux don't allow '/' 
                cat("Writing FASTA for HLA:", hla, "| Length:", len, "| Samples:", nrow(sub), "\n")
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
    files <- list.files(sub("/$", "", path_fasta), recursive = TRUE, full.names = TRUE,pattern = "^HLA")
    write.table(files, file=paste0(path_fasta,"archive_mhci.txt"),col.names = F,row.names = F,quote = F)
### fasta-HLA pseudosequence-format
    #mhci info come from netmhcpan4.1 training data; mhcii info come from netmhciipan4.3 training data
    load(paste0(path_data,"TEST.Rdata"))
    hlamhci01<-"/data1/wuguojia/data/mhc_benchmark/database/HLAallele_sequence/MHC_pseudo.dat"
    hlamhci02<-"/data1/wuguojia/data/mhc_benchmark/database/HLAallele_sequence/MHC_pseudo.txt"
    seq1<-rbind(read.table(hlamhci01, header = FALSE, sep = "", stringsAsFactors = FALSE),read.table(hlamhci02, header = FALSE, sep = "", stringsAsFactors = FALSE))
    #mhci match sequences
    seq1$V1<-gsub("[^a-zA-Z0-9]", "", seq1$V1)
    seq1<-seq1 %>% distinct() %>% filter(grepl("^HLA",V1)) %>% distinct(V1,.keep_all=TRUE)
    setdiff(gsub("[^a-zA-Z0-9]","",unique(test$hlatype)),seq1$V1)
    #write fasta files
    test$V1<-gsub("[^a-zA-Z0-9]", "", test$hlatype)
    test<-left_join(test,seq1,by="V1")
    temp_tes <- test
    temp_sel <- summary[["hla2len"]]
    for(m in 1:nrow(temp_sel)){
        for(n in 1:(ncol(temp_sel)-1)){
            hla <- rownames(temp_sel)[m]
            len <- colnames(temp_sel)[n]
            num <- temp_sel[hla,len]
            if(num != 0){
                sub <- temp_tes %>% filter(hlatype == hla & antigen_peptide_length == as.numeric(len))
                hla <- gsub("/","-",hla)#linux don't allow '/' 
                cat("Writing FASTA for HLA:", hla, "| Length:", len, "| Samples:", nrow(sub), "\n")
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
    files <- list.files(sub("/$", "", path_HLA_fasta), recursive = TRUE, full.names = TRUE,pattern = "^HLA")
    write.table(files,file=paste0(path_HLA_fasta,"archive_mhci.txt"),col.names = F,row.names = F,quote = F)
### csv format
    load(paste0(path_data,"TEST.Rdata"))
    temp_tes <- test
    temp_sel <- summary[["hla2len"]]
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
                cat("Writing csv for HLA:", hla, "| Length:", len, "| Samples:", nrow(sub), "\n")
                write.csv(sub,file=paste0(path_csv, hla, "_", len, ".csv"),row.names=FALSE)
            }
        }
    }
    files <- list.files(sub("/$", "", path_csv), recursive = TRUE, full.names = TRUE,pattern = "^HLA")
    write.table(files,file=paste0(path_csv,"archive_mhci.txt"),col.names = F,row.names = F,quote = F)
### txt format CapsNet-MHC Anthem model
    load(paste0(path_data,"TEST.Rdata"))
    temp_tes <- test
    temp_sel <- summary[["hla2len"]]
    for(m in 1:nrow(temp_sel)){
        for(n in 1:(ncol(temp_sel)-1)){
            hla <- rownames(temp_sel)[m]
            len <- colnames(temp_sel)[n]
            num <- temp_sel[hla,len]
            if(num != 0){
                sub <- temp_tes %>% filter(hlatype == hla & antigen_peptide_length == as.numeric(len))
                sub <- data.frame(HLA=sub$"hlatype",peptide=sub$"antigen_peptide",Label="none",length=sub$"antigen_peptide_length")
                hla <- gsub("/","-",hla)#linux don't allow '/' 
                cat("Writing txt for HLA:", hla, "| Length:", len, "| Samples:", nrow(sub), "\n")
                write.table(sub,file=paste0(path_txt_casan, hla, "_", len, ".txt"),row.names=FALSE,quote=FALSE,sep='\t')
            }
        }
    }
    files <- list.files(sub("/$", "", path_txt_casan), recursive = TRUE, full.names = TRUE,pattern = "^HLA")
    write.table(files,file=paste0(path_txt_casan,"archive_mhci.txt"),col.names = F,row.names = F,quote = F)
### txt format CapsNet-MHC iedb model
    load(paste0(path_data,"TEST.Rdata"))
    temp_tes <- test
    temp_sel <- summary[["hla2len"]]
    for(m in 1:nrow(temp_sel)){
        for(n in 1:(ncol(temp_sel)-1)){
            hla <- rownames(temp_sel)[m]
            len <- colnames(temp_sel)[n]
            num <- temp_sel[hla,len]
            if(num != 0){
                sub <- temp_tes %>% filter(hlatype == hla & antigen_peptide_length == as.numeric(len))
                sub <- data.frame(Date=0,`IEDB reference`=0,Allele=sub$"hlatype",`Peptide length`=sub$"antigen_peptide_length",`Measurement type`=0,`Peptide seq`=sub$"antigen_peptide",`Measurement value`=0,`NetMHCpan 2.8`=0,`NetMHCpan 3.0`=0,`NetMHCpan 4.0`=0,SMM=0,`ANN 3.4`=0,`ANN 4.0`=0,ARB=0,SMMPMBEC=0,`IEDB Consensus`=0,NetMHCcons=0,PickPocket=0,check.names = FALSE)
                hla <- gsub("/","-",hla)#linux don't allow '/' 
                cat("Writing txt for HLA:", hla, "| Length:", len, "| Samples:", nrow(sub), "\n")                
                write.table(sub,file=paste0(path_txt_casie, hla, "_", len, ".txt"),row.names=FALSE,quote=FALSE,sep='\t')
            }
        }
    }
    files <- list.files(sub("/$", "", path_txt_casie), recursive = TRUE, full.names = TRUE,pattern = "^HLA")
    write.table(files,file=paste0(path_txt_casie,"archive_mhci.txt"),col.names = F,row.names = F,quote = F)
### csv format for stmhcpan
    load(paste0(path_data,"TEST.Rdata"))
    temp_tes <- test
    temp_sel <- summary[["hla2len"]] 
    for(m in 1:nrow(temp_sel)){
        for(n in 1:(ncol(temp_sel)-1)){
            hla <- rownames(temp_sel)[m]
            len <- colnames(temp_sel)[n]
            num <- temp_sel[hla,len]
            if(num != 0){
                sub <- temp_tes %>% filter(hlatype == hla & antigen_peptide_length == as.numeric(len))
                sub <- data.frame(allele=sub$"hlatype",peptide=sub$"antigen_peptide",label="none",length=sub$"antigen_peptide_length")
                hla <- gsub("/","-",hla)#linux don't allow '/' 
                cat("Writing csv for HLA:", hla, "| Length:", len, "| Samples:", nrow(sub), "\n")
                write.csv(sub,file=paste0(path_csv_stmhcpan, hla, "_", len, ".csv"),row.names=FALSE)
            }
        }
    }
    files <- list.files(sub("/$", "", path_csv_stmhcpan), recursive = TRUE, full.names = TRUE,pattern = "^HLA")
    write.table(files,file=paste0(path_csv_stmhcpan,"archive_mhci.txt"),col.names = F,row.names = F,quote = F)
### txt format for acme
    load(paste0(path_data,"TEST.Rdata"))
    temp_tes <- test
    temp_sel <- summary[["hla2len"]]
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
                cat("Writing txt for HLA:", hla, "| Length:", len, "| Samples:", nrow(sub), "\n")
                write.table(sub,file=paste0(path_txt_acme, hla, "_", len, ".txt"),row.names=FALSE,quote=FALSE,sep='\t', col.names=FALSE)
            }
        }
    }
    files <- list.files(sub("/$", "", path_txt_acme), recursive = TRUE, full.names = TRUE,pattern = "^HLA")
    write.table(files,file=paste0(path_txt_acme,"archive_mhci.txt"),col.names = F,row.names = F,quote = F)
### csv format for deephlapan
    load(paste0(path_data,"TEST.Rdata"))
    temp_tes <- test
    temp_sel <- summary[["hla2len"]]
    for(m in 1:nrow(temp_sel)){
        for(n in 1:(ncol(temp_sel)-1)){
            hla <- rownames(temp_sel)[m]
            len <- colnames(temp_sel)[n]
            num <- temp_sel[hla,len]
            if(num != 0){
                sub <- temp_tes %>% filter(hlatype == hla & antigen_peptide_length == as.numeric(len))
                sub <- data.frame(Annotation=sub$"bind_result",HLA=gsub("\\*","",sub$"hlatype"),peptide=sub$"antigen_peptide")
                hla <- gsub("/","-",hla)#linux don't allow '/' 
                cat("Writing csv for HLA:", hla, "| Length:", len, "| Samples:", nrow(sub), "\n")
                write.csv(sub,file=paste0(path_csv_deephlapan, hla, "_", len, ".csv"),row.names=FALSE)
            }
        }
    }
    files <- list.files(sub("/$", "", path_csv_deephlapan), recursive = TRUE, full.names = TRUE,pattern = "^HLA")
    write.table(files,file=paste0(path_csv_deephlapan,"archive_mhci.txt"),col.names = F,row.names = F,quote = F)
### txt format for deepnetbim
    load(paste0(path_data,"TEST.Rdata"))
    temp_tes <- test
    temp_sel <- summary[["hla2len"]]
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
                cat("Writing txt for HLA:", hla, "| Length:", len, "| Samples:", nrow(sub), "\n")
                write.table(sub,file=paste0(path_txt_deepnetbim, hla, "_", len, ".txt"),row.names=FALSE,quote=FALSE,sep='\t')
            }
        }
    }
    #only remain 9-mer for deepnetbim, because this tool only accept 9 aa peptide
    all_files <- list.files(path = path_txt_deepnetbim, full.names = TRUE)
    file.remove(all_files[!grepl("_9\\.txt$", basename(all_files))])
    #write archive_mhci.txt
    files <- list.files(sub("/$", "", path_txt_deepnetbim), recursive = TRUE, full.names = TRUE,pattern = "^HLA")
    write.table(files,file=paste0(path_txt_deepnetbim,"archive_mhci.txt"),col.names = F,row.names = F,quote = F)
### csv format for bigmhc
    load(paste0(path_data,"TEST.Rdata"))
    temp_tes <- test
    temp_sel <- summary[["hla2len"]]
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
                cat("Writing csv for HLA:", hla, "| Length:", len, "| Samples:", nrow(sub), "\n")
                write.csv(sub,file=paste0(path_csv_bigmhc, hla, "_", len, ".csv"),row.names=FALSE)
            }
        }
    }
    files <- list.files(sub("/$", "", path_csv_bigmhc), recursive = TRUE, full.names = TRUE,pattern = "^HLA")
    write.table(files,file=paste0(path_csv_bigmhc,"archive_mhci.txt"),col.names = F,row.names = F,quote = F)
#------------------------- end data configuration
    cat("Finished processing fold: 1_vs_", fold, "\n")
    cat("file saved in ", path_data, "\n")
}