--Create Procedure
CREATE PROCEDURE uspEmpDetails
	@FirstName VARCHAR(30),
	@LastName VARCHAR(30)
AS
	SELECT FirstName, LastName,EmployeeID
	FROM Employees
	WHERE FirstName = @FirstName AND LastName = @LastName
Go

EXECUTE uspEmpDetails @FirstName=N'David' , @LastName =N'Austin'

--Output parameter
CREATE PROCEDURE uspDetails @EmpID INT , @FirstName VARCHAR(50) OUTPUT, @DepartmentName VARCHAR(30) OUTPUT
AS
BEGIN
IF EXISTS (SELECT * FROM Employees WHERE EmployeeID =@EmpID)
BEGIN
	SELECT @FirstName= E.FirstName , @DepartmentName = D.DepartmentName
	FROM Employees E 
	JOIN Departments D
	ON E.DepartmentID = D.DepartmentID
	WHERE EmployeeID = @EmpID
END
END

EXECUTE dbo.uspDetails @EmpID=101 , @FirstName =N'Lex' , @DepartmentName='IT'

--Return JSON output from stored procedure
CREATE PROCEDURE uspStudent @JSON NVARCHAR(MAX) OUTPUT
AS 
BEGIN
SET @JSON =(SELECT TOP(1)
			[Name],
			[City]
			FROM Students
			FOR JSON PATH
			)
END

DECLARE @JSON NVARCHAR(MAX)
EXEC dbo.uspStudent @JSON = @JSON OUTPUT
SELECT @JSON


--ASSIGNMENT

--1.Create a Store Procedure which will accept name of the customer as input parameter and product the following output, List Names of Customers who are Depositors and have Same Branch City as that of input parameter customer’s Name.
CREATE PROCEDURE uspCustomer @Name VARCHAR(30) 
AS
BEGIN
	SELECT D.Cname  From Deposite D join 
	branch B  ON D.Bname=B.Bname WHERE B.City IN
	(
		SELECT B.City from branch JOIN 
		Deposite D ON D.Bname = B.Bname WHERE D.Cname=@Name
	)
END

EXEC uspCustomer @Name = 'Anil'

--2. Create a Store Procedure which will accept name of the customer as input parameter and produce the following output List in JSON format, All the Depositors Having Depositors Having Deposit in All the Branches where input parameter customer is Having an Account.

CREATE PROCEDURE uspCustomers @Name varchar (30)
AS
BEGIN
    IF EXISTS(SELECT *
            FROM customer
            WHERE Cname = @Name)
    BEGIN
            SELECT *
            FROM Deposite
            WHERE Bname IN(
                SELECT Bname
                FROM Deposite
                WHERE Cname = @Name
                UNION
                SELECT Bname
                FROM borrow
                WHERE Cname = @Name
            )
            FOR JSON PATH
    END
END
GO

EXEC dbo.uspCustomers @Name = 'Sunil'


--3.Create a Store Procedure that will accept city name and returns the number of customers in that city.

CREATE PROCEDURE uspGetCityCustomer1 @CityName VARCHAR (20)
AS
BEGIN
	SELECT * FROM customer 
	WHERE City = @CityName
END

EXEC uspGetCityCustomer1 @CityName ='mumbai'


--4.Create a Store Procedure which will accept city of the customer as input parameter and product the following output List in JSON format List All the Customers Living in city provided in input parameter and Having the Branch City as MUMBAI or DELHI.
CREATE PROCEDURE uspCity @City varchar (30),@Customer NVARCHAR(MAX) OUTPUT
AS 
BEGIN 
SET @Customer = 
	(
		SELECT C.Cname  FROM Deposite D join 
		customer C on C.Cname = D .Cname join 
		branch B on D.Bname = B.Bname 
		WHERE C.City= @City AND B.City IN ('BOMBAY','DELHI')
		FOR JSON PATH
	)
END

DECLARE @Customer NVARCHAR(MAX)
EXEC dbo.uspCity @Customer = @Customer OUTPUT ,@City = 'Nagpur'
SELECT @Customer



--5.Count the Number of Customers Living in the City where Branch is Located.

CREATE PROCEDURE uspBranch1 @Branch varchar (30)
AS
BEGIN
IF EXISTS(
		SELECT *FROM branch
        WHERE City LIKE @Branch
		)
    BEGIN
        SELECT COUNT(*) AS 'No of customer'
        FROM customer AS C
            INNER JOIN Deposite AS D
                ON C.Cname = D.Cname
            INNER JOIN borrow AS B
                ON C.Cname = B.Cname
        WHERE City = @Branch
            
    END
END

EXEC dbo.uspBranch1 @Branch = 'Nagpur'

--6.Create a Procedure which will accept input in JSON parameter CustomerName,City, ACTNO,Branch,amount And insert these record in the Deposit table. Before inserting some validation should be done like amount should be greater than 10Rs. and date should always be current date.
    
CREATE PROCEDURE uspDeposit
    @depositData NVARCHAR(MAX)
AS
BEGIN
    IF(ISJSON(@depositData)=1)
    BEGIN
            INSERT INTO Deposite
            SELECT *
            FROM OPENJSON(@depositData)
            WITH(
                ACTNO VARCHAR(5) 'strict $.ACTNO'
            ,    CName VARCHAR(18) 'strict $.Cname'
            ,    BName VARCHAR(18) 'strict $.Bname'
            ,    Amount INT 'strict $.Amount'
            ,    Adate DATE 'strict $.Adate'
            ) AS temp
    END
    ELSE
        PRINT 'Json is not proper.'
END
GO
