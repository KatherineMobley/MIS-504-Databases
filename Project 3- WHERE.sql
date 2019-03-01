--Project 3
--Katherine Mobley
--WHERE
--9/11/18

--USE Northwind 

--1. Select the ProductID, ProductName, and unitprice of all products that cost less than $8.50. Order products by productID.

SELECT ProductID,
       Productname,
	   UnitPrice
FROM   Products
WHERE  UnitPrice <$8.50
Order By ProductID ASC

--2. Select the ProductID, ProductName, and unitprice of all products that have fewer than 10 units in stock. Order by ProductID.

SELECT ProductID,
       ProductName, 
	   Unitprice,
	   Unitsinstock
From Products
WHERE unitsinstock <10
Order By ProductID 

--3. Select the Productname, unitprice, and total value in inventory of all products. Value in inventory is calculated by multiplying unitsInstock by unitprice. Order by productname.

Select ProductName,
       UnitPrice,
	   unitsinstock*unitprice AS [Total Value in Inventory]
FROM Products
Order By ProductName ASC

--4. Select the Productname, categoryID and unitprice of all products that are in category 1 and cost less than $10. 

SELECT ProductName,
       CategoryID,
	   Unitprice
From Products
WHERE CategoryID IN (1)
AND UnitPrice<10

--5. Select the ProductName, categoryID, and unitprice of all products that are in category 2 and cost more than $8.

SELECT ProductName,
       CategoryID,
	   Unitprice
From Products
WHERE CategoryID IN (2)
AND unitprice> 8

--6. Combine all the records from questions 4 and 5 into a single SELECT statement. Use parentheses, ANDs and ORs as necessary.
 
SELECT ProductName,
       CategoryID,
	   Unitprice
From Products
WHERE (CategoryID IN (1) AND UnitPrice<10) 
OR (CategoryID IN (2) AND UnitPrice>8) 
Order By CategoryID

--7. Show all productnames and prices of products that are packaged in bottles. Do this by using the LIKE statement on the QuantityPerUnit field.

SELECT ProductName,
	   unitprice,
	   Quantityperunit
From Products
WHERE QuantityPerUnit LIKE '%Bottles' 

--8. Show all productnames that end in the word 'Lager'.

SELECT ProductName
FROM Products
WHERE Productname LIKE '%Lager'

--9. Show all products that are in one of these categories: 1, 3, 5, or 7. Use the IN clause. Show the name and unitprice of each product.

SELECT CategoryID,
       ProductName,
	   Unitprice
FROM Products
WHERE CategoryID IN (1,3,5,7)

--10. Select ProductID, ProductName, and SupplierID of all products that have the word "Ale" or "Lager" in the productname. Order by ProductID.

SELECT ProductID,
       ProductName,
	   SupplierID
FROM Products
WHERE (ProductName LIKE '%Ale' OR ProductName LIKE '%Lager')
Order By ProductID

--11. Select the productname and unitprice of all products whose units in stock are less than half of the reorder level. Order by units in stock ascending.

Select ProductName,
       Unitprice,
	   Reorderlevel,
	   unitsinstock
FROM   Products
WHERE (Reorderlevel/2) > UnitsInStock
Order By Unitsinstock ASC

--12. Select the productname of all products whose value in inventory is more than $500. Order by inventory value descending.

SELECT ProductName,
	   UnitsInstock,
	   UnitPrice,
	   UnitsInStock*UnitPrice AS [Value in Inventory]
FROM Products
WHERE (unitsinstock*Unitprice) > 500
Order By (unitsinstock*UnitPrice) DESC

--13. Select the Productname of any products whose value in inventory is more than $500 and is discontinued. Also show inventory value. Order by inventory value descending.

SELECT ProductName,
	   Discontinued,
	   UnitsInStock*UnitPrice AS [Value in Inventory]
FROM Products
WHERE (unitsinstock*Unitprice) > 500 
AND Discontinued IN (1)
Order By (unitsinstock*UnitPrice) DESC

--14. Show all products that we need to reorder. These are the products that are not discontinued, and the unitsinstock plus unitsOnOrder is less than or equal to the reorderLevel.

SELECT ProductID,
	   ProductName,
	   Discontinued,
	   Reorderlevel,
	   UnitsInStock + UnitsOnOrder AS [Units]
From Products
Where Discontinued IN (0) 
AND (unitsinstock + unitsonorder)<= ReorderLevel

--15. Show the categoryID, productID, productname, and unitprice of all products. Order by categoryID, then unitprice descending, then productID.

SELECT CategoryID,
       ProductID,
	   ProductName,
	   UnitPrice
From Products
Order By CategoryID ASC,
		 UnitPrice DESC,
		 ProductID ASC