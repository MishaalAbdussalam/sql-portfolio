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
  - Reached $5M cumulative revenue in Sep-2011
  - Crossed $10M by July-2012
  - Surpassed $20M by July-2013
  - Total revenue: $29.3M since 2010
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
  - €100-€500
  - €500-€1,000
  - €1,000-€2,000
  - Above €2,000: 5 products (high-end models)

- Customers by spending behavior:
  - **VIP**: 1,619 (12+ months history, >€5,000 spent)
  - **Regular**: 2,037 (12+ months history, ≤€5,000 spent)
  - **New**: 14,828 (< 12 months history)

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
- ✅ Consistent and steady business growth over 4+ years
- ✅ Strong year-over-year growth with doubled revenue in consecutive years
- ⚠️ 2013 was the peak sales year
- ⚠️ 2012 had lowest full-year sales (partial data for 2010 & 2014)

### Customer Base
- 📊 Large volume of new customers (14,828) indicates strong acquisition
- 📊 Smaller long-term customer base suggests retention opportunity
- 💡 Recommendation: Focus on converting new customers to repeat/VIP status

### Product Portfolio
- 🏍️ Heavy reliance on bikes (96.5% of revenue) - concentrated risk
- 🎯 Accessories and clothing represent growth opportunity
- 📈 Majority of products are low-cost items (<€100)
- ⭐ Only 5 premium products (>€2,000)

### Seasonality
- 📅 Sales peak towards end of year (holiday season effect)
- 📅 Notable mid-year uplift in June worth monitoring
- 💡 Recommendation: Plan inventory and marketing around seasonal patterns

---

## Business Recommendations

### 1. **Customer Retention & Loyalty Program** 🎯
**Issue:** 89.7% of customers are new (<12 months), with only 21.8% achieving VIP or Regular status.

**Recommendations:**
- **Develop a tiered loyalty program:**
  - Reward repeat purchases within first 6 months to move new customers to Regular status
  - Exclusive perks for VIP customers (discounts on bikes, free accessories)
  - Track customer journey milestones (1st purchase, 5th purchase, 12-month milestone)

- **Implement targeted re-engagement campaigns:**
  - Send personalized offers to customers showing declining activity
  - Analyze churning customers to identify pain points
  - Expected outcome: Increase Regular customers from 2,037 to 5,000+ and VIP from 1,619 to 3,000+

- **Calculate Customer Lifetime Value (CLV):**
  - Focus marketing budget on highest CLV customers
  - Prioritize retention over acquisition for top 20% of customer base

---

### 2. **Diversify Revenue Streams - Expand Accessories & Clothing** 📦
**Issue:** 96.5% revenue from bikes creates concentrated risk; Accessories (2.4%) and Clothing (1.2%) are vastly underutilized.

**Recommendations:**
- **Cross-selling Strategy:**
  - Bundle complementary products (helmet + jacket bundles, maintenance kits)
  - Recommend accessories during checkout (basket upsell: average +15-20% revenue per order)
  - Target bike buyers with accessory campaigns (high conversion rate expected)

- **Product Expansion:**
  - Research trending motorcycle accessories (safety gear, tech gadgets)
  - Introduce affordable clothing line (€50-€150 range) to match existing customer base
  - Set target: Increase Accessories to 5% and Clothing to 3% within 12 months

- **Pricing Strategy Review:**
  - Analyze margin differences: bikes vs. accessories
  - Consider higher-margin accessory bundles to offset bike margin pressure

---

### 3. **Inventory & Production Planning Based on Seasonality** 📈
**Issue:** Significant sales variance throughout the year (peak end-of-year, mid-year dip in some months).

**Recommendations:**
- **Seasonal Forecasting:**
  - Increase inventory 20-30% ahead of peak seasons (Oct-Dec)
  - Plan for 40% higher staffing/logistics during Q4
  - Reduce inventory and costs during slower months

- **Marketing Calendar Alignment:**
  - Launch major campaigns 2-3 months before peak (July-August for holiday sales)
  - Create flash sales/promotions during traditionally slow months
  - Leverage June uplift with targeted mid-year campaigns

- **Supply Chain Optimization:**
  - Negotiate flexible supplier agreements for seasonal demand
  - Build 4-6 week safety stock before peak periods
  - Expected impact: Reduce stockouts by 50% and working capital by 10%

---

