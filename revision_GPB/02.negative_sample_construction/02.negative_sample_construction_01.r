##################################################################
    library(data.table)
    library(tidyr)
    library(dplyr)
    library(purrr)
    library(stringr)
    library(openxlsx)
    library(stringdist)
    library(parallel)
    #path of databases and tools
    path_test <- "/data1/wuguojia/data/mhc_benchmark/testbase/"
    path_retest <- "/data1/wuguojia/data/mhc_benchmark/revision/02.negtive_sample_reconstruction/"
##################################################################

##################################################################
#--------------------------- prepare data
    load(paste0(path_test,"TEST.Rdata")) #to extract hlatype
    load(paste0(path_test,"FILTERATION.Rdata")) #to extract protein name
    pos_mhci <- subset(filteration_mhci, hlatype %in% unique(test_mhci$hlatype))
    protein <- pos_mhci[,c("hlatype","antigen_protein")]
    protein <- distinct(protein[!(is.na(protein$antigen_protein) | trimws(protein$antigen_protein) == ""), ])
    #i decide to use swiss-prot database only,for accuracy and confidence
    proref <- distinct(fread(paste0(path_test,"uniprotkb_AND_reviewed_true_2024_09_18.tsv"))%>%.[,c("Protein names","Sequence")])
    
    setDT(protein)
    setDT(proref)
    setnames(proref, 
            old = c("Protein names", "Sequence"),
            new = c("protein_names", "sequence"),
            skip_absent = TRUE)
    
    normalize_text <- function(x) {
        x <- tolower(as.character(x))
        x <- gsub("\\s*\\[?\\s*homo\\s+sapiens\\s*\\]?\\s*", " ", x, ignore.case = TRUE)
        x <- gsub("[,;]", " ", x)
        x <- gsub("\\s+", " ", x)
        x <- trimws(x)
        return(x)
    }
    
    protein_unique <- distinct(protein[, .(antigen_protein)])
    protein_unique[, antigen_norm := normalize_text(antigen_protein)]
    protein_unique <- protein_unique[antigen_norm != ""]
    cat(sprintf("  Unique query proteins: %d\n", nrow(protein_unique)))
    
    proref_unique <- distinct(proref[, .(protein_names)])
    proref_unique[, protein_norm := normalize_text(protein_names)]
    proref_unique <- proref_unique[protein_norm != ""]
    cat(sprintf("  Unique reference proteins: %d\n", nrow(proref_unique)))
#--------------------------- match procedure
    match_proteins <- function(query_names, ref_names, max_match_num = 5, n_cores = NULL) {
        
        if (is.null(n_cores)) {
            n_cores <- max(1, detectCores() - 1)
        }
        
        cat(sprintf("Starting matching: %d queries × %d references\n", 
                    length(query_names), length(ref_names)))
        cat(sprintf("Using %d cores\n", n_cores))
        
        # 1. exact match items
        cat("Step 1: Finding exact matches...\n")
        exact_matches <- data.table(
            antigen_norm = intersect(query_names, ref_names)
        )
        exact_matches[, protein_norm := antigen_norm]
        exact_matches[, match_score := 1.0]
        
        cat(sprintf("  Found %d exact matches\n", nrow(exact_matches)))
        
        # 2. fuzzy match items
        queries_need_fuzzy <- setdiff(query_names, exact_matches$antigen_norm)
        cat(sprintf("Step 2: Fuzzy matching for %d queries...\n", length(queries_need_fuzzy)))
        
        if (length(queries_need_fuzzy) == 0) {
            return(exact_matches[, .(antigen_norm, protein_norm, match_score)])
        }
        
        # 3. batch process
        batch_size <- ceiling(length(queries_need_fuzzy) / (n_cores * 4))
        n_batches <- ceiling(length(queries_need_fuzzy) / batch_size)
        
        cat(sprintf("  Processing in %d batches (batch size: %d)\n", n_batches, batch_size))
        
        fuzzy_match_batch <- function(batch_queries) {
            results <- lapply(batch_queries, function(q) {
                # Jaro-Winkler
                distances <- stringdist(q, ref_names, method = "jw")
                scores <- 1 - distances
                
                top_idx <- order(scores, decreasing = TRUE)[1:min(max_match_num, length(scores))]
                
                data.table(
                    antigen_norm = q,
                    protein_norm = ref_names[top_idx],
                    match_score = scores[top_idx]
                )
            })
            rbindlist(results)
        }
        
        batches <- split(queries_need_fuzzy, 
                        ceiling(seq_along(queries_need_fuzzy) / batch_size))
        
        cl <- makeCluster(n_cores)
        clusterExport(cl, c("ref_names", "max_match_num"), envir = environment())
        clusterEvalQ(cl, {
            library(data.table)
            library(stringdist)
        })
        
        fuzzy_results <- parLapply(cl, batches, fuzzy_match_batch)
        stopCluster(cl)
        
        fuzzy_matches <- rbindlist(fuzzy_results)
        
        cat(sprintf("  Fuzzy matching complete: %d matches\n", nrow(fuzzy_matches)))
        
        # 5. results
        all_matches <- rbind(exact_matches, fuzzy_matches)
        
        cat(sprintf("Total matches: %d\n", nrow(all_matches)))
        
        return(all_matches[, .(antigen_norm, protein_norm, match_score)])
    }

    index <- match_proteins(
        query_names = unique(protein_unique$antigen_norm),
        ref_names = unique(proref_unique$protein_norm),
        max_match_num = 5,
        n_cores = 10
    )
    proref_unique <- subset(proref_unique, protein_norm %in% unique(index$protein_norm))
    proref <- distinct(subset(proref, protein_names %in% unique(proref_unique$protein_names)))
    protein <- left_join(protein,protein_unique,by="antigen_protein")
    proref <- left_join(proref,proref_unique,by="protein_names")
    save(protein, index, proref, file = paste0(path_retest,"protein.rdata"))
##################################################################