# Customer Retention & Sales Analysis Project

## 1. Project Overview

This project analyzes sales performance and customer retention behavior using the Superstore dataset.
The goal is to simulate the workflow of a real Data Analyst: cleaning raw data, storing it in a database, performing SQL analysis, and building business dashboards to generate insights.

The project focuses on understanding:

* Sales growth trends
* Customer purchasing behavior
* Customer retention and churn
* Revenue distribution across segments, regions, and product categories

The final output is an interactive Power BI dashboard with business insights and recommendations.

---

# 2. Business Objectives

The main objectives of this analysis are:

* Analyze overall sales and profit performance.
* Identify customer purchasing patterns.
* Measure customer retention and churn.
* Determine which products and segments generate the most revenue.
* Identify growth trends over time.
* Provide actionable business insights.

---

# 3. Dataset

Dataset used: **Superstore Sales Dataset**

The dataset contains transaction-level information including:

* Customer details
* Product details
* Order information
* Sales and profit values
* Shipping information
* Regional sales data

Dataset size after cleaning:

* **Rows:** 25,753
* **Columns:** 30

---

# 4. Project Architecture

Raw Dataset (CSV)
↓
Python Data Cleaning (Pandas)
↓
Clean Dataset Export
↓
PostgreSQL Database
↓
SQL Business Analysis
↓
Power BI Dashboard
↓
Business Insights & Recommendations

---

# 5. Technologies Used

### Programming

* Python
* Pandas

### Database

* PostgreSQL
* SQL

### Visualization

* Power BI

### Tools

* Jupyter Notebook
* pgAdmin

---

# 6. Data Cleaning (Python)

Data cleaning and preprocessing were performed using Python and Pandas.

Steps performed:

* Loaded CSV dataset.
* Inspected dataset structure.
* Removed duplicate records.
* Converted date columns to datetime format.
* Renamed columns to standardized format.
* Created new derived features.
* Exported cleaned dataset.

### Example

Extracting year from order date:

```
df["order_year"] = df["order_date"].dt.year
```

Example:

Order Date → 2013-05-10
Order Year → 2013

---

# 7. Database Storage

The cleaned dataset was loaded into PostgreSQL.

Table created:

```
clean_data
```

Data loading method:

```
COPY clean_data
FROM 'superstore_clean.csv'
CSV HEADER;
```

---

# 8. SQL Analysis

Several SQL queries were used to analyze business performance.

### Key KPIs

* Total Customers → **4,873**
* Total Orders → **25,035**
* Total Sales → **5.83M**
* Total Profit → **496K**
* Average Order Value → **232**

---

# 9. Sales Trend Analysis

### Yearly Sales Growth

| Year | Sales |
| ---- | ----- |
| 2011 | 1.03M |
| 2012 | 1.21M |
| 2013 | 1.57M |
| 2014 | 2.00M |

Sales increased steadily each year, indicating strong business growth.

---

# 10. Customer Analysis

### Customer Retention

Customers were analyzed to determine repeat purchasing behavior.

Retention cohort analysis shows how many customers returned after their first purchase year.

Example:

| First Purchase Year | Active Year | Customers |
| ------------------- | ----------- | --------- |
| 2011                | 2011        | 2890      |
| 2011                | 2012        | 1949      |
| 2011                | 2013        | 2187      |
| 2011                | 2014        | 2387      |

---

# 11. Churn Rate

Customers who purchased only once were considered churned customers.

Churn Rate Calculation:

Churn Rate = (Customers with only one order / Total customers) × 100

Result:

**Churn Rate ≈ 8.74%**

---

# 12. Revenue Analysis

### Revenue by Segment

| Segment     | Revenue |
| ----------- | ------- |
| Consumer    | 3.02M   |
| Corporate   | 1.74M   |
| Home Office | 1.06M   |

Consumer customers generate the highest revenue.

---

### Revenue by Category

| Category        | Revenue |
| --------------- | ------- |
| Office Supplies | 2.11M   |
| Furniture       | 1.95M   |
| Technology      | 1.75M   |

Office supplies generate the highest sales volume.

---

# 13. Dashboard Visualization

An interactive Power BI dashboard was created containing:

* KPI cards (Sales, Profit, Orders, Customers)
* Yearly and monthly sales trends
* Revenue by region
* Revenue by product category
* Customer retention cohort heatmap
* Product profitability analysis
* Sales vs Profit scatter plot

---

# 14. Key Insights

* Sales grew consistently from 2011 to 2014.
* Consumer segment generates the highest revenue.
* Office supplies drive the highest sales volume.
* Some products have high sales but low profitability.
* Customer retention is relatively strong.
* Churn rate is approximately 8.7%.

---

# 15. Business Recommendations

* Focus marketing efforts on high-value consumer customers.
* Optimize pricing or discounts for low-profit products.
* Improve retention strategies for first-time customers.
* Expand high-profit product categories.
* Target regions with strong growth potential.

---

# 16. Conclusion

This project demonstrates an end-to-end data analytics workflow including:

* Data cleaning
* SQL-based analysis
* Customer retention analytics
* Business intelligence dashboards
* Insight generation

The project simulates the tasks performed by real Data Analysts in industry environments.

---
