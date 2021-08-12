SELECT * FROM Employees
SELECT FirstName,LastName FROM Employees
SELECT FirstName as employeeName FROM Employees
SELECT * FROM Employees WHERE FirstName='Steven'
SELECT * FROM Employees WHERE FirstName IN  ('Neena', 'Lex')
SELECT * FROM Employees WHERE FirstName NOT IN  ('Neena', 'Lex')
SELECT salary FROM Employees WHERE salary BETWEEN 5000 AND 8000
SELECT  * FROM Employees WHERE FirstName LIKE 'N%'
SELECT FirstName,LastName,salary, salary*0.12 PF FROM Employees
SELECT DISTINCT DepartmentID FROM Employees
SELECT FirstName FROM Employees ORDER BY FirstName DESC
SELECT EmployeeID,FirstName,LastName,salary FROM Employees ORDER BY salary ASC
SELECT TOP 2 salary FROM Employees

