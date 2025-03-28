/* Stored Procedure Group Exercise

Use the MyGuitarShop database.

Create a stored procedure that counts the number of products that are between a minimum price and a maximum price.

The procedure should have a default minimum price of 0 and a default maximum price of 2000.

The procedure should return the number of products that pass the filter.

Test the procedure with multiple minimum and maximum values. */



USE MyGuitarShop;
GO
DROP PROC IF EXISTS uspCountProd
GO

CREATE PROCEDURE uspCountProd

    @MinPrice DECIMAL(10, 2) = 0,			-- Default minimum price of 0
    @MaxPrice DECIMAL(10, 2) = 2000			-- Default maximum price of 2000

AS

BEGIN

    SELECT COUNT(*) AS ProductCount
    FROM Products
    WHERE ListPrice BETWEEN @MinPrice AND @MaxPrice;   -- Defined with 0 and 2000 default

END;
GO



-- TESTS

EXEC uspCountProd                                             -- default 0 and 2000: 9
EXEC uspCountProd @MinPrice = 100, @MaxPrice = 1000;		      -- 8
EXEC uspCountProd @MinPrice = 799, @MaxPrice = 2000;	          -- 3
EXEC uspCountProd @MinPrice = 299.00, @MaxPrice = 299.00;     -- 1
EXEC uspCountProd @MinPrice = 0, @MaxPrice = 50.00;           -- 0


--USE MyGuitarShop;
--SELECT *
--FROM Products
--WHERE ListPrice < 2000
--ORDER BY ListPrice; 