--JSON PATH
	SELECT FirstName AS 'EmployeeName',
	LastName AS 'Employe LastName'
	FROM Employees FOR JSON PATH

--JSON QUERY
SELECT EmployeeID,
         JSON_QUERY(CONCAT('["',FirstName,'","',LastName,'"]')) AS FullName
FROM Employees 
FOR JSON PATH

--JSON MODIFY
DECLARE @info NVARCHAR(100)=
		'{"Name":"John","skills":["C#","SQL"]}'

PRINT @info

-- Update name  

SET @info=JSON_MODIFY(@info,'$.Name','Michel')

PRINT @info

-- Insert surname  

SET @info=JSON_MODIFY(@info,'$.Surname','Steve')

PRINT @info

-- Add skill  

SET @info=JSON_MODIFY(@info,'append $.skills','PHP')

PRINT @info

-- Multiple updates  

SET @info=JSON_MODIFY(JSON_MODIFY(JSON_MODIFY(@info,'$.Name','Mike'),'$.Surname','Smith'),'append $.skills','Azure')

PRINT @info

-- Update skills array  

SET @info=JSON_MODIFY(@info,'$.skills',JSON_QUERY('["C#","T-SQL","Azure"]'))

PRINT @info

--JSON AUTO
	SELECT E.Firstname,I.incentiveAmount 
	FROM employee1 E 
	INNER JOIN incentives I
	on E.empID= I.emp_ref_ID 
	AND incentiveAmount>3000
	FOR JSON AUTO

--INCLUDE NULL VALUES
SELECT ManagerID FROM Employees FOR JSON PATH,INCLUDE_NULL_VALUES
 
--WIHOUT ARRAY WRAPPER
SELECT TOP 2 Salary FROM Employees 
FOR JSON PATH, WITHOUT_ARRAY_WRAPPER 

--Assignment
DECLARE @data NVARCHAR(MAX)
SET @data =N'
  
   [
        {
            "Name": "Raj",
            "Address":"dhfjhfj",
            "City" : "Rajkot",
            "DOB": "2008/08/13",
            "Standard" : 11
        },
        {
            "Name": "Shital",
            "Address":"behdjsxnk",
            "City" : "Ahmedabad",
            "DOB": "2009/06/15",
            "Standard" : 10
        },
        {
            "Name": "Pratik",
            "Address":"bcbnerbjhchj",
            "City" : "Baroda",
            "DOB": "2011/05/05",
            "Standard" : 8
        },
        {
            "Name": "Mital",
            "Address":"nverjfheh",
            "City" : "Surat",
            "DOB": "2012/03/09",
            "Standard" : 7
        },
        {
            "Name": "Dhruv",
            "Address":"hdhsjkjdc",
            "City" : "Jamnagar",
            "DOB": "2012/04/22",
            "Standard" : 7
      }
]'

SELECT *
FROM OPENJSON(@data)
WITH 
(
        Name VARCHAR(50) '$.Name',
       Address VARCHAR(60) '$.Address',
       City VARCHAR(30)  '$.City',
       DOB DATE '$.DOB',
       Standard INT '$.Standard'
)

SELECT *
FROM Students
