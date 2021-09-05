--1.Select employee details from employee table if data exists in incentive table ?
SELECT * FROM employee1 where exists (select* from incentives)

--2.Find Salary of the employee whose salary is more than Roy Salary.
SELECT * FROM employee1 WHERE salary>(SELECT salary FROM employee1 WHERE Firstname='roy')


--Practise view
CREATE TABLE dbo.SUPPLY1 (  
supplyID INT PRIMARY KEY CHECK (supplyID BETWEEN 1 and 150),  
supplier CHAR(50)  
);  
CREATE TABLE dbo.SUPPLY2 (  
supplyID INT PRIMARY KEY CHECK (supplyID BETWEEN 151 and 300),  
supplier CHAR(50)  
);  
CREATE TABLE dbo.SUPPLY3 (  
supplyID INT PRIMARY KEY CHECK (supplyID BETWEEN 301 and 450),  
supplier CHAR(50)  
);  
CREATE TABLE dbo.SUPPLY4 (  
supplyID INT PRIMARY KEY CHECK (supplyID BETWEEN 451 and 600),  
supplier CHAR(50)  
);  
GO  
--Create the view that combines all supplier tables.  
CREATE VIEW dbo.all_supplier_view  
WITH SCHEMABINDING  
AS  
SELECT supplyID, supplier  
  FROM dbo.SUPPLY1  
UNION ALL  
SELECT supplyID, supplier  
  FROM dbo.SUPPLY2  
UNION ALL  
SELECT supplyID, supplier  
  FROM dbo.SUPPLY3  
UNION ALL  
SELECT supplyID, supplier  
  FROM dbo.SUPPLY4;  
GO
INSERT dbo.all_supplier_view VALUES ('1', 'CaliforniaCorp'), ('5', 'BraziliaLtd')    
, ('231', 'FarEast'), ('280', 'NZ')  
, ('321', 'EuroGroup'), ('442', 'UKArchip')  
, ('475', 'India'), ('521', 'Afrique');  
GO   

--3.Create a view to select FirstName,LastName,Salary,JoiningDate,IncentiveDate and IncentiveAmount.

GO
CREATE VIEW VIEW1
AS

	SELECT E.FirstName ,E.LastName ,E.Salary ,E.HireDate, I.incentivedate , I.incentiveAmount
	FROM Employees E
	JOIN incentives I
	ON  E.EmployeeID = I.emp_ref_ID
 GO

	SELECT * FROM VIEW1

--4.Write a View to display the department name, manager name, and city.

GO
CREATE VIEW VIEW2
AS 
	SELECT D.DepartmentName , E.FirstName , L.City
	FROM Employees E
	JOIN Departments D
	ON D.ManagerID = E.EmployeeID
	JOIN Locations L
	ON D.LocationID = D.LocationID
GO

	SELECT * FROM VIEW2


--5.Create a view to select Select first_name, incentive amount from employee and incentives table for those employees who have incentives and incentive amount greater than 3000.

GO
CREATE VIEW VIEW3
AS 
	SELECT E.Firstname,I.incentiveAmount 
	FROM employee1 E 
	INNER JOIN incentives I
	on E.empID= I.emp_ref_ID 
	AND incentiveAmount>3000
GO

	SELECT* FROM VIEW3

--6.Create a View to Find the names (first_name, last_name), job, department number, and department name of the employees who work in London.

GO
CREATE VIEW VIEW4
AS
	
	SELECT E.FirstName ,E.LastName ,E.JobId ,D.DepartmentName , D.DepartmentId
	FROM Employees E
	JOIN Departments D
	ON E.DepartmentID = D.DepartmentID
	JOIN Locations L
	ON D.LocationID = L.LocationID
	WHERE L.city = 'LONDON'
GO


SELECT *FROM VIEW4

--7.Create a View to get the department name and number of employees in the department.

GO 
CREATE VIEW VIEW5
AS
	SELECT D.DepartmentName , COUNT(*) AS 'No. of Employees'
	FROM Departments D
	INNER JOIN Employees E
	ON E.DepartmentID =D.DepartmentID
	GROUP BY D.DepartmentID , D.DepartmentName

GO

SELECT * FROM VIEW5

--8.Find the employee ID, job title, number of days between ending date and starting date for all jobs in department 90 from job history.

GO
CREATE VIEW VIEW6
AS
	SELECT J.EmployeeID,J.JobId,D.DepartmentID, DATEDIFF( DAY, StartDate , EndDate ) AS Diff
	FROM job_History J
	JOIN Departments D
	ON D.DepartmentID = J.DepartmentID
	WHERE D.DepartmentID = 90
GO

SELECT * FROM VIEW6

--9.Write a View to display the department name, manager name, and city.

GO 
CREATE VIEW VIEW7
AS
	SELECT E.FirstName AS 'Manger Name' , E.ManagerID , D.DepartmentName , L.city
	FROM Employees E
	JOIN Departments D
	ON E.ManagerID =D.DepartmentID
	JOIN Locations L
	ON D.LocationID = L.LocationID
GO

SELECT * FROM VIEW7

--10.Create a View to display department name, name (first_name, last_name), hire date, salary of the manager for all managers whose experience is more than 15 years.

GO
CREATE VIEW VIEW8
AS
	(SELECT M.FirstName, M.LastName, M.HireDate, M.Salary
	FROM Employees E JOIN Employees M
	ON (E.EmployeeID=M.EmployeeID) 
	JOIN Jobhistory j ON M.EmployeeID=j.EmployeeID
	WHERE DATEDIFF(YEAR,j.StartDate,j.End_date)>15)
GO

SELECT * FROM VIEW8

--11.Create a batch Select Banking as ‘Bank Dept’, Insurance as ‘Insurance Dept’ and Services as ‘Services Dept’ from employee table.

GO
    SELECT D.DepartmentID , 'DepartmentName' = CASE D.DepartmentName WHEN 'Banking' THEN 'Bank Dept'
                                  WHEN 'Insurance'THEN 'Insurance Dept'
                                  WHEN 'Services' THEN 'Services Dept'
                                  ELSE D.DepartmentName
                                  END
                                  FROM Employees E
                                  JOIN Departments D
                                  ON D.DepartmentID = E.DepartmentID
                                
GO

--WHILE LOOP
USE SQL

GO
WHILE
	( SELECT AVG(Salary) FROM Employees) <1500
BEGIN
	UPDATE Employees 
	SET Salary = Salary * 20
	SELECT MAX(Salary) FROM Employees
	IF 
	(SELECT MAX(Salary) FROM Employees) > 5000
		BREAK
	ELSE
		CONTINUE
END


SELECT * FROM Employees

--WHILE LOOP
DECLARE @MIN INT
DECLARE @MAX INT
DECLARE @ABC INT

SELECT  @MIN= MIN(EmployeeID) ,
		@MAX= MAX(EmployeeID)
FROM Employees WHERE  DepartmentID = 100

SET @ABC = @MIN
WHILE @ABC <= @MAX
BEGIN 
	SELECT FirstName AS 'EmpName', EmployeeID
	FROM Employees WHERE EmployeeID = @ABC AND DepartmentID=100
SET @ABC= @ABC + 1
END


