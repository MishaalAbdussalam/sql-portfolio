-- DATA CLEANING

SELECT*
FROM LAYOFFS;

-- 1. Remove Duplicates
-- 2. Standardize the Data
-- 3. Null Values or blank values
-- 4. Remove any Columns;


Create table layoff_staging
like layoffs;

insert layoff_staging
select*
from layoffs;

select*
from layoff_staging;


select *, row_number() over( 
partition by 
company, location, industry, total_laid_off, percentage_laid_off, `date`, stage, country, funds_raised_millions) as row_num
from layoff_staging;

with duplicate_cte as 
(select *, row_number() over( 
partition by 
company, location, industry, total_laid_off, percentage_laid_off, `date`, stage, country, funds_raised_millions) as row_num
from layoff_staging)
SELECT *
FROM DUPLICATE_CTE  
WHERE ROW_NUM > 1;

SELECT *
FROM layoff_staging
WHERE company = 'CASPER';



CREATE TABLE `layoff_staging2` (
  `company` text,
  `location` text,
  `industry` text,
  `total_laid_off` double DEFAULT NULL,
  `percentage_laid_off` text,
  `date` text,
  `stage` text,
  `country` text,
  `funds_raised_millions` int DEFAULT NULL,
  `row_num` int
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


insert into layoff_staging2
select *, row_number() over( 
partition by 
company, location, industry, total_laid_off, percentage_laid_off, `date`, stage, country, funds_raised_millions) as row_num
from layoff_staging;

delete
from layoff_staging2
where row_num > 1;

select *
from layoff_staging2;

-- standardize the data

select company, trim(company)
from layoff_staging2;

update layoff_staging2
set company = trim(company);

select company
from layoff_staging2;

select distinct industry
from layoff_staging2
order by 1;

select industry 
from layoff_staging2
where industry like 'crypto%';

update layoff_staging2
set industry = 'Crypto'
where industry like 'Crypto%';

select distinct country 
from layoff_staging2
order by 1;

select distinct country, trim(trailing '.' from country)
from layoff_staging2;

update layoff_staging2
set country = trim(trailing '.' from country)
where country = 'United States%';

select `date`
from layoff_staging2;

select `date`, 
str_to_date(`date`, '%m/%d/%Y')
from layoff_staging2;

update layoff_staging2
set `date` = str_to_date(`date`, '%m/%d/%Y');

alter table layoff_staging2
modify column `date` date;

-- Null Values or Blank Values

select *
from layoff_staging2 
where industry is null 
or industry = '';

select *
from layoff_staging2
where company = 'airbnb';

select l1.industry, l2.industry
from layoff_staging2 l1
join layoff_staging2 l2
	on l1.company = l2.company
where (l1.industry is null or l1.industry = '')
and l2.industry is not null;

update layoff_staging2
set industry = null
where industry = '';

update layoff_staging2 l1
join layoff_staging2 l2
	on l1.company = l2.company
set l1.industry = l2.industry
where l1.industry is null
and l2.industry is not null;

select *
from layoff_staging2
where total_laid_off is null
and percentage_laid_off is null;

delete
from layoff_staging2
where total_laid_off is null
and percentage_laid_off is null;

select *
from layoff_staging2;

-- remove unwanted column or rows

alter table layoff_staging2
drop column	row_num;






