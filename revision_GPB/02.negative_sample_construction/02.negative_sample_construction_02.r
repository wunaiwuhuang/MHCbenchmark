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
    path_all <- "/data1/wuguojia/data/mhc_benchmark/database/"
    path_tool <- "/data1/wuguojia/data/mhc_benchmark/toolbase/"
    path_test <- "/data1/wuguojia/data/mhc_benchmark/testbase/"
    path_extract <- paste0(path_all,"extract_database/")
    path_filter<- paste0(path_tool,"filter_toolbase/")
    path_retest <- "/data1/wuguojia/data/mhc_benchmark/revision/02.negtive_sample_reconstruction/"
    path_neg_raw <- paste0(path_retest,"negative_raw/")
    path_neg_ripe <- paste0(path_retest,"negative_ripe/")
##################################################################

##################################################################
#------------ create negative raw
    load(paste0(path_retest,"protein.rdata"))
    index <- subset(index, match_score >= 0.9) #leften high confidence matches
    hla_stats <- data.table(hlatype = character(), n_proteins = integer())
    for(hla in unique(protein$hlatype)){
        anti_norm <- unique(subset(protein, hlatype == hla)$antigen_norm)
        prot_norm <- unique(subset(index, antigen_norm %in% anti_norm)$protein_norm)
        prolist <- unique(subset(proref, protein_norm %in% prot_norm)$sequence)
        prolist <- prolist[!is.na(prolist) & nchar(prolist) > 0]
        if (length(prolist) > 0) {
            fasta_lines <- unlist(lapply(seq_along(prolist), function(i) {
                c(paste0(">", hla, "_seq_", i), prolist[i])
            }))
            fasta_file <- file.path(path_neg_raw, paste0(hla, ".fasta"))
            writeLines(fasta_lines, con = fasta_file)
            cat("  -> Wrote", length(prolist), "sequences to", basename(fasta_file), "\n")
        } else {
            cat("  -> No sequences found for", hla, "\n")
        }
        hla_stats <- rbind(hla_stats, data.table(hlatype = hla, n_proteins = length(prolist)))
    }
#------------ create negative ripe
    load(paste0(path_filter,"TOOL_COMBINE.Rdata"))
    load(paste0(path_extract,"DATABASE_COMBINE.Rdata"))
    # standard amino acids
    valid_amino_acids <- "^[ARNDCEQGHILKMFPSTWYV]+$"
    # output 8-11 mer directories
    peptide_lengths <- 8:11
    for (len in peptide_lengths) {
    dir.create(file.path(path_neg_ripe, paste0(len, "_aa_length")), 
                showWarnings = FALSE, recursive = TRUE)
    }
    # all input FASTA files
    fasta_files <- list.files(path_neg_raw, pattern = "\\.fasta", full.names = TRUE)
    hla_names <- tools::file_path_sans_ext(basename(fasta_files))
    # parallel processing function
    process_hla <- function(fasta_in, hla, peptide_lengths, valid_amino_acids,
                            tool_combine, database_combine, path_neg_ripe) {
    
        cat("Processing HLA:", hla, "in PID", Sys.getpid(), "\n")
        
        aa_seq_list <- readAAStringSet(fasta_in)
        if (length(aa_seq_list) == 0) {
            return(NULL)
        }
        
        results <- list()
        for (pep_len in peptide_lengths) {
            # 1.create all possible peptides of length pep_len
            all_peptides <- unlist(lapply(aa_seq_list, function(seq) {
            s <- as.character(seq)
            L <- nchar(s)
            if (L < pep_len) return(character(0))
            starts <- 1:(L - pep_len + 1)
            substring(s, starts, starts + pep_len - 1)
            }))
            
            if (length(all_peptides) == 0) {
            results[[as.character(pep_len)]] <- integer(0)
            next
            }
            
            # 2. filter valid amino acids
            is_valid <- grepl(valid_amino_acids, all_peptides)
            valid_peptides <- all_peptides[is_valid]
            
            # 3. exclude peptides in tool and database
            tool_peps <- unique(unlist(subset(tool_combine, antigen_peptide_length == pep_len) $ antigen_peptide))
            db_peps   <- unique(unlist(subset(database_combine, antigen_peptide_length == pep_len) $ antigen_peptide))
            exclude_peps <- unique(c(tool_peps, db_peps))
            final_peps <- setdiff(valid_peptides, exclude_peps)
            final_peps <- unique(final_peps)
            
            results[[as.character(pep_len)]] <- final_peps
            cat("  -> HLA", hla, ": length", pep_len, "->", length(final_peps), "peptides\n")
            
            # 4. save to FASTA
            if (length(final_peps) > 0) {
                headers <- paste0(">", hla, "_pep_", seq_along(final_peps))
                fasta_out <- c(rbind(headers, final_peps))
                out_dir <- file.path(path_neg_ripe, paste0(pep_len, "_aa_length"))
                out_file <- file.path(out_dir, paste0(hla, ".fasta"))
                writeLines(fasta_out, con = out_file)
            }
        }
        
        # summary statistics
        stats <- data.table(
            hlatype = hla,
            len_8 = length(results[["8"]]),
            len_9 = length(results[["9"]]),
            len_10 = length(results[["10"]]),
            len_11 = length(results[["11"]])
        )
        return(stats)
    }
    # run in parallel
    results_list <- mclapply(
        seq_along(fasta_files),
        function(i) {
            process_hla(
            fasta_in = fasta_files[i],
            hla = hla_names[i],
            peptide_lengths = peptide_lengths,
            valid_amino_acids = valid_amino_acids,
            tool_combine = tool_combine,
            database_combine = database_combine,
            path_neg_ripe = path_neg_ripe
            )
        },
        mc.cores = 10
    )
    results_clean <- rbindlist(results_list[!sapply(results_list, is.null)], fill = TRUE)
    fwrite(results_clean, file.path(path_neg_ripe, "negative_peptide_counts.csv"))
    cat("Done! Summary saved.\n")