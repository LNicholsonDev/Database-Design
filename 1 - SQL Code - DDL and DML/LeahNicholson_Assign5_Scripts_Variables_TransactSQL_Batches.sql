--*  DEV 140           Assignment   #9		              DUE DATE:  Consult course calendar
							
/*
PURPOSE:

Knowledge:

•	Describe the use of scripts.
•	Describe the difference between a scalar variable and a table variable.
•	Describe the scope of a local variable.
•	Describe the use of cursors.
•	Describe the scopes of temporary tables, table variables, and derived tables.
•	Describe the use of dynamic SQL.
•	Given a Transact-SQL script, explain what each statement in the script does.


Skills:

•	Given a Transact-SQL script written as a single batch, insert GO commands to divide the script into appropriate batches.
•	Given the specification for a database problem, write a script that solves it.


TASK:

    1. Download the following SQL file and rename it Xxxxx-DEV140-Assignment-09, where Xxxxx is your last and first name. 
			
    2. Open the file in SQL Server Management Studio (SSMS).

    3. Add your SQL code in the space provided below each question. The questions are written as comments so they will not execute in SQL Server. 

    4. Proofread your document to make sure all questions are answered completely and that it is easy to distinguish
	your responses from the questions on the page.

    5. Return to this Exercise page, attach your completed file, and submit.

 

CRITERIA:

    o Answer all the questions
    o If you do not understand a question, did you post your question on the Discussion board, ask your classmate or a tutor?
    o Your answer/query is in the right place underneath the question
    o Your answer/query is not commented out
    o Your answer/query executes without an error
    o You have renamed the file as specified above and submitted it via Canvas
    
	
    You are to develop SQL statements for each task listed. You should type your SQL statements under each task.
	The fields' names are written as if a person is asking you for the report. You will need to look at the data
	and understand that list price is in the ListPrice field, for example.
	Add comments to describe your reasoning when you are in doubt about something. 

	For this Assignment, we will use the MyGuitarShop database. We tell SQL Server which database 
    to use via the USE statement.

    Do not remove the USE statement. 
*/

--- CHAPTER 14 - HOW TO CODE SCRIPTS -- 


--1.	Write a script that declares a variable and sets it to the count of all products in the Products table. 
--		If the count is less than or equal to 10, the script should display a message that says, 
--		“The number of products is less than or equal to 10”. 
--		Otherwise, it should say, “The number of products is greater than 10”.

USE MyGuitarShop;

DECLARE @ProductCount INT;

SET @ProductCount = (SELECT COUNT(*) FROM Products);

IF @ProductCount <= 10
	PRINT 'The number of products is less than or equal to 10.';
ELSE
	PRINT 'The number of products is greater than 10.';





--2.	Write a script that uses three variables to store (1) the count of all of the products in the Products table, 
--		(2) the average list price for those products, and the maximum list price of the products. If the product count is greater than or equal to 8, 
--		the script should print a message that displays the values of the variables. 
--		Otherwise, the script should print a message that says, “The number of products is less than 8”.


USE MyGuitarShop;

DECLARE @AllProductCount INT;
SET @AllProductCount = (SELECT COUNT(*) FROM Products);

DECLARE @AvgListPrice DECIMAL(10, 2);
SET @AvgListPrice = (SELECT AVG(ListPrice) FROM Products);

DECLARE @MaxListPrice DECIMAL(10, 2);
SET @MaxListPrice = (SELECT MAX(ListPrice) FROM Products);

IF @AllProductCount >= 8
	PRINT 'Number of Products: ' + CAST(@AllProductCount AS VARCHAR) + '. | Average List Price: ' + CAST(@AvgListPrice AS VARCHAR) + '. | Max List Price: ' + CAST(@MaxListPrice AS VARCHAR) + '.';
ELSE
	PRINT 'The number of products is less than 8.';







--3.	Write a script that attempts to insert a new category named “Basses” into the Categories table. 
--		If the insert is successful, the script should display this message: SUCCESS: Record was inserted.
--		If the update is unsuccessful, the script should display a message something like this:
--		FAILURE: Record was not inserted.
--		Error 2627: Violation of UNIQUE KEY constraint 'UQ__Categori__8517B2E0A87CE853'. 
--		Cannot insert duplicate key in object 'dbo.Categories'. The duplicate key value is (Guitars).

USE MyGuitarShop;

BEGIN TRY
    INSERT INTO Categories (CategoryName)
    VALUES ('Basses');
    PRINT 'SUCCESS: Record was inserted.';
END TRY

BEGIN CATCH
    PRINT 'FAILURE: Record was not inserted.';
    PRINT 'Error ' + CAST(ERROR_NUMBER() AS NVARCHAR(10)) + ': ' + ERROR_MESSAGE();
END CATCH;






--4.	Write a script that attempts to insert a new category named “Violins” into the Categories table. 
--		If the insert is successful, the script should display this message: SUCCESS: Record was inserted.
--		If the update is unsuccessful, the script should display a message something like this:
--		FAILURE: Record was not inserted.
--		Error 2627: Violation of UNIQUE KEY constraint 'UQ__Categori__8517B2E0A87CE853'. 
--		Cannot insert duplicate key in object 'dbo.Categories'. The duplicate key value is (Violins).

USE MyGuitarShop;

BEGIN TRY
    INSERT INTO Categories (CategoryName)
    VALUES ('Violins');
    PRINT 'SUCCESS: Record was inserted.';
END TRY

BEGIN CATCH
    PRINT 'FAILURE: Record was not inserted.';
    PRINT 'Error ' + CAST(ERROR_NUMBER() AS NVARCHAR(10)) + ': ' + ERROR_MESSAGE();
END CATCH;











