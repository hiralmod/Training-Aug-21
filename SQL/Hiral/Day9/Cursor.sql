--DECLARE CURSOR
DECLARE CURSOR1 CURSOR
	FOR SELECT * FROM Employees

--OPEN CURSOR
OPEN CURSOR1

FETCH NEXT FROM CURSOR1; 

GO  
 
 
DECLARE @MyCursor CURSOR;  
SET @MyCursor = CURSOR LOCAL SCROLL FOR  
    SELECT * FROM Employees;  
  
DEALLOCATE @MyCursor;  
  
SET @MyCursor = CURSOR LOCAL SCROLL FOR  
    SELECT * FROM Departments;  
GO  

--FETCH
GO  
DECLARE ContactCursor CURSOR FOR  
SELECT LastName FROM Employees  
WHERE LastName LIKE 'B%'  
ORDER BY LastName;  
  
OPEN ContactCursor;  
  
-- Perform the first fetch.  
FETCH NEXT FROM ContactCursor;  
  
-- Check @@FETCH_STATUS to see if there are any more rows to fetch.  
WHILE @@FETCH_STATUS = 0  
BEGIN  
   -- This is executed as long as the previous fetch succeeds.  
   FETCH NEXT FROM ContactCursor;  
END  
  
CLOSE ContactCursor;  
DEALLOCATE ContactCursor;  
GO  


--ASSIGNMENT

DECLARE @ID INT , @Salary MONEY 
DECLARE MyCursor CURSOR 
FOR
SELECT EmployeeID ,Salary FROM Employees

OPEN MyCursor

IF @@CURSOR_ROWS >0
BEGIN
		FETCH NEXT FROM MyCursor INTO @Salary , @ID
		WHILE @@FETCH_STATUS =0
			BEGIN
			IF @Salary BETWEEN 30000 AND 40000
			SET @Salary =@Salary + 5000

			ELSE IF @Salary BETWEEN 40000 AND 55000
			SET @Salary =@Salary + 7000

			ELSE IF @Salary BETWEEN 55000 AND 65000
			SET @Salary =@Salary + 9000
UPDATE Employees
SET Salary= @Salary 
WHERE EmployeeID = @ID
	FETCH NEXT FROM MyCursor INTO @ID
	END 
END
	
CLOSE MyCursor

SELECT * FROM Employees

Deallocate MyCursor

