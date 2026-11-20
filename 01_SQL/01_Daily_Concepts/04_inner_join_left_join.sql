-- INNER JOIN and LEFT JOIN (20 Nov - Day 4)

-- CREATE TABLE customers_j (
--     customer_id INT PRIMARY KEY,
--     customer_name VARCHAR(50),
--     city VARCHAR(30)
-- );

-- CREATE TABLE orders_j (
--     order_id INT PRIMARY KEY,
--     customer_id INT,
--     amount DECIMAL(10, 2),
--     order_status VARCHAR(20)
-- );

-- INSERT INTO customers_j VALUES
-- (1, 'Aarav Sharma', 'Mumbai'),
-- (2, 'Priya Verma', 'Delhi'),
-- (3, 'Rohan Mehta', 'Bangalore'),
-- (4, 'Ananya Iyer', 'Hyderabad'),
-- (5, 'Vikram Singh', 'Pune');

-- INSERT INTO orders_j VALUES
-- (101, 1, 45000.00, 'Delivered'),
-- (102, 1, 12000.00, 'Delivered'),
-- (103, 2, 8500.00, 'Cancelled'),
-- (104, 3, 25000.00, 'Delivered'),
-- (105, 4, 6000.00, 'Pending'),
-- (106, 99, 15000.00, 'Delivered'); -- customer_id 99 customers_j mein nahi hai



-- Basic INNER JOIN
SELECT
  O.order_id,
  C.customer_name,
  C.city,
  O.amount,
  O.order_status
FROM
  customers_j C  
INNER JOIN
  orders_j O  
ON C.customer_id = O.customer_id


-- Filtered INNER JOIN
SELECT
    O.order_status,
    C.customer_name,
    C.city,
    O.amount
FROM
  customers_j C 
INNER JOIN
  orders_j O  
ON C.customer_id = O.customer_id
WHERE
  O.order_status = 'Delivered'


-- INNER JOIN + GROUP BY
SELECT  
  C.customer_name,
  COUNT(*) AS total_orders,
  SUM(amount) AS total_sales
FROM
  customers_j C  
INNER JOIN
  orders_j O  
ON C.customer_id = O.customer_id
GROUP BY
  C.customer_name


-- Basic LEFT JOIN:
SELECT  
  C.customer_name,
  C.city,
  O.order_id,
  O.amount,
  O.order_status
FROM
  customers_j C 
LEFT JOIN
  orders_j O  
ON C.customer_id = O.customer_id
-- VIKARAM SINGH K SATH NULL AAYA

-- Zero-Order Customers (LEFT JOIN + IS NULL):
SELECT  
  C.customer_name,
  C.city
FROM
  customers_j C  
LEFT JOIN
  orders_j O  
ON C.customer_id = O.customer_id
WHERE
  O.order_id IS NULL


-- LEFT JOIN + COALESCE:
SELECT  
  C.customer_name,
  O.order_id,
  COALESCE(O.amount, 0) AS order_amount
FROM
  customers_j C  
LEFT JOIN
  orders_j O  
ON C.customer_id = O.order_id


-- LEFT JOIN + GROUP BY
SELECT  
  C.customer_name,
  COALESCE(SUM(O.amount), 0) AS total_spend
FROM
  customers_j C 
LEFT JOIN
  orders_j O  
ON C.customer_id = O.customer_id
GROUP BY
  C.customer_name


-- Orphan Orders Check
SELECT
  o.order_id,
  o.customer_id,
  o.amount,
  o.order_status
FROM
  orders_j O  
LEFT JOIN
  customers_j C
ON O.customer_id = C.customer_id
WHERE
  C.customer_id IS NULL