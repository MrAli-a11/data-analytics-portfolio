-- CASE WHEN & Data Type Casting (19 Nov - Day 3)
-- Order Value Buckets (CASE WHEN)

-- ADD BUCKET BASED ON Order value
SELECT  
  order_id,
  customer_name,
  amount,
  CASE 
    WHEN amount >= 40000 THEN 'High Value'
    WHEN amount >= 5000 THEN 'Medium Value'
    ELSE 'Low Value'
  END AS order_tier
FROM
  orders


-- Order Status Classification
SELECT
  order_id,
  CASE 
    WHEN [status] = 'Delivered' THEN 'Completed'
    WHEN [status] IN ('Cancelled', 'Returned') THEN 'Lost / Reversed'
    ELSE 'In Progress'
  END AS status_group
FROM
  orders


-- Conditional Aggregation with CASE WHEN
SELECT  
  city,
  SUM(CASE WHEN [status] = 'Delivered' THEN amount ELSE 0 END) AS delivered_revenue,
  SUM(CASE WHEN [status] IN ('Cancelled', 'Returned') THEN amount ELSE 0 END) AS lost_revenue
FROM
  orders
GROUP BY
  city



-- Row-to-Column Pivot (CASE WHEN + COUNT):
SELECT
  category,
  COUNT(CASE WHEN [status] = 'Delivered' THEN 1 END) AS delivered_count,
  COUNT(CASE WHEN [status] = 'Pending' THEN 1 END) AS pending_count
FROM
  orders
GROUP BY
  category


-- Discount / Risk Flag (CASE WHEN):
SELECT
  order_id,
  city,
  amount,
  CASE 
    WHEN [status] = 'Pending' AND amount > 10000 THEN 'High Risk Pending'
    ELSE 'Normal'
  END AS review_flag
FROM
  orders



-- Integer Division Trap + CAST
SELECT
  order_id,
  amount,
  CAST(amount / 3.0 AS decimal(10,2)) AS divided_amount
FROM
  orders



-- Concatenating Numbers with Text (CAST):
SELECT
  CONCAT('Order #', CAST(order_id AS nvarchar), ' | ', city, ' | ', 'Rs. ', CAST(amount as nvarchar)) AS order_summary
FROM
  orders



-- Date to Text / Date Casting (CAST):
SELECT
  CAST(order_date AS nvarchar) AS date_to_string,
  CAST('2026-11-10' AS date) AS string_to_date
FROM
  orders
WHERE
  order_date >= CAST('2026-11-10' AS date)


-- Clean Percentage Calculation (CAST + CASE WHEN)
SELECT
  CAST(COUNT(CASE WHEN [status] = 'Delivered' THEN 1 END) * 100.0 / COUNT(*) AS decimal(5, 2)) AS delivered_pct
FROM
  orders



-- Business Case (CASE WHEN + GROUP BY + HAVING)
SELECT  
  COUNT(*) AS total_orders,
  SUM(amount) AS total_revenue,
  CASE 
    WHEN amount >= 40000 THEN 'High Value'
    WHEN amount >= 5000 THEN 'Medium Value'
    ELSE 'Low Value'
  END AS order_tier
FROM
  orders
GROUP BY 
  CASE 
    WHEN amount >= 40000 THEN 'High Value'
    WHEN amount >= 5000 THEN 'Medium Value'
    ELSE 'Low Value'
  END
HAVING SUM(amount) > 15000
  