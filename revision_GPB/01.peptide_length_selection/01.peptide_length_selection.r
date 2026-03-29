library(data.table)
library(tidyr)
library(dplyr)
library(openxlsx)
library(ggplot2)
#path of databases and tools
    path_all <- "/data1/wuguojia/data/mhc_benchmark/database/"
    path_tool <- "/data1/wuguojia/data/mhc_benchmark/toolbase/"
    path_test <- "/data1/wuguojia/data/mhc_benchmark/testbase/"
    path_out <- "/data1/wuguojia/data/mhc_benchmark/revision/01.peptide_length_selection/"
    #database path
    path_extract <- paste0(path_all,"extract_database/")
    #toolbase path
    path_filter<- paste0(path_tool,"filter_toolbase/")
#widely used functions
    hla2len <- function(x){a<-as.data.frame.matrix(table(x$hlatype,x$antigen_peptide_length));a$SUM <- rowSums(a);return(a)}
    hla2bin <- function(x){a<-as.data.frame.matrix(table(x$hlatype,x$bind_result));a$SUM <- rowSums(a);return(a)}
    len2bin <- function(x){{a<-as.data.frame.matrix(table(x$antigen_peptide_length,x$bind_result));a$SUM <- rowSums(a);return(a)}}    
#load data
    load(paste0(path_filter,"TOOL_COMBINE.Rdata"))
    load(paste0(path_extract,"DATABASE_COMBINE.Rdata"))
    load(paste0(path_test,"TEST.Rdata"))
    #filter by two column
    filteration <- anti_join(database_combine, tool_combine, by = c("hlatype", "antigen_peptide"))
    #retain common hlatype name
    filteration<-filteration[grep("\\*", filteration$hlatype), ]
    #delete unnatural peptide
    valid_amino_acids <- "^[ARNDCEQGHILKMFPSTWYV]+$"
    filteration <- filteration[grepl(valid_amino_acids, filteration$antigen_peptide), ]
    #remove redundant peptide
    filteration<-filteration %>% distinct(hlatype,antigen_peptide,.keep_all = TRUE)
    #left selected mhci positive data
    filter_mchi<-subset(filteration, antigen_peptide_length %in% c(5:20) & hlatype %in% unique(test_mhci$hlatype) & bind_result=="positive")
#summary
    sum01 <- hla2bin(filter_mchi)
    sum02 <- hla2len(filter_mchi)
    sum03 <- len2bin(filter_mchi)
    write.csv(sum02, file = paste0(path_out,"01.peptide_length_selection.csv"))
#plot
    # ==========================================
    # 1. PARAMETERS DEFINITION
    # ==========================================
    # Input a vector of lengths you want to analyze
    target_lengths <- c(8, 9, 10, 11, 12) 
    # Input the threshold count
    count_threshold <- 20        
    # Output filename
    output_pdf <- "01.peptide_length_selection.pdf" 
    # ==========================================
    # 2. INITIALIZE PDF
    # ==========================================
    # We open the PDF device once at the beginning
    pdf(file = paste0(path_out,output_pdf), width = 6, height = 3.5)
    # ==========================================
    # 3. PLOT 1: Overall Length Distribution
    # ==========================================
    # This is the first page of the PDF
    p1 <- ggplot(filter_mchi, aes(x = factor(antigen_peptide_length))) +
    geom_bar(fill = "steelblue", color = "black", alpha = 0.8) +
    geom_text(stat = 'count', aes(label = ..count..), vjust = -0.5, size = 4) +
    theme_minimal() +
    labs(title = "Overall Distribution of Antigen Peptide Lengths (All Data)",
        x = "Peptide Length (aa)",
        y = "Total Count") +
    theme(axis.text.x = element_text(size = 8, face = "bold"),
    panel.border = element_rect(colour = "black", fill=NA, linewidth=0.5))
    print(p1)
    # ==========================================
    # 4. PLOT 2 SERIES: Loop through each length
    # ==========================================
    for (len in target_lengths) {
    
    # A. Subset data for the current length (len)
    plot_data <- filter_mchi %>%
        filter(antigen_peptide_length == len)
    
    # Check if data exists for this length to avoid errors
    if(nrow(plot_data) > 0) {
        
        # B. Process counts and status
        plot_summary <- plot_data %>%
        count(hlatype) %>%
        mutate(status = ifelse(n >= count_threshold, "Pass", "Fail")) %>%
        # IMPORTANT: Sort by count descending so colors match labels later
        arrange(desc(n))
        # C. Lock factor levels for correct plotting order (only for hlatype)
        plot_summary $ hlatype <- factor(plot_summary $ hlatype, 
                                    levels = plot_summary $ hlatype)
        # D. Create dynamic color vector for X-axis labels
        axis_text_colors <- ifelse(plot_summary $ status == "Fail", "red", "black")
        # E. Create the Plot
        p_loop <- ggplot(plot_summary, aes(x = hlatype, y = n)) +
        geom_bar(stat = "identity", aes(fill = status), color = "black", alpha = 0.8) +
        geom_hline(yintercept = count_threshold, linetype = "dashed", color = "red", size = 1) +
        annotate("text", x = nrow(plot_summary) / 2, y = count_threshold * 1.1, 
                label = paste("Threshold =", count_threshold), color = "red", fontface = "bold") +
        scale_fill_manual(values = c("Pass" = "#4E84C4", "Fail" = "gray")) +
        theme_bw() +
        labs(
            title = paste("Distribution of", len, "-mer Peptides by HLA Type"),
            subtitle = paste("Red X-axis labels indicate HLA types with <", count_threshold, " peptides"),
            x = "HLA Type",
            y = "Count",
            fill = "Status"
        ) +
        theme(
            axis.text.x = element_text(angle = 90, hjust = 1, size = 8, color = axis_text_colors),
            legend.position = "top"
        )
        print(p_loop)
    } else {
        message(paste("Skipping length", len, "- No data found."))
    }
    }
    # ==========================================
    # 5. CLOSE PDF
    # ==========================================
    dev.off()
    message(paste("All plots have been saved to:", output_pdf))