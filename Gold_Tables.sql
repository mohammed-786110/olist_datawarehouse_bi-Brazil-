-- ADVANCE JOIN QUERRY:

--truncate table gold.DimProduct;

-- select top 5 * from gold.DimProduct;

--drop table gold.DimProduct;
--select * from gold.DimProduct;

/*CREATE TABLE gold.DimProduct
(
    product_key INT IDENTITY(1,1) PRIMARY KEY,
    product_id VARCHAR(100) NOT NULL,
    product_category_name_pt VARCHAR(100),
    product_category_name_en VARCHAR(100),
    product_weight_g INT,
    product_length_cm INT,
    product_height_cm INT,
    product_width_cm INT
);*/
GO

-- select top 5 * from silver.category_name;


/*CREATE TABLE gold.DimProduct
(
    product_key INT IDENTITY(1,1) PRIMARY KEY,
    product_id VARCHAR(100) NOT NULL,
    product_category_name_pt VARCHAR(100),
    product_category_name_en VARCHAR(100),
    product_weight_g INT,
    product_length_cm INT,
    product_height_cm INT,
    product_width_cm INT
)*/


/*insert into gold.DimProduct
(
 product_id,
    product_category_name_pt,
    product_category_name_en,
    product_weight_g,
    product_length_cm,
    product_height_cm,
    product_width_cm
    )
SELECT DISTINCT
    p.product_id,
    p.product_category_name,
    t.column2,
    p.product_weight_g,
    p.product_length_cm,
    p.product_height_cm,
    p.product_width_cm
FROM silver.products p
LEFT JOIN silver.category_name AS t
    ON p.product_category_name = t.column1;*/


select top 5 * from gold.DimProduct;

--truncate table gold.DimProduct;

--drop table gold.DimProduct;

-- PRODUCT TABLE OPTIMIZED
   
select count(*) from gold.DimProduct;
select count(distinct product_id) from silver.products;

-- OPTIMIZED SELLER TABLE

select top 5 * from silver.sellers;

/*create table gold.DimSeller
(
seller_key INT IDENTITY(1,1) PRIMARY KEY,
    seller_id VARCHAR(100) NOT NULL,
    seller_city VARCHAR(100),
    seller_state CHAR(2)
);
go

INSERT INTO gold.DimSeller
(
    seller_id,
    seller_city,
    seller_state
)
SELECT DISTINCT
    seller_id,
    seller_city,
    seller_state
FROM silver.sellers;

SELECT COUNT(*)
FROM gold.DimSeller;

SELECT COUNT(DISTINCT seller_id)
FROM silver.sellers;*/

select top 10 * from gold.DimSeller;

/*UPDATE gold.DimSeller
SET seller_city =
    CONCAT(
        UPPER(LEFT(seller_city,1)),
        LOWER(SUBSTRING(seller_city,2,LEN(seller_city)))
    );


-- ADDING A REGION COLUMN FOR SELLERS:
alter table gold.DimSeller
add seller_region varchar(20);

select top 10 * from gold.DimSeller;

update gold.DimSeller
set seller_region=
CASE
   when seller_state in ('AC','AM','AP','PA','RO','RR','TO')
      Then 'North'
   WHEN seller_state IN ('AL','BA','CE','MA','PB','PE','PI','RN','SE')
        THEN 'Northeast'

    WHEN seller_state IN ('DF','GO','MT','MS')
        THEN 'Central-West'

    WHEN seller_state IN ('ES','MG','RJ','SP')
        THEN 'Southeast'

    WHEN seller_state IN ('PR','RS','SC')
        THEN 'South'

    ELSE 'Unknown'
END;*/

select distinct seller_region, seller_state from 
gold.DimSeller
order by seller_region,seller_state;
-- OPTIMIZESD SELLER


--- OPTIMISED PAYMENT------

select * from silver.payments;
select * from gold.DimPayment;

/*CREATE TABLE gold.DimPayment
(
    payment_key INT IDENTITY(1,1) PRIMARY KEY,

    payment_type VARCHAR(30) NOT NULL,

    payment_installments INT NOT NULL,

    installment_category VARCHAR(20),

    payment_method_group VARCHAR(30),

    load_date DATETIME DEFAULT GETDATE()
);
GO


INSERT INTO gold.DimPayment
(
    payment_type,
    payment_installments,
    installment_category,
    payment_method_group
)
SELECT DISTINCT

    payment_type,

    payment_installments,
    CASE
        WHEN payment_installments = 1 THEN 'Single Payment'
        WHEN payment_installments BETWEEN 2 AND 6 THEN 'Short EMI'
        WHEN payment_installments >= 7 THEN 'Long EMI'
        ELSE 'Unknown'

    END AS installment_category,
    CASE
        WHEN payment_type IN ('credit_card', 'debit_card')
            THEN 'Card'

        WHEN payment_type = 'boleto'
            THEN 'Cash Equivalent'

        WHEN payment_type = 'voucher'
            THEN 'Voucher'

        ELSE 'Other'
    END AS payment_method_group
    from silver.payments;
    go */
      
