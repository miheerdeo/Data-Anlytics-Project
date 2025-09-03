# Retail Sales Data Analysis

This project demonstrates an end-to-end data analysis pipeline for retail sales data.  
It covers data ingestion, preprocessing, feature engineering, SQL-based reporting, and visualization using Python, MS SQL Server, and Excel.  

## Project Overview
- Built a scalable ETL pipeline to clean and transform retail order data.  
- Designed SQL queries for business insights such as top revenue products, sales by region, and year-over-year growth.  
- Created Excel dashboards to visualize trends and highlight decision-making metrics.  

## Dataset
- Source: Retail Orders Dataset (Kaggle)  
- Format: orders.csv  
- Size: ~50k records  

## Workflow
1. **Download Data**  
   - Used Kaggle API to download dataset.  
   - Extracted the zip file into the working directory.  

2. **Preprocessing with Pandas**  
   - Handled missing values (`Not Available`, `unknown`).  
   - Engineered new features: discount, sale_price, and profit.  
   - Converted order_date into datetime format.  
   - Dropped redundant columns such as list_price, cost_price, and discount_percent.  

3. **Load into SQL Server**  
   - Connected Python to MS SQL Server using SQLAlchemy.  
   - Stored the cleaned dataset into SQL table `df_orders`.  

4. **SQL Analysis**  
   - Wrote analytical queries to extract sales insights.  

5. **Visualization in Excel**  
   - Built pivot tables and charts for reporting.  

## SQL Queries
- Top 10 highest revenue products  
- Top 5 selling products per region  
- Month-over-month growth (2022 vs 2023)  
- Best sales month for each category  
- Highest profit growth sub-category (2023 vs 2022)  

## Key Insights
- Identified top revenue-generating products.  
- Found regional bestsellers and their contribution to overall revenue.  
- Highlighted categories with the highest growth potential.  
- Compared monthly sales performance for 2022 and 2023.  

## Tech Stack
- Python (Pandas, SQLAlchemy)  
- MS SQL Server  
- Excel / Advanced Excel  
- Kaggle API  

## How to Run
1. Clone this repository:  
   ```bash
   git clone https://github.com/yourusername/retail-sales-analysis.git
   cd retail-sales-analysis
s# Data-Anlytics-Project
This project demonstrates an end-to-end data analysis pipeline built on real retail orders data. The workflow covers data ingestion, preprocessing, feature engineering, and SQL-based reporting.
