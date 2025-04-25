##################################################################
library(data.table)
library(tidyr)
library(dplyr)
library(openxlsx)
#path of databases and tools
    path_all <- "/data1/wuguojia/data/mhc_benchmark/database/"
    path_tool <- "/data1/wuguojia/data/mhc_benchmark/toolbase/"
    path_test <- "/data1/wuguojia/data/mhc_benchmark/testbase/"
    #database path
    path_extract <- paste0(path_all,"extract_database/")
    path_vdjbd <- paste0(path_all,"vdjbd/")
    path_iedb <- paste0(path_all,"iedb/")
    path_cedar <- paste0(path_all,"cedar/")
    path_dbpepneo <- paste0(path_all,"dbpepneo/")
    path_mhcepitopes <- paste0(path_all,"mhcepitopes/")
    #toolbase path
    path_filter<- paste0(path_tool,"filter_toolbase/")
    path_capsnetmhc <- paste0(path_tool,"capsnetmhc/")
    path_stmhcpan <- paste0(path_tool,"stmhcpan/")
    path_hlab <-paste0(path_tool,"hlab/")
    path_mhcroberta <- paste0(path_tool,"mhcroberta/")
    path_transphla <- paste0(path_tool,"transphla/")
    path_deepseqpanii <- paste0(path_tool,"deepseqpanii/")
    path_deepnetbim <- paste0(path_tool,"deepnetbim/")
    path_deepattentionpan <- paste0(path_tool,"deepattentionpan/")
    path_spconvm <- paste0(path_tool,"spconvm/")
    path_mhcattnet <- paste0(path_tool,"mhcattnet/")
    path_acme <- paste0(path_tool,"acme/")
    path_deephlapan  <- paste0(path_tool,"deephlapan/")
    path_mhcflurry2_0 <- paste0(path_tool,"mhcflurry2_0/")
    path_iedb_mhci <- paste0(path_tool,"iedb_mhcprediction/mhc_i/")
    path_iedb_mhcii <- paste0(path_tool,"iedb_mhcprediction/mhc_ii/")
#widely used functions
    hla2len <- function(x){a<-as.data.frame.matrix(table(x$hlatype,x$antigen_peptide_length));a$SUM <- rowSums(a);return(a)}
    hla2bin <- function(x){a<-as.data.frame.matrix(table(x$hlatype,x$bind_result));a$SUM <- rowSums(a);return(a)}
    len2bin <- function(x){{a<-as.data.frame.matrix(table(x$antigen_peptide_length,x$bind_result));a$SUM <- rowSums(a);return(a)}}
##################################################################

##################################################################
##############################darabase extraction
##############################vdjbd
    data <- fread(paste0(path_vdjbd,"vdjdb.slim.txt"))
    data <- subset(data,species=="HomoSapiens")
    data <- data[!(is.na(data$"reference.id") | trimws(data$"reference.id") == ""), ]#should have reference
    data1<-data[data$mhc.class=="MHCI",-c("mhc.b")]
    data2<-data[data$mhc.class=="MHCII",-c("mhc.a")]
    names(data1)[names(data1) %in% c("mhc.a", "mhc.b")] <- "hlatype"
    names(data2)[names(data2) %in% c("mhc.a", "mhc.b")] <- "hlatype"
    data <- rbind(data1,data2)
    data_vdjbd <- data.frame(
            mhc_class=data$"mhc.class",
            hlatype=data$"hlatype",
            antigen_peptide=data$"antigen.epitope",
            antigen_peptide_length=nchar(data$"antigen.epitope"),
            antigen_gene=data$"antigen.gene",
            antigen_species=data$"antigen.species",
            antigen_reference=data$"reference.id",
            #bind_dectect_method=data$"method.identification",
            bind_result=data$"vdjdb.score"
        )
    #data_vdjbd <- data_vdjbd[!(is.na(data_vdjbd$bind_dectect_method) | trimws(data_vdjbd$bind_dectect_method) == ""), ]#retain experiment supported data
    data_vdjbd<-separate_rows(data_vdjbd,hlatype, sep = ",")
    unique(data_vdjbd$hlatype)
    data_vdjbd<-distinct(data_vdjbd)
    save(data_vdjbd,file=paste0(path_extract,"data_vdjbd.Rdata"))
