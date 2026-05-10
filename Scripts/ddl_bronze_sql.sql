IF OBJECT_ID ('olist_customer_dataset', 'u') IS NOT NULL
   DROP TABLE olist_customer_dataset;
CREATE TABLE cust_dataset (
customer_id NVARCHAR(100) PRIMARY KEY,
unique_id NVARCHAR(100),
cust_zipcod INT,
cust_city NVARCHAR(100),
Cust_state NVARCHAR(100) 

);

IF OBJECT_ID ('olist_geolaction_dataset', 'u') IS NOT NULL
   DROP TABLE olist_geolaction_dataset;
CREATE TABLE olist_geolaction_dataset (
geo_zip INT,
geo_lat DECIMAL(18, 8),
geo_city NVARCHAR(100),
geo_state NVARCHAR(2)
)
IF OBJECT_ID ('olist_order_items_dataset', 'u') IS NOT NULL
   DROP TABLE olist_order_items_dataset;
CREATE TABLE olist_order_items_dataset ( 
order_id NVARCHAR(100) PRIMARY KEY,
ORDER_ITEM_ID INT,
product_id NVARCHAR(100),
seller_id NVARCHAR(100),
shipping_date DATETIME,
price INT,
freight_value INT

);

IF OBJECT_ID ('olist_order_payment_dataset', 'u') IS NOT NULL
   DROP TABLE olist_order_payment_dataset;
CREATE TABLE olist_order_payment_dataset (
order_id NVARCHAR(100) PRIMARY KEY,
Payment_sequential INT,
payment_type NVARCHAR(30),
payment_installments INT,
payment_value INT

)

IF OBJECT_ID ('olist_order_reviews_dataset', 'u') IS NOT NULL
   DROP TABLE olist_order_reviews_dataset;
CREATE TABLE olist_order_reviews_dataset (
Review_id NVARCHAR(100) PRIMARY KEY,
order_id NVARCHAR(100),
review_score INT,
review_comment_title NVARCHAR(50),
review_comment_message NVARCHAR(100),
review_creation_date DATETIME,
review_answer_timestamp DATETIME

);

IF OBJECT_ID ('olist_orders_dataset', 'u') IS NOT NULL
   DROP TABLE olist_orders_dataset;
CREATE TABLE olist_orders_dataset (
  order_id NVARCHAR(50) PRIMARY KEY,
    customer_id NVARCHAR(50),
    order_status NVARCHAR(20),
    order_purchase_timestamp DATETIME,
    order_approved_at DATETIME,
    order_delivered_carrier_date DATETIME,
    order_delivered_customer_date DATETIME,
    order_estimated_delivery_date DATETIME

);

IF OBJECT_ID ('olist_products_dataset', 'u') IS NOT NULL
   DROP TABLE olist_products_dataset;
CREATE TABLE olist_products_dataset (
    product_id NVARCHAR(50) PRIMARY KEY,
    product_category_name NVARCHAR(100),
    product_name_lenght INT,
    product_description_lenght INT,
    product_photos_qty INT,
    product_weight_g INT,
    product_length_cm INT,
    product_height_cm INT,
    product_width_cm INT
);
IF OBJECT_ID('olist_sellers_dataset','u') IS NOT NULL
   DROP TABLE olist_sellers_dataset;
CREATE TABLE olist_sellers_dataset (
    seller_id VARCHAR(50) PRIMARY KEY,
    seller_zip_code_prefix INT,
    seller_city VARCHAR(100),
    seller_state CHAR(2)
);
CREATE TABLE product_category_translation (
    product_category_name VARCHAR(100) PRIMARY KEY,
    product_category_name_english VARCHAR(100)
);
