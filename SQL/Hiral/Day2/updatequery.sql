UPDATE Employees SET Email='Not available'
UPDATE Employees SET Email='Not available',CommissionPct = '0.10'
UPDATE Employees SET Email='Not available',CommissionPct = '0.10' WHERE DepartmentID='110'
UPDATE Employees SET Email='Not available'	WHERE DepartmentID=80 AND CommissionPct>0.20
UPDATE Employees SET Email='Not available' WHERE  DepartmentID=(select DepartmentID from Department WHERE DepartmentName='Accounting')
UPDATE Employees SET salary=8000 WHERE EmployeeID=105 and salary<5000
UPDATE Employees SET JobID ='SH_CLERK' WHERE EmployeeID=118 AND DepartmentID=30 AND NOT JobID LIKE 'SH%'
UPDATE Employees  SET salary= CASE DepartmentID WHEN 40 THEN salary+(salary*.25) 
												  WHEN 90 THEN salary+(salary*.15)
												  WHEN 110 THEN salary+(salary*.10)
												  ELSE salary
												  END
                                                 WHERE DepartmentID IN (40,90,110)

select * from Employees