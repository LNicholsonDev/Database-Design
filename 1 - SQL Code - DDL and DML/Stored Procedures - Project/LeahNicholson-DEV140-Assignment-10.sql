--*  DEV 140           Assignment   #10		              DUE DATE:  Consult course calendar
							
/*
PURPOSE:

Knowledge:

•	Explain why a stored procedure executes faster than an equivalent SQL script.
•	Describe the basic process for validating data within a stored procedure.
•	Describe the basic purpose of the system stored procedures.
•	Describe the effects of the WITH ENCRYPTION and WITH SCHEMABINDING clauses on a stored procedure, 
	user-defined function, or trigger.
•	Explain why you’d want to use the ALTER statement rather than dropping and recreating a procedure, 
	function, or trigger.
•	Given a stored procedure, user-defined function, or trigger, explain what each statement does.


Skills:

•	Given an expression, write a scalar-valued user-defined function based on the formula or expression.
•	Given a SELECT statement with a WHERE clause, write a table-valued user-defined function that replaces it.
•	Given the specifications for a database problem that could be caused by an action query, write a trigger that prevents the problem.
•	Given the specifications for a database problem that could be caused by a DDL statement, write a trigger that prevents the problem.



TASK:

    1. Download the following SQL file and rename it Xxxxx-DEV140-Assignment-10, where Xxxxx is your last and first name. 

    2. Open the file in SQL Server Management Studio (SSMS).

    3. Add your SQL code in the space provided below each question. The questions are written as comments so they will not execute in SQL Server. 

    4. Proofread your document to make sure all questions are answered completely and that it is easy to distinguish your responses from the questions on the page.

    5. Return to this Assignment page, attach your completed file, and submit.
	 

CRITERIA:

    o Answer all the questions
    o Your answer/query is in the right place underneath the question
    o Your answer/query is not commented out
    o Your answer/query executes without an error
    o You have renamed the file as specified above and submitted it via Canvas

For this Assignment, we will use the MyGuitarShop database. 

Test if a procedure already exists before creating it. 
Assuming you are already pointing to the correct database and you want to create
a procedure named spInsertCategory, the easiest syntax to drop it before creating a new one is:

	DROP PROC IF EXISTS spInsertCategory;	  
*/

--- CHAPTER 15 - HOW TO CODE STORED PROCEDURES ---

/*
1.	Write a script that creates and calls a stored procedure named spInsertCategory. 

	First, code a statement that creates a procedure that adds a new row to the Categories table. 
	To do that, this procedure should have one parameter for the category name.

	Code at least two EXEC statements that test this procedure -- one that succeeds, 
	and one that fails. 
	(Note that this table doesn’t allow duplicate category names.)   
*/




USE MyGuitarShop;

DROP PROC IF EXISTS spInsertCategory;
GO

--Create PROC:

CREATE PROCEDURE spInsertCategory
	@CategoryName NVARCHAR(100)

AS 
BEGIN

	BEGIN TRY
		INSERT INTO Categories (CategoryName)
		VALUES(@CategoryName);
	END TRY

	BEGIN CATCH
		PRINT 'Error: ' + ERROR_MESSAGE();
	END CATCH

END;
GO


-- Test fail: 
EXEC spInsertCategory @CategoryName = 'Basses'		-- Already in database

-- Test success: 
EXEC spInsertCategory @CategoryName = 'Bagpipes'		-- Not yet in database



/*
2.	Write a script that creates and calls a stored procedure named spInsertProduct 
	that inserts a row into the Products table. 
	
	This stored procedure should accept five parameters. 
	One parameter for each of these columns: CategoryID, ProductCode, ProductName, ListPrice, 
	and DiscountPercent.
	
	This stored procedure should set the Description column to an empty string, 
	and it should set the DateAdded column to the current date.
	
	If the value for the ListPrice column is a negative number, the stored procedure should 
	raise an error 
	that indicates that this column doesn’t accept negative numbers. 
	
	Similarly, the procedure should raise an error if the value for the DiscountPercent column 
	is a negative number.
	
	Test ALL the branches of your logic. Raise errors with THROW syntax.

	Code at least two EXEC statements that test this procedure.
*/


