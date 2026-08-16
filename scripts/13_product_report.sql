/*
=============================================================================
Product Report
=============================================================================
Purpose:
	- This report consolidates key product metrics and behaviors.

Highlights:
	1. Gathers essential fields such as product name, category, subcategory, and cost.
	2. Segments products by revenue to identify high-performers, mid-range, and low-performers.
	3. Aggregates product-level metrics:
		- total orders
		- total sales
		- total quantity sold
		- total customers (unique)
		- lifespan (in months)
	4. Calculates valuable KPIs:
		- receny (months since last sale)
		- average order revenue (AOR)
		- average monthly revenue
============================================================================= 
*/

-- ===========================================================================
-- Create Report: gold.report_products
-- ===========================================================================
IF OBJECT_ID('gold.report_products', 'v') IS NOT NULL
	DROP VIEW gold.report_products;

CREATE VIEW gold.report_products AS
/*---------------------------------------------------------------------------
1. Base Query: Retrieves core columns from fact_sales and dim_products
---------------------------------------------------------------------------*/
WITH base_query AS (
SELECT 
	s.order_number,
	s.order_date,
	s.customer_key,
	s.sales_amount,
	s.quantity,
	p.product_key,
	p.product_name,
	p.category,
	p.subcategory,
	p.product_cost
FROM gold.fact_sales s
LEFT JOIN gold.dim_products p
ON s.product_key = p.product_key
WHERE order_date IS NOT NULL),

/*---------------------------------------------------------------------------
2. Product Aggregations: Summarizes key metrics at the product level
---------------------------------------------------------------------------*/
product_aggregations AS (
	SELECT 
		product_key,
		product_name,
		category,
		subcategory,
		product_cost,
		DATEDIFF(MONTH, MIN(order_date), MAX(order_date)) AS lifespan,
		MAX(order_date) AS last_order_date,
		COUNT(DISTINCT order_number) AS total_orders,
		COUNT(DISTINCT customer_key) AS total_customers,
		SUM(sales_amount) AS total_sales,
		SUM(quantity) AS total_quantity,
		ROUND(AVG(CAST(sales_amount AS FLOAT) / NULLIF(quantity, 0)), 2) AS average_selling_price
	FROM base_query
	GROUP BY 
		product_key,
		product_name,
		category,
		subcategory,
		product_cost)

/*---------------------------------------------------------------------------
3. Final Query: Combines all product results into one output
---------------------------------------------------------------------------*/
SELECT
	product_key,
	product_name,
	category,
	subcategory,
	product_cost,
	lifespan,
	last_order_date,
	DATEDIFF(MONTH, last_order_date, GETDATE()) AS recency_in_months,
	CASE 
		WHEN total_sales > 50000 THEN 'High-Performer'
		WHEN total_sales >= 10000 THEN 'Mid-Range'
		ELSE 'Low-Performer'
	END AS product_segment,
	total_orders,
	total_customers,
	total_sales,
	total_quantity,
	average_selling_price,
	CASE 
		WHEN total_orders = 0 THEN total_sales
		ELSE CAST(total_sales AS FLOAT) / total_orders
	END AS average_order_revenue, -- Average order revenue (AOR)
	CASE 
		WHEN lifespan = 0 THEN total_sales
		ELSE CAST(total_sales AS FLOAT) / lifespan
	END average_monthly_revenue -- Average monthly revenue
	FROM product_aggregations;
	