### 4. **Premium Product Strategy** ⭐
**Issue:** Only 5 products above €2,000; untapped high-margin opportunity.

**Recommendations:**
- **Develop Premium Tier:**
  - Expand high-end bike collection (€2,000+)
  - Target high-income customer segments (age 40+, VIP customers)
  - Market premium features: performance, exclusivity, customization

- **Premium Accessories Bundling:**
  - Create luxury bundles (premium bike + premium accessories)
  - Offer premium financing options
  - Expected margin: 25-35% higher than standard products

- **Pricing & Positioning:**
  - Conduct competitor pricing analysis
  - Test price elasticity for premium segment
  - Target: Generate 5-10% of revenue from premium products within 18 months

---

### 5. **Geographic Expansion & Localization** 🌍
**Issue:** Need to identify which countries drive highest customer value.

**Recommendations:**
- **Country-Level Analysis:**
  - Identify top 5 performing countries by revenue and customer count
  - Analyze customer lifetime value by geography
  - Assess market saturation vs. growth potential

- **Localized Marketing:**
  - Tailor product offerings to regional preferences (accessories popular in certain climates)
  - Partner with local distributors in high-potential markets
  - Create country-specific promotions

- **Customer Acquisition Cost (CAC) by Region:**
  - Compare acquisition costs vs. customer value by country
  - Allocate marketing budget to highest ROI regions
  - Expected outcome: Improve overall CAC by 15-20%

---

### 6. **Data-Driven Performance Monitoring** 📊
**Issue:** Need real-time visibility into business metrics.

**Recommendations:**
- **KPI Dashboard Development:**
  - Real-time tracking of monthly revenue targets
  - Customer acquisition vs. churn rates
  - Product performance by category and region
  - Seasonality forecasting dashboard

- **Monthly Business Reviews:**
  - Compare actual vs. forecasted performance
  - Identify underperforming products (Low-Performers) for action
  - Track customer segment migration (New → Regular → VIP)

- **Predictive Analytics:**
  - Build churn prediction model for at-risk customers
  - Forecast next month/quarter revenue with 80%+ accuracy
  - Identify upselling opportunities in customer base

---

### 7. **Product Performance Management** 🎯
**Issue:** Identify and optimize Low-Performer products.

**Recommendations:**
- **Low-Performer Review (Quarterly):**
  - Products generating <€10K revenue → consider discontinuation or repricing
  - Analyze why underperformance exists (market mismatch, poor positioning, pricing)
  - Implement corrective actions:
    - Marketing push with discounts
    - Bundle with high-performers
    - Discontinue if no improvement in 6 months

- **Mid-Range Optimization:**
  - Products generating €10K-€50K → evaluate growth potential
  - Test price increases (5-10%) for consistent performers
  - Cross-promote with High-Performers

- **High-Performer Expansion:**
  - Identify successful product features
  - Develop adjacent products with similar characteristics
  - Increase marketing spend on these proven winners

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

**Identify high-performing products:**
```sql
SELECT product_name, category, total_sales, product_segment
FROM report_products
WHERE product_segment = 'High-Performer'
ORDER BY total_sales DESC;
```

**Analyze customer segments:**
```sql
SELECT customer_segments, COUNT(*) as count, 
       ROUND(AVG(total_sales)) as avg_sales
FROM report_customers
GROUP BY customer_segments;
```

**Monitor seasonality:**
```sql
SELECT year(order_date) as years, 
       month(order_date) as months,
       sum(sales_amount) as total_sales,
       count(customer_key) as total_customers
FROM fact_sales
WHERE order_date is not null
GROUP BY year(order_date), month(order_date)
ORDER BY 1, 2;
```

---

## Requirements
- SQL database with data warehouse analytics schema
- Tables: `fact_sales`, `dim_customers`, `dim_products`
- `information_schema` access for exploration queries

---

## Notes
- Data spans from 2010 to 2014
- All sales amounts in Euros (€)
- Customer ages calculated from birthdate to current date
- Recency measured in months from last activity to current date

---

## Future Enhancements
- [ ] Product affinity analysis (frequently bought together)
- [ ] Geographic heat maps of sales by region
- [ ] Customer lifetime value (CLV) prediction model
- [ ] Churn prediction for at-risk customers
- [ ] Price elasticity analysis
- [ ] Inventory optimization based on sales patterns
- [ ] RFM (Recency, Frequency, Monetary) segmentation
- [ ] Marketing attribution modeling
