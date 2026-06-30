use olist_ecommerce;

select * from gold.DimSeller;
--select count(distinct seller_key) as count from gold.DimSeller where seller_region='Southeast';

-- OPTIMIZED FACT TABLE:

CREATE TABLE gold.FactSales
(
    sales_key BIGINT IDENTITY(1,1) PRIMARY KEY,

    order_id VARCHAR(50) NOT NULL,
    order_item_id INT NOT NULL,

    customer_key INT NOT NULL,
    product_key INT NOT NULL,
    seller_key INT NOT NULL,
    payment_key INT NOT NULL,
    review_key INT NULL,

    purchase_date_key INT NOT NULL,

    order_status VARCHAR(30),

    price DECIMAL(10,2),
    freight_value DECIMAL(10,2),
    payment_value DECIMAL(10,2),

    load_date DATETIME DEFAULT GETDATE()
);
GO


-- making a cte 
select top 5 * from silver.payments;

-- aggregating payment for same order
with PaymentAgg as 
(
select 
order_id,
sum(payment_value) as payment_value,
max(payment_type) as payment_type,
max(payment_installments) as payment_installments
from silver.payments
group by order_id
)
select count(distinct order_id) from PaymentAgg;

-- aggregating reviwe or choosing max review

with reviewAgg as (
select 
order_id,
max(review_id) as rvid
from silver.reviews
group by order_id
)
select count(*) from reviewAgg;


SELECT TOP 5 * FROM gold.DimCustomer;

SELECT TOP 5 * FROM gold.DimReview;

alter table gold.DimReview
add order_id varchar(50);

UPDATE dr
SET dr.order_id = sr.order_id
FROM gold.DimReview dr
INNER JOIN silver.reviews sr
ON dr.review_id = sr.review_id;


CREATE INDEX IX_DimReview_OrderID
ON gold.DimReview(order_id);

