IF OBJECT_ID ('olist_customer', 'u') IS NOT NULL
   DROP TABLE olist_customer;
CREATE TABLE olist_customer (
customer_id NVARCHAR(100) PRIMARY KEY,
unique_id NVARCHAR(100),
cust_zipcod INT,
cust_city NVARCHAR(100),
Cust_state NVARCHAR(100) 

);

IF OBJECT_ID ('olist_geolaction', 'u') IS NOT NULL
   DROP TABLE olist_geolaction;
CREATE TABLE olist_geolaction(
geo_zip DECIMAL(18,8),
geo_lat DECIMAL(18, 8),
geo_city NVARCHAR(100),
geo_state NVARCHAR(10)
)
IF OBJECT_ID ('olist_order_items', 'u') IS NOT NULL
   DROP TABLE olist_order_items;
CREATE TABLE olist_order_items ( 
order_id NVARCHAR(100) PRIMARY KEY,
ORDER_ITEM_ID INT,
product_id NVARCHAR(100),
seller_id NVARCHAR(100),
shipping_date DATETIME,
price INT,
freight_value INT

);

IF OBJECT_ID ('olist_order_payment', 'u') IS NOT NULL
   DROP TABLE olist_order_payment;
CREATE TABLE olist_order_payment (
order_id NVARCHAR(100) PRIMARY KEY,
Payment_sequential INT,
payment_type NVARCHAR(30),
payment_installments INT,
payment_value INT

)

IF OBJECT_ID ('olist_order_reviews', 'u') IS NOT NULL
   DROP TABLE olist_order_reviews;
CREATE TABLE olist_order_reviews (
Review_id NVARCHAR(100) PRIMARY KEY,
order_id NVARCHAR(100),
review_score INT,
review_comment_title NVARCHAR(50),
review_comment_message NVARCHAR(100),
review_creation_date DATETIME,
review_answer_timestamp DATETIME

);

IF OBJECT_ID ('olist_orders', 'u') IS NOT NULL
   DROP TABLE olist_orders;
CREATE TABLE olist_orders (
  order_id NVARCHAR(100) PRIMARY KEY,
    customer_id NVARCHAR(100),
    order_status NVARCHAR(100),
    order_purchase_timestamp DATETIME,
    order_approved_at DATETIME,
    order_delivered_carrier_date DATETIME,
    order_delivered_customer_date DATETIME,
    order_estimated_delivery_date DATETIME

);

IF OBJECT_ID ('olist_products', 'u') IS NOT NULL
   DROP TABLE olist_products;
CREATE TABLE olist_products (
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
IF OBJECT_ID('olist_sellerst','u') IS NOT NULL
   DROP TABLE olist_sellers;
CREATE TABLE olit_sellers (
    seller_id VARCHAR(50) PRIMARY KEY,
    seller_zip_code_prefix INT,
    seller_city VARCHAR(100),
    seller_state CHAR(2)
);
CREATE TABLE prod_cat_translation (
    product_category_name VARCHAR(100) PRIMARY KEY,
    product_category_name_english VARCHAR(100)
);
