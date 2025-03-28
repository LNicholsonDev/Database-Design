--*  PROG 140           Assignment   #2 (Chapters 3,4,5)              DUE DATE:  Consult course calendar
							
/*
PURPOSE:

Knowledge:

    o Understand the mechanics of completing exercises for this class
	o Understand the SQL syntax for retrieving data from single database tables

Skills:

    o Outside of class, access a computer that has SQL Server loaded on it
    o Interpret questions to understand how to answer the questions
    o Write SQL queries to answer questions by retrieving data from a single database table

TASK:

    1. Download the following SQL file and rename it DEV140-Assignment-02, where Xxxxx is your last and first name. 
	
    2. Open the file in SQL Server Management Studio (SSMS).

    3. Add your SQL code in the space provided below each question. The questions are written as comments so they will not execute in SQL Server. 

    4. Proofread your document to make sure all questions are answered completely and that it is easy to distinguish your responses from the questions on the page.

    5. Return to this Exercise page, attach your completed file, and submit.

 

CRITERIA:

    o Answer all the questions
    o If you do not understand a question, did you ask for help from the teacher, a classmate, the Discussion board, or a tutor?
    o Your answer/query is in the right place underneath the question
    o Your answer/query is not commented out
    o Your answer/query executes without an error
    o You have renamed the file as specified above and submitted it via Canvas
    o If you cannot complete the Exercise, did you communicate with the teacher (before the due date) so that he/she/they understands your situation?

*/

/*	
    You are to develop SQL statements for each task listed. You should type your SQL statements under each task.
	The fields' names are written as if a person is asking you for the report. You will need to look at the data
	and understand that list price is in the ListPrice field, for example.
	Add comments to describe your reasoning when you are in doubt about something. 


    For this Assignment, we will use the MyGuitarShop database. We tell SQL Server which database 
    to use via the USE statement.

    Do not remove the USE statement. 
*/

--- CHAPTER 3 - RETRIEVE DATA FROM A SINGLE TABLE ---

USE MyGuitarShop;

--1.	Write a SELECT statement that returns four columns from the Products table: ProductCode, ProductName, ListPrice, and DiscountPercent. Then, run this statement to make sure it works correctly.
--		Add an ORDER BY clause to this statement that sorts the result set by list price in descending sequence. Then, run this statement again to make sure it works correctly. This is a good way to build and test a statement, one clause at a time.
--		I did this one for you.
--		3 points
--		I got 10 rows.
--		QUESTION: What is the product name in record 6?
--		ANSWER: Fender Stratocaster

SELECT ProductCode, ProductName, ListPrice, DiscountPercent
FROM Products
ORDER BY ListPrice DESC;





--2.	Write a SELECT statement that returns one column from the Customers table named FullName that joins the LastName and FirstName columns.
--		Format this column with the last name, a comma, a space, and the first name like this:
--		Doe, John
--		Sort the result set by last name in ascending sequence.
--		Return only the contacts whose last name begins with a letter from M to Z.
--		4 points
--		I got 227 rows.
--		QUESTION: What is the FullName in record 2?
--		ANSWER: Madarang, Kimbery

SELECT LastName + ', ' + FirstName AS FullName	-- Must write '' instead of ""
FROM Customers
WHERE LastName >= 'M'
ORDER BY LastName ASC;





--3.	Write a SELECT statement that returns these column names and data from the Products table:
--		ProductName	The ProductName column
--		ListPrice	The ListPrice column
--		DateAdded	The DateAdded column
--		Return only the rows with a list price that’s greater than 400 and less than 2000.
--		Sort the result set in descending sequence by the DateAdded column.
--		4 points
--		I got 8 rows.
--		QUESTION: What is the product name in record 2?
--		ANSWER: Rodriguez Caballero 11

SELECT ProductName, ListPrice, DateAdded
FROM Products
WHERE ListPrice > 400 and ListPrice < 2000
ORDER BY DateAdded DESC;





--4.	Write a SELECT statement that returns these columns from the Orders table:
--			OrderID		The OrderID column
--			OrderDate	The OrderDate column
--			ShipDate		The ShipDate column
--			Return only the rows where the ShipDate column contains a null value.
--		3 points
--		I got 5 rows.
--		QUESTION: What is the OrderId in record 5?
--		ANSWER: 41

SELECT OrderID, OrderDate, ShipDate 
FROM Orders
WHERE ShipDate IS NULL;		-- Do not write: ShipDate = NULL




--- CHAPTER 4 - RETRIEVE DATA FROM 2 OR MORE TABLES ---

--5.	Write a SELECT statement that joins the Categories table to the Products table and returns these columns: 
--		CategoryName, ProductName, ListPrice.
--		Sort the result set by CategoryName in descending order and then by ProductName in ascending order.
--		4 points
--		I got 10 rows.
--		QUESTION: What is the product name in record 2?
--		ANSWER: Gibson Les Paul

SELECT 
	Categories.CategoryName, 
	Products.ProductName, 
	Products.ListPrice
FROM Categories
INNER JOIN Products
ON Categories.CategoryID = Products.CategoryID
ORDER BY 
	Categories.CategoryName DESC, 
	Products.ProductName ASC;		-- Table aliases included (Categories. and Products.)





--6.	Write a SELECT statement that joins the Customers, Orders, OrderItems, and Products tables. This statement should return these columns: 
--		LastName, FirstName, OrderDate, ProductName, ItemPrice, DiscountAmount, and Quantity.
--		Sort the final result set by LastName, OrderDate, and ProductName in ascending order.
--		4 points
--		I got 47 rows.
--		QUESTION: What is the first name in record 6?
--		ANSWER: Chanel

