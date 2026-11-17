-- SELECT, WHERE, AND/OR, IN, BETWEEN, LIKE (17 Nov - Day 1)

-- CREATE TABLE orders (
--     order_id INT PRIMARY KEY,
--     customer_name VARCHAR(50),
--     city VARCHAR(30),
--     category VARCHAR(30),
--     amount DECIMAL(10, 2),
--     order_date DATE,
--     status VARCHAR(20)
-- );

-- INSERT INTO orders VALUES
-- (101, 'Aarav Sharma', 'Mumbai', 'Electronics', 45000.00, '2026-10-05', 'Delivered'),
-- (102, 'Priya Verma', 'Delhi', 'Fashion', 2500.00, '2026-10-12', 'Delivered'),
-- (103, 'Rohan Mehta', 'Bangalore', 'Electronics', 72000.00, '2026-10-15', 'Cancelled'),
-- (104, 'Ananya Iyer', 'Hyderabad', 'Groceries', 1200.00, '2026-10-18', 'Delivered'),
-- (105, 'Vikram Singh', 'Mumbai', 'Fashion', 4800.00, '2026-10-20', 'Returned'),
-- (106, 'Neha Gupta', 'Pune', 'Home Decor', 8500.00, '2026-11-01', 'Delivered'),
-- (107, 'Arjun Reddy', 'Hyderabad', 'Electronics', 18500.00, '2026-11-03', 'Delivered'),
-- (108, 'Sneha Nair', 'Bangalore', 'Fashion', 3200.00, '2026-11-05', 'Pending'),
-- (109, 'Kabir Khan', 'Delhi', 'Home Decor', 12000.00, '2026-11-08', 'Delivered'),
-- (110, 'Meera Joshi', 'Mumbai', 'Groceries', 950.00, '2026-11-10', 'Delivered'),
-- (111, 'Aditya Das', 'Chennai', 'Electronics', 55000.00, '2026-11-12', 'Pending'),
-- (112, 'Riya Sen', 'Kolkata', 'Fashion', 6100.00, '2026-11-15', 'Delivered');


-- SELECT & WHERE
-- Only Delivered orders
SELECT
  order_id,
  customer_name,
  amount,
  [status]
FROM
  orders
WHERE
  [status] = 'Delivered';


-- Amount > 10000
SELECT
  order_id,
  customer_name,
  amount
FROM
  orders
WHERE
  amount > 10000;


-- AND Operator
-- Mumbai's Electronics items orders
SELECT
  order_id,
  city,
  category
FROM
  orders
WHERE
  city = 'Mumbai' AND category = 'Electronics';


-- OR Operator
SELECT
  order_id,
  [status]
FROM
  orders
WHERE
  [status] = 'Cancelled' OR [status] = 'Returned';


-- Operator predence 
-- Filter only Delivered orders from Mumbai and Delhi
SELECT
  *
FROM
  orders
WHERE
  (city = 'Mumbai' OR city = 'Delhi') AND [status] = 'Delivered';


-- IN operator
-- Filter orders by Mumbai, Bengaluru and Hyderabad
SELECT  
  order_id,
  city
FROM
  orders
WHERE
  city IN ('Mumbai', 'Bangalore', 'Hyderabad');


-- NOT IN Operator
-- Remove electronics and fashion cat
SELECT
  order_id,
  category
FROM  
  orders
WHERE
  category NOT IN ('Electronics', 'Fashion');


-- BETWEEN Operator (Numbers)
-- Amount is between 2000 and 10000
SELECT
  order_id,
  amount
FROM
  orders
WHERE
  amount BETWEEN 2000 AND 10000;


-- BETWEEN Operator (Dates)
-- Orders between 1 Oct 2026 and 31 Oct 2026
SELECT
  order_id,
  order_date
FROM
  orders
WHERE
  order_date BETWEEN '2026-10-01' AND '2026-10-31';


-- LIKE OPERATOR
-- Customer names start with A
SELECT
  order_id,
  customer_name
FROM
  orders
WHERE
  customer_name LIKE 'A%';


-- Customer names end with Sharma or Verma
SELECT
  order_id,
  customer_name
FROM
  orders
WHERE
  customer_name LIKE '%ma';


-- Customer first names exact with 5 letter
SELECT
  order_id,
  customer_name
FROM
  orders
WHERE 
  customer_name LIKE '_____ %';




