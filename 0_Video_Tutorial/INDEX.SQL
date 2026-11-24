-- INDEX
-- NEW TABLE
SELECT
  *
FROM
  Sales.DBCustomers
WHERE
  customerId = 1


-- DEFINING AN CLUSTERED INDEX
CREATE CLUSTERED INDEX Idx_DBCustomers_CustomerID ON Sales.DBCustomers (CustomerID)

-- CREATE CLUSTERED INDEX Idx_DBCustomers_FirstName ON Sales.DBCustomers (FirstName)

-- -- DROPPING INDEX
-- DROP INDEX Idx_DBCustomers_FirstName ON Sales.DBCustomers

SELECT  
  *
FROM
  Sales.DBCustomers
WHERE
  LastName = 'Brown'

-- DEFINING AN NONCLUSTERED INDEX
CREATE INDEX Idx_DBCustomers_LastName ON Sales.DBCustomers (LastName)

DROP INDEX Idx_DBCustomers_LastName ON Sales.DBCustomers




-- MULTIPLE COLUMNS FILTER
SELECT  
  *
FROM
  Sales.DBCustomers
WHERE
  Country = 'USA' AND Score > 500


-- COMPOSITE INDEX: IT HANDLES MULTIPLE COLUMNS INSIDE SAME INDEX
CREATE INDEX Idx_DBCustomers_CountryScore ON Sales.DBCustomers (Country, Score)


-- COLUMNSTORE INDEX
CREATE NONCLUSTERED COLUMNSTORE INDEX  Idx_DBCustomers_CS_FirstName ON Sales.DBCustomers (FirstName)

DROP INDEX Idx_DBCustomers_CS ON Sales.DBCustomers 


-- UNIQUE COLUMNSTORE INDEX

SELECT
  *
FROM
  Sales.Products


-- CREATE UNIQUE COLUMNSTORE INDEX
CREATE UNIQUE NONCLUSTERED INDEX idx_product_product ON Sales.Products (Product)


-- FILTERED INDEX
SELECT
  *
FROM
  Sales.Customers
WHERE Country = 'USA'


-- CREATE FILTERED INDEX
CREATE NONCLUSTERED INDEX idx_customer_country ON Sales.Customers (Country)
WHERE Country = 'USA'