##############################iedb
    data <- fread(paste0(path_iedb,"mhc_ligand_full.csv"))
    colnames(data) <- paste0(colnames(data),as.character(unlist(data[1,])))
    data <- data[-1, ]
    data <- subset(data,(HostName=="Homo sapiens"|HostName=="Homo sapiens (human)"))
    data <- data[!(is.na(data$"ReferenceTitle") | trimws(data$"ReferenceTitle") == ""), ]#should have reference title
    data <- data[!(is.na(data$"AssayMethod") | trimws(data$"AssayMethod") == ""), ]#should have experimental supports
    data_iedb <- data.frame(
        time=data$"ReferenceDate",
        mhc_class=data$"MHC RestrictionClass",
        hlatype=data$"MHC RestrictionName",
        antigen_peptide=data$"EpitopeName",
        antigen_peptide_length=nchar(data$"EpitopeName"),
        antigen_protein=data$"EpitopeSource Molecule",
        antigen_protein_parent=data$"EpitopeMolecule Parent",
        antigen_species=data$"EpitopeSpecies",
        antigen_species_organism=data$"EpitopeSource Organism",
        antigen_reference=data$"ReferenceTitle",
        bind_dectect_method=data$"AssayMethod",
        bind_dectect_index=data$"AssayResponse measured",
        bind_dectect_outcome=data$"AssayQuantitative measurement",
        bind_result=data$"AssayQualitative Measurement"
        antigen_reference=data$"Source",)
    data_iedb<-data_iedb[grep("^HLA",data_iedb$"hlatype"),]
    data_iedb<-distinct(data_iedb)
    unique(data_iedb$hlatype)
    save(data_iedb,file=paste0(path_extract,"data_iedb.Rdata"))
##############################cedar
    data <- fread(paste0(path_cedar,"mhc_ligand_full.csv"))
    colnames(data) <- paste0(colnames(data),as.character(unlist(data[1,])))
    data <- data[-1, ]
    data <- subset(data,(HostName=="Homo sapiens"|HostName=="Homo sapiens (human)"))
    data <- data[!(is.na(data$"ReferenceTitle") | trimws(data$"ReferenceTitle") == ""), ]#should have reference title
    data <- data[!(is.na(data$"AssayMethod") | trimws(data$"AssayMethod") == ""), ]#should have experimental supports
    data_cedar <- data.frame(
        time=data$"ReferenceDate",
        mhc_class=data$"MHC RestrictionClass",
        hlatype=data$"MHC RestrictionName",
        antigen_peptide=data$"EpitopeName",
        antigen_peptide_length=nchar(data$"EpitopeName"),
        antigen_protein=data$"EpitopeSource Molecule",
        antigen_protein_parent=data$"EpitopeMolecule Parent",
        antigen_species=data$"EpitopeSpecies",
        antigen_species_organism=data$"EpitopeSource Organism",
        antigen_reference=data$"ReferenceTitle",
        bind_dectect_method=data$"AssayMethod",
        bind_dectect_index=data$"AssayResponse measured",
        bind_dectect_outcome=data$"AssayQuantitative measurement",
        bind_result=data$"AssayQualitative Measurement"
        )
    data_cedar<-data_cedar[grep("^HLA",data_cedar$"hlatype"),]
    data_cedar<-distinct(data_cedar)
    unique(data_cedar$hlatype)
    save(data_cedar,file=paste0(path_extract,"data_cedar.Rdata"))
