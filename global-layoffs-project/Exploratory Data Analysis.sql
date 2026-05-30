-- Exploratory Data Analysis

select*
from layoff_staging2;

-- Which stage had most layoffs
select stage , sum(total_laid_off)
from layoff_staging2
group by stage
having stage is not null
order by 2 desc;

select company, sum(total_laid_off)
from layoff_staging2
group by company
order by 2 desc;

select company, year(`date`), sum(total_laid_off) 
from layoff_staging2
group by company, year(`date`)
HAVING COMPANY = 'GOOGLE'
order by 2 desc;

SELECT stage, ROUND(avg(PERCENTAGE_LAID_OFF),2)
FROM layoff_staging2
GROUP BY stage
ORDER BY 2 DESC;

select min(`date`), max(`date`) 
from layoff_staging2;

select industry, sum(total_laid_off)
from layoff_staging2
group by industry
order by 2 desc;

select *
from layoff_staging2;

select year(`date`), sum(total_laid_off)
from layoff_staging2
group by year(`date`)
order by 1 desc;


select substring(`date`, 1, 7) as `month`, sum(total_laid_off)
from layoff_staging2
where substring(`date`, 1, 7)  is not null
group by `month`
order by 1 ;

with cte_example as 
(select substring(`date`, 1, 7) as `month`, sum(total_laid_off) as sum_laidoff
from layoff_staging2
where substring(`date`, 1, 7)  is not null
group by `month`
order by 1 )
select *, sum(sum_laidoff) over (order by `month`) as rolling_total
from cte_example ;

select company, year(`date`), sum(total_laid_off)
from layoff_staging2
group by company, year(`date`)
order by 3 desc;

with company_cte ( company, years, total_laid_off) as
(select company, year(`date`), sum(total_laid_off)
from layoff_staging2
group by company,  year(`date`)
order by 3 desc), 
company_year_rank as
(select *, dense_rank() over(partition by years order by total_laid_off desc) as ranking
from company_cte
where years is not null)
select *
from company_year_rank
where ranking <= 5;

select*
from layoff_staging2;

with cte_example3 as
(select industry, company , sum(total_laid_off) as total_off , rank() over(partition by industry order by sum(total_laid_off)) as ranking
from layoff_staging2
group by industry, company)
select *
from cte_example3
where ranking <= 3;



