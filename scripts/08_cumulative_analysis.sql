-- Calculate the total sales per month and the running total of sales over time

SELECT 
	order_month,
	total_sales,
	SUM(total_sales) OVER (ORDER BY order_month) AS running_total_sales,
	average_price,
	AVG(average_price) OVER (ORDER BY order_month) AS cumulative_average_price
FROM (
	SELECT 
		DATETRUNC(MONTH, order_date) AS order_month,
		SUM(sales_amount) AS total_sales,
		AVG(price) AS average_price
	FROM gold.fact_sales
	WHERE order_date IS NOT NULL
	GROUP BY DATETRUNC(MONTH, order_date)
) t;
