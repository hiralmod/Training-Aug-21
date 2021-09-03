
SELECT FirstName 'Name',
Len('FirstName') 'Length'
FROM Employees
WHERE FirstName LIKE 'J%'
OR FirstName LIKE 'M%'
OR FirstName LIKE 'A%'
ORDER BY FirstName;


Select CONCAT(REPLICATE('$',10+Len(Salary)) ,cast(Salary as varchar)) SALARY from Employees



SELECT FirstName,LastName,HireDate 
FROM Employees 
WHERE datepart(mm,HireDate) like 07 or datepart(dd,HireDate) like 07;


select FirstName,LastName,Len(FirstName) length from Employees
where LastName like '_%c%'order by LastName


SELECT RIGHT(PhoneNumber, 4) FROM Employees;


UPDATE Employees 
SET PhoneNumber = REPLACE(PhoneNumber, '124', '999') 
WHERE PhoneNumber LIKE '%124%'


select Datediff (day, '2008/03/16',sysdatetime()) /365


select * from Employees where datename(weekday,HireDate) - 'Monday'


SELECT FirstName, HireDate 
    FROM Employees 
       WHERE HireDate  
         BETWEEN '1987-06-01' 
            AND '1987-07-30'



SELECT  FORMAT(GETDATE(),'hh:mm tt MMM dd,yy')


SELECT FirstName,LastName FROM Employees WHERE Month(HireDate)=6



SELECT FirstName,HireDate,DATEDIFF(YEAR , GETDATE(),HireDate)/365 as experience  FROM Employees


 SELECT FirstName, HireDate
 FROM Employees
 WHERE YEAR(HireDate)=1987;
