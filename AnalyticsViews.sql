-- CREATING THE VIEWS FOR EASY DATA ANALYSIS:


CREATE VIEW gold.vwCustomerAnalysis
AS
SELECT
    fs.sales_key,
    fs.order_id,

    dc.customer_id,
    dc.customer_city,
    dc.customer_state,

    dd.full_date,

    fs.price,
    fs.freight_value,
    fs.payment_value,

    fs.order_status

FROM gold.FactSales fs

INNER JOIN gold.DimCustomer dc
    ON fs.customer_key = dc.customer_key

INNER JOIN gold.DimDate dd
    ON fs.purchase_date_key = dd.date_key;
GO

select top 10 * from gold.vwCustomerAnalysis;






CREATE VIEW gold.vwProductPerformance
AS
SELECT
    fs.sales_key,
    fs.order_id,

    dp.product_id,
    dp.product_category_name_en,

    dp.product_weight_g,
    dp.product_length_cm,
    dp.product_height_cm,
    dp.product_width_cm,

    dd.full_date,

    fs.price,
    fs.freight_value,
    fs.payment_value,

    fs.order_status

FROM gold.FactSales fs

INNER JOIN gold.DimProduct dp
    ON fs.product_key = dp.product_key

INNER JOIN gold.DimDate dd
    ON fs.purchase_date_key = dd.date_key;
GO

select top 10 * from gold.vwProductPerformance;





CREATE VIEW gold.vwSellerPerformance
AS
SELECT
    fs.sales_key,
    fs.order_id,

    ds.seller_id,
    ds.seller_city,
    ds.seller_state,

    dd.full_date,

    fs.price,
    fs.freight_value,
    fs.payment_value,

    fs.order_status

FROM gold.FactSales fs

INNER JOIN gold.DimSeller ds
    ON fs.seller_key = ds.seller_key

INNER JOIN gold.DimDate dd
    ON fs.purchase_date_key = dd.date_key;
GO

select top 10 * from gold.vwSellerPerformance;





CREATE VIEW gold.vwPaymentAnalysis
AS
SELECT
    fs.sales_key,
    fs.order_id,

    dp.payment_type,
    dp.payment_installments,

    dd.full_date,

    fs.payment_value,

    fs.order_status

FROM gold.FactSales fs

LEFT JOIN gold.DimPayment dp
    ON fs.payment_key = dp.payment_key

INNER JOIN gold.DimDate dd
    ON fs.purchase_date_key = dd.date_key;
GO

select top 10 * from gold.vwPaymentAnalysis;








CREATE VIEW gold.vwReviewAnalysis
AS
SELECT
    fs.sales_key,
    fs.order_id,

    dr.review_score,
    dr.review_rating_category,
    dr.review_sentiment,

    dd.full_date,

    fs.price,
    fs.payment_value,

    fs.order_status

FROM gold.FactSales fs

LEFT JOIN gold.DimReview dr
    ON fs.review_key = dr.review_key

INNER JOIN gold.DimDate dd
    ON fs.purchase_date_key = dd.date_key;
GO



select top 10 * from gold.vwReviewAnalysis;












CREATE VIEW gold.vwMonthlySales
AS
SELECT

    dd.year_number,

    dd.month_name,

    dd.month_number,

    COUNT(DISTINCT fs.order_id) AS TotalOrders,

    SUM(fs.payment_value) AS TotalRevenue,

    AVG(fs.payment_value) AS AverageOrderValue

FROM gold.FactSales fs

INNER JOIN gold.DimDate dd
    ON fs.purchase_date_key = dd.date_key

GROUP BY

    dd.year_number,

    dd.month_number,

    dd.month_name;
GO

select * from gold.vwMonthlySales
order by year_number,month_number;






CREATE VIEW gold.vwCategorySales
AS
SELECT

    dp.product_category_name_en,

    COUNT(DISTINCT fs.order_id) AS TotalOrders,

    SUM(fs.payment_value) AS TotalRevenue,

    AVG(fs.payment_value) AS AverageOrderValue

FROM gold.FactSales fs

INNER JOIN gold.DimProduct dp
    ON fs.product_key = dp.product_key

GROUP BY

    dp.product_category_name_en;
GO

select * from gold.vwCategorySales
order by TotalRevenue desc;



select count(*) from gold.DimCustomer;

-- THIS WE WILL BE LOADING INTO POWER BI FOR EASY ANALYSIS
