--*  DEV 140           Assignment   #4		              DUE DATE:  Consult course calendar
							
/*
PURPOSE:

Knowledge
•	Describe the three types of action queries.
•	Explain how to handle null values and default values when coding INSERT and UPDATE statements.
•	Explain how the FROM clause is used in an UPDATE or DELETE statement.
•	Explain how the MERGE statement works.
•	Describe the use of views.
•	Name the three SQL statements you use to work with views.
•	Given a SELECT statement, determine whether it can be used as the basis for a view.
•	Given a SELECT statement, determine whether it can be used as the basis for an updatable view.
•	Describe the benefits provided by views.
•	Describe the effects of the WITH SCHEMABINDING on a view.
•	Describe the use of SQL Server’s catalog views for getting information from the system catalog.

Skills
•	Given the specifications for an action query, code the INSERT, UPDATE, or DELETE statement for doing the action.
•	Create a copy of a table by using the INTO clause of the SELECT statement.
•	Given a SELECT statement, create a new view based on the statement.
•	Given a SELECT statement, use the View Designer to create a new view based on the statement.
•	Use the View Designer to change the design of an existing view.


TASK:

    1. Download the following SQL file and rename it Xxxxx-DEV140-Assignment-04, where Xxxxx is your last and first name. 
	
    2. Open the file in SQL Server Management Studio (SSMS).

    3. Add your SQL code in the space provided below each question. The questions are written as comments so they will not execute in SQL Server. 

    4. Proofread your document to make sure all questions are answered completely and that it is easy to distinguish your responses from the questions on the page.

    5. Return to this Assignment page, attach your completed file, and submit.

 

CRITERIA:

    o Answer all the questions
    o If you do not understand a question, did you post your your question on the Discussion board, or ask a tutor?
    o Your answer/query is in the right place underneath the question
    o Your answer/query is not commented out
    o Your answer/query executes without an error
    o You have renamed the file as specified above and submitted it via Canvas
    o If you cannot complete the Exercise, did you communicate with the teacher
	(before the due date) so that he/she/they understands your situation?

*/
/*	
    You are to develop SQL statements for each task listed. You should type your SQL statements under each task.
	The fields' names are written as if a person is asking you for the report. You will need to look at the data
	and understand that list price is in the ListPrice field, for example.
	Add comments to describe your reasoning when you are in doubt about something. 


    For this Assignment, we will use the MyGuitarShop database. 

!!!!! Execute CreateMyGuitarShop.sql before completing this assignment. This ensures that you have a "clean" database before starting.

!!!!! Look at the data before and after your SQL statement so that you understand what each statement is doing.

*/
--- CHAPTER 7 - How to insert, update, and delete data ---










USE MyGuitarShop;


--1.	Write an INSERT statement that adds this row to the Categories table:
--		CategoryName:	Woodwinds
--		Code the INSERT statement so SQL Server automatically generates the value for the CategoryID column.


INSERT INTO Categories(CategoryName)
VALUES ('Woodwinds');





--2.	Write an UPDATE statement that modifies the row you just added to the Categories table. 
--		This statement should change the CategoryName column to “Brass”, and it should use the CategoryID column to identify the row.


UPDATE Categories
SET CategoryName = 'Brass'
WHERE CategoryID = 5;





--3.	Write a DELETE statement that deletes the row you added to the Categories table in question 1. 
--		This statement should use the CategoryID column to identify the row.


DELETE FROM Categories
WHERE CategoryID = 5;





--4.	Write an INSERT statement that adds this row to the Products table:
--			ProductID:	The next automatically generated ID 
--			CategoryID:		4
--			ProductCode:		GV_010X
--			ProductName:		GoodVibe 12
--			Description:		Keyboard with LCD Display Kit
--			ListPrice:		158.99
--			DiscountPercent:	0
--			DateAdded:		Today’s date/time.
--		Use a column list for this statement.


INSERT INTO Products (
	CategoryID, 
	ProductCode, 
	ProductName, 
	Description, 
	ListPrice, 
	DiscountPercent, 
	DateAdded)
VALUES (
	4, 
	'GV_010X', 
	'GoodVibe 12', 
	'Keyboard with LCD Display Kit', 
	158.99, 
	0, 
	GETDATE());






--5.	Write an UPDATE statement that modifies the product you added in exercise 4. This statement should change 
--			the DiscountPercent column from 0% to 12%.


UPDATE Products
SET DiscountPercent = 12
WHERE ProductID = 11;





--6.	Write a DELETE statement that deletes the row in the Categories table that has an ID of 4. 
--		When you execute this statement, it will produce an error since the category has related rows in the Products table. 
--		To fix that, precede the DELETE statement with another DELETE statement that deletes all products in this category.


---- Preceded statement to delete all Products with CategoryID = 4
DELETE FROM Products		
WHERE CategoryID = 4;

---- Statement to delete the CategoryID = 4 in Categories
DELETE FROM Categories
WHERE CategoryID = 4;





--7.	Write an INSERT statement that adds this row to the Customers table:
--			EmailAddress:	ted_lasso@afcrichmond.org
--			Password:		(empty string)
--			FirstName:		Ted
--			LastName:		Lasso
--		Use a column list for this statement.


INSERT INTO Customers (EmailAddress, Password, FirstName, LastName)
VALUES ('ted_lasso@afcrichmond.org', '', 'Ted', 'Lasso');





