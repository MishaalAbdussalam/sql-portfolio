-- ADVANCE DATA ANALYTICS
-- Changes Over Time Analysis

-- Analyze sales performance over time

select year(order_date) as years, 
sum(sales_amount) as total_sales,
count(customer_key) as total_customers
from fact_sales
where order_date is not null
group by year(order_date)
order by 1;

-- 2013 had the most sales and 2010 & 2014 has only 1 month of data, so the least sales in a whole year is 2012.

-- By months
select year(order_date) as years, 
month(order_date) as months,
sum(sales_amount) as total_sales,
count(customer_key) as total_customers
from fact_sales
where order_date is not null
group by year(order_date), month(order_date)
order by 3 desc;

-- Sales volume tends to peak toward the end of the year, consistent with seasonal demand patterns.
-- June also shows a notable uplift in sales, suggesting a mid-year trend worth monitoring

-- CUMULATIVE ANALYSIS(Whether business is growing or declining)
-- Calculate the total sales per month and the running total of sales over time

with running_totalcte as
(select substring(order_date, 1, 7) as months, 
sum(sales_amount) as total_sales
from fact_sales
where order_date is not null
group by substring(order_date, 1, 7)
)
select *, sum(total_sales) over ( order by months) as running_total
from running_totalcte;


-- by years
with running_totalcte as
(select year(order_date) as years, 
sum(sales_amount) as total_sales
from fact_sales
where order_date is not null
group by year(order_date)
)
select *, sum(total_sales) over (order by years) as running_total
from running_totalcte;

/* The business has generated a total of 29.3 million since 2010. The business crossed 5M cumulative revenue milestone in Sep-2011,
reached 10M by July-2012 and surpassed 20M by July 2013. The business showcases consistent and steady growth. 
Notably, the business doubled its total revenue in back to back years, a strong indicator of healthy and sustained growth */

-- PERFORMANCE ANALYSIS
/* Analyze the yearly performance of products by comparing each product's sales to both its average sales performance and the 
previous year sales */

with product_sales as 
(select year(order_date) as years, 
product_name, 
sum(sales_amount) as current_sales
from fact_sales f
join dim_products p
	on f.product_key = p.product_key
where year(order_date) is not null
group by year(order_date), product_name
)
select years,
product_name,
current_sales,
round(avg(current_sales) over(partition by product_name)) as avg_sales,
current_sales - round(avg(current_sales) over(partition by product_name)) as diff_avg,
case 
	when current_sales - round(avg(current_sales) over(partition by product_name)) > 0 then 'Above Avg'
	when current_sales - round(avg(current_sales) over(partition by product_name)) < 0 then 'Below Avg'
    else 'Avg'
 end avg_change ,
lag(current_sales) over(partition by product_name order by years) as prev_yr,
current_sales - lag(current_sales) over(partition by product_name order by years) as diff_py,
case 
	when current_sales - lag(current_sales) over(partition by product_name order by years) > 0 then 'Growth'
    when current_sales - lag(current_sales) over(partition by product_name order by years) < 0 then 'Decline'
    else 'No Change'
end py_change
from product_sales;

/* This analysis evaluates each product's yearly sales performance by comparing it against two benchmarks - its historical average and the prior year's sales. 
For each product and year, the results show whether performance was above or below both reference points, giving a clearer picture of growth trends beyond just raw sales numbers.
2013 stands out as the strongest year across the dataset, with the majority of products recording positive variance against both their historical average and the previous year. This aligns with the earlier finding that 2013 contributed the highest single-year revenue in the dataset.
Products were flagged as 'Above Avg' or 'Below Avg' against their historical performance, and 'Growth' or 'Decline' relative to the prior year,making it straightforward to identify which products improved, which slipped, and which consistently outperformed.*/

 -- PART-TO-WHOLE ANALYSIS
 
 -- which category contribute the most to overall sales
 with cte_example as
 (select category, 
 sum(sales_amount) as total_sales
 from dim_products p
 join fact_sales s
	on p.product_key = s.product_key
group by category
order by 2 desc)
select *, 
sum(total_sales) over() as overall_sales,
concat(round(total_sales/ sum(total_sales) over() * 100, 2),'%')
from cte_example;

/* Bike contributes to 96.5% of the total sales whereas accessories and clothing contributes 2.4% and 1.2% respectively,
highlighting a heavy reliance on a single product category for overall business performance.*/

-- DATA SEGMENTATAION

-- segment products into cost ranges and count how many products fall into each segment

with cte_example as (
select cost, product_id,
case
	WHEN cost < 100 then 'Below 100' 
	WHEN cost >= 100 AND cost < 500  THEN '100 to 500'
    WHEN cost BETWEEN 500 AND 1000 THEN  '500 to 1000'
    when cost BETWEEN 1000 AND 2000 THEN '1000 to 2000'
    else 'Above 2000'
end cost_range
from dim_products
)
select cost_range,
count(product_id) as total_products
from cte_example
group by cost_range
order by 2 desc; 

-- Majority of the products are below 100 euros, with 110 products falling in this range. This is largely driven by the accessories category.
-- Only 5 products above 2000, representing higher end bike models.

/* Group customers into 3 segments based on their spending behaviour:
  - VIP: Customers with at least 12 months of history and spending more than 5000 euros.
  - Regular: Customers with at least 12 months of history but spending 5000euros or less.
  - New: Custometrs with a lifespan less than 12 months.
And find the total number of customers by each group. 
*/