select * from gold.DimPayment;
select count(*) from silver.payments;

---- OPTIMISED DATE TABLE:


select top 10 * from silver.order_items;

SELECT
    MIN(CAST(order_purchase_timestamp AS DATE)) AS StartDate,
    MAX(CAST(order_purchase_timestamp AS DATE)) AS EndDate
FROM silver.orders;

CREATE TABLE gold.DimDate
(
    date_key INT PRIMARY KEY,
    full_date DATE NOT NULL,
    day_number TINYINT NOT NULL,
    month_number TINYINT NOT NULL,
    month_name VARCHAR(20) NOT NULL,
    quarter_number TINYINT NOT NULL,
    year_number SMALLINT NOT NULL,
    week_number TINYINT NOT NULL,
    day_name VARCHAR(20) NOT NULL,
    is_weekend BIT NOT NULL,
    load_date DATETIME DEFAULT GETDATE()
);
GO

DECLARE @StartDate DATE = '2016-09-04';
DECLARE @EndDate DATE = '2018-10-17';

WHILE @StartDate <= @EndDate
BEGIN

    INSERT INTO gold.DimDate
    (
        date_key,
        full_date,
        day_number,
        month_number,
        month_name,
        quarter_number,
        year_number,
        week_number,
        day_name,
        is_weekend
    )

    VALUES
    (
        YEAR(@StartDate) * 10000 +
        MONTH(@StartDate) * 100 +
        DAY(@StartDate),

        @StartDate,

        DAY(@StartDate),

        MONTH(@StartDate),

        DATENAME(MONTH, @StartDate),

        DATEPART(QUARTER, @StartDate),

        YEAR(@StartDate),

        DATEPART(ISO_WEEK, @StartDate),

        DATENAME(WEEKDAY, @StartDate),

        CASE
            WHEN DATENAME(WEEKDAY, @StartDate) IN ('Saturday', 'Sunday')
            THEN 1
            ELSE 0
        END
    );

    SET @StartDate = DATEADD(DAY, 1, @StartDate);

END;
GO

select * from gold.DimDate;

SELECT COUNT(*) AS TotalDates
FROM gold.DimDate;

SELECT TOP 10 *
FROM gold.DimDate
ORDER BY full_date;

---- REVIEW TABLE OPTIMISED

select * from silver.reviews;

/*CREATE TABLE gold.DimReview
(
    review_key INT IDENTITY(1,1) PRIMARY KEY,
    review_id VARCHAR(100) NOT NULL,
    review_score TINYINT NOT NULL,

    review_rating_category VARCHAR(20),

    review_sentiment VARCHAR(20),

    review_comment_message VARCHAR(MAX),

    review_creation_date DATE,

    review_answer_timestamp DATETIME,

    has_comment BIT,

    load_date DATETIME DEFAULT GETDATE()
);*/
GO

/*INSERT INTO gold.DimReview
(
    review_id,
    review_score,
    review_rating_category,
    review_sentiment,
    
    review_comment_message,
    review_creation_date,
    review_answer_timestamp,
    has_comment
)

SELECT DISTINCT

    review_id,

    review_score,
    -- doing sentiment analysis
    CASE
        WHEN review_score = 5 THEN 'Excellent'
        WHEN review_score = 4 THEN 'Good'
        WHEN review_score = 3 THEN 'Average'
        WHEN review_score = 2 THEN 'Poor'
        WHEN review_score = 1 THEN 'Very Poor'
        ELSE 'Unknown'
    END AS review_rating_category,

    CASE
        WHEN review_score >= 4 THEN 'Positive'
        WHEN review_score = 3 THEN 'Neutral'
        ELSE 'Negative'
    END AS review_sentiment,

   

    review_comment_message,

    CAST(review_creation_date AS DATE),

    review_answer_timestamp,

    CASE
        WHEN review_comment_message = 'No comment'
             OR LTRIM(RTRIM(review_comment_message)) = ''
        THEN 0
        ELSE 1
    END AS has_comment

FROM silver.reviews;*/
GO

select top 10 * from gold.DimReview;

drop table gold.DimReview;







