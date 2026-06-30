
use olist_ecommerce;
select * from silver.orders;


select * from silver.payments;
select payment_type, sum(payment_value) as Total_Payment from silver.payments

group by payment_type order by Total_Payment desc;

select sum(payment_value) as revenue from silver.payments;

select count(*) from silver.c_olist_customers_dataset;
select count(*) from silver.orders;
select count(*) from silver.category

select count(*) from silver.payments;
select count(*) from silver.products;
select count(*) from silver.sellers;

select count(*) from silver.c_olist_customers_dataset;
select count(distinct customer_id) from silver.c_olist_customers_dataset;

SELECT COUNT(*) FROM silver.orders;
SELECT COUNT(DISTINCT order_id) FROM silver.orders;

SELECT COUNT(*) FROM silver.products;
SELECT COUNT(DISTINCT product_id) FROM silver.products;

SELECT customer_id, COUNT(*) as count
FROM silver.c_olist_customers_dataset
GROUP BY customer_id
HAVING COUNT(*) > 1; 



select * from silver.products;