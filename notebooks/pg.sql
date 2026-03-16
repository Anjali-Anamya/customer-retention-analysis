-- Create table
CREATE TABLE clean_data (
category TEXT,
city TEXT,
country TEXT,
customer_id TEXT,
customer_name TEXT,
discount FLOAT,
market TEXT,
record_count INT,
order_date TIMESTAMP,
order_id TEXT,
order_priority TEXT,
product_id TEXT,
product_name TEXT,
profit FLOAT,
quantity INT,
region TEXT,
row_id INT,
sales INT,
segment TEXT,
ship_date TIMESTAMP,
ship_mode TEXT,
shipping_cost FLOAT,
state TEXT,
sub_category TEXT,
year INT,
market2 TEXT,
weeknum INT,
order_year INT,
order_month INT,
year_month TEXT
);

-- Load CSV
COPY clean_data
FROM 'C:/temp/superstore_clean.csv'
DELIMITER ','
CSV HEADER;

-- Validate
SELECT COUNT(*) FROM clean_data ;  
-- Output 25753 


-- Total No. of Customer
SELECT COUNT(DISTINCT customer_id) FROM clean_data;
-- Output 4873

-- Total No. of Orders
SELECT COUNT(DISTINCT order_id) AS total_orders
FROM clean_data;
-- Output 25035

-- Total Sales & Profit
SELECT 
    SUM(sales) AS total_sales,
    SUM(profit) AS total_profit
FROM clean_data;
-- Output 
--     total_sales=5831858	
--     total_profit=496062.86332000135831858


-- Yearly Sales Trend 

SELECT 
order_year,
SUM(sales) AS yearly_sales
FROM clean_data
GROUP BY order_year
ORDER BY order_year;

-- 2011	1035159
-- 2012	1214349
-- 2013	1578154
-- 2014	2004196

-- Monthly Sales Trend

SELECT 
year_month,
SUM(sales) AS monthly_sales
FROM clean_data
GROUP BY year_month
ORDER BY year_month;

-- "2011-01"	42098
-- "2011-02"	29146
-- "2011-03"	77791
-- "2011-04"	48533
-- "2011-05"	73327
-- "2011-06"	102836
-- "2011-07"	52513
-- "2011-08"	97702
-- "2011-09"	134161
-- "2011-10"	88039
-- "2011-11"	140583
-- "2011-12"	148430
-- "2012-01"	66447
-- "2012-02"	54284
-- "2012-03"	69451
-- "2012-04"	77593
-- "2012-05"	90285
-- "2012-06"	113185
-- "2012-07"	67390
-- "2012-08"	126356
-- "2012-09"	128078
-- "2012-10"	120336
-- "2012-11"	148692
-- "2012-12"	152252
-- "2013-01"	90456
-- "2013-02"	75617
-- "2013-03"	93748
-- "2013-04"	88813
-- "2013-05"	121432
-- "2013-06"	167495
-- "2013-07"	99394
-- "2013-08"	140969
-- "2013-09"	167207
-- "2013-10"	141260
-- "2013-11"	176112
-- "2013-12"	215651
-- "2014-01"	95505
-- "2014-02"	92896
-- "2014-03"	108439
-- "2014-04"	111718
-- "2014-05"	142447
-- "2014-06"	201488
-- "2014-07"	126591
-- "2014-08"	200170
-- "2014-09"	211858
-- "2014-10"	203578
-- "2014-11"	246475
-- "2014-12"	263031

-- Orders per Customer (Top 10)
SELECT 
customer_id,
COUNT(DISTINCT order_id) AS total_orders
FROM clean_data
GROUP BY customer_id
ORDER BY total_orders DESC
LIMIT 10;
-- "DK-130901"	18
-- "CS-121751"	17
-- "EP-139154"	17
-- "EM-139601"	16
-- "AR-108252"	15
-- "NC-186251"	15
-- "TZ-214453"	15
-- "JG-158052"	15
-- "JH-159853"	15
-- "AF-108701"	14


-- Total Revenue per Customer 

SELECT 
customer_id,
SUM(sales) AS total_spent
FROM clean_data
GROUP BY customer_id
ORDER BY total_spent DESC;

