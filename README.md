# SQL Exploratory Data Analysis & Advanced Analytics

A hands-on **SQL Server / T-SQL exploratory data analysis project** focused on transforming a sales data warehouse into actionable business insights.

The project progresses from database and dimensional exploration to KPI analysis, ranking, time-series analysis, cumulative metrics, performance comparisons, part-to-whole analysis, segmentation, and reusable customer/product reporting views.

---

## 📌 Project Overview

This project uses a **star-schema sales model** consisting of:

- `gold.fact_sales` — transactional sales data
- `gold.dim_customers` — customer attributes
- `gold.dim_products` — product and category attributes

The analysis is designed to answer questions such as:

- What is the overall sales performance?
- Which products and categories contribute the most revenue?
- Which customers generate the most sales and orders?
- How does sales performance change over time?
- Which products are improving or declining year over year?
- What percentage of total revenue comes from each category?
- How can customers and products be segmented using business rules?
- What reusable KPIs can be exposed through customer and product reports?

---

## 🎯 Objectives

The main objectives of the project are to:

1. Explore the structure and contents of the sales data warehouse.
2. Establish a baseline of business KPIs.
3. Analyze customers, products, categories, and countries.
4. Study sales trends across time.
5. Apply SQL window functions for cumulative and comparative analysis.
6. Rank top and bottom performing products and customers.
7. Measure category contribution to total revenue.
8. Segment customers based on spending and relationship lifespan.
9. Segment products based on revenue performance.
10. Build reusable analytical views for customer and product-level reporting.

---

## 🗂️ Data Model

The project follows a simple dimensional model:

```text
                    ┌─────────────────────┐
                    │   dim_customers     │
                    │─────────────────────│
                    │ customer_key        │
                    │ customer_id         │
                    │ customer_number     │
                    │ first_name          │
                    │ last_name           │
                    │ country             │
                    │ marital_status      │
                    │ gender              │
                    │ birthdate           │
                    │ create_date         │
                    └──────────┬──────────┘
                               │
                               │ customer_key
                               │
                    ┌──────────▼──────────┐
                    │     fact_sales      │
                    │─────────────────────│
                    │ order_number        │
                    │ product_key         │
                    │ customer_key        │
                    │ order_date          │
                    │ shipping_date       │
                    │ due_date            │
                    │ sales_amount        │
                    │ quantity            │
                    │ price               │
                    └──────────┬──────────┘
                               │
                               │ product_key
                               │
                    ┌──────────▼──────────┐
                    │    dim_products     │
                    │─────────────────────│
                    │ product_key         │
                    │ product_id          │
                    │ product_number      │
                    │ product_name        │
                    │ category_id         │
                    │ category            │
                    │ subcategory         │
                    │ maintenance         │
                    │ cost                │
                    │ product_line        │
                    │ start_date          │
                    └─────────────────────┘
```

### Dataset size

| Table | Rows | Purpose |
|---|---:|---|
| `gold.dim_customers` | 18,484 | Customer master data |
| `gold.dim_products` | 295 | Product master data |
| `gold.fact_sales` | 60,398 | Sales transactions |

The sales data covers orders from **2013-03-16 through 2014-06-30**.

---

## 🧰 Tech Stack

- **SQL Server**
- **T-SQL**
- Common Table Expressions (CTEs)
- Aggregate functions
- `JOIN` operations
- `CASE` expressions
- Window functions
- `LAG()`
- `SUM() OVER()`
- `AVG() OVER()`
- `DATETRUNC()`
- `DATEDIFF()`
- `BULK INSERT`
- SQL Views
- Git / GitHub

---

## 📁 Project Structure

