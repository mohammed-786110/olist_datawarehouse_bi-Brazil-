use olist_ecommerce;
/*go
create Table gold.DimCustomer
(
 customer_key INT IDENTITY(1,1) PRIMARY KEY,
 customer_id VARCHAR(50) NOT NULL,
 customer_unique_id VARCHAR(50),
 customer_city VARCHAR(100),
 customer_state CHAR(2)

); */

-- select * from gold.DimCustomer;
/*insert into gold.DimCustomer
(
    customer_id,
    customer_unique_id,
    customer_city,
    customer_state
)
SELECT DISTINCT
    customer_id,
    customer_unique_id,
    customer_city,
    customer_state
FROM silver.c_olist_customers_dataset;*/


-- select *  from silver.c_olist_customers_dataset;



-- select count(*) from silver.c_olist_customers_dataset;

-- SELECT COUNT(DISTINCT customer_id)
-- FROM silver.c_olist_customers_dataset;

-- Debugging the count:

-- select count(*) as Totalrows from gold.DimCustomer;

--select count(distinct customer_id) as unique_cust
-- from gold.DimCustomer;

--truncate table gold.DimCustomer;
--select count(*) from gold.DimCustomer;

/*INSERT INTO gold.DimCustomer
(
    customer_id,
    customer_unique_id,
    customer_city,
    customer_state
)
SELECT DISTINCT
    customer_id,
    customer_unique_id,
    customer_city,
    customer_state
FROM silver.c_olist_customers_dataset;*/

GO
select count(*) from gold.DimCustomer;

go
select count(distinct customer_id) from silver.c_olist_customers_dataset;

go 
select top 10 * from gold.DimCustomer;

-- DIMCUSTOMER COMPLETED.

go
select top 10 * from silver.products;

go
/*create table gold.DimProduct
(
product_key int identity(1,1) primary key,
product_id varchar(50) not null,
product_category_name VARCHAR(255),
product_weight_g INT,
product_length_cm INT,
product_height_cm INT,
product_width_cm INT
)*/

go
/*insert into gold.DimProduct
(
    product_id,
    product_category_name,
    product_weight_g,
    product_length_cm,
    product_height_cm,
    product_width_cm
)
select distinct 
    product_id,
    product_category_name,
    product_weight_g,
    product_length_cm,
    product_height_cm,
    product_width_cm
from silver.products;*/

go

select count(*) as optimized_count from gold.DimProduct;

select count(distinct product_id) as original_count from silver.products ;

--truncate table gold.DimProduct;

select top 10 * from gold.DimProduct;