#################################dbpepneo
    files <- list.files(path_dbpepneo, recursive = TRUE, full.names = TRUE)
    for(i in 1:length(files)){
        assign(paste0("data",i),read.xlsx(files[i], sheet = 1))
        temp<-get(paste0("data",i))
        colnames(temp)<-temp[1,]
        temp<-temp[-1,]
        assign(paste0("data",i),temp)}
    data_dbpepneo <-data.frame(
        mhc_class="I",
        hlatype=c(data1$"HLA allele",data3$"HLA allele"),
        antigen_peptide=c(data1$"Mut peptide",data3$"Mut peptide"),
        antigen_peptide_length=c(data1$"Peptide length",data3$"Peptide length"),
        antigen_protein=c(data1$"Gene",data3$"Gene"),#in order to form antigen_protein column in DATABASE_COMBINE file
        antigen_protein_parent=c(data1$"Gene",data3$"Gene"),
        antigen_reference=c(data1$"Reference",data3$"Reference"),
        bind_dectect_method=c(data1$"Cancer",data3$"Cancer/Cell line"),
        bind_dectect_outcome=c(data1$" Mut Affinity(nM)",data3$"Mut Affinity(nM)"),
        bind_result=c(data1$"Bind Level",data3$"Bind Level")
    )
    data_dbpepneo <- data_dbpepneo[!(is.na(data_dbpepneo$"antigen_reference") | trimws(data_dbpepneo$"antigen_reference") == ""), ]#should have reference title
    data_dbpepneo<-distinct(data_dbpepneo)
    unique(data_dbpepneo$hlatype)
    save(data_dbpepneo,file=paste0(path_extract,"data_dbpepneo.Rdata"))
#################################mhcepitopes
    data<-fread(paste0(path_mhcepitopes,"MHC_epitopes.csv"))
    data_mhcepitopes<-data.frame(
        mhc_class=data$"HLA_class",
        hlatype=data$"HLA_allele",
        antigen_peptide=data$"Epitope",
        antigen_peptide_length=data$"Epitope_length",
        antigen_protein=data$"Protein",
        antigen_reference=data$"Source",
        bind_result="positive"
        )
    data_mhcepitopes<-separate_rows(data_mhcepitopes,hlatype, sep = ",")
    data_mhcepitopes <- data_mhcepitopes[grep("^HLA",data_mhcepitopes$hlatype),]
    unique(data_mhcepitopes$hlatype)
    data_mhcepitopes<-distinct(data_mhcepitopes)
    save(data_mhcepitopes,file=paste0(path_extract,"data_mhcepitopes.Rdata"))
##################################################################

##################################################################
#################################toolbase extraction
##############################capsnetmhc
    files <- list.files(paste0(path_capsnetmhc,"dataset/"), recursive = TRUE, full.names = TRUE)  
    files <- grep("train", files, value = TRUE)
    for(i in 1:length(files)){assign(paste0("data",i),fread(files[i]))}
    data_capsnetmhc <- data.frame(hlatype=c(data1$"HLA",data2$"mhc"),antigen_peptide=c(data1$"peptide",data2$"sequence"),antigen_peptide_length=c(data1$"Length",data2$"peptide_length"))
    data_capsnetmhc <- data_capsnetmhc[grep("^HLA",data_capsnetmhc$hlatype),]#retain human data
    unique(data_capsnetmhc$hlatype)#check hlatype
    data_capsnetmhc <- distinct(data_capsnetmhc)
    save(data_capsnetmhc,file=paste0(path_filter,"data_capsnetmhc.Rdata"))
