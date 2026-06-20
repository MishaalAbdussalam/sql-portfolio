# Motorcycle Retail Project

## Overview
This project contains comprehensive SQL analysis of a motorcycle retail business, focusing on exploratory data analysis and advanced analytics to uncover business insights from customer, product, and sales data.

## Project Structure

### Files

#### 1. **1_motorcycle_retail_exploratory_analysis.sql**
Initial exploration and validation of the data warehouse structure.

**Key Sections:**
- Database schema exploration (tables and columns)
- Customer and product dimensions analysis
- Date range analysis (2010-2014)
- Key business metrics calculation
- Magnitude analysis by various dimensions:
  - Total sales and customers by country
  - Product categories and costs
  - Revenue generation by category and customer
- Top and bottom performing products

**Key Findings:**
- Analysis covers 4+ years of historical sales data
- Customer segmentation by geography and demographics
- Product performance rankings

---

#### 2. **2_motorcycle_retail_advanced_analytics.sql**
In-depth analytical queries with business intelligence views.

**Key Sections:**

**A. Changes Over Time Analysis**
- Yearly and monthly sales performance trends
- Sales volume seasonality patterns
- Identification of peak sales periods (end of year and June)

**B. Cumulative Growth Analysis**
- Running total of sales over time
- Business milestone tracking:
  - Reached €5M cumulative revenue in Sep-2011
  - Crossed €10M by July-2012
  - Surpassed €20M by July-2013
  - Total revenue: $€9.3M since 2010
- Year-over-year growth indicators (doubled revenue back-to-back years)

**C. Product Performance Analysis**
- Yearly product sales compared to:
  - Historical average sales
  - Previous year sales
- Performance flags: Above Avg, Below Avg, Growth, Decline
- 2013 identified as strongest year

**D. Part-to-Whole Analysis**
- Category contribution to total sales:
  - **Bikes: 96.5%** (dominant category)
  - **Accessories: 2.4%**
  - **Clothing: 1.2%**
- Highlights heavy reliance on single product category

**E. Data Segmentation**
- Products by cost range:
  - Below €100: 110 products (majority)
  - €100-€500: 101 products
  - €500-€1,000: 45 products
  - €1,000-€2,000: 34 products
  - Above €2,000: 5 products (high-end models)

- Customers by spending behavior:
  - **VIP**: 1,617 Customers (12+ months history, >€5,000 spent)
  - **Regular**: 2,039 Customers (12+ months history, ≤€5,000 spent)
  - **New**: 14,826 Customers (< 12 months history)

**F. SQL Views Created**

**report_customers** - Consolidated customer metrics:
- Customer identification and demographics (age, age groups)
- Transaction metrics (orders, quantity, products purchased)
- Customer lifecycle (lifespan, recency)
- Customer segmentation (VIP, Regular, New)
- KPIs: Average order value, Average monthly spend

**report_products** - Consolidated product metrics:
- Product identification (name, category, subcategory, cost)
- Sales metrics (quantity, revenue, orders)
- Product popularity (unique customers)
- Product lifecycle (lifespan, recency)
- Product segmentation: High-Performer (>€50K), Mid-Range (≥€10K), Low-Performer
- KPIs: Average order revenue, Average monthly revenue

---

## Key Business Insights

### Growth & Performance
-  Consistent and steady business growth over 4+ years
-  Strong year-over-year growth with doubled revenue in consecutive years
-  2013 was the peak sales year
-  2012 had lowest full-year sales (partial data for 2010 & 2014)

### Customer Base
-  Large volume of new customers (14,826) indicates strong acquisition
-  Smaller long-term customer base suggests retention opportunity
-  Recommendation: Focus on converting new customers to repeat/VIP status

### Product Portfolio
-  Heavy reliance on bikes (96.5% of revenue) - concentrated risk
-  Accessories and clothing represent growth opportunity
-  Majority of products are low-cost items (<€100)
-  Only 5 premium products (>€2,000)

