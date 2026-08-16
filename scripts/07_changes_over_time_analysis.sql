-- Analyze sales performance over time
SELECT 
	YEAR(order_date) AS order_year,
	DATETRUNC(MONTH, order_date) AS order_month,
	COUNT(DISTINCT customer_key) AS total_customers,
	SUM(sales_amount) AS total_sales,
	SUM(quantity) AS total_quantity
FROM gold.fact_sales
GROUP BY 
	YEAR(order_date), 
	DATETRUNC(MONTH, order_date)
ORDER BY 
	YEAR(order_date), 
	DATETRUNC(MONTH, order_date);