##############################stmhcpan
    files <- list.files(paste0(path_stmhcpan,"data/train_set/NetMHCpan4.1"), recursive = TRUE, full.names = TRUE)
    for(i in 1:length(files)){assign(paste0("data",i),fread(files[i]))}
    extract <- list()
    for(i in 1:length(files)){
        if(all(c("HLA","peptide") %in% colnames(get(paste0("data",i))))){extract[[i]] <- get(paste0("data",i))[,c("HLA","peptide")]}
    }
    data_stmhcpan<-do.call(rbind,extract)
    data_stmhcpan<-data.frame(hlatype=data_stmhcpan$"HLA",antigen_peptide=data_stmhcpan$"peptide",antigen_peptide_length=nchar(data_stmhcpan$"peptide"))    
    data_stmhcpan <- data_stmhcpan[grep("^HLA",data_stmhcpan$hlatype),]#retain human data
    unique(data_stmhcpan$hlatype)#check hlatype
    data_stmhcpan<-distinct(data_stmhcpan)
    save(data_stmhcpan,file=paste0(path_filter,"data_stmhcpan.Rdata"))
##############################hlab
    data_hlab<-fread(paste0(path_hlab,"data/train_data.csv"))
    data_hlab<-data.frame(hlatype=data_hlab$"HLA",antigen_peptide=data_hlab$"peptide",antigen_peptide_length=data_hlab$"Length")
    unique(data_hlab$hlatype)
    data_hlab<-distinct(data_hlab)
    save(data_hlab,file=paste0(path_filter,"data_hlab.Rdata"))
##############################mhcroberta(author mainly use netmhcpan4.1 training data, i've checked it and decided not to collect it because those data contained below.)
##############################transphla
    data_transphla<-fread(paste0(path_transphla,"Dataset/train_set.csv"))
    data_transphla<-data.frame(hlatype=data_transphla$"HLA",antigen_peptide=data_transphla$"peptide",antigen_peptide_length=data_transphla$"length")
    unique(data_transphla$hlatype)
    data_transphla<-distinct(data_transphla)
    save(data_transphla,file=paste0(path_filter,"data_transphla.Rdata"))
##############################immunobert(author haven't provide data access due to some reason, but  he said they use data from IEDB, BD2013 dataset and SysteMHC Atlas)
##############################bertmhc(author used NetMHCIIpan-3.0(trained on BD2013) and NetMHCIIpan-3.2(trained on BD2013) training data, however, the DTU health tech closed resource links. fortunately,in the next method deepseqpanii whose provider offer BD2013 & BD2016 data. so that's dosen't matter)
##############################deepseqpanii
    files <- list.files(paste0(path_deepseqpanii,"code_and_dataset/dataset/"), recursive = TRUE, full.names = TRUE)
    files <- grep("READY", files, value = TRUE) 
    for(i in 1:length(files)){assign(paste0("data",i),fread(files[i]))}
    extract <- list()
    for(i in 1:length(files)){
        if(all(c("HLA","sequence","length") %in% colnames(get(paste0("data",i))))){extract[[i]] <- get(paste0("data",i))[,c("HLA","sequence","length")]}
    }
    data_deepseqpanii<-do.call(rbind,extract)
    data_deepseqpanii<-data.frame(hlatype=data_deepseqpanii$"HLA",antigen_peptide=data_deepseqpanii$"sequence",antigen_peptide_length=nchar(data_deepseqpanii$"length"))
    data_deepseqpanii$hlatype<-paste0("HLA-",gsub("-", "/", data_deepseqpanii$hlatype))
    unique(data_deepseqpanii$hlatype)
    data_deepseqpanii<-distinct(data_deepseqpanii)
    save(data_deepseqpanii,file=paste0(path_filter,"data_deepseqpanii.Rdata"))
##############################deepnetbim
    data_deepnetbim<-fread(paste0(path_deepnetbim,"data/binding_train.csv"))
    data_deepnetbim<-data.frame(hlatype=data_deepnetbim$"mhc",antigen_peptide=data_deepnetbim$"sequence",antigen_peptide_length=nchar(data_deepnetbim$"sequence"))
    unique(data_deepnetbim$hlatype)
    data_deepnetbim<-distinct(data_deepnetbim)
    save(data_deepnetbim,file=paste0(path_filter,"data_deepnetbim.Rdata"))
