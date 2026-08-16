-- Which 5 products generate the highest revenue?
SELECT TOP 5
	p.product_name,
	SUM(s.sales_amount) AS total_revenue
FROM gold.fact_sales s
LEFT JOIN gold.dim_products p
ON s.product_key = p.product_key
GROUP BY p.product_name
ORDER BY total_revenue DESC;


-- What are the 5 worst performing products in terms of sales?
SELECT TOP 5
	p.product_name,
	SUM(s.sales_amount) AS total_revenue
FROM gold.fact_sales s
LEFT JOIN gold.dim_products p
ON s.product_key = p.product_key
GROUP BY p.product_name
ORDER BY total_revenue;


-- Which categories and subcategories generate the highest revenue?
SELECT TOP 5
	p.category,
	p.subcategory,
	SUM(s.sales_amount) AS total_revenue
FROM gold.fact_sales s
LEFT JOIN gold.dim_products p
ON s.product_key = p.product_key
GROUP BY 
	p.category, 
	p.subcategory
ORDER BY total_revenue DESC;


-- The 5 customers with fewest orders placed
SELECT TOP 5
	c.customer_key,
	c.first_name,
	c.last_name,
	COUNT(DISTINCT order_number) AS total_orders
FROM gold.fact_sales s
LEFT JOIN gold.dim_customers c
ON s.customer_key = c.customer_key
GROUP BY 
	c.customer_key,
	c.first_name,
	c.last_name
ORDER BY total_orders;


-- The 5 customers with highest orders placed
SELECT TOP 5
	c.customer_key,
	c.first_name,
	c.last_name,
	COUNT(DISTINCT order_number) AS total_orders
FROM gold.fact_sales s
LEFT JOIN gold.dim_customers c
ON s.customer_key = c.customer_key
GROUP BY 
	c.customer_key,
	c.first_name,
	c.last_name
ORDER BY total_orders DESC;





	