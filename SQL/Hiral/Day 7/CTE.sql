--1. Write a query to rank employees based on their salary for a month.

;WITH RANKCTE(Drank)
AS 
(
Select  dense_rank () over(order by salary desc) AS Drank
from Employees 
)

SELECT * FROM RANKCTE ORDER BY Drank


--2.Select 4th Highest salary from employee table using ranking function.

WITH RANKCTE(Drank,salary)
AS 
(
select * from(
select  dense_rank() 
over(order by salary  desc) Drank,salary from Employees) temp
where Drank =4
)

SELECT * FROM RANKCTE

--3.Get department, total salary with respect to a department from employee table.

WITH ResultCTE(DepartmentID,totalsalary)
AS
(
SELECT DepartmentID ,SUM(Salary) AS 'totalsalary'
FROM Employees
GROUP BY DepartmentID
)
SELECT * FROM ResultCTE


--4.Get department, total salary with respect to a department from employee table order by total salary descending.

WITH RANKCTE(DepartmentID, sal)
AS
(
SELECT DepartmentID ,sum(Salary) 'sal'
FROM Employees
GROUP BY DepartmentID 
)

SELECT DepartmentID, sal FROM RANKCTE ORDER BY sal DESC


--5.Get department wise maximum salary from employee table order by salary ascending.

WITH RANKCTE(DepartmentID, sal)
AS
(
SELECT DepartmentID ,MAX(Salary) 'sal'
FROM Employees GROUP BY DepartmentID 
)

SELECT DepartmentID, sal FROM RANKCTE ORDER BY sal ASC

--6.Get department wise minimum salary from employee table order by salary ascending.

WITH RANKCTE(DepartmentID, sal)
AS
(
SELECT DepartmentID ,MIN(Salary) 'sal' 
FROM Employees GROUP BY DepartmentID
)

SELECT DepartmentID, sal FROM RANKCTE ORDER BY sal ASC

--7.Select department, total salary with respect to a department from employee table where total salary greater than 50000 order by TotalSalary descending.

WITH RANKCTE(DepartmentID, sal)
AS
(
SELECT DepartmentID ,sum(Salary) 'sal'
FROM Employees
GROUP BY DepartmentID 
having sum(salary) > 50000
)

SELECT DepartmentID, sal FROM RANKCTE ORDER BY sal DESC


--8.Get difference between JOINING_DATE and INCENTIVE_DATE from employee and incentives table.

WITH RESULTCTE(Firstname,incentivedate,JoinDate ,Diff)
AS
(
SELECT Firstname,JoinDate , incentivedate , DATEDIFF( DAY, JoinDate , incentivedate ) AS Diff
FROM employee1 A INNER JOIN incentives B
ON A.empID = B.emp_ref_ID
)

SELECT Firstname,incentivedate,JoinDate , incentivedate ,Diff FROM RESULTCTE

--9.Select first_name, incentive amount from employee and incentives table for those employees who have incentives and incentive amount greater than 3000.

WITH RESULTCTE(Firstname,incentivedate)
AS
(
SELECT Firstname,incentiveAmount 
FROM employee1 A INNER  JOIN incentives B
ON A.empID = B.emp_ref_ID AND incentiveAmount>3000
)

SELECT Firstname,incentivedate FROM RESULTCTE

--10.Select first_name, incentive amount from employee and incentives table for all employees even if they didn’t get incentives.

WITH RESULTCTE(Firstname,incentivedate)
AS
(
SELECT Firstname,incentiveAmount 
FROM employee1 A LEFT JOIN incentives B
ON A.empID = B.emp_ref_ID 
)

SELECT Firstname,incentivedate FROM RESULTCTE

--11.Select EmployeeName, ManagerName from the employee table.

WITH RESULTCTE(Firstname,Managername)
AS
(
SELECT e.Firstname,m.Firstname AS Managername
FROM employee1 e
JOIN employee1 m on e.managerID=m.empID
)

SELECT Firstname,Managername FROM RESULTCTE

--12.Select first_name, incentive amount from employee and incentives table for all employees even if they didn’t get incentives and set incentive amount as 0 for those employees who didn’t get incentives.

WITH RESULTCTE(Firstname,incentiveAmount)
AS 
(
SELECT Firstname,ISNULL(incentiveAmount,0) 
FROM employee1 A LEFT JOIN incentives B
ON A.empID = B.emp_ref_ID 
)

SELECT Firstname , incentiveAmount FROM RESULTCTE