-- Average Order Value 

SELECT 
SUM(sales) / COUNT(DISTINCT order_id) AS avg_order_value
FROM clean_data;

-- Output 232

-- First Purchase Year for each Customer 

SELECT 
customer_id,
MIN(order_year) AS first_purchase_year
FROM clean_data
GROUP BY customer_id;


-- Identify Returning Customers 

SELECT 
customer_id,
COUNT(DISTINCT order_year) AS active_years
FROM clean_data
GROUP BY customer_id
HAVING COUNT(DISTINCT order_year) > 1;

-- Customers who purchased only once 

SELECT 
customer_id
FROM clean_data
GROUP BY customer_id
HAVING COUNT(DISTINCT order_id) = 1;


-- Churn Rate Calculation 

SELECT
COUNT(CASE WHEN order_count = 1 THEN 1 END) AS churned_customers,
COUNT(*) AS total_customers,
COUNT(CASE WHEN order_count = 1 THEN 1 END)*100.0 / COUNT(*) AS churn_rate
FROM (
SELECT 
customer_id,
COUNT(DISTINCT order_id) AS order_count
FROM clean_data
GROUP BY customer_id
) t;

-- Output 
-- 426	  4873	 8.7420480197003899


-- Create Customer First Purchase Table 
WITH first_purchase AS (
SELECT 
customer_id,
MIN(order_year) AS first_purchase_year
FROM clean_data
GROUP BY customer_id
)

SELECT 
f.first_purchase_year,
c.order_year,
COUNT(DISTINCT c.customer_id) AS customers
FROM clean_data c
JOIN first_purchase f
ON c.customer_id = f.customer_id
GROUP BY f.first_purchase_year, c.order_year
ORDER BY f.first_purchase_year, c.order_year;

-- Output
-- 2011	2011	2890
-- 2011	2012	1949
-- 2011	2013	2187
-- 2011	2014	2387
-- 2012	2012	1172
-- 2012	2013	838
-- 2012	2014	907
-- 2013	2013	566
-- 2013	2014	409
-- 2014	2014	245

-- Revenue per Customer 

SELECT 
customer_id,
SUM(sales) AS total_revenue
FROM clean_data
GROUP BY customer_id
ORDER BY total_revenue DESC;

-- Revenue by Customer Segment 

SELECT 
segment,
SUM(sales) AS revenue
FROM clean_data
GROUP BY segment
ORDER BY revenue DESC;

-- Output 
-- "Consumer"	3025549
-- "Corporate"	1746089
-- "Home Office"	1060220


-- Revenue by Region 

SELECT 
region,
SUM(sales) AS revenue
FROM clean_data
GROUP BY region
ORDER BY revenue DESC;

-- Output
-- "Central"	1257657
-- "South"	735703
-- "Oceania"	589279
-- "North"	563345
-- "Southeast Asia"	502267
-- "EMEA"	377233
-- "Africa"	347291
-- "North Asia"	333720
-- "Central Asia"	326117
-- "East"	315182
-- "West"	307838
-- "Caribbean"	150129
-- "Canada"	26097

-- Revenue by Product Category 

SELECT 
category,
SUM(sales) AS revenue
FROM clean_data
GROUP BY category
ORDER BY revenue DESC;
-- Output
-- "Office Supplies"	2118097
-- "Furniture"	1955707
-- "Technology"	1758054


-- Revenue by Sub Category 

SELECT 
sub_category,
SUM(sales) AS revenue
FROM clean_data
GROUP BY sub_category
ORDER BY revenue DESC;


-- Output
-- "Chairs"	723856
-- "Bookcases"	716461
-- "Appliances"	659477
-- "Phones"	632953
-- "Copiers"	546374
-- "Storage"	509500
-- "Tables"	351082
-- "Machines"	302689
-- "Accessories"	276038
-- "Binders"	227684
-- "Art"	226780
-- "Furnishings"	164308
-- "Paper"	140930
-- "Supplies"	135060
-- "Envelopes"	119691
-- "Fasteners"	53273
-- "Labels"	45702
