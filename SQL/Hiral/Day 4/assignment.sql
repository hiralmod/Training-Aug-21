--1.Write a query to rank employees based on their salary for a month.
SELECT  DENSE_RANK() OVER(ORDER BY salary DESC) Drank FROM Employees ORDER BY Drank


--2.Select 4th Highest salary from employee table using ranking function.
SELECT * FROM(
SELECT DENSE_RANK() 
OVER(ORDER BY salary  DESC) drank,salary FROM Employees) temp
WHERE drank =4


--3.Get department, total salary with respect to a department from employee table.
SELECT DepartmentID ,SUM(Salary)
FROM Employees
GROUP BY DepartmentID


--4.Get department, total salary with respect to a department from employee table order by total salary descending.
SELECT DepartmentID ,SUM(Salary) 'sal'
FROM Employees
GROUP BY DepartmentID ORDER BY sal DESC


--5.Get department wise maximum salary from employee table order by salary ascending.
SELECT DepartmentID ,MAX(Salary) 'sal' FROM Employees GROUP BY DepartmentID ORDER BY Sal ASC


--6.Get department wise minimum salary from employee table order by salary ascending.
SELECT DepartmentID ,MIN(Salary) 'sal' FROM Employees GROUP BY DepartmentID ORDER BY Sal ASC


--7.Select department, total salary with respect to a department from employee table where total salary greater than 50000 order by TotalSalary descending.
SELECT DepartmentID ,sum(Salary) 'sal'
FROM Employees
GROUP BY DepartmentID 
HAVING SUM(salary) > 50000 ORDER BY sal DESC