```text
sql-exploratory-data-analysis-project/
│
├── datasets/
│   ├── gold.dim_customers.csv
│   ├── gold.dim_products.csv
│   └── gold.fact_sales.csv
│
├── docs/
│   └── Project Roadmap.png
│
├── scripts/
│   ├── 00_init_database.sql
│   ├── 01_database_exploration.sql
│   ├── 02_dimensions_exploration.sql
│   ├── 03_date_exploration.sql
│   ├── 04_measures_exploration.sql
│   ├── 05_magnitude_analysis.sql
│   ├── 06_ranking_analysis.sql
│   ├── 07_changes_over_time_analysis.sql
│   ├── 08_cumulative_analysis.sql
│   ├── 09_performance_analysis.sql
│   ├── 10_part_to_whole_analysis.sql
│   ├── 11_data_segmentation.sql
│   ├── 12_customer_report.sql
│   └── 13_product_report.sql
│
├── LICENSE
└── README.md
```

---

## 🔎 Analysis Workflow

### 1. Database Exploration

**Script:** `01_database_exploration.sql`

Explores:

- Available database tables
- Table metadata
- Column definitions

This establishes the structure of the analytical environment before deeper analysis begins.

---

### 2. Dimension Exploration

**Script:** `02_dimensions_exploration.sql`

Examines important categorical dimensions such as:

- Customer countries
- Product categories
- Product subcategories
- Product names

This helps identify the business dimensions available for slicing and grouping the data.

---

### 3. Date Exploration

**Script:** `03_date_exploration.sql`

Analyzes the temporal scope of the dataset:

- First order date
- Last order date
- Number of days/months/years covered
- Oldest customer
- Youngest customer

---

### 4. KPI & Measure Exploration

**Script:** `04_measures_exploration.sql`

Calculates core business metrics:

- Total sales
- Total quantity sold
- Average selling price
- Total orders
- Total products
- Total customers
- Customers who placed orders

It also combines the main KPIs into a single summary result.

---

### 5. Magnitude Analysis

**Script:** `05_magnitude_analysis.sql`

Analyzes the size and distribution of the business across major dimensions:

- Customers by country
- Customers by gender
- Products by category
- Average product cost by category
- Revenue by category
- Revenue by customer
- Quantity sold by country

This stage identifies where the business generates the largest volumes and revenues.

---

### 6. Ranking Analysis

**Script:** `06_ranking_analysis.sql`

Uses ranking logic to identify:

- Top 5 products by revenue
- Bottom 5 products by revenue
- Top category/subcategory combinations
- Customers with the fewest orders
- Customers with the highest number of orders

This helps identify high-value products/customers as well as potential underperformers.

---

### 7. Changes Over Time

**Script:** `07_changes_over_time_analysis.sql`

Builds a monthly sales trend containing:

- Year
- Month
- Active customers
- Total sales
- Total quantity sold

This provides a foundation for time-series performance analysis.

---

### 8. Cumulative Analysis

**Script:** `08_cumulative_analysis.sql`

Uses SQL window functions to calculate:

- Monthly sales
- Running cumulative sales
- Monthly average selling price
- Cumulative average of monthly average price

This demonstrates how window functions can reveal long-term business trends without collapsing the underlying time series.

---

### 9. Product Performance Analysis

**Script:** `09_performance_analysis.sql`

Compares yearly product sales against:

- The product's historical average sales
- The previous year's sales

The analysis classifies each result as:

- Above Average
- Below Average
- Average

and:

- Increase
- Decrease
- No Change

Key SQL techniques include:

- CTEs
- `AVG() OVER(PARTITION BY ...)`
- `LAG()`
- Conditional classification with `CASE`

---

### 10. Part-to-Whole Analysis

**Script:** `10_part_to_whole_analysis.sql`

Measures each product category's contribution to overall sales.

The output includes:

- Category sales
- Overall sales
- Percentage contribution

This is useful for understanding revenue concentration and category-level business importance.

---

### 11. Data Segmentation

**Script:** `11_data_segmentation.sql`

Performs rule-based segmentation of both products and customers.

#### Product segmentation