USE MyGuitarShop;
GO

DROP PROC IF EXISTS spInsertProduct;
GO

-- Create PROC:


CREATE PROCEDURE spInsertProduct

	@CategoryID INT,
	@ProductCode NVARCHAR(25),
	@ProductName NVARCHAR(100),
	@ListPrice DECIMAL(10, 2),
	@DiscountPercent DECIMAL(10, 2)

AS 
BEGIN

	-- Listprice checks
	IF @ListPrice < 0
	BEGIN
		THROW 50001, 'ListPrice cannot be negative.', 1;
	END;

	-- Discount Percent checks
	IF @DiscountPercent < 0
	BEGIN
		THROW 50002, 'DiscountPercent cannot be negative.', 1;
	END;

	-- Insert the rows
	INSERT INTO Products (CategoryID, ProductCode, ProductName, Description, ListPrice, DiscountPercent, DateAdded)	
	VALUES (@CategoryID, @ProductCode, @ProductName, '', @ListPrice, @DiscountPercent, GETDATE());

END;
GO



-- Test fail: Try to insert a negative Listprice

BEGIN TRY
	EXEC spInsertProduct
		@CategoryID = 1,
		@ProductCode = 'special',
		@ProductName = 'My Special Guitar',
		@ListPrice = -999.00,
		@DiscountPercent = 10.00;
END TRY

BEGIN CATCH
	PRINT ERROR_MESSAGE();
END CATCH
GO

-- Test fail: Try to insert a negative DiscountPercent

BEGIN TRY
	EXEC spInsertProduct
		@CategoryID = 2, 
		@ProductCode = 'grandest',
		@ProductName = 'Grandest Piano',
		@ListPrice = 10000.00,
		@DiscountPercent = -5.00;
END TRY

BEGIN CATCH
	PRINT ERROR_MESSAGE();
END CATCH
GO

-- Test success: Try to insert a proper new Product

BEGIN TRY
EXEC spInsertProduct
	@CategoryID = 10,
	@ProductCode = 'valued',
	@ProductName = 'Valued Violin',
	@ListPrice = 250.00,
	@DiscountPercent = 20.00;
END TRY

BEGIN CATCH
	PRINT ERROR_MESSAGE();
END CATCH
GO







/*
3.	Write a script that creates and calls a stored procedure named spUpdateProductDiscount 
	that updates the DiscountPercent column in the Products table. 

	This procedure should have one parameter for the product ID and another for the discount percent.

	If the value for the DiscountPercent column is a negative number, the stored procedure 
	should raise an error that indicates that the value for this column must be a positive number.

	Code at least two EXEC statements that test this procedure.
*/


USE MyGuitarShop;
GO

DROP PROC IF EXISTS spUpdateProductDiscount;
GO




-- Create PROC:

CREATE PROCEDURE spUpdateProductDiscount
	@ProductID INT,
	@DiscountPercent DECIMAL(10,2)

AS
BEGIN

	-- DiscountPercent check for negative
	IF @DiscountPercent < 0

	BEGIN
		THROW 50003, 'Error: DiscountPercent must be positive.', 1;
	END

	-- Update DiscountPercent in Products table
	UPDATE Products
	SET DiscountPercent = @DiscountPercent
	WHERE ProductID = @ProductID

END;
GO



-- Test fail: Negative DiscountPercent

BEGIN TRY
	EXEC spUpdateProductDiscount
		@ProductID = 1,
		@DiscountPercent = -40.00;
END TRY

BEGIN CATCH
	PRINT ERROR_MESSAGE();
END CATCH
GO



-- Test success: Positive DiscountPercent

BEGIN TRY
	EXEC spUpdateProductDiscount
		@ProductID = 1,
		@DiscountPercent = 50.00;
END TRY

BEGIN CATCH
	PRINT ERROR_MESSAGE();
END CATCH
GO