--8.	Write an UPDATE statement that modifies the Customers table. Change the password column to “secret” for the customer 
--			with an email address of ted_lasso@afcrichmond.org.


UPDATE Customers
SET Password = 'secret'
WHERE EmailAddress = 'ted_lasso@afcrichmond.org';





--9.	Write an UPDATE statement that modifies the Customers table. Change the password column to “reset” for every customer in the table. 


UPDATE Customers
SET Password = 'reset';





--10.	Change the database connection to a different database from MyGuitarShop (use the USE command).
--		Open the script named CreateMyGuitarShop.sql that’s in the Week 04 Resources page.
--		Then, run the script. That should restore the data that’s in the database.


USE AP;
--Restore completed




--- CHAPTER 13 - How to work with views ---


USE MyGuitarShop;
GO


--11.	Create a view named CustomerAddresses that shows the shipping and billing addresses for each customer in the MyGuitarShop database.
--		This view should return these columns from the Customers table: CustomerID, EmailAddress, LastName and FirstName.
--		This view should return these columns from the Addresses table: BillLine1, BillLine2, BillCity, BillState, BillZip, 
--			ShipLine1, ShipLine2, ShipCity, ShipState, and ShipZip.
--		Use the BillingAddressID and ShippingAddressID columns in the Customers table to determine which addresses are billing addresses 
--			and which are shipping addresses. 
--		Hints: You can use two JOIN clauses to join the Addresses table to Customers table twice (once for each type of address).
--				Put the command GO before the CREATE VIEW command.


DROP VIEW IF EXISTS CustomerAddresses 
GO

CREATE VIEW CustomerAddresses AS

SELECT
	c.CustomerID,
	c.EmailAddress,
	c.LastName,
	c.FirstName,
	ba.Line1 AS BillLine1,
	ba.Line2 AS BillLine2,
	ba.City AS BillCity,
	ba.State AS BillState,
	ba.ZipCode AS BillZip,
	sa.Line1 AS ShipLine1,
	sa.Line2 AS ShipLine2,
	sa.City AS ShipCity,
	sa.State AS ShipState,
	sa.ZipCode AS ShipZip

FROM Customers c

INNER JOIN
Addresses ba ON c.BillingAddressID = ba.AddressID

INNER JOIN
Addresses sa ON c.ShippingAddressID  = sa.AddressID;
GO





--12.	Write a SELECT statement that returns these columns from the CustomerAddresses view that you created in question 11: 
--			CustomerID, LastName, FirstName, BillLine1.


SELECT
    CustomerID,
    LastName,
    FirstName,
    BillLine1
FROM CustomerAddresses;





--13.	Write an UPDATE statement that updates the CustomerAddresses view you created in question 11 so it sets 
--			the first line of the shipping address to “3000 Landerholm Circle SE” for the customer with an ID of 3.


--# Checking which ShippingAddressID exists for CustomerID = 3, it is 4:

--SELECT ShippingAddressID
--FROM Customers
--WHERE CustomerID = 3;
-----------------------------


UPDATE Addresses
SET Line1 = '3000 Landerholm Circle SE'

WHERE AddressID = (
    SELECT ShippingAddressID
    FROM Customers
    WHERE CustomerID = 3);





--14.	Create a view named OrderItemProducts that returns columns from the Orders, OrderItems, and Products tables.
--		This view should return these columns from the Orders table:			OrderID, OrderDate, TaxAmount, and ShipDate.
--		This view should return these columns from the OrderItems table:		ItemPrice, DiscountAmount, 
--			FinalPrice (the discount amount subtracted from the item price), Quantity, and ItemTotal (the calculated total for the item).
--		This view should return the ProductName column from the Products table.


DROP VIEW IF EXISTS OrderItemProducts;
GO

CREATE VIEW OrderItemProducts AS

SELECT 
    o.OrderID,
    o.OrderDate,
    o.TaxAmount,
    o.ShipDate,

    oi.ItemPrice,
    oi.DiscountAmount,
    (oi.ItemPrice - oi.DiscountAmount) AS FinalPrice,
    oi.Quantity,
    (oi.Quantity * (oi.ItemPrice - oi.DiscountAmount)) AS ItemTotal,

    p.ProductName

FROM Orders o
JOIN OrderItems oi 
ON o.OrderID = oi.OrderID

JOIN Products p 
ON oi.ProductID = p.ProductID;
GO





--15.	Create a view named ProductSummary that uses the view you created in question 14. 
--		This view should return some summary information about each product (remember GROUP BY?).
--		Each row should include these columns: ProductName, OrderCount (the number of times the product has been ordered), 
--			and OrderTotal (the total sales for the product).


DROP VIEW IF EXISTS ProductSummary;
GO

CREATE VIEW ProductSummary AS

SELECT 
    p.ProductName,
    COUNT(o.OrderID) AS OrderCount,
    SUM(oi.Quantity * (oi.ItemPrice - oi.DiscountAmount)) AS OrderTotal

FROM Orders o
JOIN OrderItems oi 
ON o.OrderID = oi.OrderID

JOIN Products p 
ON oi.ProductID = p.ProductID

GROUP BY p.ProductName;
GO





--16.	Write a SELECT statement that uses the view that you created in question 15 to get total sales for the five best selling products.


SELECT TOP 5
    ProductName,
    OrderTotal

FROM ProductSummary
ORDER BY OrderTotal DESC;




