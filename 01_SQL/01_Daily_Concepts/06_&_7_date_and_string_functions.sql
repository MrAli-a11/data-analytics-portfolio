-- Date Functions (DATEDIFF, DATE_TRUNC, EXTRACT) (22 Nov - Day 6 & 7)


-- CREATE TABLE customers_clean (
--     customer_id INT,
--     full_name VARCHAR(60),
--     email VARCHAR(80),
--     city VARCHAR(40),
--     signup_date DATE
-- );

-- INSERT INTO customers_clean VALUES
-- (1, '  aarav sharma  ', 'Aarav.Sharma@Gmail.COM', '  Mumbai ', '2026-08-15'),
-- (2, 'Priya Verma   ', NULL, 'delhi', '2026-09-01'),
-- (3, '  rohan mehta', 'rohan.m@yahoo.com', ' BANGALORE  ', '2026-09-20'),
-- (4, 'Ananya Iyer', 'ananya.iyer@outlook.com', NULL, '2026-10-10'),
-- (5, ' vikram   singh ', 'vikram.s@gmail.com', 'Pune', '2026-11-01');


-- Year & Month (orders):
SELECT
  order_id,
  order_date,
  YEAR(order_date) AS order_year,
  MONTH(order_date) AS order_month
FROM
  orders



-- Monthly Sales (orders):
SELECT  
  DATEFROMPARTS(YEAR(order_date), MONTH(order_date), 1) AS month_name,
  COUNT(order_id) AS total_orders,
  SUM(amount) AS total_sales
FROM
  orders
GROUP BY
  DATEFROMPARTS(YEAR(order_date), MONTH(order_date), 1)


-- Days Since Order (orders):
SELECT
  order_id,
  DATEDIFF(DAY, order_date, '2026-11-23') AS days_since_order
FROM
  orders



-- Signup Days (customers_clean):
SELECT  
  customer_id,
  DATEDIFF(DAY, signup_date, GETDATE()) AS signup_days
FROM
  customers_clean



-- Clean Name & City (customers_clean)
SELECT
  TRIM(full_name) AS full_name,
  TRIM(city) AS City
FROM
  customers_clean


-- Email Domain (customers_clean):
SELECT  
  COALESCE(SUBSTRING(email, CHARINDEX('@', email) + 1, LEN(email)), 'No Email') AS  email_domain
FROM
  customers_clean



-- Customer Profile String (customers_clean)
SELECT  
  CONCAT(
    TRIM(full_name), ' | ',
    COALESCE(TRIM(city), 'Unknown City'), ' | ',
    COALESCE(TRIM(email), 'Missing Email')
  ) AS customer_profile
FROM
  customers_clean



-- Name Prefix (customers_clean):
SELECT
  SUBSTRING(TRIM(full_name), 1, 6) AS name_prefix,
  LEN( SUBSTRING(TRIM(full_name), 1, 6)) AS name_prefix_len
FROM
  customers_clean