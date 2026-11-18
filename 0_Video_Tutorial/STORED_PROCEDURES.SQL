-- STORED PROCEDURES
-- WRITE A QUERY FOR US CUSTOMERS FIND THE TOTAL NUMBER OF CUSTOMERS AND THE AVG SCORE


-- TURNING THE QUERY INTO A STORED PROCEDURE WITH DYNAMIC VALUE USING PARAMETER
ALTER PROCEDURE get_customer_summary @Country NVARCHAR(50) = 'Germany'
AS
BEGIN

  -- WRITE A QUERY FOR DYNAMIC COUNTRY CUSTOMERS FIND THE TOTAL NUMBER OF CUSTOMERS AND THE AVG SCORE
  SELECT COUNT(*) AS total_customer,
         AVG(Score) AS avg_score,
         @Country AS Country
  FROM   Sales.Customers
  WHERE  Country = @Country;

-- FIND THE TOTAL NUMBER OF ORDERS AND TOTAL SALES
SELECT 
  COUNT(OrderID) AS total_orders,
  SUM(Sales) as total_sales,
  @Country AS Country
FROM
  Sales.Orders O  
JOIN Sales.Customers C  
ON o.CustomerID = c.CustomerID
WHERE
  C.Country = @Country

END



-- EXECUTE THE STORED PROCEDURE
EXEC get_customer_summary

EXEC get_customer_summary @Country = 'USA'


