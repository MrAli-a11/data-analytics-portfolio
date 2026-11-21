-- Multiple Joins (3+ tables) & SELF JOIN (21 Nov - Day 5)

-- 3-Table INNER JOIN
SELECT  
  O.order_id,
  C.customer_name,
  C.city,
  O.category,
  O.order_date,
  O.amount
FROM
  orders O  
INNER JOIN
  orders_j J
ON O.order_id = J.order_id
INNER JOIN
  customers_j C  
ON J.customer_id = C.customer_id



-- Filtered 3-Table Join:
SELECT
  *
FROM
  orders O  
INNER JOIN
  orders_j J  
ON O.order_id = J.order_id
INNER JOIN
  customers_j C  
ON J.customer_id = C.customer_id
WHERE
  O.category = 'Electronics' AND J.order_status = 'Delivered'


-- 3-Table LEFT JOIN
SELECT
  *
FROM
  customers_j C  
LEFT JOIN
  orders_j J  
ON C.customer_id = J.customer_id
LEFT JOIN
  orders O  
ON J.order_id = O.order_id



-- 3-Table Join + GROUP BY
SELECT  
  C.customer_name,
  O.category,
  SUM(J.amount) AS total_sales
FROM
  customers_j C  
LEFT JOIN
  orders_j J  
ON C.customer_id = J.customer_id
LEFT JOIN
  orders O  
ON J.order_id = O.order_id
GROUP BY
  C.customer_name,
  O.category




-- SELF JOIN Same-City Order Pairs:
SELECT  
  O1.order_id,
  O1.customer_name,
  O2.order_id,
  O2.customer_name
FROM  
  orders O1
JOIN
  orders O2
ON O1.city = O2.city AND O1.order_id < O2.order_id



-- Same-Category Higher Amount Check
SELECT  
  O1.order_id,
  O1.customer_name,
  O1.amount,
  O2.order_id,
  O2.amount
FROM
  orders O1 
JOIN
  orders O2
ON O1.category = O2.category AND O1.amount > O2.amount



-- Same-Status Pairs (Pending)
SELECT
  O1.order_id,
  O2.order_id,
  O1.[status]
FROM
  orders O1
JOIN
  orders O2
ON O1.category = O2.category
WHERE
  O1.[status] = o2.[status] AND O1.order_id < O2.order_id



-- Same-Customer Repeat Orders
SELECT  
  *
FROM
  orders O1
JOIN
  orders O2
ON O1.order_id = O2.order_id
WHERE
  O1.customer_name = O2.customer_name AND O1.order_id <> O2.order_id