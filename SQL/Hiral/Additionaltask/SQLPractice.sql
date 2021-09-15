--1.. Write a SQL statement to rename the table countries to country_new using sp(store procedure).
	SP_RENAME 'Country_New','Country'

--2.Write a SQL statement to add a column region_id to the table locations.

	ALTER TABLE Locations 
	ADD  Region_ID INT

--3. Write a SQL statement to add a columns ID of the table locations.
	
	ALTER TABLE Locations 
	ADD  ID INT


--4.Write a SQL statement to drop the column city from the table locations.

	ALTER TABLE Locations
	DROP COLUMN city
	
	ALTER TABLE Locations
	ADD city VARCHAR(20)

--5.Write a SQL statement to change the name of the column state_province to state, keeping the data type and size same.

	EXECUTE SP_RENAME 'Locations.StateProvince' , 'Locations.State','column'
	
--6. Write a query to display the names (first_name, last_name) using alias name “First Name", "Last Name"

	SELECT FirstName "First Name",  LastName "Last Name" 
	FROM Employees;

--7.Write a query to get unique department ID from employee table.

	SELECT DISTINCT DepartmentID
	FROM Employees;

--8.3)Write a query to get all employee details from the employee table order by first name, descending.

	SELECT * 
	FROM Employees 
	ORDER BY FirstName DESC;

--9.Write a query to get the names (first_name, last_name), salary, PF of all the employees (PF is calculated as 12% of salary).

	SELECT FirstName, LastName , salary, salary*.12 PF 
	FROM Employees;

--10.Write a query to get the employee ID, names (first_name, last_name), salary in ascending order of salary.

	SELECT EmployeeID, FirstName, LastName, Salary 
    FROM Employees 
    ORDER BY Salary

--11.Write a query to get the total salary ,min salary ,max salary ,average salary of employees.

	SELECT SUM(Salary) Totalsalary , MAX(Salary) Maximumsal ,MIN(Salary) Minimumsal,AVG(Salary) Averagesal
	FROM Employees

--12.Write a query to get the number of employees working with the company.

	SELECT COUNT(*)
	FROM Employees

--13.Write a query to get the number of jobs available in the employees table.

	SELECT COUNT(DISTINCT JobId) 
    FROM Employees;

--14.Write a query get all first name from employees table in uppr case.

	SELECT UPPER(FirstName) 
    FROM Employees;

--15. Write a query to display the names (first_name, last_name) and salary for all employees whose salary is not in the range $10,000 through $15,000.

	SELECT FirstName, LastName, Salary
	FROM Employees
	WHERE Salary NOT BETWEEN 10000 AND 15000;

--16. Write a query to display the names (first_name, last_name) and department ID of all employees in departments 30 or 100 in ascending alphabetical order by department ID.

	SELECT FirstName, LastName, DepartmentID
	FROM Employees
	WHERE DepartmentID IN (30, 100)
	ORDER BY  DepartmentID  ASC;

--17.Write a query to display the names (first_name, last_name) and salary for all employees whose salary is not in the range $10,000 through $15,000 and are in department 30 or 100.

	SELECT FirstName, LastName, DepartmentID
	FROM Employees
	WHERE Salary NOT BETWEEN 10000 AND 15000
	AND DepartmentID IN (30, 100)

--18. Write a query to display the names (first_name, last_name) and hire date for all employees who were hired in 1987.

	SELECT FirstName, LastName, HireDate 
	FROM Employees 
	WHERE YEAR(HireDate)  LIKE '1987%';

--19. Write a query to display the first_name of all employees who have both "b" and "c" in their first name.

	SELECT FirstName
	FROM Employees
	WHERE FirstName LIKE '%b%'
	AND FirstName LIKE '%c%';

--20.Write a query to display the last name, job, and salary for all employees whose job is that of a Programmer or a Shipping Clerk, and whose salary is not equal to $4,500, $10,000, or $15,000.

	SELECT LastName,JobId, Salary
	FROM Employees
	WHERE JobId IN ('IT_PROG', 'SH_CLERK')
	AND Salary NOT IN (4500,10000, 15000);