Products are grouped into cost ranges.

#### Customer segmentation

Customers are classified based on:

- Relationship lifespan
- Total spending

Segments:

- **VIP** — at least 12 months of history and spending above 5,000
- **Regular** — at least 12 months of history and spending of 5,000 or less
- **New** — less than 12 months of history

This converts raw transactional behavior into business-friendly customer groups.

---

## 📊 Analytical Reporting Views

### Customer Report

**Script:** `12_customer_report.sql`

Creates:

```sql
gold.report_customers
```

The view provides customer-level analytical metrics including:

- Customer identity
- Age
- Age group
- Customer segment
- Total orders
- Total products purchased
- Total sales
- Total quantity
- Last order date
- Recency
- Customer lifespan
- Average Order Value (AOV)
- Average monthly spend

This view can serve as a reusable customer analytics layer for dashboards or downstream analysis.

---

### Product Report

**Script:** `13_product_report.sql`

Creates:

```sql
gold.report_products
```

The view provides product-level metrics including:

- Product name
- Category
- Subcategory
- Product cost
- Product lifespan
- Last sale date
- Recency
- Product performance segment
- Total orders
- Unique customers
- Total sales
- Total quantity sold
- Average selling price
- Average order revenue
- Average monthly revenue

Product performance segments are:

- **High-Performer** — sales above 50,000
- **Mid-Range** — sales from 10,000 to 50,000
- **Low-Performer** — sales below 10,000

---

## 🧠 SQL Concepts Demonstrated

This project goes beyond basic `SELECT` queries and demonstrates practical analytical SQL, including:

### Data Exploration
- `INFORMATION_SCHEMA`
- `DISTINCT`
- Metadata exploration

### Aggregation
- `SUM()`
- `AVG()`
- `COUNT()`
- `COUNT(DISTINCT ...)`
- `MIN()`
- `MAX()`

### Relational Analysis
- `LEFT JOIN`
- Multi-column `GROUP BY`
- Sorting and filtering aggregated results

### Date & Time Analysis
- `YEAR()`
- `DATETRUNC()`
- `DATEDIFF()`
- Dynamic date calculations with `GETDATE()`

### Advanced SQL
- CTEs
- Window functions
- `LAG()`
- Running totals
- Partitioned averages
- Conditional segmentation
- Part-to-whole calculations

### Analytical Engineering
- Reusable SQL views
- Layered CTE design
- Business KPI definitions
- Customer/product analytical marts

---

## 📈 Key Analytical Questions

The project is structured around business questions rather than isolated SQL syntax exercises.

### Business Performance
- What is the total revenue?
- How many orders and items were sold?
- What is the average selling price?

### Customer Analytics
- Where are customers located?
- Which customers generate the most revenue?
- Who places the most orders?
- How can customers be segmented by value and relationship lifespan?
- What is customer recency and AOV?

### Product Analytics
- Which products generate the most revenue?
- Which products underperform?
- Which categories and subcategories drive sales?
- Which products are high, mid, or low performers?

### Time-Series Analytics
- How do sales change month over month?
- What is the cumulative revenue trajectory?
- How does a product perform against its historical average?
- How does current performance compare with the previous year?

### Contribution Analysis
- Which categories contribute most to total revenue?
- What percentage of total sales does each category represent?

---

## 🗺️ Project Roadmap

The project follows a progression from foundational exploration to advanced analytical reporting:

![Project Roadmap](docs/Project%20Roadmap.png)

---

## ▶️ How to Run

### Prerequisites

Install or have access to:

- SQL Server
- SQL Server Management Studio (SSMS) or another SQL Server-compatible client
- Git

### Step 1 — Clone the repository

```bash
git clone <your-repository-url>
cd sql-exploratory-data-analysis-project
```

### Step 2 — Prepare the database

Open:

```text
scripts/00_init_database.sql
```

Run the script in SQL Server.

