-- Project 2 
--Katherine Mobley
-- One-Table Select
-- 9/5/18

-- 1. Select the ProductID and ProductName. Order by ProductID.

Select ProductID, 
	   ProductName
From Products
Order By ProductID 

-- 2. Select the Productname and ProductID. Order by productname. (note that it is natural to order first by the left-most column)

Select ProductName,
	   ProductID
From Products
Order By ProductName

-- 3. Select the ProductID, productname, and total value of inventory. The total value is found by multiplying the unitsInstock and unitprice. Name the new column [inventory value]. Order by inventory value descending.

Select ProductID,
       ProductName, 
	   unitsInstock * unitprice AS [Inventory Value]
From Products
Order By [Inventory Value] DESC

-- 4. Select the CategoryID, ProductID, productname and inventory value. Order first by CategoryID ascending, then by inventory value descending.

Select CategoryID, 
       ProductID, 
	   Productname,
	   unitsInstock * unitprice AS [Inventory Value]
From Products
Order By CategoryID ASC, 
		 [Inventory Value] DESC

-- 5. Select the ProductID, ProductName, and unitsInstock plus unitsOnOrder. Name this column [units available].

Select ProductID, 
	   ProductName,
	   unitsInstock + unitsOnOrder AS [Units Available]
From Products

-- 6. (Note, we're switching to the customer table....) Show the CustomerID and ContactName of all customers. Order by CustomerID. Rename the columns [ID] and [name].

Select CustomerID AS [ID], 
	   ContactName AS [Name] 
From Customers
Order By CustomerID

-- 7. Show the CustomerID, ContactName, location of the space character in the contactname, and the length of the contactName. Use the CHARINDEX() and LEN() functions.

Select CustomerID,
	   ContactName,
	   LEN(ContactName) AS [Length],
	   CHARINDEX(' ', ContactName) AS [Space]
From Customers

-- 8. Show the CustomerID, ContactName, and the last name of the contact. Use code from 7 above, and the RIGHT() function.

Select CustomerID,
	   ContactName, 
	   LEN(ContactName) AS [Length],
	   CHARINDEX(' ', ContactName) AS [Space],
	   Right(ContactName, LEN(ContactName) - CHARINDEX(' ', ContactName)) AS [Last Name]
From Customers

-- 9. Show the CustomerID, CompanyName, and the City and Country concatenated together with a comma, like this: Berlin, Germany. Use the plus sign. Order first by the Country, then by the City, then by the customerID.

SELECT CustomerID,
       CompanyName,
	   Country + ', ' + City AS [Location]
From Customers
Order By Country,
		 City,
		 CustomerID

-- 10. Let's check to see if the CompanyNames are clean. Show the CustomerID and CompanyName of each customer. Also show the length in characters of the CompanyName. Also show the trimmed CompanyName (use the TRIM() function.) Also show the length of the trimmed CompanyName. If those two lengths are different, then CompanyName has some trailing spaces.

Select CustomerID,
	   CompanyName,
	   LEN(CompanyName) AS [Length],
	   Trim(CompanyName) AS [Trim], 
	   LEN(TRIM(CompanyName))
From Customers

-- 11. Show the CustomerID and the customerID converted to lower case (use LOWER()).

SELECT CustomerID, 
	   LOWER(CUSTOMERID) AS [Lower Case]
From Customers

-- 12. Show the CustomerID, and the contactname. We'd also like to see the customer name like this: first initial, one space, then the lastname, all in one column called [short name].

Select CustomerID, 
	   ContactName,
	   LEFT(ContactName,1) + ' '+  Right(ContactName, LEN(ContactName)-CharIndex(' ', ContactName)) AS [Short Name]
From Customers
