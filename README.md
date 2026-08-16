# SQL Exploratory Data Analysis & Advanced Analytics

## 📌 About

This project is an **SQL Exploratory Data Analysis and Advanced Analytics project** built using **SQL Server and T-SQL**. It analyzes sales data through KPI analysis, time-series analysis, ranking, window functions, performance analysis, segmentation, and reusable customer and product reporting views to derive meaningful business insights.

---

## 🎯 Objectives

- Explore the structure and quality of the sales data warehouse.
- Calculate core business KPIs and measures.
- Analyze customers, products, categories, and countries.
- Identify top and underperforming products and customers.
- Analyze sales trends over time.
- Apply SQL window functions for cumulative and comparative analysis.
- Perform category contribution and customer/product segmentation.
- Build reusable analytical views for customer and product reporting.

---

## 🏗️ Data Model

The project uses a simple **star-schema structure**:

```text
                 ┌─────────────────────┐
                 │   dim_customers     │
                 │─────────────────────│
                 │ customer_key        │
                 │ customer_id         │
                 │ customer_number     │
                 │ name / demographics │
                 │ country             │
                 │ birthdate           │
                 └──────────┬──────────┘
                            │
                            │
                 ┌──────────▼──────────┐
                 │     fact_sales      │
                 │─────────────────────│
                 │ order_number        │
                 │ product_key         │
                 │ customer_key        │
                 │ order_date          │
                 │ sales_amount        │
                 │ quantity            │
                 │ price               │
                 └──────────┬──────────┘
                            │
                            │
                 ┌──────────▼──────────┐
                 │    dim_products     │
                 │─────────────────────│
                 │ product_key         │
                 │ product_name        │
                 │ category            │
                 │ subcategory         │
                 │ cost                │
                 │ product_line        │
                 │ start_date          │
                 └─────────────────────┘
```

### Dataset

| Table | Rows | Description |
|---|---:|---|
| `gold.fact_sales` | 60,398 | Sales transactions |
| `gold.dim_customers` | 18,484 | Customer master data |
| `gold.dim_products` | 295 | Product master data |

The sales data covers orders from **March 2013 to June 2014**.

---

## 🗂️ Project Structure

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

## 🔍 Analysis Workflow

### 01 — Database Exploration
**`01_database_exploration.sql`**

Explores database tables and column metadata using `INFORMATION_SCHEMA`.

### 02 — Dimension Exploration
**`02_dimensions_exploration.sql`**

Explores available customer countries and product categories, subcategories, and products.

### 03 — Date Exploration
**`03_date_exploration.sql`**

Analyzes:

- First and last order dates
- Sales period in days, months, and years
- Oldest and youngest customer dates
- Customer age calculations

### 04 — Measures & KPI Analysis
**`04_measures_exploration.sql`**

Calculates:

- Total sales
- Total quantity sold
- Average selling price
- Total orders
- Total products
- Total customers
- Customers who placed orders

It also combines the main KPIs into a single result.

### 05 — Magnitude Analysis
**`05_magnitude_analysis.sql`**

Analyzes the distribution of:

- Customers by country
- Customers by gender
- Products by category
- Average product cost by category
- Revenue by category
- Revenue by customer
- Quantity sold by country

### 06 — Ranking Analysis
**`06_ranking_analysis.sql`**

Identifies:

- Top 5 products by revenue
- Bottom 5 products by revenue
- Top category/subcategory combinations
- Customers with the fewest orders
- Customers with the highest number of orders

### 07 — Changes Over Time
**`07_changes_over_time_analysis.sql`**

Creates a monthly sales trend containing:

- Year
- Month
- Active customers
- Total sales
- Total quantity

### 08 — Cumulative Analysis
**`08_cumulative_analysis.sql`**

Uses window functions to calculate:

- Monthly sales
- Running total sales
- Monthly average price
- Cumulative average price

### 09 — Performance Analysis
**`09_performance_analysis.sql`**

Compares yearly product performance against:

- The product's average yearly sales
- The previous available year's sales

Uses `AVG() OVER()` and `LAG()` to classify products as:

- Above Average
- Below Average
- Average
- Increase
- Decrease
- No Change

### 10 — Part-to-Whole Analysis
**`10_part_to_whole_analysis.sql`**

Calculates each category's:

- Total sales
- Overall sales
- Percentage contribution to total sales

This demonstrates the use of window functions for contribution analysis.

### 11 — Data Segmentation
**`11_data_segmentation.sql`**

Segments:

#### Products
Products are grouped into cost ranges.

#### Customers
Customers are classified based on spending and relationship lifespan:

- **VIP** — 12+ months of history and spending above 5,000
- **Regular** — 12+ months of history and spending 5,000 or less
- **New** — less than 12 months of history

### 12 — Customer Report
**`12_customer_report.sql`**

Creates the reusable view:

```sql
gold.report_customers
```