##############################deepattentionpan
    data_deepattentionpan<-fread(paste0(path_deepattentionpan,"dataset/training_set.txt"))
    data_deepattentionpan<-data.frame(hlatype=data_deepattentionpan$"mhc",antigen_peptide=data_deepattentionpan$"sequence",antigen_peptide_length=data_deepattentionpan$"peptide_length")
    data_deepattentionpan<-data_deepattentionpan[grep("^HLA",data_deepattentionpan$hlatype),]
    unique(data_deepattentionpan$hlatype)
    data_deepattentionpan<-distinct(data_deepattentionpan)
    save(data_deepattentionpan,file=paste0(path_filter,"data_deepattentionpan.Rdata"))
##############################spconvm
    files <- list.files(paste0(path_spconvm,"data/fold"), recursive = TRUE, full.names = TRUE)
    files <- grep("train", files, value = TRUE) 
    for(i in 1:length(files)){
        assign(paste0("data",i),fread(files[i]))
        temp <-  get(paste0("data",i))
        temp$hlatype <- gsub(".*/fold/([^/]+)/.*", "\\1", files[i])
        assign(paste0("data", i), temp)}
    extract <- list()
    for(i in 1:length(files)){
        if(all(c("V1","hlatype") %in% colnames(get(paste0("data",i))))){extract[[i]] <- get(paste0("data",i))[,c("V1","hlatype")]}
    }
    data_spconvm<-do.call(rbind,extract)
    data_spconvm<-data.frame(hlatype=data_spconvm$"hlatype",antigen_peptide=data_spconvm$"V1",antigen_peptide_length=nchar(data_spconvm$"V1"))
    data_spconvm<-data_spconvm[grepl("^HLA", data_spconvm$hlatype), ]
    data_spconvm$hlatype<-gsub("([A-Z]+-[A-Z]+)-([0-9]{2})([0-9]{2})", "\\1*\\2:\\3", data_spconvm$hlatype)
    unique(data_spconvm$hlatype)
    data_spconvm<-distinct(data_spconvm)
    save(data_spconvm,file=paste0(path_filter,"data_spconvm.Rdata"))
##############################mhcattnet
    files <- list.files(paste0(path_mhcattnet,"train_data"), recursive = TRUE, full.names = TRUE)
    files <- grep("train.csv", files, value = TRUE) 
    for(i in 1:length(files)){assign(paste0("data",i),fread(files[i]))}
    extract <- list()
    for(i in 1:length(files)){
        if(all(c("peptide","mhc_allele") %in% colnames(get(paste0("data",i))))){extract[[i]] <- get(paste0("data",i))[,c("peptide","mhc_allele")]}
    }
    data_mhcattnet<-do.call(rbind,extract)
    data_mhcattnet<-data.frame(hlatype=data_mhcattnet$"mhc_allele",antigen_peptide=data_mhcattnet$"peptide",antigen_peptide_length=nchar(data_mhcattnet$"peptide"))
    unique(data_mhcattnet$hlatype)
    data_mhcattnet<-distinct(data_mhcattnet)
    save(data_mhcattnet,file=paste0(path_filter,"data_mhcattnet.Rdata"))
##############################acme
    files <- list.files(paste0(path_acme,"ACME_codes/binding_data"), recursive = TRUE, full.names = TRUE)
    for(i in 1:length(files)){assign(paste0("data",i),fread(files[i]))}
    data_acme<-data.frame(
        hlatype=c(data1$V2,data2$V2,data3$mhc,data4$V4),
        antigen_peptide=c(data1$V4,data2$V4,data3$sequence,data4$V1))
        data_acme$antigen_peptide_length=nchar(data_acme$hlatype)
    data_acme<-data_acme[grep("^HLA",data_acme$hlatype),]
    unique(data_acme$hlatype)
    data_acme<-distinct(data_acme)
    save(data_acme,file=paste0(path_filter,"data_acme.Rdata"))
