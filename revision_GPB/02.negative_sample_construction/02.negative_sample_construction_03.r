##################################################################
    library(data.table)
    library(tidyr)
    library(dplyr)
    library(purrr)
    library(stringr)
    library(openxlsx)
    library(stringdist)
    library(parallel)
    library(Biostrings)
    #path of databases and tools
    path_test <- "/data1/wuguojia/data/mhc_benchmark/testbase/"
    path_retest <- "/data1/wuguojia/data/mhc_benchmark/revision/02.negtive_sample_reconstruction/"
    path_neg_ripe <- paste0(path_retest,"negative_ripe/")
    path_retest_base <- paste0(path_retest,"retest_base/")
    #widely used functions
    hla2len <- function(x){a<-as.data.frame.matrix(table(x$hlatype,x$antigen_peptide_length));a$SUM <- rowSums(a);return(a)}
    hla2bin <- function(x){a<-as.data.frame.matrix(table(x$hlatype,x$bind_result));a$SUM <- rowSums(a);return(a)}
    len2bin <- function(x){{a<-as.data.frame.matrix(table(x$antigen_peptide_length,x$bind_result));a$SUM <- rowSums(a);return(a)}}
##################################################################

##################################################################
    load(paste0(path_test,"TEST.Rdata"))
    pos <- subset(test_mhci, bind_result == "positive")
    count <- hla2len(pos)
    hla_list <- rownames(count)
    len_list <- 8:11
    fold_neg_pos <- c(1,4,9,99)
    # match negative samples from ripe negative database
    set.seed(20030622)
    for (fold in fold_neg_pos) { 
        dir.create(paste0(path_retest_base, "1_vs_",fold), recursive = TRUE, showWarnings = FALSE)
    } # create output directories if not exist
    read_fasta_peptides <- function(fasta_path) {
        if (!file.exists(fasta_path)) return(character(0))
        seqs <- readAAStringSet(fasta_path)
        as.character(seqs)
    } # function to read peptides from FASTA
    # start processing
    for (fold in fold_neg_pos) {
        cat("Processing fold:", fold, "\n")
        all_samples <- list()
        sample_id_counter <- 1        
        for (hla in hla_list) {
            cat("  HLA type:", hla, "\n")   
            for (len in len_list) {
            cat("    Peptide length:", len, "\n")
            # get positive count
            n_pos <- count[hla, as.character(len)]
            if (is.na(n_pos) || n_pos == 0) next
            # get needed negative count
            n_neg_needed <- as.numeric(n_pos * fold)
            neg_fasta_path <- paste0(path_neg_ripe, len, "_aa_length/", hla, ".fasta")
            # read negative peptides            
            neg_peptides <- read_fasta_peptides(neg_fasta_path)
            n_neg_available <- length(neg_peptides)
            if (n_neg_available == 0) {
                warning("No negative peptides found for ", hla, " length ", len)
                next
            }
            if (n_neg_needed > n_neg_available) {
                warning("Not enough negatives for ", hla, " (", len, "aa): need ", n_neg_needed, ", have ", n_neg_available, ". Using all available.")
                n_neg_needed <- n_neg_available
            }
            # select negatives
            selected_neg <- sample(neg_peptides, size = n_neg_needed, replace = FALSE)
            # construct test data frame
            pos_sub <- pos[pos$hlatype == hla & pos$antigen_peptide_length == len, ]
            neg_df <- data.frame(
                hlatype = hla,
                antigen_peptide = selected_neg,
                antigen_peptide_length = len,
                bind_result = "negative",
                stringsAsFactors = FALSE
            )
            combined <- rbind(
                pos_sub[, c("hlatype", "antigen_peptide", "antigen_peptide_length", "bind_result")],
                neg_df
            )
            all_samples[[sample_id_counter]] <- combined
            sample_id_counter <- sample_id_counter + 1
            }
        }
    # combine all samples for this fold
    test <- do.call(rbind, all_samples)
    rownames(test) <- NULL
    # save summary list by hla2bin, hla2len, len2bin
    summary <- list()
    summary$hla2bin <- hla2bin(test)
    summary$hla2len <- hla2len(test)
    summary$len2bin <- len2bin(test)
    # save test data
    save(test, summary,
        file = paste0(path_retest_base, "1_vs_", fold, "/TEST.Rdata"))
    cat("Saved:", nrow(test), "samples (", 
        sum(test$bind_result == "positive"), " pos, ",
        sum(test$bind_result == "negative"), " neg) for fold", fold, "\n\n")
    }
##################################################################
