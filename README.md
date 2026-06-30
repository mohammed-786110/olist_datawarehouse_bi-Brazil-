<img width="1552" height="727" alt="DB_Page_1" src="https://github.com/user-attachments/assets/41655183-1403-4b7a-82dc-ff75d140c6d5" />

# olist_datawarehouse_bi-Brazil-
Enterprise Data Warehouse and Business Intelligence solution built using SQL Server and Power BI on the Brazilian Olist E-commerce dataset.


# 🛒 Olist E-Commerce Data Warehouse & Business Intelligence

Project Overview

This project demonstrates the design and implementation of an Enterprise Data Warehouse using SQL Server and an interactive Business Intelligence dashboard using Power BI.

The Brazilian Olist E-Commerce dataset was transformed using a multi-layer ETL architecture (Silver → Gold), optimized into a Star Schema, and visualized through interactive dashboards that provide actionable business insights.

---

 Features

- SQL Server Data Warehouse
- Multi-layer ETL Pipeline
- Star Schema Design
- Fact & Dimension Modeling
- Data Cleaning & Transformation
- SQL Views for Analytics
- Interactive Power BI Dashboard
- Executive KPI Reporting

---

Tech Stack

| Technology | Purpose |
|------------|---------|
| SQL Server | Data Warehouse |
| SSMS | Database Development |
| SQL | ETL & Analytics |
| Power BI | Dashboard & Visualization |
| Git & GitHub | Version Control |

---

Data Warehouse Architecture

Bronze Layer
↓

Silver Layer (Cleaned Data)
↓

Gold Layer (Star Schema)

↓

Power BI Dashboard

---

Star Schema

### Fact Table

- FactSales

### Dimension Tables

- DimCustomer
- DimProduct
- DimSeller
- DimPayment
- DimReview
- DimDate

---

Dashboard Pages

Executive Dashboard

- Total Revenue
- Total Orders
- Total Customers
- Total Sellers
- Total Products
- Average Review Score

### Sales Analysis

- Monthly Revenue
- Revenue Trend
- Sales by State
- Order Status

### Customer Analysis

- Customer Distribution
- Top Customer Cities
- Revenue by State

### Product Analysis

- Category Performance
- Top Products
- Product Revenue

### Seller Analysis

- Seller Performance
- Revenue by Seller
- Seller Distribution

### Payment Analysis

- Payment Methods
- Installment Analysis

### Review Analysis

- Review Distribution
- Revenue by Rating
- Customer Sentiment

---

## 📁 Project Structure

```
olist-data-warehouse-bi
│
├── Dataset
├── SQL Scripts
│   ├── Database Setup
│   ├── Silver Layer
│   ├── Gold Layer
│   ├── Views
│   └── Optimization
│
├── Power BI
│
├── Images
│
└── Documentation
```

---

SQL Components

### Silver Layer

- Customer
- Orders
- Order Items
- Products
- Sellers
- Payments
- Reviews
- Geolocation
- Category Translation

### Gold Layer

- DimCustomer
- DimProduct
- DimSeller
- DimPayment
- DimReview
- DimDate
- FactSales

### Views

- vwSalesOverview
- vwCustomerAnalysis
- vwProductPerformance
- vwSellerPerformance
- vwPaymentAnalysis
- vwReviewAnalysis
- vwMonthlySales
- vwCategorySales

---

Business KPIs

- Total Revenue
- Total Orders
- Average Order Value
- Monthly Revenue Trend
- Revenue by Category
- Revenue by State
- Top Selling Products
- Top Sellers
- Payment Distribution
- Review Score Analysis

---

Dashboard Preview

> Add screenshots inside the **Images** folder.

Example:

- Executive Dashboard
- Sales Dashboard
- Customer Dashboard
- Product Dashboard

---

Dataset

Brazilian E-Commerce Public Dataset by Olist

https://www.kaggle.com/datasets/olistbr/brazilian-ecommerce

---

How to Run

1. Clone the repository.

2. Create the database in SQL Server.

3. Execute scripts in this order:

Database Setup

↓

Silver Layer

↓

Gold Layer

↓

Views

↓

Indexes

4. Open Power BI.

5. Connect to SQL Server.

6. Load the Gold Views.

7. Refresh the dashboard.

---

Author

**Mohammed Rangwala**

B.Tech Computer Science Engineering

SQL | Power BI | Data Warehousing | Business Intelligence

GitHub:
https://github.com/mohammed-786110
