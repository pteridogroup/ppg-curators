# Curators Data Repository

Automated import of data from Google Sheets to CSV files for [Pteridophyte Phylogeny Group (PPG)](https://pteridogroup.github.io/).

## Overview

This repository automatically imports data from a public Google Spreadsheet
and stores it as CSV files. The import runs daily and can also be triggered
manually.

You can find the data files here:

- [`curators.csv`](data/curators.csv): List of curator names and [ORCID iDs](https://orcid.org/)
- [`genera.csv`](data/genera.csv): List of fern and lycophyte genera and their curators

For more information about Curators in PPG, see the [Curator's Guide](https://pteridogroup.github.io/curators.html)

## Data Source

- **Google Spreadsheet**: 
  [View Spreadsheet](https://docs.google.com/spreadsheets/d/1E4ROaW30dj4Hig3KH8qy4p1QUuXAAUUGrZ3voGUu3hM/edit?usp=sharing)
- **Import Frequency**: Daily at 2 AM UTC (automatic)
- **Manual Trigger**: Available via GitHub Actions

## Repository Structure

```
.
├── data/                 # CSV files exported from Google Sheets
├── scripts/              # R scripts for data import
│   └── import_sheets.R   # Main import script
└── .github/
    └── workflows/
        └── import-sheets.yml  # GitHub Actions workflow
```

## Manual Import

To manually trigger an import:

1. Go to the [Actions tab](../../actions)
2. Select "Import Google Sheets Data" workflow
3. Click "Run workflow"
4. Click the green "Run workflow" button

## Local Development

### Prerequisites

- R (version 4.0 or higher)
- R packages: `googlesheets4`, `readr`

### Running Locally

```bash
# Install required packages (first time only)
Rscript -e 'install.packages(c("googlesheets4", "readr"))'

# Run the import script
Rscript scripts/import_sheets.R
```

The script will:
1. Connect to the Google Spreadsheet (no authentication needed for public
   sheets)
2. Read all sheets
3. Export each sheet as a CSV file in the `data/` directory

## How It Works

1. **GitHub Actions workflow** runs on a schedule (daily) or manual trigger
2. **R script** uses `googlesheets4` package to read the public spreadsheet
3. Each sheet is exported as a separate CSV file
4. Changes are automatically committed to the repository
5. If no changes are detected, no commit is made

## Notes

- The spreadsheet is public, so no authentication credentials are needed
- CSV files are tracked in git and will show in commit history
- The workflow only commits when data actually changes
- Created with help from Claude Sonnet 4.5 in VSCode