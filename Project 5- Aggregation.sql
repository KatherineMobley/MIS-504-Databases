--Project 5: Aggregation
--Katherine Mobley
--10/12/18


--1. Show the Supplier companyname and the count of how many products we get from that supplier. Make sure to count the primary key of the products table. Order by companyname.

Select   Suppliers.CompanyName,
		 Count(Products.ProductID) AS [NumberofProducts]
From     Products
	Join Suppliers ON Suppliers.SupplierID = Products.SupplierID
Group By Suppliers.CompanyName
Order BY Suppliers.CompanyName

--2. Do number 1 again, but only include products that are not discontinued.

Select  Suppliers.CompanyName,
		Count(Products.ProductID) AS [NumberofProducts]
From    Products
	Join Suppliers ON Suppliers.SupplierID = Products.SupplierID
WHERE    Products.Discontinued < 1
Group By Suppliers.CompanyName
Order BY Suppliers.CompanyName

--3. Show the Supplier companyname and the average unitprice of products from that supplier. Only include products that are not discontinued.

Select   Suppliers.CompanyName,
		 AVG(Products.Unitprice) AS AverageUnitPrice
From     Products
	Join Suppliers ON Suppliers.SupplierID = Products.SupplierID
WHERE    Products.Discontinued < 1
Group By Suppliers.CompanyName
Order BY Suppliers.CompanyName

--4. Show the Supplier companyname and the total inventory value of all products from that supplier. This will involve the SUM() function with some calculations inside the functions.

Select   Suppliers.CompanyName,
	     SUM(Products.Unitsinstock*Products.UnitPrice) AS [Total Inventory Value]
From     Suppliers
	JOIN Products ON Products.SupplierID = Suppliers.SupplierID
Group BY Suppliers.CompanyName
Order BY Suppliers.CompanyName

--5. Show the Category name and a count of how many products are in each category.

Select   Categories.CategoryID,
	     Categories.CategoryName,
	     COUNT(Products.CategoryID) AS ProductsinCategories
From     Categories
	JOIN Products ON Products.categoryID = Categories.CategoryID
Group BY Categories.CategoryID,
		 categories.CategoryName
Order BY Categories.CategoryID,
		 Categories.CategoryName

--6. Show the Category name and a count of how many products in each category that are packaged in jars (have the word 'jars' in the QuantityPerUnit.)

Select    Categories.CategoryName,
		  Products.CategoryID,
		  Products.Quantityperunit,
		  Count(Products.Quantityperunit) As Quantityperunit
From      Categories
	JOIN  Products ON Products.categoryID = Categories.CategoryID
Where     Products.Quantityperunit LIKE '%jars'
Group BY  Categories.CategoryID,
		  Categories.CategoryName,
		  Products.Quantityperunit,
		  Products.CategoryID
Having    Products.Quantityperunit LIKE '%jars'
Order BY  Categories.CategoryID,
		  Categories.CategoryName,
		  Products.Quantityperunit,
		  Products.CategoryID

--7. Show the Category name, and the minimum, average, and maximum price of products in each category.

Select Categories.CategoryName,
	   Min(products.unitprice) AS [Min Unit Price],
	   AVG(Products.unitprice) AS [AVG Unit Price],
	   Max(Products.unitprice) AS [Max Unit Price]
From   Categories
	JOIN Products ON Products.categoryID = Categories.CategoryID
Group BY Categories.CategoryName
Order BY Categories.CategoryName

--8. Show each order ID, its orderdate, the customer ID, and a count of how many items are on each order

Select   Orders.OrderID,
		 Orders.OrderDate,
		 Orders.CustomerID,
		 Count([Order Details].Quantity) AS Itemsonorder
From     Orders
	Join [Order Details] ON Orders.OrderID = [Order Details].OrderID
Group BY  Orders.OrderID,
		  Orders.Orderdate,
		  Orders.CustomerID
Order BY  Orders.OrderID,
		  Orders.Orderdate,
		  Orders.CustomerID

--9. Show each productID, its productname, and a count of how many orders it has appeared on.

Select   Products.ProductID,
	     Products.ProductName,
	     Count([Order Details].ProductID) AS AppearsON
From     Products
	JOIN [Order Details] ON Products.ProductID = [Order Details].ProductID
Group BY Products.ProductID,
	     Products.ProductName
Order BY Products.ProductID,
	     Products.ProductName

--10. Do #9 again, but limit to only orders that were place in January of 1997.

Select   Products.ProductID,
	     Products.ProductName,
	     Count([Order Details].ProductID) AS OrdersinJAN
