--- JOINS FOR FACT TABLE 
use olist_ecommerce;

select top 2 * from silver.order_items;

-- VERIFYING DIMENSIONAL JOINS:
WITH PaymentAgg AS
(
    SELECT
        order_id,
        SUM(payment_value) AS payment_value,
        MAX(payment_type) AS payment_type,
        MAX(payment_installments) AS payment_installments
    FROM silver.payments
    GROUP BY order_id
),

ReviewAgg AS
(
    SELECT
        order_id,
        MAX(review_id) AS review_id
    FROM silver.reviews
    GROUP BY order_id
)

SELECT count(*) 
    /*o.order_id,

    oi.order_item_id,

    c.customer_key,

    p.product_key,

    s.seller_key,

    dp.payment_key,

    dr.review_key,

    d.date_key,

    o.order_status,

    oi.price,

    oi.freight_value,
    
    pay.payment_value*/

FROM silver.orders o

INNER JOIN silver.order_items oi
    ON o.order_id = oi.order_id

INNER JOIN gold.DimCustomer c
    ON o.customer_id = c.customer_id

INNER JOIN gold.DimProduct p
    ON oi.product_id = p.product_id

INNER JOIN gold.DimSeller s
    ON oi.seller_id = s.seller_id

LEFT JOIN PaymentAgg pay
    ON o.order_id = pay.order_id

LEFT JOIN gold.DimPayment dp
    ON pay.payment_type = dp.payment_type
   AND pay.payment_installments = dp.payment_installments

LEFT JOIN ReviewAgg r
    ON o.order_id = r.order_id

LEFT JOIN gold.DimReview dr
    ON r.review_id = dr.review_id

INNER JOIN gold.DimDate d
    ON CAST(o.order_purchase_timestamp AS DATE) = d.full_date;




drop table gold.FactSales;

CREATE TABLE gold.FactSales
(
    sales_key BIGINT IDENTITY(1,1) PRIMARY KEY,

    order_id VARCHAR(50) NOT NULL,
    order_item_id INT NOT NULL,

    customer_key INT NOT NULL,
    product_key INT NOT NULL,
    seller_key INT NOT NULL,
    payment_key INT NULL,
    review_key INT NULL,
    purchase_date_key INT NOT NULL,

    order_status VARCHAR(30),

    price DECIMAL(10,2),
    freight_value DECIMAL(10,2),
    payment_value DECIMAL(10,2),

    load_date DATETIME DEFAULT GETDATE()
);

select * from gold.FactSales;





WITH PaymentAgg AS
(
    SELECT
        order_id,
        SUM(payment_value) AS payment_value,
        MAX(payment_type) AS payment_type,
        MAX(payment_installments) AS payment_installments
    FROM silver.payments
    GROUP BY order_id
),

ReviewAgg AS
(
    SELECT
        order_id,
        MAX(review_id) AS review_id
    FROM silver.reviews
    GROUP BY order_id
)
INSERT INTO gold.FactSales
(
    order_id,
    order_item_id,
    customer_key,
    product_key,
    seller_key,
    payment_key,
    review_key,
    purchase_date_key,
    order_status,
    price,
    freight_value,
    payment_value
)
SELECT 
    o.order_id,

    oi.order_item_id,

    c.customer_key,

    p.product_key,

    s.seller_key,

    dp.payment_key,

    dr.review_key,

    d.date_key,

    o.order_status,

    oi.price,

    oi.freight_value,
    
    pay.payment_value

FROM silver.orders o

INNER JOIN silver.order_items oi
    ON o.order_id = oi.order_id

INNER JOIN gold.DimCustomer c
    ON o.customer_id = c.customer_id

INNER JOIN gold.DimProduct p
    ON oi.product_id = p.product_id

INNER JOIN gold.DimSeller s
    ON oi.seller_id = s.seller_id

LEFT JOIN PaymentAgg pay
    ON o.order_id = pay.order_id

LEFT JOIN gold.DimPayment dp
    ON pay.payment_type = dp.payment_type
   AND pay.payment_installments = dp.payment_installments

LEFT JOIN ReviewAgg r
    ON o.order_id = r.order_id

LEFT JOIN gold.DimReview dr
    ON r.review_id = dr.review_id

INNER JOIN gold.DimDate d
    ON CAST(o.order_purchase_timestamp AS DATE) = d.full_date;


 select count(*) from gold.FactSales;

 SELECT COUNT(*)
FROM gold.FactSales
WHERE customer_key IS NULL;

SELECT COUNT(*)
FROM gold.FactSales
WHERE product_key IS NULL;


SELECT COUNT(*)
FROM gold.FactSales
WHERE seller_key IS NULL;

SELECT COUNT(*)
FROM gold.FactSales
WHERE seller_key IS NULL;

SELECT COUNT(*)
FROM gold.FactSales
WHERE purchase_date_key IS NULL;




/*CREATE INDEX IX_FactSales_Customer
ON gold.FactSales(customer_key);
GO

CREATE INDEX IX_FactSales_Product
ON gold.FactSales(product_key);
GO

CREATE INDEX IX_FactSales_Seller
ON gold.FactSales(seller_key);
GO

CREATE INDEX IX_FactSales_Payment
ON gold.FactSales(payment_key);
GO

CREATE INDEX IX_FactSales_Review
ON gold.FactSales(review_key);
GO

CREATE INDEX IX_FactSales_Date
ON gold.FactSales(purchase_date_key);
GO

CREATE INDEX IX_FactSales_Order
ON gold.FactSales(order_id);
GO*/

/*CREATE VIEW gold.vwSalesOverview
AS

SELECT

    fs.sales_key,
    fs.order_id,

    dd.full_date,

    dc.customer_city,
    dc.customer_state,

    dp.product_category_name_en,

    ds.seller_city,
    ds.seller_state,

    pay.payment_type,

    rv.review_score,

    fs.order_status,

    fs.price,

    fs.freight_value,

    fs.payment_value

FROM gold.FactSales fs

INNER JOIN gold.DimCustomer dc
ON fs.customer_key = dc.customer_key

INNER JOIN gold.DimProduct dp
ON fs.product_key = dp.product_key

INNER JOIN gold.DimSeller ds
ON fs.seller_key = ds.seller_key

LEFT JOIN gold.DimPayment pay
ON fs.payment_key = pay.payment_key

LEFT JOIN gold.DimReview rv
ON fs.review_key = rv.review_key

INNER JOIN gold.DimDate dd
ON fs.purchase_date_key = dd.date_key;
GO

select * from gold.vwSalesOverview;*/