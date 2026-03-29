#!/usr/bin/env Rscript

# Load required library for command-line arguments
library(optparse)

# Define command-line options
option_list <- list(
  make_option(c("-o", "--output"), type = "character", default = "./",
              help = "Output directory path [default = %default]", metavar = "PATH"),
  make_option(c("-t", "--target"), type = "character", default = "1_vs_4",
              help = "Target directory to analyze (e.g., 1_vs_1, 1_vs_4, 1_vs_9, 1_vs_99) [default = %default]", 
              metavar = "DIR"),
  make_option(c("-n", "--name"), type = "character", default = NULL,
              help = "Output file name (without extension). If not specified, will use 'summary_<target_dir>' [default = summary_<target>]", 
              metavar = "NAME")
)

# Parse arguments
opt_parser <- OptionParser(
  option_list = option_list,
  description = "\nGenerate resource usage summary from log files in specified directory.",
  epilogue = "\nExample usage:\n  Rscript summary.r -o ./ -t 1_vs_4 -n summary_1_vs_4\n  Rscript summary.r -t 1_vs_9\n"
)
opt <- parse_args(opt_parser)

# Set default output name if not provided
if (is.null(opt$name)) {
  opt$name <- paste0("summary_", opt$target)
}

# Function to parse time string to seconds
parse_time_to_seconds <- function(time_str) {
  if (is.na(time_str) || time_str == "") return(NA)
  
  proto <- data.frame(h = numeric(), m = numeric(), s = numeric())
  parsed <- strcapture("(?:(\\d+)h)?\\s*(?:(\\d+)m)?\\s*(?:(\\d+)s)?", 
                       time_str, proto, perl = TRUE)
  
  with(parsed, h * 3600 + m * 60 + s)
}

# Function to format seconds back to readable time
format_seconds_to_time <- function(seconds) {
  if (is.na(seconds) || is.nan(seconds) || seconds < 0) {
    return(NA)
  }
  
  hours <- floor(seconds / 3600)
  minutes <- floor((seconds %% 3600) / 60)
  secs <- round(seconds %% 60)
  
  if (hours > 0) {
    return(sprintf("%dh %dm %ds", hours, minutes, secs))
  } else if (minutes > 0) {
    return(sprintf("%dm %ds", minutes, secs))
  } else {
    return(sprintf("%ds", secs))
  }
}

# Extract average CPU from monitor.log
get_average_cpu_from_monitor <- function(monitor_file) {
  if (!file.exists(monitor_file)) return(NA)
  
  df <- read.csv(monitor_file, header = TRUE, stringsAsFactors = FALSE)
  
  if (nrow(df) == 0) return(NA)
  
  cpu_col <- grep("Total_CPU", names(df), value = TRUE)
  if (length(cpu_col) == 0) return(NA)
  
  avg_cpu <- mean(df[[cpu_col]], na.rm = TRUE)
  return(avg_cpu)
}

# Function to parse a single resource log file
parse_resource_log <- function(log_file) {
  if (!file.exists(log_file)) {
    return(list(
      status = "Waiting",
      peak_cpu = NA,
      peak_memory = NA,
      peak_rss = NA,
      total_wall_time = NA
    ))
  }
  
  content <- readLines(log_file, warn = FALSE)
  
  # Check status
  has_finished <- any(grepl("^Finished at:", content))
  has_started <- any(grepl("^Started at:", content))
  
  if (has_finished) {
    status <- "Complete"
  } else if (has_started) {
    status <- "Ongoing"
  } else {
    status <- "Waiting"
  }
  
  # Extract metrics
  peak_cpu <- NA
  peak_memory <- NA
  peak_rss <- NA
  total_wall_time <- NA
  
  # Peak CPU usage
  cpu_line <- grep("^Peak CPU usage:", content, value = TRUE)
  if (length(cpu_line) > 0) {
    cpu_match <- regmatches(cpu_line, regexpr("([0-9.]+)%", cpu_line))
    if (length(cpu_match) > 0) {
      peak_cpu <- as.numeric(gsub("%", "", cpu_match))
    }
  }
  
  # Peak Memory usage
  mem_line <- grep("^Peak Memory usage:", content, value = TRUE)
  if (length(mem_line) > 0) {
    mem_match <- regmatches(mem_line, regexpr("([0-9.]+)%", mem_line))
    if (length(mem_match) > 0) {
      peak_memory <- as.numeric(gsub("%", "", mem_match))
    }
  }
  
  # Peak RSS
  rss_line <- grep("^Peak RSS \\(Memory\\):", content, value = TRUE)
  if (length(rss_line) > 0) {
    mb_match <- regmatches(rss_line, regexpr("\\(([0-9.]+) MB\\)", rss_line))
    if (length(mb_match) > 0) {
      peak_rss <- as.numeric(gsub("\\(|\\)|MB", "", mb_match))
    }
  }
  
  # Total wall time
  time_line <- grep("^Total wall time:", content, value = TRUE)
  if (length(time_line) > 0) {
    time_match <- regmatches(time_line, regexpr(":\\s*(.+)$", time_line))
    if (length(time_match) > 0) {
      time_str <- trimws(gsub(":", "", time_match))
      total_wall_time <- time_str
    }
  }
  
  return(list(
    status = status,
    peak_cpu = peak_cpu,
    peak_memory = peak_memory,
    peak_rss = peak_rss,
    total_wall_time = total_wall_time
  ))
}

