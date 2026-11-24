-- SUBQUERIES (24 Nov - Day 8)

-- Above Average Order Value (WHERE Scalar Subquery):
SELECT  
  order_id,
  customer_name,
  category,
  amount
FROM
  orders
WHERE
  amount > (SELECT AVG(amount) FROM orders)


-- Highest Amount Order(s) (WHERE Scalar Subquery):
SELECT
  *
FROM
  orders
WHERE amount = (SELECT MAX(amount) FROM orders)


-- Active Customers (WHERE IN Subquery)
SELECT  
  customer_id,
  customer_name,
  city
FROM
  customers_j
WHERE
  customer_id IN (SELECT customer_id FROM orders_j)


-- Inactive Customers (WHERE NOT IN Subquery):
SELECT
  customer_name,
  city
FROM
  customers_j
WHERE
  customer_id NOT IN (SELECT customer_id FROM orders_j)


-- Category Filter via Subquery (WHERE IN):
SELECT
  *
FROM
  orders
WHERE category IN (SELECT category FROM orders GROUP BY category HAVING AVG(amount) > 15000)


-- Derived Table — Order Count per Customer (FROM Subquery):
SELECT
  C.customer_name,
  O.total_customers AS order_count
FROM  
  customers_j C

LEFT JOIN (
  SELECT
    customer_id,
    COUNT(customer_id) AS total_customers
  FROM
    orders_j
  GROUP BY
    customer_id
) O 
ON C.customer_id = O.customer_id



-- Derived Table — High-Revenue Cities (FROM Subquery):
SELECT
  city
FROM(
  SELECT  
    city,
    SUM(amount) AS total_spend
  FROM
    orders
  GROUP BY
    city
)t
WHERE
  total_spend > 25000


-- Derived Table + Overall Comparison (FROM Subquery):
SELECT
  C.customer_name,
  O.total_spend,
 (SELECT AVG(total_spend) FROM (
    SELECT SUM(amount) AS total_spend FROM orders_j GROUP BY customer_id
 ) x) AS avg_spend
FROM
  customers_j C
JOIN (
  SELECT
    customer_id,
    SUM(amount) AS total_spend
  FROM
    orders_j
  GROUP BY
    customer_id
) O  
ON C.customer_id = O.customer_id
