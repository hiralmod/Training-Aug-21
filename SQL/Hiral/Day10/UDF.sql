--Create function
CREATE FUNCTION ufnEmp (@Salary MONEY)
RETURNS MONEY
AS
BEGIN
RETURN (@Salary  * 20 )
END

SELECT dbo.ufnEmp(1000)


--Table value Funcion

CREATE FUNCTION ufnEmpDetail (@EmployeeID INT)
RETURNS Table
AS
RETURN 
		
		(SELECT * FROM Employees 
		WHERE EmployeeID = @EmployeeID)
GO
 --Calling 
 SELECT * FROM ufnEmpDetail(101)

 --Alter Function
ALTER FUNCTION ufnEmp(@ID INT)
RETURNS INT   
AS   
BEGIN  
	DECLARE @DIFF INT
    SELECT @DIFF = DATEDIFF(DAY,HireDate,GETDATE())  
	FROM Employees 
	WHERE EmployeeID = @ID
	RETURN @DIFF
END; 

SELECT  dbo.ufnEmp(101)

--Delect function
CREATE FUNCTION ufnIncentive (@Id INT)
RETURNS TABLE
AS
RETURN
(
	SELECT A.Firstname,B.incentiveAmount 
	FROM employee1 A INNER JOIN incentives B
	ON A.empID = B.emp_ref_ID AND incentiveAmount>3000
	WHERE B.emp_ref_ID=@Id
)
GO

SELECT * FROM ufnIncentive(1)

-- determines if function exists in database  
IF OBJECT_ID (N'ufnIncentive', N'IF') IS NOT NULL
BEGIN
	PRINT 'User Defined Function Exists'
END

-- deletes function  
    DROP FUNCTION ufnIncentive ;  
GO  


--ASIIGNMENT

--1.Create a scaler Function to compute PF which will accept parameter basicsalary and compute PF. PF is 12% of the basic salary.

CREATE FUNCTION ufnCalculatePF(@Salary MONEY)
RETURNS MONEY
AS
BEGIN
	DECLARE @PF MONEY =@Salary * 0.12 
	RETURN @PF 
	END

SELECT dbo.ufnCalculatePF(25000)


--2.Create a scaler Function which will compute PT which will accept MontlyEarning. 

CREATE FUNCTION ufnTAX(@Amount MONEY)
RETURNS MONEY
BEGIN
    IF @Amount <= 5999
        RETURN @Amount
    IF @Amount >=6000 OR @Amount <= 8999
        RETURN @Amount-(12*80)
    IF @Amount >=9000 OR @Amount <= 11999
        RETURN @Amount-(12*150)
    IF @Amount >= 12000
        RETURN @Amount-(12*200)
    RETURN 0
END
GO

SELECT dbo.ufnTAX(9100)

--3.Create a table valued function which will accept JobTitle which will return new table set based on jobtitle
CREATE FUNCTION ufnJobs (@jobId INT)
RETURNS @Jobtable TABLE (JobTitle VARCHAR (20) ,JobID INT)
AS
BEGIN
	INSERT INTO @Jobtable
	SELECT Jobtitle , Job_id FROM job WHERE Job_id = @jobId
	RETURN 
END

SELECT * FROM ufnJobs(2)