##############################deephlapan
    files <- list.files(paste0(path_deephlapan,"train_data/"), recursive = TRUE, full.names = TRUE)
    for(i in 1:length(files)){
        assign(paste0("data",i),read.xlsx(files[i], sheet = 1))
        temp<-get(paste0("data",i))
        colnames(temp)<-temp[1,]
        temp<-temp[-1,]
        assign(paste0("data",i),temp)}
    extract <- list()
        for(i in 1:length(files)){
        if(all(c("HLA","Peptide") %in% colnames(get(paste0("data",i))))){extract[[i]] <- get(paste0("data",i))[,c("HLA","Peptide")]}
    }
    data_deephlapan<-do.call(rbind,extract)
    data_deephlapan<-data.frame(
        hlatype=data_deephlapan$"HLA",
        antigen_peptide=data_deephlapan$"Peptide",
        antigen_peptide_length=nchar(data_deephlapan$"Peptide"))
    unique(data_deephlapan$hlatype)
    data_deephlapan<-distinct(data_deephlapan)
    save(data_deephlapan,file=paste0(path_filter,"data_deephlapan.Rdata"))
##############################mhcflurry2_0
    files <- list.files(paste0(path_mhcflurry2_0,"train_data/"), recursive = TRUE, full.names = TRUE)
    for(i in 1:length(files)){assign(paste0("data",i),fread(files[i]))}
    data_mhcflurry2_0<-data.frame(
        hlatype=c(data1$"allele",data2$"hla",data3$"hla"),antigen_peptide=c(data1$"peptide",data2$"peptide",data3$"peptide"))
        data_mhcflurry2_0$antigen_peptide_length=nchar(data_mhcflurry2_0$"antigen_peptide")
        data_mhcflurry2_0 <- data_mhcflurry2_0 %>% mutate(hlatype = strsplit(as.character(hlatype), " ")) %>% unnest(hlatype)
    data_mhcflurry2_0<-data_mhcflurry2_0[grep("^HLA",data_mhcflurry2_0$hlatype),]
    unique(data_mhcflurry2_0$hlatype)
    data_mhcflurry2_0<-distinct(data_mhcflurry2_0)
    save(data_mhcflurry2_0,file=paste0(path_filter,"data_mhcflurry2_0.Rdata"))
##############################iedb_mhci
    files <- list.files(paste0(path_iedb_mhci,"train_data/"), recursive = TRUE, full.names = TRUE)
    files <- grep("_ba|Stability", files, value = TRUE)
    for(i in 1:length(files)){assign(paste0("data",i),fread(files[i]))}
    colnames(data6)<-c("V3","V1","V2")
    extract <- list()
    for(i in 1:length(files)){
        if(all(c("V1","V3") %in% colnames(get(paste0("data",i))))){extract[[i]] <- get(paste0("data",i))[,c("V1","V3")]}
    }
    data_iedb_mhci<-do.call(rbind,extract)
    data_iedb_mhci<-data.frame(hlatype=data_iedb_mhci$"V3",antigen_peptide=data_iedb_mhci$"V1",antigen_peptide_length=nchar(data_iedb_mhci$"V1"))    
    data_iedb_mhci<-data_iedb_mhci[grep("^HLA",data_iedb_mhci$hlatype),]
    data_iedb_mhci$hlatype<-sub("([A-Z]+-[A-Z])(\\d+:\\d+)", "\\1*\\2", data_iedb_mhci$hlatype)
    unique(data_iedb_mhci$hlatype)
    data_iedb_mhci<-distinct(data_iedb_mhci)
    save(data_iedb_mhci,file=paste0(path_filter,"data_iedb_mhci.Rdata"))