### Seasonality
-  Sales peak towards end of year (holiday season effect)
-  Notable mid-year uplift in June worth monitoring
-  Recommendation: Plan inventory and marketing around seasonal patterns

---



---

## Database Schema

### Fact Tables
- **fact_sales** - Transaction-level sales data with order dates, quantities, amounts

### Dimension Tables
- **dim_customers** - Customer master data (names, birthdates, geography)
- **dim_products** - Product master data (names, categories, costs)

---

## How to Use

### Running the Analysis

1. **Start with exploratory analysis:**
   ```sql
   -- Execute 1_motorcycle_retail_exploratory_analysis.sql first
   -- This validates data quality and provides overview
   ```

2. **Then run advanced analytics:**
   ```sql
   -- Execute 2_motorcycle_retail_advanced_analytics.sql
   -- Creates views and detailed reporting
   ```

3. **Query the views:**
   ```sql
   SELECT * FROM report_customers;
   SELECT * FROM report_products;
   ```

### Common Queries

**Find top 10 customers by revenue:**
```sql
SELECT customer_number, full_name, total_sales, customer_segments
FROM report_customers
ORDER BY total_sales DESC
LIMIT 10;
```
<img src="https://github.com/MishaalAbdussalam/powerbi_portfolio/blob/main/motorcycle_retail_dashboard/screenshots/top10_customers_by_revenue.png? raw=true" width="500">

**Identify Top 5 high-performing products:**
```sql
SELECT product_name, category, total_sales, product_segment
FROM report_products
ORDER BY total_sales DESC
LIMIT 5;
```

## Business Recommendations

### 1. **Improve Customer Retention** 
**Issue:** 80.2% of customers are new (<12 months), with only 19.8% achieving VIP or Regular status.

  - Introduce a tiered loyalty program to encourage repeat purchases and increase Regular/VIP customers.
  - Launch personalized re-engagement campaigns targeting inactive customers.
  - Focus on high Customer Lifetime Value (CLV) segments to improve retention and marketing efficiency.

<img src="https://github.com/MishaalAbdussalam/powerbi_portfolio/blob/main/motorcycle_retail_dashboard/screenshots/total_customers_by_segments.png? raw=true" width="500">
---

### 2. **Diversify Revenue Streams - Expand Accessories & Clothing** 
**Issue:** 96.5% revenue from bikes creates concentrated risk; Accessories (2.4%) and Clothing (1.2%) are vastly underutilized.

  - Increase accessory and clothing sales through product bundles and checkout upselling.
  - Launch targeted campaigns for existing bike customers.
  - Aim to reduce revenue concentration by growing accessories and apparel as a share of total sales.

 <img src="https://github.com/MishaalAbdussalam/powerbi_portfolio/blob/main/motorcycle_retail_dashboard/screenshots/revenue_by_category.png?raw=true" width="500">

---

### 3. **Optimize Inventory Based on Seasonality** 
**Issue:** Significant sales variance throughout the year (peak end-of-year, mid-year dip in some months).

  - Align inventory, staffing, and marketing efforts with seasonal demand patterns.
  - Increase stock levels ahead of peak sales periods and reduce inventory during slower months.
  - Improve forecasting to minimize stockouts and excess inventory.

---

### 4. **Develop a Premium Product Strategy** 
**Issue:** Only 5 products above €2,000; untapped high-margin opportunity.

  - Expand the premium product range to target higher-income customer segments.
  - Offer premium bundles, financing options, and exclusive features.
  - Increase revenue and margins through high-value products.

---

### 5. **Improve Product Portfolio Performance** 
**Issue:** Identify and optimize Low-Performer products.

  - Regularly review underperforming products for repricing, bundling, or discontinuation.
  - Identify growth opportunities among mid-performing products.
  - Invest more heavily in top-performing products and replicate their successful attributes.
