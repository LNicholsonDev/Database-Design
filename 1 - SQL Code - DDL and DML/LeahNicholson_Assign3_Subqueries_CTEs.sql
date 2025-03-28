--*  DEV 140           Assignment   #3		              DUE DATE:  Consult course calendar
							
/*
PURPOSE:

Knowledge:

•	Describe the way subqueries can be used in the WHERE, HAVING, FROM and SELECT clauses of a SELECT statement.
•	Describe the difference between a correlated subquery and a noncorrelated subquery.
•	Describe the use of common table expressions (CTEs).
•	Describe the data that can be stored in any of the string, numeric, date/time, and large value data types.
•	Describe the difference between standard character data and Unicode character data.
•	Describe the differences between implicit and explicit data type conversion.
•	Describe how the use of functions can solve the problems associated with (1) sorting string data that contains numeric values, and (2) doing date or time searches.

Skills:

•	Code SELECT statements that require subqueries.
•	Code SELECT statements that use common table expressions (CTEs) to define the subqueries.
•	Code queries that use data conversion functions.
•	Code queries that require functions for working with string, numeric, and date/time data.


TASK:

    1. Download the following SQL file and rename it Xxxxx-PROG140-Assignment-03, where Xxxxx is your last and first name. 
			Xxxxx-PROG140-Assignment-03.sql

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
    o If you cannot complete the Assignment, did you communicate with the teacher (before the due date) so that he/she/they understands your situation?

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

--- CHAPTER 6 - HOW TO CODE SUBQUERIES -- 

USE MyGuitarShop;



--1.	Write a SELECT statement that answers this question: 
--		Which products have a list price that’s greater than the average list price for all products?
--		Return the ProductName and ListPrice columns for each product.
--		Sort the results by the ProductName column in ascending sequence.
--		4 points
--		I got 2 rows.
--		QUESTION:	What is the ProductName in record 2?
--		ANSWER:		Gibson SG

SELECT ProductName, ListPrice
FROM Products
WHERE ListPrice > (SELECT AVG(ListPrice) FROM Products)
ORDER BY ProductName ASC;



--2.	Write a SELECT statement that returns the same result set as this SELECT statement, but don’t use a join. 
--		Instead, use a subquery in a WHERE clause that uses the IN keyword.
--			SELECT DISTINCT CategoryName
--			FROM Categories c JOIN Products p
--			ON c.CategoryID = p.CategoryID
--			ORDER BY CategoryName;
--		4 points
--		I got 3 rows.
--		QUESTION:	What is the CategoryName in record 1?
--		ANSWER:		Basses


SELECT DISTINCT CategoryName
FROM Categories
WHERE CategoryID IN 
	(SELECT CategoryID
    FROM Products)
ORDER BY CategoryName;



--3.	Write a SELECT statement that returns the CategoryName column from the Categories table.
--		Return one row for each category that has never been assigned to any product in the Products table. 
--		To do that, use a subquery introduced with the NOT EXISTS operator. Sort by CategoryName in alphabetical order.
--		5 points
--      I got 1 row
--		QUESTION:	What is the CategoryName in record 1?
--		ANSWER:	Keyboards

SELECT CategoryName
FROM Categories
WHERE NOT EXISTS 
	(SELECT 1 FROM Products
    WHERE Products.CategoryID = Categories.CategoryID)
ORDER BY CategoryName;



--4.	Use a correlated subquery to return one row per customer, representing 
--		the customer’s oldest order (the one with the earliest date). 
--		Each row should include these three columns: EmailAddress, OrderID, and OrderDate.
--		Sort by OrderID in ascending order.
--		5 points
--		I got 35 rows.
--		QUESTION:	What is the EmailAddress in record 1?
--		ANSWER:		allan.sherwood@yahoo.com

SELECT Customers.EmailAddress, Orders.OrderID, Orders.OrderDate
FROM Customers
JOIN Orders ON Customers.CustomerID = Orders.CustomerID
WHERE Orders.OrderDate = 
	(SELECT MIN(OrderDate)
    FROM Orders o
    WHERE o.CustomerID = Orders.CustomerID)
ORDER BY Orders.OrderID;



--- CHAPTER 8 - HOW TO WORK WITH DATA TYPES ---

--5.	Write a SELECT statement that returns these columns from the Products table:
--			The ProductName and ListPrice columns,
--			A column that uses the CAST function to return the ListPrice column with 1 digit to the right of the decimal point (alias PriceFormat),
--			A column that uses the CONVERT function to return the ListPrice column as an integer (alias PriceConvert),
--			A column that uses the CAST function to return the ListPrice column as an integer (alias PriceCast)
--			Sort ProductName in ascending order.
--			Make sure you name your columns.
--		4 points
--		I got 10 rows.
--		QUESTION:	What is the PriceCast in record 4?
--		ANSWER:		2517

USE MyGuitarShop;

SELECT 
    ProductName, 
    ListPrice,
    CAST(ListPrice AS DECIMAL(10,1)) AS PriceFormat,
    CONVERT(INT, ListPrice) AS PriceConvert,
    CAST(ListPrice AS INT) AS PriceCast
FROM Products
ORDER BY ProductName;



--6.	Write a SELECT statement that returns these columns from the Products table:
--			The DateAdded column,
--			A column that uses the CAST function to return the DateAdded column with its date only (year, month, and day) (alias AddedDate),
--			A column that uses the CAST function to return the DateAdded column 
--				with its full time only (hour, minutes, seconds, and milliseconds)  (alias AddedTime), 
--			A column that uses the CAST function to return the DateAdded column with just the month and day (Hint: CHAR(7)) (alias AddedChar7).
--			Sort DateAdded in ascending order.
--			Make sure you name your columns.
--		4 points
--		I got 10 rows.
--		QUESTION:	What is the AddedDate, AddedTime and AddedChar7 in record 2?
--		ANSWER:		2019-05-05, 16:33:13.0000000, May  5 

SELECT 
    DateAdded,
    CAST(DateAdded AS DATE) AS AddedDate,
    CAST(DateAdded AS TIME) AS AddedTime,
    CAST(DateAdded AS CHAR(7)) AS AddedChar7
FROM Products
ORDER BY DateAdded;



--7.	Write a SELECT statement that returns these colums from the Orders table:
--			The OrderDate column,
--			A column that uses the CONVERT function to return the OrderDate column in this format: MM/DD/YYYY. 
--				In other words, use 2-digit months and  days and a 4-digit year, and separate each date component with slashes (alias OrderDateConverted).
--			A column that uses the CONVERT function to return the OrderDate column with the date, 
--				and the hours and minutes on a 12-hour clock with an am/pm indicator (alias AMPM).
--			A column that uses the CONVERT function to return the OrderDate column 
--				with 2-digit hours, minutes, and seconds on a 24-hour clock. Use leading zeros for all date/time components (alias OrderTime).
--		Sort OrderDate in ascending order.
--		Make sure you name your columns.
--		4 points
--		I got 41 rows.
--		QUESTION:	What is the OrderDateConverted, AMPM, and OrderTime in record 3?
--		ANSWER:		01/29/2020, Jan 29 2020  9:44AM, 09:44:58

SELECT 
    OrderDate,
    CONVERT(VARCHAR, OrderDate, 101) AS OrderDateConverted,
    CONVERT(VARCHAR, OrderDate, 100) AS AMPM,
    CONVERT(VARCHAR, OrderDate, 108) AS OrderTime
FROM Orders
ORDER BY OrderDate;



--- CHAPTER 9 - HOW TO USE FUNCTIONS ---

USE MyGuitarShop;

--8.	Write a SELECT statement that returns these columns from the Products table:
--			The ListPrice column
--			The DiscountPercent column
--			A column named DiscountAmount that uses the previous two columns 
--				to calculate the discount amount and uses the ROUND function to round the result to 2 decimal places.
--		Hint: Since DiscountPercent is a percentage, you need to multiply by .01 to make the calculation valid.
--		Note that ROUND does not necessarily affect the number of decimal places displayed; it affects the decimal precision.
--		Sort DiscountPercent in descending order.
--		Make sure you name your columns.
--		5 points
--		I got 10 rows.
--		QUESTION:	What is the discount amount (the calculated field) in record 2?
--		ANSWER:		161.850000

SELECT 
    ListPrice, 
    DiscountPercent, 
    ROUND(ListPrice * DiscountPercent * 0.01, 2) AS DiscountAmount
FROM Products
ORDER BY DiscountPercent DESC;



--9.	Write a SELECT statement that returns these columns from the Orders table:
--			The OrderID and OrderDate columns
--			A column that returns the four-digit year that’s stored in the OrderDate column (alias OrderYear),
--			A column that returns only the day of the month that’s stored in the OrderDate column (alias DayOnly),
--			A column that returns the result from adding thirty days to the OrderDate column (alias DueDate).
--		Sort OrderDate in descending order.
--		Make sure you name your columns.
--		5 points
--		I got 41 rows.
--		QUESTION:	What is the OrderYear, DayOnly, and DueDate in record 2?
--		ANSWER:		2020, 8, 2020-04-07 22:22:26.000


SELECT 
    OrderID, 
    OrderDate,
    YEAR(OrderDate) AS OrderYear,
    DAY(OrderDate) AS DayOnly,
    DATEADD(DAY, 30, OrderDate) AS DueDate
FROM Orders
ORDER BY OrderDate DESC;



--10.	Write a SELECT statement that returns these columns from the Orders table:
--			The OrderID and CardNumber columns,
--			The length of the CardNumber column (alias CardNumberLength),
--			The last four digits of the CardNumber column (alias LastFourDigits),
--			When you get that working right, add the column that follows to the result set. 
--			A column that displays the last four digits of the CardNumber column in this format: XXXX-XXXX-XXXX-1234. 
--			In other words, use Xs for the first 12 digits of the card number 
--			and actual numbers for the last four digits of the number (alias FormattedNumber).
--		Sort OrderID in descending order.
--		Make sure you name your columns.
--		5 points
--		I got 41 rows.
--		QUESTION:	What is formatted number (last column) in record 3?
--		ANSWER:		XXXX-XXXX-XXXX-1881

SELECT 
    OrderID, 
    CardNumber,
    LEN(CardNumber) AS CardNumberLength,
    RIGHT(CardNumber, 4) AS LastFourDigits,
    'XXXX-XXXX-XXXX-' + RIGHT(CardNumber, 4) AS FormattedNumber
FROM Orders
ORDER BY OrderID DESC;




--11.	Write a SELECT statement that returns these columns from the Orders table:
--			The OrderID column,
--			The OrderDate column,
--			A column named ApproxShipDate that’s calculated by adding 2 days to the OrderDate column,
--			The ShipDate column,
--			A column named DaysToShip that shows the number of days between the order date and the ship date
--			When you have this working, add a WHERE clause that retrieves just the orders for March 2020.
--		Sort OrderDate in ascending order.
--		Make sure you name your columns.
--		5 points
--		I got 10 rows.
--		QUESTION:	What is the ApproxShipDate in record 3?
--		ANSWER:		2020-03-04 11:36:12.000

SELECT 
    OrderID, 
    OrderDate,
    DATEADD(DAY, 2, OrderDate) AS ApproxShipDate,
    ShipDate,
    DATEDIFF(DAY, OrderDate, ShipDate) AS DaysToShip
FROM Orders
WHERE OrderDate >= '2020-03-01' AND OrderDate < '2020-04-01'
ORDER BY OrderDate ASC;