##############################iedb_mhcii
    files <- list.files(paste0(path_iedb_mhcii,"train_data/"), recursive = TRUE, full.names = TRUE)
    files <- grep("_ba", files, value = TRUE)
    for(i in 1:length(files)){assign(paste0("data",i),fread(files[i]))}
    extract <- list()
    for(i in 1:length(files)){
        if(all(c("V1","V3") %in% colnames(get(paste0("data",i))))){extract[[i]] <- get(paste0("data",i))[,c("V1","V3")]}
    }
    data_iedb_mhcii<-do.call(rbind,extract)
    data_iedb_mhcii<-data.frame(hlatype=data_iedb_mhcii$"V3",antigen_peptide=data_iedb_mhcii$"V1",antigen_peptide_length=nchar(data_iedb_mhcii$"V1"))    
    data_iedb_mhcii <- data_iedb_mhcii[grep("HLA|DRB", data_iedb_mhcii$hlatype), ]
    data_iedb_mhcii$hlatype <- ifelse(
        grepl("^HLA-[A-Z]{3}\\d{5}-[A-Z]{3}\\d{5}$", data_iedb_mhcii$hlatype),
        gsub("HLA-([A-Z]{3})(\\d)(\\d{2})(\\d{2})-([A-Z]{3})(\\d)(\\d{2})(\\d{2})", 
       "HLA-\\1\\2*\\3:\\4/\\5\\6*\\7:\\8", data_iedb_mhcii$hlatype),
            ifelse(grepl("^DRB\\d_\\d{4}$", data_iedb_mhcii$hlatype),
            gsub("DRB(\\d)_(\\d{2})(\\d{2})", "HLA-DRB\\1*\\2:\\3", data_iedb_mhcii$hlatype),
            data_iedb_mhcii$hlatype
        )
        )
    unique(data_iedb_mhcii$hlatype)
    data_iedb_mhcii<-distinct(data_iedb_mhcii)
    save(data_iedb_mhcii,file=paste0(path_filter,"data_iedb_mhcii.Rdata"))
##############################mixmhcpred(no article, no training data access)
##############################mixmhc2pred(no article, no training data access)
##################################################################

##################################################################
#################################fileration
##############################combine toolsets
    #load all data and combine
    tool_combine <- do.call(rbind, lapply(list.files(path_filter, recursive = TRUE, full.names = TRUE), function(file) {load(file);get(ls()[1])}))
    #write hlatype into same style
    tool_combine$hlatype<-gsub("([A-Z]+-[A-Z])(\\d{2}:\\d{2})", "\\1*\\2", tool_combine$hlatype)
    tool_combine$hlatype<-gsub("(HLA-[A-Z]\\*\\d{2})-(\\d{2})", "\\1:\\2", tool_combine$hlatype)
    tool_combine$hlatype <- gsub("(.*:[0-9]+).*", "\\1", tool_combine$hlatype)#remove annotation
    unique(tool_combine$hlatype)
    #remove antigen peption annotation
    tool_combine$antigen_peptide <- gsub("[^A-Z].*", "", tool_combine$antigen_peptide)
    tool_combine$antigen_peptide_length <- nchar(tool_combine$antigen_peptide)
    #remove redundant items
    tool_combine <- distinct(tool_combine)
    save(tool_combine,file=paste0(path_filter,"TOOL_COMBINE.Rdata"))
