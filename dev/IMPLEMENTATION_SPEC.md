# Google Sheets to CSV Import - Implementation Spec

## Overview

Automate the import of data from a public Google Spreadsheet into this
repository as CSV files using R and GitHub Actions.

## Source Data

- **Google Spreadsheet URL**: 
  https://docs.google.com/spreadsheets/d/1E4ROaW30dj4Hig3KH8qy4p1QUuXAAUUGrZ3voGUu3hM/edit?usp=sharing
- **Number of sheets**: 2
- **Output format**: CSV files (one per sheet)

## Technical Approach

### R Script

Create an R script that:

1. Uses the `googlesheets4` package to read from the public spreadsheet
2. Reads each sheet from the spreadsheet
3. Exports each sheet as a separate CSV file
4. Uses `gs4_deauth()` since the spreadsheet is publicly accessible (no
   authentication needed)

**Script location**: `scripts/import_sheets.R`

**Output location**: `data/` directory
- `data/sheet1.csv` (name TBD based on actual sheet name)
- `data/sheet2.csv` (name TBD based on actual sheet name)

### GitHub Actions Workflow

Create a workflow that:

1. **Trigger mechanisms**:
   - Manual trigger via `workflow_dispatch`
   - Scheduled trigger (e.g., daily) via `schedule` cron
   - Note: Google Sheets doesn't support webhooks directly, so we'll use
     scheduled runs
   
2. **Workflow steps**:
   - Checkout the repository
   - Setup R environment
   - Install required R packages (`googlesheets4`, `readr`)
   - Run the import script
   - Commit and push changes if CSV files have changed
   
3. **Workflow location**: `.github/workflows/import-sheets.yml`

## Implementation Tasks

- [ ] Create R script to fetch and export data
- [ ] Create `data/` directory for CSV outputs
- [ ] Create GitHub Actions workflow file
- [ ] Add `.gitignore` if needed
- [ ] Add README documentation
- [ ] Test the workflow

## Dependencies

### R Packages
- `googlesheets4` - for reading Google Sheets
- `readr` - for writing CSV files (optional, base R can also work)

### GitHub Actions
- `actions/checkout@v3` - for checking out the repo
- `r-lib/actions/setup-r@v2` - for setting up R environment

## Notes

- The spreadsheet is public, so no authentication secrets are needed
- CSV files will be committed to the repository
- The workflow will only commit if there are actual changes to the data
- Consider adding a commit message that includes timestamp and identifies
  the source

## Future Enhancements

- Add data validation checks
- Send notifications on data changes
- Add error handling and logging
- Consider using GitHub API to detect if sheets were modified before
  running the import
