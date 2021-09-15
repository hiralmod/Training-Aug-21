--1.Get difference between JOINING_DATE and INCENTIVE_DATE from employee and incentives table.

SELECT DATEDIFF( DAY, StartDate , EndDate ) AS Diff
FROM 
	(
		SELECT E.empID, E.JoinDate AS StartDate , I.emp_ref_ID,I.incentivedate AS EndDate
		FROM employee1 E JOIN
		incentives I 
		ON E.empID = I.emp_ref_ID
	)D

--2.Select first_name, incentive amount from employee and incentives table for those employees who have incentives and incentive amount greater than 3000.

SELECT E.Firstname,I.incentiveAmount
FROM employee1 E,
incentives I WHERE 
E.empID =I.emp_ref_ID
AND incentiveAmount IN 
	(
		SELECT incentiveAmount FROM incentives 
		WHERE incentiveAmount > 3000
	)	
 

 --3.Select first_name, incentive amount from employee and incentives table for all employees even if they didn’t get incentives.
SELECT E.Firstname , E.empID , I.emp_ref_ID , I.incentiveAmount
FROM employee1 E 
LEFT JOIN

	( 
		SELECT I.incentiveAmount ,I.emp_ref_ID 
		FROM incentives I 
	)AS I ON (E.empID = I.emp_ref_ID)


--4.Select EmployeeName, ManagerName from the employee table.

SELECT E.empID, E.Firstname AS EmpName , M.Firstname AS Managername
FROM employee1 E , employee1 M 
WHERE M.empID = E.managerID


--5. Select first_name, incentive amount from employee and incentives table for all employees even if they didn’t get incentives and set incentive amount as 0 for those employees who didn’t get incentives.

SELECT E.Firstname , E.empID , I.emp_ref_ID , ISNULL(I.incentiveAmount,0)
FROM employee1 E 
LEFT JOIN
	( 
		SELECT I.incentiveAmount ,I.emp_ref_ID 
		FROM incentives I 
	)  AS I ON (E.empID = I.emp_ref_ID)