--Project 6
--Katherine Mobley
--10/20/18
--Ranking and Conversions

--1. Show the CategoryName, CategoryDescription, and number of products in each category. You will have trouble grouping by CategoryDescription, because of its data type.

Select Categories.CategoryName,
	   Cast(Categories.Description AS NVARCHAR(100))   AS [Category Description],
	   Count(Products.Unitsinstock)                    AS [Number of Products]
From Categories
	JOIN Products ON Products.categoryID = Categories.CategoryID
Group BY Categories.CategoryName,
		 Cast(Categories.Description AS nvarchar(100))
Order BY Categories.CategoryName

--2. We want to know the percentage of buffer stock we hold on every product. We want to see this as a percentage above/below the reorderLevel. Show the ProductID, productname, unitsInstock, reOrderLevel, and the percent above/below the reorderlevel. So if unitsInstock is 13 and the reorderLevel level is 10, the percent above/below would be 0.30. Make sure you convert at the appropriate times to ensure no rounding occurs. Check your work carefully.

Select   ProductID,
	     ProductName,
	     Unitsinstock,
	     ReorderLevel,
	     Cast((unitsinstock/ReorderLevel) AS FLOAT)                AS [Percentage Above/Below],
	     Cast(Unitsinstock as Float)/(Cast(ReorderLevel as float)) AS [Percent Above/Below]
From     Products
WHERE    Reorderlevel > 0 
Group BY ProductID,
		 ProductName,
		 UnitsInStock,
		 ReorderLevel
Order BY ProductID

--3. Show the orderID, orderdate, and total amount due for each order, including freight. Make sure that the amount due is a money data type and that there is no loss in accuracy as conversions happen. Do not do any unnecessary conversions. The trickiest part of this is the making sure that freight is NOT in the SUM.

SELECT OrderID, 
	   OrderDate, 
	   CAST (Freight AS MONEY) AS [Amount Due]
FROM   Orders

--4. Our company is located in Wilmington NC, the eastern time zone (UTC-5). We've been mostly local, but are now doing business in other time zones. Right now all of our dates in the orders table are actually our server time, and the server is located in an Amazon data center outside San Francisco, in the pacific time zone (UTC-8). For only the orders we ship to France, show the orderID, customerID, orderdate in UTC-5, and the shipped date in UTC+1 (France's time zone.) You might find the TODATETIMEOFFSET() function helpful in this regard. Remember the implied time zone (EST) when you do this.
		
		-- So I have 2 codes here, one to show the specific orderdate and shippeddate that don't include time according to their original table. The other using Getdate which includes the Time Zone's. 

SELECT   OrderID, 
		 CustomerID, 
		 TODATETIMEOFFSET(OrderDate,'-05:00')   AS [Time on East Coast],
		 TODATETIMEOFFSET(ShippedDate,'+01:00') AS [France's Time Zone]
FROM     Orders
Where    ShipCountry = 'France'
Group BY OrderID,
		 CustomerID,
		 OrderDate,
		 ShippedDate
Order By OrderID,
		 CustomerID


SELECT  OrderID, 
		CustomerID, 
		TODATETIMEOFFSET(GETDATE(),'-05:00') AS [Time on East Coast],
		TODATETIMEOFFSET(GETDATE(),'+01:00') AS [France's Time Zone]
FROM    Orders
Where   ShipCountry = 'France'
Group BY OrderID,
		 CustomerID,
		 OrderDate
Order By OrderID,
		 CustomerID

--5. We are realizing that our data is taking up more space than necessary, which is making some of our regular data become "big data", in other words, difficult to deal with. In preparation for a data migration, we'd like to convert many of the fields in the Customers table to smaller data types. We anticipate having 1 million customers, and this conversion could save us up to 58MB on just this table. Do a SELECT statement that shows all fields in the table, in their original order, and rows ordered by customerID, with these fields converted:
	-- CustomerID converted to CHAR(5) - saves at least 5 bytes per record
	-- PostalCode converted to VARCHAR(10) - saves up to 5 bytes per record
	-- Phone converted to VARCHAR(24) - saves up to 24 bytes per record
	-- Fax converted to VARCHAR(24) - saves up to 24 bytes per record

Select  Convert(Char(5),CustomerID)     AS [CustomerID], 
		CompanyName,
		ContactName,
		ContactTitle,
		Customers.Address,
		City,
		Region,
		Convert(VARCHAR(10),PostalCode) AS [PostalCode],
		Country,
		Convert(VARCHAR(24),Phone)      AS [Phone],
		Convert(VARCHAR(24),Fax)        AS [Fax]
From    Customers
Order BY CustomerID

--6. Show a list of products, their unit price, and their ROW_NUMBER() based on price, ASC. Order the records by productname.

Select   ProductID,
	     ProductName,
	     UnitPrice,
	     ROW_Number() OVER(Order By UnitPrice ASC) AS [Price]
From     Products
Order By ProductName

--7. Do #6, but show the DENSE_RANK() based on price, ASC, rather than ROW_NUMBER().

SELECT   ProductID,
	     ProductName, 
	     UnitPrice, 
	     DENSE_RANK () OVER (ORDER BY UnitPrice ASC) AS [Price]
FROM     Products
ORDER BY ProductName

--8. Show a list of products ranked by price into three categories based on price: 1, 2, 3. The highest 1/3 of the products will be marked with a 1, the second 1/3 as 2, the last 1/3 as 3. HINT: this is NTILE(3), order by unitprice ASC.

SELECT   ProductID, 
		 UnitPrice,
		 NTILE (3) OVER (ORDER BY UnitPrice DESC) AS [PriceRank]
FROM     Products 
ORDER BY UnitPrice ASC

--9. Show a list of products from categories 1, 2 7, 4 and 5. Show their RANK() based on value in inventory.

SELECT   Categories.CategoryID,
		 Products.ProductID,
		 Products.ProductName, 
		 RANK ()   OVER (ORDER BY (Products.UnitPrice * Products.UnitsInStock) ASC) AS [Value In Inventory]
FROM     Products
	JOIN Categories ON Categories.CategoryID = Products.CategoryID
WHERE    Categories.CategoryID IN (1, 2, 7, 4, 5) 
Order BY [Value In Inventory] ASC

--10. Show a list of orders, ranked based on freight cost, highest to lowest. Order the orders by the orderdate.

SELECT   OrderID, 
	     OrderDate,
	     RANK () OVER (ORDER BY Freight DESC) AS [Freight Cost]
FROM     Orders
ORDER BY OrderDate