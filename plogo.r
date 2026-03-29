library(dplyr)
library(ggplot2)
library(cowplot)
library(gridExtra)
library(ggseqlogo)
path_data <- "/data1/wuguojia/data/mhc_benchmark/database/extract_database/"
path_test <- "/data1/wuguojia/data/mhc_benchmark/testbase/"
path_attention<-"/data1/wuguojia/data/mhc_benchmark/attentionbase/"
################################ deal data
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
################################ ALL MHCI
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
                plot.title = element_text(hjust = 0.5,size = 12),
                axis.text.x = element_text(angle = 0, hjust = 1, size = 12),
                axis.text.y = element_text(size = 12),
                legend.position = "none")
        }
    }
    ncol <- 4
    nrow <- 4
    pdf(paste0(path_attention,"plogo_plots.pdf"), width = 16, height = 10)
    for (i in seq(1, length(plogo), by = ncol * nrow)) {
        plots_to_plot <- plogo[i:min(i + ncol * nrow - 1, length(plogo))]
        grid.arrange(grobs = plots_to_plot, ncol = ncol)
    }
    dev.off()
################################ SELECTED MHCI (major fig)
    len_se<-9
    hla_se<-c("HLA-A*02:01","HLA-B*15:02","HLA-C*05:01")
    plogo<-list();
    for(hla in hla_se){
        for(len in len_se){
            df<-filteration %>% filter(hlatype==hla&antigen_peptide_length ==len&bind_result=="positive")
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
                plot.title = element_text(hjust = 0.5,size = 12),
                axis.text.x = element_text(angle = 0, hjust = 1, size = 12),
                axis.text.y = element_text(size = 12),
                legend.position = "none")
        }
    }
    pdf(paste0(path_attention,"plogo_plots_se.pdf"), width = 4, height = 9)
    grid.arrange(grobs = plogo, ncol = 1)
    dev.off()
################################ SELECTED MHCI (supplement fig)
    hla_se<-c("HLA-B*07:02","HLA-C*08:02","HLA-A*33:01","HLA-A*33:03","HLA-B*35:01","HLA-B*35:02","HLA-B*35:03","HLA-B*40:01","HLA-B*40:02","HLA-B*44:02","HLA-B*44:03")
    len_se<-c(8,9,10,11)
    plogo<-list();
    for(hla in hla_se){
        for(len in len_se){
            df<-filteration %>% filter(hlatype==hla&antigen_peptide_length ==len&bind_result=="positive")
            plogo[[paste0(hla,"_",len)]]<-ggplot() +
            geom_logo(df$antigen_peptide, method = "bits", seq_type = "aa") +
            theme_logo() +
            scale_y_continuous(labels = scales::number_format(accuracy = 0.1))+
            labs(y = NULL,x=NULL,title=NULL) +
            annotate("text",x = (nchar(df$antigen_peptide[1]) + 1) / 2,  y = 2.0,label = paste0("n = ", length(df$antigen_peptide)),size = 2.5,hjust = 0.5) +
            theme_minimal(base_size = 15) +
            theme(
                panel.grid=element_blank(),
                panel.border=element_rect(color ="black",fill = NA,size = 0.5),
                panel.background = element_rect(fill = "white", color = "black"),
                plot.title = element_text(hjust = 0.5,size = 7),
                axis.text.x = element_blank(),
                axis.text.y = element_text(size = 7),
                axis.ticks.y = element_line(color = "black", size = 0.5),
                legend.position = "none")
        }
    }
    pdf(paste0(path_attention,"plogo_plots_se2.pdf"), width = 7.5, height = 10)
    grid.arrange(grobs = plogo, ncol = 4)
    dev.off()
################################################################