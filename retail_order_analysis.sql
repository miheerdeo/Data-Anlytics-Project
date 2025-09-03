-- ============================================================
-- Retail Orders Analysis Queries
-- ------------------------------------------------------------
-- This script runs different SQL queries on the 'df_orders' table
-- to analyze revenue, sales trends, and growth performance.
-- ============================================================

-- 1. Find top 10 highest revenue generating products
SELECT TOP 10 
    product_id,
    SUM(sale_price) AS sales
FROM df_orders
GROUP BY product_id
ORDER BY sales DESC;


-- 2. Find top 5 highest selling products in each region
WITH cte AS (
    SELECT 
        region,
        product_id,
        SUM(sale_price) AS sales
    FROM df_orders
    GROUP BY region, product_id
)
SELECT *
FROM (
    SELECT *,
           ROW_NUMBER() OVER(PARTITION BY region ORDER BY sales DESC) AS rn
    FROM cte
) A
WHERE rn <= 5;


-- 3. Compare month-over-month growth for 2022 vs 2023
WITH cte AS (
    SELECT 
        YEAR(order_date) AS order_year,
        MONTH(order_date) AS order_month,
        SUM(sale_price) AS sales
    FROM df_orders
    GROUP BY YEAR(order_date), MONTH(order_date)
)
SELECT 
    order_month,
    SUM(CASE WHEN order_year = 2022 THEN sales ELSE 0 END) AS sales_2022,
    SUM(CASE WHEN order_year = 2023 THEN sales ELSE 0 END) AS sales_2023
FROM cte
GROUP BY order_month
ORDER BY order_month;


-- 4. For each category, find the month with highest sales
WITH cte AS (
    SELECT 
        category,
        FORMAT(order_date,'yyyyMM') AS order_year_month,
        SUM(sale_price) AS sales 
    FROM df_orders
    GROUP BY category, FORMAT(order_date,'yyyyMM')
)
SELECT *
FROM (
    SELECT *,
           ROW_NUMBER() OVER(PARTITION BY category ORDER BY sales DESC) AS rn
    FROM cte
) a
WHERE rn = 1;


-- 5. Identify sub-category with highest profit growth in 2023 vs 2022
WITH cte AS (
    SELECT 
        sub_category,
        YEAR(order_date) AS order_year,
        SUM(sale_price) AS sales
    FROM df_orders
    GROUP BY sub_category, YEAR(order_date)
),
cte2 AS (
    SELECT 
        sub_category,
        SUM(CASE WHEN order_year = 2022 THEN sales ELSE 0 END) AS sales_2022,
        SUM(CASE WHEN order_year = 2023 THEN sales ELSE 0 END) AS sales_2023
    FROM cte 
    GROUP BY sub_category
)
SELECT TOP 1 *,
       (sales_2023 - sales_2022) AS growth
FROM cte2
ORDER BY growth DESC;