From     Products
	JOIN [Order Details] ON Products.ProductID = [Order Details].ProductID
	Join Orders ON Orders.OrderID = [Order Details].OrderID
WHERE    Orders.ShippedDate BETWEEN '1997-01-01' AND '1997-02-01'
Group BY Products.ProductID,
	     Products.ProductName
Order BY Products.ProductID,
	     Products.ProductName

--11. Show each OrderID, its orderdate, the customerID, and the total amount due, not including freight. Sum the amounts due from each product on the order. The amount due is the quantity times the unitprice, times one minus the discount. Order by amount due, descending, so the biggest dollar amount due is at the top.

Select   Orders.OrderID,
		 Orders.OrderDate,
		 Orders.CustomerID,
		 SUM([Order Details].Quantity*[Order Details].Unitprice*1-[Order Details].Discount) AS [TotalAmountDue]
From     Orders
	Join [Order Details] ON Orders.OrderID = [Order Details].OrderID
Group BY Orders.OrderID,
		 Orders.OrderDate,
		 Orders.CustomerID
Order BY SUM([Order Details].Quantity*[Order Details].UnitPrice*1-[Order Details].Discount) DESC,
		 Orders.OrderID,
		 Orders.OrderDate,
		 Orders.CustomerID

--12. We want to know, for the year 1997, the total revenues by category. Show the CategoryID, categoryname, and the total revenue from products in that category. This is very much like #11. Don't include freight.

Select   Categories.CategoryID,
	     Categories.CategoryName,
	     SUM(([Order Details].UnitPrice-[Order Details].Discount) * [Order Details].Quantity) AS [1997 Total Revenue]
From     Categories
	Join Products        ON Products.CategoryID = Categories.CategoryID
	JOIN [Order Details] ON [Order Details].ProductID = Products.ProductID
	JOIN Orders          ON Orders.OrderID = [Order Details].OrderID
Where    Year(Orders.Orderdate)=1997
Group BY Categories.CategoryID,
	     Categories.CategoryName
Order BY Categories.CategoryID,
	     Categories.CategoryName

--13. We want to know, for the year 1997, total revenues by month. Show the month number, and the total revenue for that month. Don't include freight.

SELECT     MONTH(orderDate) [Month],
           SUM(([Order Details].UnitPrice-[Order Details].Discount) * [Order Details].Quantity) AS [Monthly Revenue]
FROM       Orders
	JOIN   [Order Details] ON Orders.OrderID = [Order Details].OrderID
WHERE      YEAR(orderDate) = 1997
GROUP BY   MONTH(orderDate)
HAVING     MIN(Orders.OrderDate) > 1997-01-01
	AND    Max(Orders.OrderDate) < 1997-02-10
ORDER BY   MONTH(orderDate)
--14. We want to know, for the year 1997, total revenues by employee. Show the EmployeeID, lastname, title, then their total revenues. Don't include freight. 

SELECT     Employees.EmployeeID,
           Employees.LastName,
           Employees.Title,
           SUM(([Order Details].UnitPrice-[Order Details].Discount) * [Order Details].Quantity) AS [1997 Total Revenue]
FROM       Employees
	JOIN   Orders            ON Employees.EmployeeID = Orders.EmployeeID
	JOIN   [Order Details]   ON Orders.OrderID = [Order Details].OrderID
WHERE      YEAR(Orders.OrderDate)=1997
GROUP BY   Employees.EmployeeID,
           Employees.LastName,
           Employees.Title
ORDER BY   Employees.EmployeeID

--15. We want to know, for the year 1997, a breakdown of revenues by month and category. Show the month number, the categoryname, and the total revenue for that month in that category. Order the records by month then category.

SELECT     MONTH(orderDate) [Month],
		   Categories.CategoryName,
           SUM(([Order Details].UnitPrice-[Order Details].Discount) * [Order Details].Quantity) AS [Monthly Revenue]
FROM       Orders
	JOIN   [Order Details] ON Orders.OrderID      = [Order Details].OrderID
	JOIN   Products        ON Products.ProductID  = [Order Details].ProductID
	JOIN   Categories      ON Products.CategoryID = Categories.CategoryID
WHERE      YEAR(orderDate) = 1997
GROUP BY   Categories.CategoryName,
		   MONTH(orderDate)
HAVING     MIN(Orders.OrderDate) > 1997-01-01
	AND    Max(Orders.OrderDate) < 1997-02-10
ORDER BY   MONTH(orderDate),
		   Categories.CategoryName
