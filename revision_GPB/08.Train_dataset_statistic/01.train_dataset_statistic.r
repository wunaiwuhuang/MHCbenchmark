##################################################################
# Script: 01.train_dataset_statistic.r
# Objective: Calculate sample sizes, positive counts, negative counts, 
#            and positive ratios for various MHC prediction tool training datasets.
# Definition: Positive = present in the comprehensive positive database.
#             Negative = absent from the comprehensive positive database.
##################################################################

library(data.table)
library(dplyr)
library(tidyr)

# 1. Define paths based on previous pipeline
path_filter <- "/data1/wuguojia/data/mhc_benchmark/toolbase/filter_toolbase/"
path_extract <- "/data1/wuguojia/data/mhc_benchmark/database/extract_database/"
out_dir <- "/home/wuguojia/biocode/mhc_benchmark/revision_GPB/08.Train_dataset_statistic/"

# Create output directory if it doesn't exist
if(!dir.exists(out_dir)) {
  dir.create(out_dir, recursive = TRUE)
  cat(sprintf("[INFO] Created output directory: %s\n", out_dir))
}

##################################################################
# 2. Load and prepare the comprehensive positive database
##################################################################
cat("[INFO] Loading DATABASE_COMBINE.Rdata...\n")
load(paste0(path_extract, "DATABASE_COMBINE.Rdata"))

# Filter for positive samples and create a unique matching key (HLA_Peptide)
cat("[INFO] Extracting positive samples to build reference dictionary...\n")
positive_db_keys <- database_combine %>%
  filter(bind_result == "positive") %>%
  mutate(key = paste(hlatype, antigen_peptide, sep = "_")) %>%
  pull(key) %>%
  unique()

cat(sprintf("[INFO] Total unique positive HLA-peptide pairs in reference: %d\n", length(positive_db_keys)))
# Free up memory
rm(database_combine)
gc()

##################################################################
# 3. Process each tool's training dataset
##################################################################
# Fetch all individual tool .Rdata files, excluding the combined one to prevent double counting
tool_files <- list.files(path_filter, pattern = "^data_.*\\.Rdata$", full.names = TRUE)
cat(sprintf("[INFO] Found %d tool datasets to process.\n", length(tool_files)))

# Initialize an empty list to store results
results_list <- list()

for (file in tool_files) {
  # Extract tool name from filename (e.g., "data_capsnetmhc.Rdata" -> "capsnetmhc")
  tool_name <- gsub("^data_(.*?)\\.Rdata$", "\\1", basename(file))
  cat(sprintf("\n[INFO] --- Processing tool: %s ---\n", tool_name))
  
  # Load the file into a temporary environment to safely extract the dataframe
  temp_env <- new.env()
  load(file, envir = temp_env)
  df_name <- ls(temp_env)[1]
  df <- get(df_name, envir = temp_env)
  
  # Ensure necessary columns exist before processing
  if(!all(c("hlatype", "antigen_peptide") %in% colnames(df))) {
    cat(sprintf("[WARN] Skipping %s: Missing 'hlatype' or 'antigen_peptide' columns.\n", tool_name))
    next
  }
  
  # Apply the exact same string standardizations used in your previous pipeline
  # This ensures the keys will match perfectly with the positive database
  df$hlatype <- gsub("([A-Z]+-[A-Z])(\\d{2}:\\d{2})", "\\1*\\2", df$hlatype)
  df$hlatype <- gsub("(HLA-[A-Z]\\*\\d{2})-(\\d{2})", "\\1:\\2", df$hlatype)
  df$hlatype <- gsub("(.*:[0-9]+).*", "\\1", df$hlatype)
  df$antigen_peptide <- gsub("[^A-Z].*", "", df$antigen_peptide)
  
  # Create the matching key
  df <- df %>% mutate(key = paste(hlatype, antigen_peptide, sep = "_"))
  
  # Calculate statistics
  total_samples <- nrow(df)
  positive_samples <- sum(df$key %in% positive_db_keys)
  negative_samples <- total_samples - positive_samples
  positive_ratio <- ifelse(total_samples > 0, positive_samples / total_samples, 0)
  
  # Log progress for this specific tool
  cat(sprintf("[INFO] %s -> Total: %d | Pos: %d | Neg: %d | Pos Ratio: %.4f\n", 
              tool_name, total_samples, positive_samples, negative_samples, positive_ratio))
  
  # Store in list
  results_list[[tool_name]] <- data.frame(
    Tool = tool_name,
    Total_Samples = total_samples,
    Positive_Samples = positive_samples,
    Negative_Samples = negative_samples,
    Positive_Ratio = round(positive_ratio, 4)
  )
}

##################################################################
# 4. Combine and save results
##################################################################
cat("\n[INFO] Compiling final statistics...\n")
final_statistics <- do.call(rbind, results_list)

out_file <- paste0(out_dir, "train_dataset_statistics.csv")
write.csv(final_statistics, out_file, row.names = FALSE)

cat(sprintf("[INFO] Script finished successfully! Results saved to:\n       %s\n", out_file))