> **Important:** The current initialization script contains a local Windows `BULK INSERT` path. Update the three CSV paths to match the location of your cloned repository before execution.

For example:

```sql
FROM 'C:\path\to\project\datasets\gold.fact_sales.csv'
```

### Step 3 — Execute the analysis scripts

Run the scripts in order:

```text
01_database_exploration.sql
02_dimensions_exploration.sql
03_date_exploration.sql
04_measures_exploration.sql
05_magnitude_analysis.sql
06_ranking_analysis.sql
07_changes_over_time_analysis.sql
08_cumulative_analysis.sql
09_performance_analysis.sql
10_part_to_whole_analysis.sql
11_data_segmentation.sql
12_customer_report.sql
13_product_report.sql
```

The final two scripts create reusable analytical views:

```sql
gold.report_customers
gold.report_products
```

---

## ⚠️ Implementation Notes

The repository demonstrates the intended analytical workflow, but a few SQL expressions should be corrected before presenting the project as a fully executable production-quality repository:

1. **Product cost column:**  
   The table defines the column as `cost`, while `05_magnitude_analysis.sql` references `product_cost`.

2. **Quantity ranking alias:**  
   The country-level quantity query orders by `total_quantity`, while its selected alias is `total_sold_items`.

3. **Product cost segmentation:**  
   `11_data_segmentation.sql` contains `BETWEEN 500 AND 100`, which is an invalid range for the intended `500–1000` bucket.

4. **Customer report view drop:**  
   The existence check should consistently reference `gold.report_customers` rather than the unqualified object name.

5. **Average calculations:**  
   Because sales and order-related columns are integer types, explicit decimal/float casting should be used when fractional results are required, e.g. for AOV or average monthly spend.

6. **Moving-average terminology:**  
   The calculation in `08_cumulative_analysis.sql` is a cumulative average of monthly average prices, not a fixed-window moving average.

These are implementation-level issues rather than limitations of the analytical approach.

---

## 💡 Business Value

The project demonstrates how SQL can be used as an **analytical language**, not just a data-retrieval tool.

The workflow moves from:

```text
Raw Sales Data
      ↓
Database Exploration
      ↓
KPI Definition
      ↓
Dimensional Analysis
      ↓
Time-Series Analysis
      ↓
Window Functions
      ↓
Performance Comparison
      ↓
Segmentation
      ↓
Customer & Product Reports
      ↓
Business Insights
```

This approach is particularly relevant to **Data Analyst, BI Analyst, Analytics Engineer, and Data Engineer** workflows where SQL is used to transform transactional data into reusable analytical datasets.

---

## 🚀 Potential Extensions

Possible next steps include:

- Add a dedicated date dimension.
- Add data-quality checks and constraints.
- Add indexes for analytical queries.
- Replace hard-coded segmentation thresholds with configurable parameters.
- Add month-over-month and year-over-year percentage growth.
- Add customer retention and cohort analysis.
- Add RFM customer segmentation.
- Add product/category profitability analysis using product cost.
- Build Power BI dashboards on top of the reporting views.
- Add automated SQL data-quality validation.
- Add query performance analysis and optimization.
- Containerize the SQL environment for reproducible setup.

---

## 📚 Skills Demonstrated

**SQL / T-SQL:**  
`SELECT` · `JOIN` · `GROUP BY` · `CASE` · `CTE` · Window Functions · `LAG()` · Aggregations · Date Functions · Views

**Analytics:**  
EDA · KPI Analysis · Trend Analysis · Ranking · Cumulative Analysis · Performance Analysis · Segmentation · Part-to-Whole Analysis

**Data Modeling:**  
Fact and Dimension Tables · Star Schema · Analytical Views

**Business Analysis:**  
Customer Analytics · Product Analytics · Revenue Analysis · Sales Performance · Behavioral Segmentation

---

## 📄 License

This project is distributed under the license included in the repository.
