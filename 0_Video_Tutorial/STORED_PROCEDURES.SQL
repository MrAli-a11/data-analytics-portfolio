-- STORED PROCEDURES
-- WRITE A QUERY FOR US CUSTOMERS FIND THE TOTAL NUMBER OF CUSTOMERS AND THE AVG SCORE


-- TURNING THE QUERY INTO A STORED PROCEDURE WITH DYNAMIC VALUE USING PARAMETER
ALTER PROCEDURE get_customer_summary @Country NVARCHAR(50) = 'Germany'
AS
BEGIN
  BEGIN TRY
  -- DECLARING A VARIABLE (SYNTAX)
  DECLARE @TotalCustomers INT, @AVGScore FLOAT, @myCountry NVARCHAR(50)

  -- ================================
  -- STEP 1: PREPARE AND CLEANUP DATA
  -- ================================
  IF EXISTS(SELECT 1 FROM Sales.Customers WHERE Score IS NULL AND Country = @Country)
  BEGIN
    PRINT('UPDATING NULL SCORES TO 0...')
    UPDATE Sales.Customers
    SET Score = 0
    WHERE Score IS NULL AND Country = @Country
  END

  ELSE
  BEGIN
    PRINT('NO NULL SCORES FOUND')
  END

   -- ================================
  -- STEP 2: GENERATING SUMMARY REPORTS
  -- ================================
  -- CALCULATE TOTAL CUSTOMERS AND AVG SCORE FOR SPECIFIC COUNTRIES
  SELECT 
      -- ASSIGNING VALUES TO THE VARIABLES (SYNTAX) LEFT SIDE VARIABLE NAME WITH = THEN RIGHT SIDE expressions with no Alias
      @TotalCustomers = COUNT(*),
      @AVGScore = AVG(Score),
      @myCountry = @Country
  FROM   Sales.Customers
    WHERE  Country = @Country;

  PRINT 'TOTAL CUSTOMERS FROM ' + @Country + ':' + CAST(@TotalCustomers AS NVARCHAR);
  PRINT 'Avg SCORE FROM ' + @Country + ':' + CAST(@AVGScore AS NVARCHAR);

  -- CALCULATE TOTAL NUMBER OF ORDERS AND TOTAL SALES FOR SPECIFIC COUNTRY
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

  END TRY

  BEGIN CATCH
  -- ==============
  -- ERROR HANDLING
  -- ==============
    PRINT('AN ERROR OCCURED');
    PRINT('ERROR MESSAGE: ' + ERROR_MESSAGE());
    PRINT('ERROR NUMBER: ' + CAST(ERROR_NUMBER() AS NVARCHAR));
    PRINT('ERROR LINE: ' + CAST(ERROR_LINE() AS NVARCHAR));
    PRINT('ERROR PROCEDURE: ' + ERROR_PROCEDURE());
  END CATCH
END





-- EXECUTE THE STORED PROCEDURE
EXEC get_customer_summary

EXEC get_customer_summary @Country = 'USA'


-- Variables
