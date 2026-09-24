-- use smartsale;
-- SELECT COUNT(*) AS total_rows FROM train;
-- DESCRIBE train;

/*SELECT
    COUNT(*) AS total_rows,
    COUNT(Store) AS Store,
    COUNT(DayOfWeek) AS DayOfWeek,
    COUNT(Date) AS Date,
    COUNT(Sales) AS Sales,
    COUNT(Customers) AS Customers,
    COUNT(Open) AS Open,
    COUNT(Promo) AS Promo,
    COUNT(StateHoliday) AS StateHoliday,
    COUNT(SchoolHoliday) AS SchoolHoliday
FROM train; */

/*SELECT
    COUNT(*) AS total_rows,
    COUNT(DISTINCT Store, DayOfWeek, Date, Sales, Customers, Open, Promo, StateHoliday, SchoolHoliday) AS unique_rows
FROM train; */

/* SELECT
    MIN(Sales) AS min_sales,
    MAX(Sales) AS max_sales,
    AVG(Sales) AS avg_sales
FROM train; */

-- SELECT COUNT(DISTINCT Store) AS total_stores FROM train;

/* SELECT COUNT(*) AS open_records
FROM train
WHERE Open = 1; */

/* SELECT COUNT(*) AS closed_records
FROM train
WHERE Open = 0; */

-- Task 1 — Average Sales by Store

/* SELECT
    Store,
    AVG(Sales) AS avg_sales
FROM train
GROUP BY Store
ORDER BY avg_sales DESC; */

-- Top 10 Stores

/* SELECT
    Store,
    AVG(Sales) AS avg_sales
FROM train
GROUP BY Store
ORDER BY avg_sales DESC
LIMIT 10; */

-- Bottom 10 Stores

/* SELECT
    Store,
    AVG(Sales) AS avg_sales
FROM train
GROUP BY Store
ORDER BY avg_sales ASC
LIMIT 10; */

-- Store-wise Total Sales

/* SELECT
    Store,
    SUM(Sales) AS total_sales
FROM train
GROUP BY Store
ORDER BY total_sales DESC
LIMIT 10; */

-- Store-wise Average Customers

/* SELECT
    Store,
    AVG(Customers) AS avg_customers
FROM train
GROUP BY Store
ORDER BY avg_customers DESC
LIMIT 10; */

-- Store-wise Average Sales and Customers

/* SELECT
    Store,
    AVG(Sales) AS avg_sales,
    AVG(Customers) AS avg_customers
FROM train
GROUP BY Store
ORDER BY avg_sales DESC
LIMIT 10; */

-- Store-wise Record Count

/* SELECT
    Store,
    COUNT(*) AS record_count
FROM train
GROUP BY Store
ORDER BY record_count DESC
LIMIT 10; */


-- Store-wise Sales Variation

/* SELECT
    Store,
    STDDEV(Sales) AS sales_stddev
FROM train
GROUP BY Store
ORDER BY sales_stddev DESC
LIMIT 10; */

-- Promo-wise Average Sales

/* SELECT
    Promo,
    AVG(Sales) AS avg_sales
FROM train
GROUP BY Promo
ORDER BY Promo; */

-- State Holiday-wise Average Sales

/* SELECT
    StateHoliday,
    AVG(Sales) AS avg_sales
FROM train
GROUP BY StateHoliday
ORDER BY avg_sales DESC; */

-- School Holiday-wise Average Sales

/* SELECT
    SchoolHoliday,
    AVG(Sales) AS avg_sales
FROM train
GROUP BY SchoolHoliday
ORDER BY SchoolHoliday; */

-- Promo and State Holiday-wise Average Sales

/* SELECT
    Promo,
    StateHoliday,
    AVG(Sales) AS avg_sales
FROM train
GROUP BY Promo, StateHoliday
ORDER BY Promo, StateHoliday; */

-- Store-wise Average Customers

/* SELECT
    Store,
    AVG(Customers) AS avg_customers
FROM train
GROUP BY Store
ORDER BY avg_customers DESC
LIMIT 10; */

-- Store-wise Average Customers and Sales

/* SELECT
    Store,
    AVG(Customers) AS avg_customers,
    AVG(Sales) AS avg_sales
FROM train
GROUP BY Store
ORDER BY avg_customers DESC
LIMIT 10; */

-- Customer Count-wise Total Sales

/* SELECT
    Customers,
    SUM(Sales) AS total_sales
FROM train
GROUP BY Customers
ORDER BY Customers DESC
LIMIT 10; */

-- Customer Count-wise Average Sales

/* SELECT
    Customers,
    AVG(Sales) AS avg_sales
FROM train
GROUP BY Customers
ORDER BY Customers DESC
LIMIT 10; */

-- Store-wise Maximum Sales