--21. Write a query to display the last names of employees whose names have exactly 6 characters.

	SELECT LastName FROM Employees WHERE LastName LIKE '______';

--22. Write a query to display the last names of employees having 'e' as the third character.

	SELECT LastName FROM Employees WHERE LastName LIKE '__e%';

--23. Write a query to display the jobs/designations available in the employees table.

	SELECT JobId, CONCAT(EmployeeID, ' ')  'Employees ID' 
	FROM Employees ;

--24.Write a query to display the names (first_name, last_name), salary and PF (15% of salary) of all employees.

	SELECT FirstName, LastName , salary, salary*.15 PF 
	FROM Employees;

--25.Write a query to select all record from employees where last name in 'BLAKE', 'SCOTT', 'KING' and 'FORD'.

	SELECT * FROM Employees 
	WHERE LastName IN ('BLAKE','SCOTT','KING','FORD')

--26. Write a query to list the number of jobs available in the employees table.

	SELECT COUNT(DISTINCT JobId)
	FROM Employees

--27. Write a query to get the average salary and number of employees working the department 90.

	SELECT AVG(Salary),COUNT(*)
	FROM Employees 
	WHERE DepartmentID =90

--28.Write a query to get the number of employees with the same job.

	SELECT JobId, COUNT(*)
	FROM Employees 
	GROUP BY JobId;

--29. Write a query to get the difference between the highest and lowest salaries.

	SELECT MAX(salary) - MIN(salary) DIFFERENCE
	FROM Employees;

--30. Write a query to find the manager ID and the salary of the lowest-paid employee for that manager.

	SELECT ManagerID, MIN(salary)
	FROM Employees
	WHERE ManagerID IS NOT NULL
	GROUP BY ManagerID
	ORDER BY MIN(salary) DESC;

--31. Write a query to get the department ID and the total salary payable in each department.

	SELECT DepartmentID , SUM(Salary)
	FROM Employees 
	GROUP BY DepartmentID

--32.Write a query to get the average salary for each job ID excluding programmer.

	SELECT JobId, AVG(salary) 
	FROM Employees 
	WHERE JobId <> 'IT_PROG' 
	GROUP BY JobId;

--33. Write a query to get the total salary, maximum, minimum, average salary of employees (job ID wise), for department ID 90 only.

	SELECT JobId ,SUM(Salary) Totalsalary , MAX(Salary) Maximumsal ,MIN(Salary) Minimumsal,AVG(Salary) Averagesal
	FROM Employees
	WHERE DepartmentID =90
	GROUP BY JobId 

--34. Write a query to get the job ID and maximum salary of the employees where maximum salary is greater than or equal to $4000.

	SELECT JobId, MAX(salary) 
	FROM Employees 
	GROUP BY JobId 
	HAVING MAX(salary) >=4000;

--35.Write a query to get the average salary for all departments employing more than 10 employees.

	SELECT DepartmentID, AVG(salary), COUNT(*) 
	FROM Employees 
	GROUP BY DepartmentID
	HAVING COUNT(*) > 10;

--36.Write a query to find the names (first_name, last_name) and salaries of the employees who have higher salary than the employee whose last_name='Bull'. 

	SELECT FirstName, LastName, SALARY 
	FROM Employees 
	WHERE SALARY > 
	(SELECT salary FROM Employees WHERE LastName = 'Bull');

--37.Find the names (first_name, last_name) of all employees who works in the IT department. 

	SELECT FirstName ,LastName
	FROM Employees 
	WHERE DepartmentID IN 
	(SELECT DepartmentID FROM Departments WHERE DepartmentName LIKE 'IT%')

--38.Find the names (first_name, last_name), job, department number, and department name of the employees who work in London. 

	SELECT e.FirstName, e.LastName, e.JobId, e.DepartmentID, d.DepartmentName 
	FROM Employees e 
	JOIN Departments d 
	ON (e.DepartmentID = d.DepartmentID) 
	JOIN Locations l ON 
	(d.LocationID = l.LocationID) 
	WHERE l.City = 'London';

