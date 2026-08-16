-- Find the date of first and last order
-- How many years of sales are available
SELECT
	MIN(order_date) AS first_order_date,
	MAX(order_date) AS last_order_date,
	DATEDIFF(DAY, MIN(order_date), MAX(order_date)) AS order_range_days,
	DATEDIFF(MONTH, MIN(order_date), MAX(order_date)) AS order_range_months,
	DATEDIFF(YEAR, MIN(order_date), MAX(order_date)) AS order_range_years
FROM gold.fact_sales;


-- Find the youngest and the oldest customer
SELECT
	MIN(birthdate) AS oldest_birthdate,
	DATEDIFF(YEAR, MIN(birthdate), GETDATE()) AS oldest_age,
	MAX(birthdate) AS youngest_birthdate,
	DATEDIFF(YEAR, MAX(birthdate), GETDATE()) AS youngest_age
FROM gold.dim_customers;