The report includes:

- Customer information
- Age and age group
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

### 13 — Product Report
**`13_product_report.sql`**

Creates the reusable view:

```sql
gold.report_products
```

The report includes:

- Product information
- Category and subcategory
- Product cost
- Product lifespan
- Last sale date
- Recency
- Product performance segment
- Total orders
- Unique customers
- Total sales
- Total quantity
- Average selling price
- Average order revenue
- Average monthly revenue

Product segments are based on total sales:

- **High-Performer** — above 50,000
- **Mid-Range** — 10,000 to 50,000
- **Low-Performer** — below 10,000

---

## 🧠 SQL Techniques Demonstrated

### SQL Fundamentals
- `SELECT`
- `WHERE`
- `GROUP BY`
- `ORDER BY`
- `DISTINCT`
- `TOP`
- `CASE`

### Aggregations
- `SUM()`
- `AVG()`
- `COUNT()`
- `COUNT(DISTINCT ...)`
- `MIN()`
- `MAX()`

### Data Relationships
- `LEFT JOIN`
- Fact-to-dimension analysis
- Multi-column grouping

### Date & Time Analysis
- `YEAR()`
- `DATETRUNC()`
- `DATEDIFF()`
- `GETDATE()`

### Advanced SQL
- Common Table Expressions (CTEs)
- Window functions
- `LAG()`
- `SUM() OVER()`
- `AVG() OVER()`
- Running totals
- Comparative analysis
- Part-to-whole analysis

### Analytical Engineering
- Reusable SQL views
- Customer analytical reporting
- Product analytical reporting
- Business-rule segmentation
- Explicit type casting
- `NULLIF()` for safe division

---

## 📊 Business Questions Answered

### Sales Performance
- What are the total sales, orders, quantity, and average price?
- How does sales performance change over time?
- What is the cumulative sales trajectory?

### Customer Analytics
- How are customers distributed across countries and genders?
- Which customers generate the most revenue?
- Which customers place the most orders?
- How can customers be segmented by value and lifespan?
- What are customer recency and AOV?

### Product Analytics
- Which products generate the most revenue?
- Which products perform poorly?
- Which categories and subcategories contribute the most revenue?
- How do products perform compared with their historical average?
- Which products are high, mid-range, or low performers?

### Revenue Contribution
- Which categories contribute most to total revenue?
- What percentage of total sales does each category represent?

---

## 🗺️ Project Roadmap

![Project Roadmap](docs/Project%20Roadmap.png)

---

## ▶️ How to Run

### Prerequisites

- SQL Server
- SQL Server Management Studio (SSMS) or another SQL Server-compatible client
- Git

### 1. Clone the repository

```bash
git clone <your-repository-url>
cd sql-exploratory-data-analysis-project
```

### 2. Create and load the database

Open:

```text
scripts/00_init_database.sql
```

Run the script in SQL Server.

> **Important:** The initialization script uses `BULK INSERT` and currently contains local file paths. Update the three CSV paths in `00_init_database.sql` to match the location of your cloned repository.

For example:

```sql
FROM 'C:\path\to\project\datasets\gold.fact_sales.csv'
```

### 3. Run the analysis scripts

Execute the scripts in order:

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

The final two scripts create the reusable customer and product reporting views.

---

## ⚠️ Important Implementation Notes

Before running the repository, update the local `BULK INSERT` paths in `00_init_database.sql`.

Also ensure the source column name is consistent with the database schema:

```sql
gold.dim_products.cost
```

rather than `product_cost`.

For analytical ratios such as AOV and average monthly spend, use explicit numeric conversion where fractional results are required:

```sql
CAST(total_sales AS FLOAT) / NULLIF(total_orders, 0)
```

The cumulative price calculation in `08_cumulative_analysis.sql` is a **cumulative average**, not a fixed-window moving average.

---

## 🚀 Potential Extensions

- Build a Power BI dashboard using the reporting views.
- Add month-over-month and year-over-year growth metrics.
- Add customer cohort and retention analysis.
- Implement RFM customer segmentation.
- Add profitability analysis using product cost.
- Add automated data-quality checks.
- Add query optimization and indexing analysis.
- Add a dedicated date dimension.
- Parameterize customer and product segmentation thresholds.

---

## 🛠️ Skills Demonstrated

**SQL / T-SQL:**  
SQL Server · CTEs · Joins · Aggregations · Window Functions · `LAG()` · `CASE` · Date Functions · Views · Type Casting

**Data Analytics:**  
EDA · KPI Analysis · Trend Analysis · Ranking · Performance Analysis · Segmentation · Part-to-Whole Analysis

**Data Modeling:**  
Fact Tables · Dimension Tables · Star Schema · Analytical Views

**Business Analytics:**  
Customer Analytics · Product Analytics · Revenue Analysis · Sales Performance

---

## 📄 License

This project is available under the license included in the repository.
