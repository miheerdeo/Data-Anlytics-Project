#!/usr/bin/env python
# coding: utf-8

# ============================================================
# Retail Orders Data Analysis Pipeline
# ------------------------------------------------------------
# This script downloads a retail orders dataset from Kaggle,
# performs preprocessing using Pandas, and loads the cleaned
# data into MS SQL Server for further analysis with SQL queries.
# ============================================================

# -------------------------------
# Import required libraries
# -------------------------------
import kaggle     # For downloading dataset
import zipfile    # For extracting the downloaded zip file
import pandas as pd  # For data preprocessing and analysis
import sqlalchemy as sal  # For loading data into SQL Server


# -------------------------------
# Download dataset from Kaggle
# -------------------------------
# Note: This requires Kaggle API credentials configured locally.
!kaggle datasets download ankitbansal06/retail-orders -f orders.csv


# -------------------------------
# Extract the downloaded zip file
# -------------------------------
zip_ref = zipfile.ZipFile('orders.csv.zip') 
zip_ref.extractall()   # Extract contents to the current directory
zip_ref.close()        # Close the zip file


# -------------------------------
# Load dataset into Pandas
# -------------------------------
# Handle missing values by treating "Not Available" and "unknown" as NaN
df = pd.read_csv('orders.csv', na_values=['Not Available', 'unknown'])

# Inspect unique values in "Ship Mode"
print(df['Ship Mode'].unique())


# -------------------------------
# Preview the dataset
# -------------------------------
# Optionally rename columns (lowercase + underscores),
# but here we simply preview the top 5 rows
print(df.head(5))


# -------------------------------
# Feature Engineering
# -------------------------------
# Derive profit column using sale_price and cost_price
# (discount and sale_price could be derived similarly if required)
df['profit'] = df['sale_price'] - df['cost_price']


# -------------------------------
# Convert order_date to datetime
# -------------------------------
df['order_date'] = pd.to_datetime(df['order_date'], format="%Y-%m-%d")


# -------------------------------
# Drop unused columns
# -------------------------------
# Remove list_price, cost_price, and discount_percent as they are redundant
df.drop(columns=['list_price', 'cost_price', 'discount_percent'], inplace=True)


# -------------------------------
# Load Data into MS SQL Server
# -------------------------------
# Create connection to SQL Server (adjust connection string as needed)
engine = sal.create_engine(
    'mssql://ANKIT\\SQLEXPRESS/master?driver=ODBC+DRIVER+17+FOR+SQL+SERVER'
)
conn = engine.connect()

# Write DataFrame to SQL Server table
# "replace" will overwrite existing data
df.to_sql('df_orders', con=conn, index=False, if_exists='append')

print("✅ Data successfully loaded into SQL Server table 'df_orders'")