--39.Write a query to find the employee id, name (last_name) along with their manager_id, manager name (last_name). 

	SELECT e.EmployeeID 'Emp_Id', e.LastName, 
	m.EmployeeID 'Mgr_Id', m.LastName 'Manager' 
	FROM Employees e 
	join Employees m 
	ON (e.ManagerID = m.EmployeeID);

--40. Find the names (first_name, last_name) and hire date of the employees who were hired after 'Jones'. 

	SELECT e.FirstName, e.LastName, e.HireDate 
	FROM Employees e 
	JOIN Employees M 
	ON (M.LastName = 'Jones') 
	WHERE M.HireDate < e.HireDate;


--41.Write a query to get the department name and number of employees in the department. 

	SELECT D.DepartmentName , COUNT(*) AS 'No of Employees'
	FROM Departments D
	INNER JOIN Employees E
	ON E.DepartmentID = D.DepartmentID
	GROUP BY D.DepartmentID , DepartmentName
	ORDER BY DepartmentName

--42.Find the employee ID, job title, number of days between ending date and starting date for all jobs in department 90 from job history. 

	SELECT  J.EmployeeID ,DATEDIFF(DAY, StartDate , EndDate) AS Diff
	FROM job_History J 
	INNER JOIN Departments D
	ON J.DepartmentID = D.DepartmentID
	WHERE D.DepartmentID = 90
	

--43.Write a query to display the department ID, department name and manager first name. 

	SELECT D.DepartmentID , D.DepartmentName, D.ManagerID , E.FirstName
	FROM Departments D
	INNER JOIN Employees E
	ON D.ManagerID = E.ManagerID

--44.Write a query to display the department name, manager name, and city. 

	SELECT D.DepartmentName , E.FirstName , L.City
	FROM Departments D
	JOIN Employees E
	ON E.DepartmentID = D.ManagerID
	JOIN Locations L
	ON  D.LocationID = L.LocationID

--45.Write a query to display the job title and average salary of employees. 
	
	SELECT J.Jobtitle ,E.Salary
	FROM job J
	JOIN emp E
	ON J.Job_id = E.Job_id

--46.Display job title, employee name, and the difference between salary of the employee and minimum salary for the job. 

	SELECT J.Jobtitle , E.FirstName , E.salary -MIN(E.Salary) AS Diff
	FROM job J
	INNER JOIN emp E
	ON E.Job_id = J.Job_id
	GROUP BY Jobtitle

--47.Write a query to display the job history that were done by any employee who is currently drawing more than 10000 of salary. 

	SELECT * FROM job_History JH
	JOIN Employees E
	ON JH.EmployeeID = E.EmployeeID
	WHERE Salary > 10000

--49.Write a query to get the first day of the current year. 

	SELECT DATEADD (YY, DATEDIFF(YY, 0 ,GETDATE()) ,0)

--50.Write a query to calculate the age in year. 

	SELECT DATEDIFF(DAY, '2000-03-16' ,GETDATE())/365

--51.Write a query to get the current date in the following format. 
Sample date : 2014-09-04
Output : September 4, 2014

	SELECT FORMAT( GETDATE() , 'MMMM dd , yyyy')

--52.Write a query to get the current date in the following format. 
Thursday September 2014

	SELECT FORMAT( GETDATE() , 'dddd MMMM yyyy')

--53.Write a query to extract the year from the current date. 

	SELECT DATEPART( YEAR , GETDATE())
	
--54.Write a query to display the current date in the following format. 
Sample output : Thursday 4th September 2014

		SELECT FORMAT( GETDATE() , 'dddd dd MMMM yyyy')

--55.Write a query to display the current date in the following format. 
Sample output : 05/09/2014

	SELECT FORMAT(GETDATE() , 'dd/MM/yyyy') AS Date

--56.Write a query to get the years in which more than 10 employees joined. 

	SELECT DATEPART(YEAR ,HireDate) 
	FROM Employees 
	GROUP BY DATEPART(YEAR ,HireDate)
	HAVING COUNT (EmployeeID) > 10

--57.Write a query to get the department ID, year, and number of employees joined. 

	SELECT DepartmentID, DATEPART (YEAR , HireDate) , COUNT(EmployeeID)
	FROM Employees
	GROUP BY DepartmentID ,DATEPART (YEAR , HireDate)



 