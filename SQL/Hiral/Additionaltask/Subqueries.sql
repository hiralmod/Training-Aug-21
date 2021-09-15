--1--
SELECT * FROM Employees WHERE salary>(SELECT salary FROM Employees WHERE Lastname='Bull')

--2--
SELECT FirstName,LastName  FROM Employees where DepartmentID
IN (SELECT DepartmentID FROM Departments WHERE DepartmentName='IT');
 
 --3--
SELECT FirstName, LastName FROM Employees 
WHERE ManagerID in (select EmployeeID 
FROM Employees WHERE DepartmentID 
IN (SELECT DepartmentID FROM Departments WHERE LocationID 
IN (select LocationID from Locations where CountryID='US')));

--4--
select FirstName,LastName from Employees
where EmployeeID in
(select ManagerID from Employees)

--5--
SELECT FirstName,LastName ,Salary from Employees 
where Salary> (select avg(Salary) from Employees) 

-6--
SELECT FirstName,LastName, salary 
FROM emp E
WHERE E.salary = (SELECT Min(salary)
FROM job J
WHERE E.Job_id = J.Job_id)

--7--
SELECT FirstName,LastName ,Salary from Employees 
where DepartmentID in
(select DepartmentID from Departments where DepartmentName like 'IT%')
and Salary > (select avg(Salary) from Employees)

--8--
SELECT * FROM Employees WHERE salary>(SELECT salary FROM Employees WHERE Lastname='Bell')

--9--
SELECT  * FROM Employees where Salary = (Select min(Salary) From Employees)

--10--
SELECT  * FROM Employees where Salary > (Select avg(Salary) From Employees)

--11--
SELECT  * FROM Employees where Salary > all(Select Salary from Employees where JobId = 'SH_CLERK')

--12--
SELECT B.FirstName,B.LastName 
FROM Employees B 
WHERE NOT EXISTS (SELECT 'X' FROM Employees E WHERE E.ManagerID = B.EmployeeID);

--13--
SELECT EmployeeID,FirstName,LastName,
(SELECT DepartmentName FROM Departments D
WHERE E.DepartmentID=D.DepartmentID ) Dept
from Employees E order by Dept

--14--
SELECT EmployeeID ,FirstName from employees A
where Salary >
(select avg(Salary) from Employees where DepartmentID = A.DepartmentID)

--15--
SELECT EmployeeID FROM Employees WHERE EmployeeID % 2=0

--16--
Select * from
(
Select FirstName ,Salary ,DENSE_RANK()
OVER (ORDER BY Salary DESC) r FROM  Employees
) temp
WHERE r=5

--17--
SELECT DISTINCT Salary 
FROM Employees e1 
WHERE 4 = (SELECT COUNT(DISTINCT Salary) 
FROM Employees  e2 
WHERE e2.Salary <= e1.Salary)

--18--
SELECT TOP 10*
FROM Employees
ORDER BY EmployeeID DESC

--19--
SELECT * FROM Departments
where DepartmentID
not in (select DepartmentID from Employees)
