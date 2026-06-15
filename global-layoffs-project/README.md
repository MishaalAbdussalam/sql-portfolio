# Global Layoffs Data Analysis 

## Project Overview
This project demonstrates a complete data analytics workflow: cleaning raw layoff data, standardizing formats, handling missing values, and performing exploratory data analysis (EDA) to uncover trends in workforce reductions across companies and industries.

## Files
- **Project data cleaning.sql** - Data cleaning and preparation
- **Exploratory Data Analysis.sql** - Analysis queries and insights

---

## Data Cleaning Process

### Steps Performed:

1. **Duplicate Removal**
   - Used `ROW_NUMBER()` window function to identify duplicates
   - Partitioned by all key columns (company, location, industry, date, stage, country, funds_raised_millions)
   - Deleted duplicate records, keeping only the first occurrence

2. **Data Standardization**
   - Trimmed whitespace from company names
   - Consolidated industry values (e.g., "Crypto", "Crypto Currency" → "Crypto")
   - Removed trailing periods from country names
   - Converted date strings from `'MM/DD/YYYY'` to proper DATE data type

3. **Handling Null & Blank Values**
   - Converted empty strings to NULL for consistency
   - Used self-joins to populate missing industry values from other records of the same company
   - Deleted rows where both `total_laid_off` and `percentage_laid_off` were NULL (incomplete records)

4. **Final Cleanup**
   - Removed temporary helper columns (e.g., row_num)
   - Created clean staging table for analysis

**Result**: A standardized, deduplicated dataset ready for analysis

---

## Exploratory Data Analysis (EDA)

### Key Insights Discovered:

1. **Funding Stage Impact**
   - Post-IPO stage had the most layoffs at 204132 followed by acquired at 40716 and Series C at 20017
   - Compares average percentage of workforce affected by stage with Seed stage being the largest stage afected at 0.7%

2. **Company-Level Trends**
   - Amazon had the highest total layoffs at 18158 followed by Google at 12000 and Meta at 11000
   - Year-over-year layoff patterns for specific companies
   - Tracks how companies' layoff volumes compare

3. **Temporal Patterns**
   - 2023 had the most layoffs at 125677, followed by 2022 at 160661 and 2021 at 15823
   - Rolling totals show acceleration/deceleration of layoff trends

4. **Ranking & Benchmarking**
   - Top 5 companies by layoffs per year (using DENSE_RANK)
   - Top companies within each industry (using RANK)
   - Year-over-year comparisons of company rankings

##  Technologies Used
- **SQL Dialect**: MySQL
- **Functions**: CTEs, Window Functions (ROW_NUMBER, DENSE_RANK, RANK), String Functions, Date Functions