/* SELECT
    Store,
    MAX(Sales) AS max_sales
FROM train
GROUP BY Store
ORDER BY max_sales DESC
LIMIT 10; */

-- Date-wise Total Sales

/* SELECT
    Date,
    SUM(Sales) AS total_sales
FROM train
GROUP BY Date
ORDER BY Date
LIMIT 10; */

-- Date-wise Average Sales

/* SELECT
    Date,
    AVG(Sales) AS avg_sales
FROM train
GROUP BY Date
ORDER BY Date
LIMIT 10; */

-- Date-wise Maximum Sales

/* SELECT
    Date,
    MAX(Sales) AS max_sales
FROM train
GROUP BY Date
ORDER BY Date
LIMIT 10; */

-- Date-wise Minimum Sales

/* SELECT
    Date,
    MIN(Sales) AS min_sales
FROM train
GROUP BY Date
ORDER BY Date
LIMIT 10; */
-- Date-wise Sales Range

/* SELECT
    Date,
    MAX(Sales) - MIN(Sales) AS sales_range
FROM train
GROUP BY Date
ORDER BY Date
LIMIT 10; */

-- Date-wise Record Count

/* SELECT
    Date,
    COUNT(*) AS record_count
FROM train
GROUP BY Date
ORDER BY Date
LIMIT 10; */

-- Date-wise Average Customers

/* SELECT
    Date,
    AVG(Customers) AS avg_customers
FROM train
GROUP BY Date
ORDER BY Date
LIMIT 10; */

-- Date-wise Total Customers

/* SELECT
    Date,
    SUM(Customers) AS total_customers
FROM train
GROUP BY Date
ORDER BY Date
LIMIT 10; */

-- Date-wise Promo Count

/* SELECT
    Date,
    COUNT(*) AS promo_count
FROM train
WHERE Promo = 1
GROUP BY Date
ORDER BY Date
LIMIT 10; */

-- Store-wise Sales and Customers Ranking

/* SELECT
    Store,
    AVG(Sales) AS avg_sales,
    AVG(Customers) AS avg_customers,
    RANK() OVER (ORDER BY AVG(Sales) DESC) AS sales_rank
FROM train
GROUP BY Store
ORDER BY sales_rank
LIMIT 10; */

-- Store-wise Average and Maximum Sales Difference

/* SELECT
    Store,
    AVG(Sales) AS avg_sales,
    MAX(Sales) AS max_sales,
    MAX(Sales) - AVG(Sales) AS sales_difference
FROM train
GROUP BY Store
ORDER BY sales_difference DESC
LIMIT 10; */

-- Store-wise Promo Performance

/* SELECT
    Store,
    AVG(CASE WHEN Promo = 0 THEN Sales END) AS avg_sales_no_promo,
    AVG(CASE WHEN Promo = 1 THEN Sales END) AS avg_sales_promo
FROM train
GROUP BY Store
ORDER BY avg_sales_promo DESC
LIMIT 10; */
-- Store-wise Sales and Customer Ranking

/* SELECT
    Store,
    AVG(Sales) AS avg_sales,
    AVG(Customers) AS avg_customers,
    RANK() OVER (ORDER BY AVG(Sales) DESC) AS sales_rank,
    RANK() OVER (ORDER BY AVG(Customers) DESC) AS customer_rank
FROM train
GROUP BY Store
ORDER BY sales_rank
LIMIT 10; */

-- High Sales and Low Customers Stores

/* SELECT
    Store,
    AVG(Sales) AS avg_sales,
    AVG(Customers) AS avg_customers
FROM train
GROUP BY Store
HAVING AVG(Sales) > 10000
   AND AVG(Customers) < 1500
ORDER BY avg_sales DESC
LIMIT 10; */

-- Monthly Average Sales

/* SELECT
    MONTH(Date) AS month,
    AVG(Sales) AS avg_sales
FROM train
GROUP BY MONTH(Date)
ORDER BY month; */

-- Year-wise Average Sales

/* SELECT
    YEAR(Date) AS year,
    AVG(Sales) AS avg_sales
FROM train
GROUP BY YEAR(Date)
ORDER BY year; */

-- Year and Month-wise Average Sales

/* SELECT
    YEAR(Date) AS year,
    MONTH(Date) AS month,
    AVG(Sales) AS avg_sales
FROM train
GROUP BY YEAR(Date), MONTH(Date)
ORDER BY year, month; */

-- Store-wise Promo Sales Difference

/* SELECT
    Store,
    AVG(CASE WHEN Promo = 1 THEN Sales END) AS avg_sales_promo,
    AVG(CASE WHEN Promo = 0 THEN Sales END) AS avg_sales_no_promo,
    AVG(CASE WHEN Promo = 1 THEN Sales END)
        - AVG(CASE WHEN Promo = 0 THEN Sales END) AS promo_sales_difference
FROM train
GROUP BY Store
ORDER BY promo_sales_difference DESC
LIMIT 10; */

