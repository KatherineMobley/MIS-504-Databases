-- Project 4
--Join
--Katheirne Mobley
-- October 4, 2018

-- USE NORTHWIND

--1. Show the Supplier companyname, then Suppliers.supplierID, then Products.supplierID, then the productname. Order by SupplierID. Use JOIN and verify that the records match up appropriately.

Select   Suppliers.Companyname,
         Suppliers.SupplierID,
		 Products.SupplierID,
		 Products.ProductName
From     Suppliers 
	JOIN Products ON Products.SupplierID = Suppliers.SupplierID
ORDER BY Suppliers.SupplierID

--2. Show the ProductID, ProductName, and Supplier Company Name of the supplier for all Products. Order by ProductID. 

Select   Products.ProductID,
		 Products.ProductName,
		 Suppliers.CompanyName
From     Products
	JOIN Suppliers ON Products.SupplierID = Suppliers.SupplierID
Order By Products.ProductID

--3. Show the Supplier Company Name, ProductName, and unitprice for all products. unitprice descending, then by productID.

Select    Suppliers.CompanyName,
		  Products.ProductName,
		  Products.UnitPrice,
		  Products.ProductID
From      Products
	JOIN Suppliers ON Products.SupplierID = Suppliers.SupplierID
Order By  Products.UnitPrice DESC, 
		  Products.ProductID

--4. For only discontinued products with non-zero unitsinstock, show the productID, productname, and Supplier companyname.

Select Products.ProductID,
	   Products.ProductName,
	   Suppliers.CompanyName,
	   Products.UnitsInStock,
	   Products.Discontinued
From   Products
	JOIN Suppliers ON Products.SupplierID = Suppliers.SupplierID
WHERE  Products.Discontinued = '1' AND Products.UnitsInStock > 0
Order By Products.Unitsinstock

--5. We need a report that tells us everything we need to place an order. This should be only non-discontinued products whose (unitsInstock + unitsOnOrder) is less than or equal to the Reorderlevel. As the final column, it should show how many to order. We usually order enough so that (unitsInStock+UnitsOnOrder) is equal to twice the reorderlevel. Columns should be SupplierID, CompanyName, companyphone, productID, productName, amount to order. Order by SupplierID, then by productID.

Select  Suppliers.SupplierID,
		Suppliers.CompanyName,
		Suppliers.Phone, 
		Products.ProductID,
		Products.ProductName,
		Products.Discontinued,
		Products.Reorderlevel,
		Products.ReorderLevel*2 AS AmounttoOrder
From    Products
	JOIN Suppliers ON Products.SupplierID = Suppliers.SupplierID
Where  Products.Discontinued = '0' AND (Products.Unitsinstock + Products.Unitsonorder) <= Products.ReorderLevel
Order By Suppliers.SupplierID,
		 Products.ProductID
		 
--6. Do # 5 again, but also add the cost, which will be the order amount multiplied by the unitprice.

Select  Suppliers.SupplierID,
		Suppliers.CompanyName,
		Suppliers.Phone, 
		Products.ProductID,
		Products.ProductName,
		Products.Discontinued,
		Products.Reorderlevel,
		Products.ReorderLevel*2 AS AmounttoOrder,
		(Products.Reorderlevel*2)*Products.UnitPrice AS CostofOrder
From    Products
	JOIN Suppliers ON Products.SupplierID = Suppliers.SupplierID
Where  Products.Discontinued = '0' AND (Products.Unitsinstock + Products.Unitsonorder) <= Products.ReorderLevel
Order By Suppliers.SupplierID,
		 Products.ProductID

--7. (shifting to categories and products) Show the productID, productname, unitprice, and categoryname of all products.

Select  Products.ProductID,
		Products.ProductName,
		Products.UnitPrice,
		Categories.CategoryName
From   Categories
	Join Products ON Products.CategoryId = Categories.CategoryID
Order By Categories.CategoryName

--8. Show the categoryName, productID, productname, and unitprice of all products. Only show products whose inventory value is greater than $200.

Select   Categories.CategoryName,
		 Products.ProductID,
		 Products.ProductName,
		 Products.UnitPrice,
		 Products.UnitPrice*Products.Unitsinstock AS [Inventory Value]
From     Categories
	Join Products ON Products.CategoryId = Categories.CategoryID
Where    (Products.UnitPrice*Products.Unitsinstock) > 200
Order By (Products.UnitPrice*Products.UnitsInStock) 

--9. Show the CategoryName, productID, productName, and supplierName of all products. Order columns from left to right.(Note this is a 3-table join.)

Select     Categories.CategoryName,
		    Suppliers.CompanyName,
		   Products.ProductID,
		   Products.ProductName
From	   Categories
	LEFT JOIN   Products ON Products.CategoryID = Categories.CategoryID
	LEFT JOIN   Suppliers ON Products.SupplierID = Suppliers.SupplierID  
Order By   Categories.CategoryName,
		  Suppliers.CompanyName,
		  Products.ProductID,
		  Products.ProductName

--10. Show the SupplierName, CategoryName, ProductID, and productName of all products. Order columns from left to right.

Select     Suppliers.CompanyName,
		   Categories.CategoryName,
		   Products.ProductID,
		   Products.ProductName
From	   Categories
	Left JOIN   Products ON Products.CategoryID = Categories.CategoryID
	Left JOIN   Suppliers ON Products.SupplierID = Suppliers.SupplierID
Order BY Suppliers.SupplierID