with products_range as (
select customer_id,  
min(order_date) as first_order , 
Max(order_date)as last_order,
timestampdiff(month, min(order_date), Max(order_date)) as lifespan,
sum(sales_amount) as total_sales
from dim_customers c
join fact_sales s
	on c.customer_key = s.customer_key
group by customer_id
),
customer_cte as (
select customer_id,
case 
	when lifespan >= 12 and total_sales > 5000 then 'VIP'
    when lifespan >= 12 and total_sales <= 5000 then 'Regular'
    else 'New'
end groupings
from products_range)
select groupings, count(customer_id) as total_customers
from customer_cte
group by groupings;

/*Most of ou cutomers are New(less than 12 months), they make up the largest at 14828. Regular customers, those with at least 12 months of history and 
spending 5000 or more account for 2037.VIP customers with at least 12 months of history and spent more than 5000 represent 1619.
High volume of new customers reflects strong acquisition and smaller long term customers suggest there may be an opportunity to improve retention.*/ 

/* 
==================================================================================================================
CUSTOMER REPORT
==================================================================================================================
Purpose:
	- This report consolidates key customer metrics and behaviours
    
Highlights:
	1. Gathers essential fields such as names, ages, and transaction details.
	2. Segments customers into categories(VIP, Regular, New) and age groups.
	3. Aggregates customer-level metrics:
		- total orders
		- total sales
        - total quantity purchased
        - total products
        - lifespan (in months)
	4. Calculates valuable KPIs:
		- recency (months since last order)
        - average order value
		- average monthly spend
=====================================================================================================================
*/

create view report_customers as
with base_query as (
-- 1) Base query: Retrieves core columns from tables
select 
order_number,
product_key,
order_date,
quantity,
sales_amount,
concat(first_name, ' ', last_name) as full_name,
timestampdiff(year, birthdate, curdate()) as age,
c.customer_key,
customer_number
from fact_sales s
join dim_customers c
	on c.customer_key = s.customer_key
where order_date is not null),
customer_aggregation as (
-- 2) Customer Aggregations: Summarizes key metrics at the customer level.
select 
	customer_key,
	customer_number, 
	full_name,
	age,
	sum(sales_amount) as total_sales,
	count(distinct order_number) as total_orders,
	sum(quantity) as total_quantity,
	count(product_key) as total_products,
	max(order_date) as last_order_date,
	timestampdiff(month, min(order_date), max(order_date)) as lifespan
from base_query
group by 
	customer_key,
	customer_number, 
	full_name,
	age )
select 
customer_key,
customer_number, 
full_name,
age,
total_sales,
total_orders,
total_quantity,
total_products,
last_order_date,
lifespan,
timestampdiff(month, last_order_date, curdate()) as recency,
case
	when age < 20 then 'Under 20'
    when age between 20 and 29 then '20-29'
	when age between 30 and 39 then '30-39'
    when age between 40 and 49 then '40-49'
    else 'Above 50'
end as age_group,
case 
	when lifespan >= 12 and total_sales > 5000 then 'VIP'
    when lifespan >= 12 and total_sales <= 5000 then 'Regular'
    else 'New'
end customer_segments,
-- compute average order value
case
	when total_sales = 0 then 0
    else round(total_sales/total_orders)
end avg_order_value,
case
	when lifespan = 0 then total_sales
    else round(total_sales/lifespan)
end avg_monthly_spend
from customer_aggregation;

/* 
==============================================================================================================
Product Report
==============================================================================================================
Purpose:
	- This report consolidates key product metrics and behaviours.

Highlights:
	1. Gathers essential fields such as product name, category, subcategory, and cost.
    2. Segments products by revenue to identify High-Performers, Mid-Range, or Low-Performers.
    3. Aggregates product-level metrics:
		- total orders
        - total sales
        - total quantity sold
        - total customers (unique)
        - lifespan (in months)
	4. Calculates valuable KPIss:
		- recency (months since last sale)
        - average order revenue (AOR)
        - average monthly revenue
===================================================================================================================
 */    
 
create view report_products as
 with base_query_p as ( 
 select 
	 product_name,
	 category,
	 subcategory,
	 cost,
     quantity,
	 sales_amount,
	 order_number,
     order_date,
	 customer_key
 from fact_sales s
 join dim_products p
	on s.product_key = p.product_key
    where order_date is not null), -- only consider valid sales date
product_aggregation as (
select 
     product_name,
	 category,
	 subcategory,
     cost,
     sum(quantity) as total_quantity,
	 sum(sales_amount) as total_sales,
	 count(distinct order_number) as total_orders,
	 count(distinct customer_key) as total_customers,
     max(order_date) as last_sale_date,
	 timestampdiff(month, min(order_date), max(order_date)) as lifespan
from base_query_p
group by 
	product_name,
	category,
	subcategory,
    cost)
select 
	 product_name,
	 category,
	 subcategory,
     total_quantity,
	 cost,
	 total_sales,
	 total_orders,
	 total_customers,
	 lifespan,
case 
	when total_sales > 50000 then 'High-Performer'
    when total_sales >=10000 then 'Mid-Range'
    else 'Low-Performer'
end as product_segment,
timestampdiff(month, last_sale_date, curdate()) as recency,
-- Average order revenue
case 
	when total_orders = 0 then 0
    else round(total_sales/total_orders)
end avg_order_revenue,
-- Average monthly revenue
case
	when lifespan = 0 then total_sales
	else round(total_sales/lifespan)
end as avg_monthly_revenue
from product_aggregation;

 select *
 from report_products;