/*
=============================================================================
Customer Report
=============================================================================
Purpose:
	- This report consolidates key customer metrics and behaviors.

Highlights:
	1. Gathers essential fields such as names, age, and transaction details.
	2. Segments customers into categories (VIP, Regular, New) and age groups.
	3. Aggregates customer-level metrics:
		- total orders
		- total sales
		- total quantity purchased
		- total products
		- lifespan (in months)
	4. Calculates valuable KPIs:
		- receny (months since last order)
		- average order value (AOV)
		- average monthly spend
============================================================================= 
*/

-- ===========================================================================
-- Create Report: gold.report_customers
-- ===========================================================================
IF OBJECT_ID('gold.report_customers', 'v') IS NOT NULL
	DROP VIEW gold.report_customers;

CREATE VIEW gold.report_customers AS

/*---------------------------------------------------------------------------
1. Base Query: Retrieves core columns from fact_sales and dim_customers
---------------------------------------------------------------------------*/
WITH base_query AS (
	SELECT 
		s.order_number,
		s.product_key,
		s.order_date,
		s.sales_amount,
		s.quantity,
		c.customer_key,
		c.customer_number,
		CONCAT(c.first_name, ' ', c.last_name) AS customer_name,
		DATEDIFF(YEAR, c.birthdate, GETDATE()) AS age
	FROM gold.fact_sales s
	LEFT JOIN gold.dim_customers c
	ON s.customer_key = c.customer_key
	WHERE s.order_date IS NOT NULL),

/*---------------------------------------------------------------------------
2. Customer Aggregations: Summarizes key metrics at the customer level
---------------------------------------------------------------------------*/
customer_aggregation AS (
	SELECT 
		customer_key,
		customer_number,
		customer_name,
		age,
		COUNT(DISTINCT order_number) AS total_orders,
		COUNT(DISTINCT product_key) AS total_products,
		SUM(sales_amount) AS total_sales,
		SUM(quantity) AS total_quantity,
		MAX(order_date) AS last_order_date,
		DATEDIFF(MONTH, MIN(order_date), MAX(order_date)) AS lifespan
	FROM base_query
	GROUP BY
		customer_key,
		customer_number,
		customer_name,
		age)

/*---------------------------------------------------------------------------
3. Final Result
---------------------------------------------------------------------------*/
SELECT 
	customer_key,
	customer_number,
	customer_name,
	age,
	CASE 
		WHEN age < 20 THEN 'under 20'
		WHEN age BETWEEN 20 AND 29 THEN '20-29'
		WHEN age BETWEEN 30 AND 39 THEN '30-39'
		WHEN age BETWEEN 40 AND 49 THEN '40-49'
		ELSE '50 and above'
	END AS age_group,
	CASE 
		WHEN lifespan >= 12 AND total_sales > 5000 THEN 'VIP'
		WHEN lifespan >= 12 AND total_sales <= 5000 THEN 'Regular'
		ELSE 'New'
	END AS customer_segment,
	total_orders,
	total_products,
	total_sales,
	total_quantity,
	last_order_date,
	DATEDIFF(MONTH, last_order_date, GETDATE()) AS recency,
	lifespan,
	CASE 
	    WHEN total_orders = 0 THEN 0
	    ELSE CAST(total_sales AS FLOAT) / total_orders
	END AS average_order_value,  -- Average order value (AOV)
	CASE 
	    WHEN lifespan = 0 THEN 0
	    ELSE CAST(total_sales AS FLOAT) / lifespan
	END AS average_monthly_spend -- Average monthly spend
FROM customer_aggregation;