-- Store-wise Sales Consistency

/* SELECT
    Store,
    AVG(Sales) AS avg_sales,
    STDDEV(Sales) AS sales_stddev,
    STDDEV(Sales) / AVG(Sales) AS coefficient_of_variation
FROM train
GROUP BY Store
ORDER BY coefficient_of_variation ASC
LIMIT 10; */

-- Business Question 1: Top Stores by Average Sales

/* SELECT
    Store,
    AVG(Sales) AS avg_sales
FROM train
GROUP BY Store
ORDER BY avg_sales DESC
LIMIT 10; */

-- Business Question 2: Bottom Stores by Average Sales

/* SELECT
    Store,
    AVG(Sales) AS avg_sales
FROM train
GROUP BY Store
ORDER BY avg_sales ASC
LIMIT 10; */

-- Business Question 3: Top Stores by Average Customers

/* SELECT
    Store,
    AVG(Customers) AS avg_customers
FROM train
GROUP BY Store
ORDER BY avg_customers DESC
LIMIT 10; */

-- Business Question 4: Top Stores by Promo Sales Difference

/* SELECT
    Store,
    AVG(CASE WHEN Promo = 1 THEN Sales END) AS avg_sales_promo,
    AVG(CASE WHEN Promo = 0 THEN Sales END) AS avg_sales_no_promo,
    AVG(CASE WHEN Promo = 1 THEN Sales END)
        - AVG(CASE WHEN Promo = 0 THEN Sales END) AS promo_sales_difference
FROM train
GROUP BY Store
ORDER BY promo_sales_difference DESC
LIMIT 10; */

-- Business Question 5: Month with Highest Average Sales

/* SELECT
    MONTH(Date) AS month,
    AVG(Sales) AS avg_sales
FROM train
GROUP BY MONTH(Date)
ORDER BY avg_sales DESC
LIMIT 1; */

-- Business Question 6: Year with Highest Average Sales

/* SELECT
    YEAR(Date) AS year,
    AVG(Sales) AS avg_sales
FROM train
GROUP BY YEAR(Date)
ORDER BY avg_sales DESC
LIMIT 1; */

-- Business Question 7: Average Sales by State Holiday

/* SELECT
    StateHoliday,
    AVG(Sales) AS avg_sales
FROM train
GROUP BY StateHoliday
ORDER BY avg_sales DESC; */

-- Business Question 8: Average Sales by School Holiday

/* SELECT
    SchoolHoliday,
    AVG(Sales) AS avg_sales
FROM train
GROUP BY SchoolHoliday
ORDER BY avg_sales DESC; */

-- Business Question 9: Stores with High Average Customers and Sales

/* SELECT
    Store,
    AVG(Customers) AS avg_customers,
    AVG(Sales) AS avg_sales
FROM train
GROUP BY Store
HAVING AVG(Customers) > 2000
   AND AVG(Sales) > 10000
ORDER BY avg_customers DESC
LIMIT 10; */ 

-- Business Question 10: Most Consistent Stores

/* SELECT
    Store,
    AVG(Sales) AS avg_sales,
    STDDEV(Sales) AS sales_stddev,
    STDDEV(Sales) / AVG(Sales) AS coefficient_of_variation
FROM train
GROUP BY Store
ORDER BY coefficient_of_variation ASC
LIMIT 10; */


-- Final SQL Verification - Row and Duplicate Check

/* SELECT
    COUNT(*) AS total_rows,
    COUNT(DISTINCT Store, DayOfWeek, Date, Sales, Customers, Open, Promo, StateHoliday, SchoolHoliday) AS unique_rows
FROM train; */

--  Final SQL Verification - NULL Check

/* SELECT
    SUM(Store IS NULL) AS null_store,
    SUM(DayOfWeek IS NULL) AS null_dayofweek,
    SUM(Date IS NULL) AS null_date,
    SUM(Sales IS NULL) AS null_sales,
    SUM(Customers IS NULL) AS null_customers,
    SUM(Open IS NULL) AS null_open,
    SUM(Promo IS NULL) AS null_promo,
    SUM(StateHoliday IS NULL) AS null_stateholiday,
    SUM(SchoolHoliday IS NULL) AS null_schoolholiday
FROM train; */

-- Final SQL Verification - Date Range and Store Count

/* SELECT
    MIN(Date) AS first_date,
    MAX(Date) AS last_date,
    COUNT(DISTINCT Store) AS total_stores
FROM train; */ 


-- Final SQL Verification - Sales Summary

/* SELECT
    MIN(Sales) AS min_sales,
    MAX(Sales) AS max_sales,
    AVG(Sales) AS avg_sales
FROM train; */ 