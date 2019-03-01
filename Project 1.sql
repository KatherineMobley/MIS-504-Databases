--Project 1
--Katherine Mobley
-- no-table Select
--8/30/18

--1.Show the number 789345 in a one-row, one-column table using SELECT.

Select 789345

--2. Show the word 'independent' in a one-row, one column table using SELECT.

Select 'independent'

--3. Show the number 7 in a one-row, one-column table using SELECT. The column should be named [Odd Number].

Select 7 AS [Odd Number]

--4. Show the 'Fred', 'Flintstone', 'male', and 37 in a one-row, four-column table. The columns should be named [First], [Last], [gender], and [age].

Select 'Fred' AS [First], 'Flinstone' AS [Last], 'Male' AS [Gender], 37 AS [Age]

--5. Show the SQRT of 45787 using the SQRT() function. (documentation with examples (Links to an external site.)Links to an external site.)

Select SQRT(45787)

--6. Show the name 'Fred S. Flintstone' in a single column. Do this by concatenating (plus sign) these things: 'Fred', 'S', and 'Flintstone'. Place the period and spaces in the appropriate places. 

Select 'Fred'+' '+ 'S'+'.'+ ' '+ 'Flinstone'

--7. Show the current server time in a column named [Current Time]. Use the GETDATE() function.

Select Getdate() AS [Current Time]

--8. Show a 3-column, 1 row table that has 345, "Barney", 35*28 in the columns. The columns should be named "number", "name", and "result".

Select '345' AS [Number], 'Barney' AS [Name], 35*28 AS [Result]

--9. Find the SQRT of 133765, and multiple it by the SQRT of 33987. Show the result in a one-row, one-column table where the column is called "calculation result". Use a single SELECT statement.

Select SQRT(133765) * SQRT(33987) AS [Calculation Result]

--10. Show the result of this calculation in a one-row, one-column table: ((34.0*72.0)+7.0)/3.0 . Name the column "calculation result".

Select ((34.0*72.0)+ 7.0)/3.0  AS [Calculation Result]