# Main function to generate summary for a directory
generate_summary <- function(target_dir) {
  # Get all resource log files
  log_files <- list.files(target_dir, pattern = "_resource\\.log$", full.names = TRUE)
  
  tool_names <- gsub("_resource\\.log$", "", basename(log_files))
  
  all_command_files <- list.files(target_dir, pattern = "_command\\.sh$", full.names = FALSE)
  all_tools <- gsub("_command\\.sh$", "", all_command_files)
  
  all_tools_unique <- unique(c(tool_names, all_tools))
  
  results <- list()
  
  for (tool in all_tools_unique) {
    log_file <- file.path(target_dir, paste0(tool, "_resource.log"))
    monitor_file <- file.path(target_dir, paste0(tool, "_monitor.log"))
    
    parsed <- parse_resource_log(log_file)
    
    # Get average CPU from monitor.log
    avg_cpu <- get_average_cpu_from_monitor(monitor_file)
    
    # Format Average CPU as string with %
    avg_cpu_str <- ifelse(is.na(avg_cpu), NA, sprintf("%.2f%%", avg_cpu))
    
    # Calculate theoretic time using AVERAGE CPU (not peak!)
    theoretic_time <- NA
    if (!is.na(parsed$total_wall_time) && !is.na(avg_cpu) && avg_cpu > 0) {
      wall_time_seconds <- parse_time_to_seconds(parsed$total_wall_time)
      if (!is.na(wall_time_seconds) && wall_time_seconds > 0) {
        total_cpu_seconds <- wall_time_seconds * avg_cpu / 100
        theoretic_time <- format_seconds_to_time(total_cpu_seconds)
      }
    }
    
    # Also keep peak CPU for reference (optional)
    peak_cpu_str <- ifelse(is.na(parsed$peak_cpu), NA, paste0(sprintf("%.2f", parsed$peak_cpu), "%"))
    
    results[[tool]] <- data.frame(
      Tool = tool,
      Status = parsed$status,
      Average_CPU_usage = avg_cpu_str,          # NEW COLUMN
      Peak_CPU_usage = peak_cpu_str,            # Keep old for comparison
      Peak_Memory_usage = ifelse(is.na(parsed$peak_memory), NA, paste0(sprintf("%.2f", parsed$peak_memory), "%")),
      Peak_RSS = ifelse(is.na(parsed$peak_rss), NA, paste0(sprintf("%.2f", parsed$peak_rss), " MB")),
      Total_wall_time = parsed$total_wall_time,
      Theoretic_time = theoretic_time,
      stringsAsFactors = FALSE
    )
  }
  
  summary_table <- do.call(rbind, results)
  rownames(summary_table) <- NULL
  
  # Sort by status and tool name
  summary_table$Status <- factor(summary_table$Status, levels = c("Complete", "Ongoing", "Waiting"))
  summary_table <- summary_table[order(summary_table$Status, summary_table$Tool), ]
  summary_table$Status <- as.character(summary_table$Status)  # Convert back to character for output
  
  return(summary_table)
}

# Main execution
cat("=====================================\n")
cat("Resource Usage Summary Generator \n")
cat("=====================================\n")
cat(sprintf("Target directory: %s\n", opt$target))
cat(sprintf("Output directory: %s\n", opt$output))
cat(sprintf("Output file name: %s\n", opt$name))
cat("=====================================\n\n")

if (!dir.exists(opt$target)) {
  stop(sprintf("Error: Target directory '%s' does not exist!", opt$target))
}

if (!dir.exists(opt$output)) {
  dir.create(opt$output, recursive = TRUE)
  cat(sprintf("Created output directory: %s\n", opt$output))
}

cat("Parsing resource and monitor log files...\n")
summary_df <- generate_summary(opt$target)

cat("\n")
print(summary_df)
cat("\n")

# Save to CSV
csv_file <- file.path(opt$output, paste0(opt$name, ".csv"))
write.csv(summary_df, csv_file, row.names = FALSE)
cat(sprintf("✓ Summary saved to: %s\n", csv_file))
cat("Summary generation completed!\n")
cat("=====================================\n")