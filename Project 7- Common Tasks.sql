--Project 7
--Common Tasks
-- Katherine Mobley

--1. Find any products that have not appeared on an order, ever. (LEFT JOIN, WHERE IS NULL)

Select Products.ProductID,
	   Products.ProductName,
	   Suppliers.SupplierID
From   Products 
	Left Join Suppliers ON Products.SupplierID = Suppliers.SupplierID
WHERE  Products.SupplierID is Null

--2. Find any products that have not appeared on an order in 1996. (subquery with NOT IN)

Select Orders.OrderID,
	   Orders.Orderdate
From   Orders
Where  Orders.OrderDate Not In (Select OrderDate
								From Orders
								Where Year(OrderDate) =1996)
Order By Orders.OrderID

--3. Find any customers who have not placed an order, ever (similar to #1).

Select Customers.CustomerID,
	   Orders.ShippedDate
From   Orders
	LEFT JOIN Customers ON Customers.CustomerID = Orders.CustomerID
WHERE  Orders.ShippedDate is Null 

--4. Find any customers that did not place an order in 1996 (similar to #2).

Select Customers.CustomerID,
	   Orders.ShippedDate
From   Orders
	LEFT JOIN Customers ON Customers.CustomerID = Orders.CustomerID
WHERE  Year(Orders.OrderDate)!= 1996 

--5. List all products that have been sold (any date). We need this to run fast, and we don't really want to see anything from the [order details] table, so use EXISTS.

Select Products.ProductName
From   Products
WHERE  Exists(Select *
			  From  Categories
			  WHERE Categories.CategoryID = Products.CategoryID) 

--6. Show all products, and a count of how many were sold across all orders in 1996. Make sure to show even products where none were sold in 1996. (OUTER JOIN)

--SKIP THIS ONE 

--7. Give all details of all the above-average priced products. (simple subquery)

Select   ProductID, 
	     AVG(UnitPrice) AS [AVG Price]
From     Products
Where    UnitPrice > (Select AVG(UnitPrice)
					From Products)
Group By ProductID

--8. Find all orders where the ShipName has non-ASCII characters in it (trick: WHERE shipname <> CAST(ShipName AS VARCHAR).

Select   OrderID,
	     Convert(Varchar(100), ShipName) AS [ShipName]
From     Orders
Where    Shipname <> Cast(Shipname AS Varchar)
Group BY OrderID,
		 ShipName

--9. Show all Customers' CompanyName and region. Replace any NULL region with the word 'unknown'. Use the ISNULL() function. (Do a search on SQL ISNULL)

Select   CustomerID,
	     CompanyName, 
		 Region
From     Customers
WHERE    Region != (Select Region
					From Customers
					Where Region = IsNull('unknown', 0))
Group by CustomerID,
		 Region,
		 CompanyName

--10. We need to know a list of customers (companyname) who paid more than $100 for freight on an order in 1996 (based on orderdate). Use the ANY operator to get this list. (We are expecting this to have to run often on billions of records. This could be done much less efficiently with a JOIN and DISTINCT.)

Select Customers.CompanyName
From   Customers	
WHERE  $100 < ANY (Select Freight
				   From   Orders
				   Where  Orders.CustomerID = Customers.CustomerID
						AND Year(Orderdate)= 1996)
Order By Customers. CompanyName

--11. We want to know a list of customers (companyname) who paid more than $100 for freight on all of their orders in 1996 (based on orderdate). Use the ALL operator. (We are expecting this to have to run often on billions of records. This could be done much less efficiently using COUNTs.)

Select Customers.CompanyName
From   Customers	
WHERE  $100 < ALL (Select Freight
				   From   Orders
				   Where  Orders.CustomerID = Customers.CustomerID
					AND   Year(Orderdate)= 1996)
Order By Customers. CompanyName

--12. Darn! These unicode characters are messing up a downstream system. How bad is the problem? List all orders where the shipName has characters in it that are not upper case letters A-Z or lower case letters a-z. Use LIKE to do this. (see the LIKE video, and use '%[^a-zA-Z]%'

Select ShipName
From   Orders
Where  ShipName LIKE '%[^a-zA-Z]%'
Order By ShipName