SELECT 
	Customers.LastName, 
	Customers.FirstName, 
	Orders.OrderDate, 
	Products.ProductName, 
	OrderItems.ItemPrice, 
	OrderItems.DiscountAmount, 
	OrderItems.Quantity
FROM Customers
INNER JOIN Orders
ON Customers.CustomerID = Orders.CustomerID
INNER JOIN OrderItems
ON Orders.OrderID = OrderItems.OrderID
INNER JOIN Products
ON OrderItems.ProductID = Products.ProductID
ORDER BY 
	Customers.LastName, 
	Orders.OrderDate, 
	Products.ProductName ASC;





--7.	Write a SELECT statement that returns these two columns: 
--		CategoryName		The CategoryName column from the Categories table
--		ProductID		The ProductID column from the Products table
--		Return one row for each category that has never been used. 
--		Hint: Use an outer join and only return rows where the ProductID column contains a null value.
--		5 points
--	    QUESTION: What is the category name in record 1?
--		ANSWER: Keyboards
 
 SELECT 
	Categories.CategoryName, 
	Products.ProductID
 FROM Categories
 LEFT OUTER JOIN Products				-- Get all Categories, including those not used (where ProductID IS NULL)
 ON Categories.CategoryID = Products.CategoryID
 WHERE Products.ProductID IS NULL;

 



--8.	Use the UNION operator to generate a result set consisting of three columns from the Orders table: 
--		ShipStatus	A calculated column that contains a value of SHIPPED or NOT SHIPPED
--		OrderID		The OrderID column
--		OrderDate	The OrderDate column
--		If the order has a value in the ShipDate column, the ShipStatus column should contain a value of SHIPPED. 
--		Otherwise, it should contain a value of NOT SHIPPED.
--		Sort the final result set by OrderDate in ascending order.
--		5 points
--		I got 41 rows.
--		QUESTION: What is the order date in record 2?
--		ANSWER:	2020-01-28 11:23:20.000

SELECT 
	'SHIPPED' AS ShipStatus,
	Orders.OrderID,
	Orders.OrderDate
FROM Orders
WHERE ShipDate IS NOT NULL		-- Replaces 2020-02-15 12:27:35.000 with text "SHIPPED"
UNION
SELECT
	'NOT SHIPPED' AS ShipStatus,
	Orders.OrderID,
	Orders.OrderDate
FROM Orders
WHERE ShipDate IS NULL			-- Replaces NULL values as "NOT SHIPPED"
ORDER BY OrderDate ASC;





--- CHAPTER 5 - HOW TO CODE SUMMARY QUERIES ---
--9.	Write a SELECT statement that returns these columns:
--		The count of the number of orders in the Orders table and 
--		the sum of the TaxAmount columns in the Orders table.
--		Be sure to name the columns.
--		3 points
--		I got 1 row.
--		QUESTION: What is the sum of the tax amount in record 1?
--		ANSWER: 2541.96

SELECT 
	COUNT(DISTINCT Orders.OrderID) AS NumberOfOrders,
	SUM(Orders.TaxAmount) AS TotalTax
FROM Orders;





--10.	Write a SELECT statement that returns one row for each category that has products with these columns:
--		The CategoryName column from the Categories table,
--		The count of the products in the Products table,
--		The list price of the most expensive product in the Products table.
--		Sort the result set so the category with the most products appears first.
--		5 points
--		I got 3 rows.
--		QUESTION: What is the list price of the most expensive product?
--		ANSWER: 2517.00

SELECT 
	Categories.CategoryName,
	COUNT(Products.ProductID) AS ProductCount,
	MAX(Products.ListPrice) AS MostExpensiveProduct
FROM Categories
INNER JOIN Products
ON Categories.CategoryID = Products.CategoryID
GROUP BY Categories.CategoryName
ORDER BY ProductCount DESC;





--11.	Write a SELECT statement that returns one row for each customer that has orders with these columns:
--		The EmailAddress column from the Customers table,
--		A count of the number of orders,
--		The total amount for those orders 
--		Hint: First, subtract the discount amount from the price. Then, multiply by the quantity.
--		Return only those rows where the customer has more than than 1 order.
--		Sort the result set in descending sequence by the sum of the line item amounts.
--		5 points
--		I got 9 rows.
--		QUESTION: What is the email address in row 1?
--		ANSWER: david.goldstein@hotmail.com

SELECT 
	Customers.EmailAddress, 
	COUNT(Orders.OrderID) AS NumberOfOrders, 
	SUM((OrderItems.ItemPrice - OrderItems.DiscountAmount) * OrderItems.Quantity) AS TotalAmount 
FROM Customers 
INNER JOIN Orders 
ON Customers.CustomerID = Orders.CustomerID 
INNER JOIN OrderItems ON Orders.OrderID = OrderItems.OrderID 
GROUP BY Customers.EmailAddress 
HAVING COUNT(Orders.OrderID) > 1 
ORDER BY TotalAmount DESC;





--12.	Write a SELECT statement that answers this question: What is the total amount ordered for each product? Return these columns:
--		The product name from the Products table,
--		The total amount for each product in the OrderItems table 
--		Hint: You can calculate the total amount by subtracting the discount amount from the item price 
--		and then multiplying it by the quantity.
--		Use the WITH ROLLUP operator to include a row that gives the grand total.
--		5 points
--		I got 11 rows.
--		QUESTION: What is the grand total in the last row?
--		ANSWER: 37292.42

SELECT 
	Products.ProductName, 
	SUM((OrderItems.ItemPrice - OrderItems.DiscountAmount) * OrderItems.Quantity) AS TotalAmount 
FROM Products 
INNER JOIN OrderItems 
ON Products.ProductID = OrderItems.ProductID 
GROUP BY Products.ProductName WITH ROLLUP;		-- NULL contains the grand total when using ROLLUP