##############################combine databases
    #load all data and combine
    files <- list.files(path_extract, recursive = TRUE, full.names = TRUE) %>% .[!grepl("DATABASE_COMBINE", .)]
    database_combine <- data.frame()
    for (file in files) {
        x<-load(file)
        data_to_merge <- get(x)
        select <- c("mhc_class", "hlatype", "antigen_peptide","antigen_peptide_length","antigen_reference","antigen_protein","bind_result")
        if (all(select %in% colnames(data_to_merge))) {
            data_subset <- data_to_merge[,select]
            database_combine <- rbind(database_combine, data_subset)}}
    #keep variable consistant
    database_combine<-database_combine%>%mutate(mhc_class=ifelse(mhc_class=="MHCI","I",mhc_class))
    database_combine<-database_combine%>%mutate(mhc_class=ifelse(mhc_class=="MHCII","II",mhc_class))
    pos<-c("Positive-Low","Positive","Positive-High","positive","Positive-Intermediate","WB","SB")
    neg<-c("Negative","NB")
    database_combine$bind_result <- ifelse(database_combine$bind_result %in% pos, "positive", ifelse(database_combine$bind_result %in% neg, "negative", "unknown"))
    #write hlatype into same style
    database_combine$hlatype <- gsub("(.*:[0-9]+).*", "\\1", database_combine$hlatype)#remove annotation
    unique(database_combine$hlatype)
    #remove antigen peption annotation
    database_combine$antigen_peptide <- gsub("[^A-Z].*", "", database_combine$antigen_peptide)
    database_combine$antigen_peptide_length <- nchar(database_combine$antigen_peptide)
    #remove redundant items
    database_combine<-database_combine%>%distinct(hlatype,antigen_peptide,.keep_all = TRUE)
    save(database_combine,file=paste0(path_extract,"DATABASE_COMBINE.Rdata"))
##############################filteration
    load(paste0(path_filter,"TOOL_COMBINE.Rdata"))
    load(paste0(path_extract,"DATABASE_COMBINE.Rdata"))
    #filter by two column
    filteration <- anti_join(database_combine, tool_combine, by = c("hlatype", "antigen_peptide"))
    #retain common hlatype name
    filteration<-filteration[grep("\\*", filteration$hlatype), ]
    #delete unnatural peptide
    valid_amino_acids <- "^[ARNDCEQGHILKMFPSTWYV]+$"
    filteration <- filteration[grepl(valid_amino_acids, filteration$antigen_peptide), ]
    #remove redundant peptide
    filteration<-filteration %>% distinct(hlatype,antigen_peptide,.keep_all = TRUE)
    #distinguish mhci and mhcii and retain common peptide length
    filteration_mhci<-filteration%>%filter(mhc_class=="I",antigen_peptide_length>=8 & antigen_peptide_length <= 11)
    filteration_mhcii<-filteration%>%filter(mhc_class=="II",antigen_peptide_length>=13 & antigen_peptide_length <= 25)
    #remove negative items. we use artificial negative sequences
    for(i in c("filteration_mhci","filteration_mhcii")){
        #delete negative data
        temp <- get(i)
        assign(i,temp[temp$bind_result=="positive",]);assign(paste0("h2l",i),hla2len(get(i)));assign(paste0("h2b",i),hla2bin(get(i)));assign(paste0("l2b",i),len2bin(get(i)))#statistics
    }
    #remove insufficient number of hlatype
    thre_i <- 250
    thre_ii <- 500
    filteration_mhci <- filteration_mhci[filteration_mhci$hlatype%in% rownames(h2lfilteration_mhci[h2lfilteration_mhci$SUM >= thre_i, ]), ]
    filteration_mhcii <- filteration_mhcii[filteration_mhcii$hlatype %in%rownames(h2lfilteration_mhcii[h2lfilteration_mhcii$SUM >= thre_ii, ]), ]
    for(i in c("filteration_mhci","filteration_mhcii")){assign(paste0("h2l",i),hla2len(get(i)));assign(paste0("h2b",i),hla2bin(get(i)));assign(paste0("l2b",i),len2bin(get(i)))}
    #save file
    save(filteration_mhci,filteration_mhcii,h2lfilteration_mhci,h2lfilteration_mhcii,h2bfilteration_mhci,h2bfilteration_mhcii,l2bfilteration_mhci,l2bfilteration_mhcii,file=paste0(path_test,"FILTERATION.Rdata"))
##################################################################