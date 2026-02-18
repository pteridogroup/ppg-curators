#!/usr/bin/env Rscript

# Import data from Google Sheets to CSV files
# This script reads a public Google Spreadsheet and exports each sheet as a
# separate CSV file

library(googlesheets4)
library(readr)

# Disable authentication since the spreadsheet is public
gs4_deauth()

# Google Spreadsheet ID
sheet_id <- "1E4ROaW30dj4Hig3KH8qy4p1QUuXAAUUGrZ3voGUu3hM"

# Get sheet names
sheet_names <- sheet_names(sheet_id)

cat("Found", length(sheet_names), "sheets:\n")
for (name in sheet_names) {
  cat("  -", name, "\n")
}

# Create data directory if it doesn't exist
if (!dir.exists("data")) {
  dir.create("data", recursive = TRUE)
}

# Read and export each sheet
for (sheet_name in sheet_names) {
  cat("\nProcessing sheet:", sheet_name, "\n")

  # Read the sheet
  data <- read_sheet(sheet_id, sheet = sheet_name)

  # Create safe filename from sheet name
  # Replace spaces and special characters with underscores
  safe_name <- gsub("[^[:alnum:]_-]", "_", sheet_name)
  safe_name <- gsub("_+", "_", safe_name) # Replace multiple underscores
  safe_name <- tolower(safe_name)

  # Output filename
  output_file <- file.path("data", paste0(safe_name, ".csv"))

  # Write CSV
  write_csv(data, output_file)

  cat("  Written to:", output_file, "\n")
  cat("  Rows:", nrow(data), "| Columns:", ncol(data), "\n")
}

cat("\nImport completed successfully!\n")
