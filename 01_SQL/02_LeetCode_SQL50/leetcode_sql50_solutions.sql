-- LEETCODE 50

-- Recyclable and Low Fat Products
SELECT
    product_id
FROM
    Products
WHERE 
    low_fats = 'Y' AND recyclable = 'Y'


-- Find Customer Referee
SELECT
    name
FROM
    Customer
WHERE
    referee_id <> 2 OR referee_id IS NULL


-- Big Countries
SELECT
    name,
    population,
    area
FROM
    World
WHERE
    area >= 3000000 OR population >= 25000000


-- Article Views I
SELECT DISTINCT
    author_id AS id
FROM
    Views
WHERE
    author_id = viewer_id
ORDER BY author_id ASC


-- Invalid Tweets
SELECT
    tweet_id
FROM
    Tweets
WHERE
    LEN(content) > 15



-- Replace Employee ID With The Unique Identifier
SELECT
    U.unique_id,
    E.name
FROM
    Employees E
LEFT JOIN EmployeeUNI U
ON E.id = U.id



-- Product Sales Analysis I
SELECT
    P.product_name,
    S.year,
    S.price
FROM
    Sales S
LEFT JOIN 
    Product P
ON S.product_id = P.product_id



-- Customer Who Visited but Did Not Make Any Transactions
SELECT
    V.customer_id ,
    COUNT(*) AS count_no_trans 
FROM
    Visits V
LEFT JOIN
    Transactions T
ON V.visit_id = T.visit_id
WHERE 
    T.transaction_id IS NULL
GROUP BY V.customer_id 


-- Rising Temperature
SELECT
    W1.id
FROM
    Weather W1
JOIN
    Weather W2
ON DATEDIFF(DAY, W2.recordDate, W1.recordDate) = 1
WHERE 
    W1.temperature >  W2.temperature    