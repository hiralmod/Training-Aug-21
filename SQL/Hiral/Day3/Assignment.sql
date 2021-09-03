--1.Write a query that displays the FirstName and the length of the FirstName for all employees whose name starts with the letters ‘A’, ‘J’ or ‘M’. Give each column an appropriate label. Sort the results by the employees’ FirstName
SELECT FirstName 'Name',
Len('FirstName') 'Length'
FROM Employees
WHERE FirstName LIKE 'J%'
OR FirstName LIKE 'M%'
OR FirstName LIKE 'A%'
ORDER BY FirstName;

--2.Write a query to display the FirstName and Salary for all employees. Format the salary to be 10 characters long, left-padded with the $ symbol. Label the column SALARY.
Select CONCAT(REPLICATE('$',10+Len(Salary)) ,cast(Salary as varchar)) SALARY from Employees


--3.Write a query to display the employees with their code, first name, last name and hire date who hired either on seventh day of any month or seventh month in any year.
SELECT FirstName,LastName,HireDate 
FROM Employees 
WHERE datepart(mm,HireDate) like 07 or datepart(dd,HireDate) like 07;

--4.Write a query to display the length of first name for employees where last name contains character ‘c’ after 2nd position.
select FirstName,LastName,Len(FirstName) length from Employees
where LastName like '_%c%'order by LastName

--5.Write a query to extract the last 4 character of PhoneNumber.
SELECT RIGHT(PhoneNumber, 4) FROM Employees;

--6.Write a query to update the portion of the PhoneNumber in the employees table, within the phone number the substring ‘124’ will be replaced by ‘999’.
UPDATE Employees 
SET PhoneNumber = REPLACE(PhoneNumber, '124', '999') 
WHERE PhoneNumber LIKE '%124%'

--7.Write a query to calculate the age in year.
select Datediff (day, '2008/03/16',sysdatetime()) /365

--8.Write a query to get the distinct Mondays from HireDate in employees tables
select * from Employees where datename(weekday,HireDate) - 'Monday'

--9.Write a query to get the FirstName and HireDate from Employees table where HireDate between ‘1987-06-01’ and ‘1987-07-30’
SELECT FirstName, HireDate 
    FROM Employees 
       WHERE HireDate  
         BETWEEN '1987-06-01' 
            AND '1987-07-30'

--10.Write a query to display the current date in the following format.
SELECT  FORMAT(GETDATE(),'hh:mm tt MMM dd,yy')

--11.Write a query to get the FirstName, LastName who joined in the month of June.
SELECT FirstName,LastName FROM Employees WHERE Month(HireDate)=6

--12.Write a query to get first name, hire date and experience of the employees.
SELECT FirstName,HireDate,DATEDIFF(YEAR , GETDATE(),HireDate)/365 as experience  FROM Employees

--13.Write a query to get first name of employees who joined in 1987.
 SELECT FirstName, HireDate
 FROM Employees
 WHERE YEAR(HireDate)=1987;
