Create table employee1 
(
empID int,
Firstname varchar(20)not null,
Lastname varchar (20)not null,
salary money not null,
JoinDate Datetime not null,
Department varchar(20),
managerID int
);

Create table incentives
(
emp_ref_ID int,
incentivedate date,
incentiveAmount numeric
);

SELECT * FROM employee1

SELECT * FROM incentives

INSERT INTO employee1 VALUES ('1','John','Abraham','1000000', '01-01-2013','Banking',null)
INSERT INTO employee1 VALUES ('2','Michel','clarke','800000','01-01-2013','Insurance','1')
INSERT INTO employee1 VALUES ('3','Roy','Thomas','700000','01-02-2013','Banking','1')
INSERT INTO employee1 VALUES ('4','Tom','jose','600000','01-02-2013','Insurance','2')
INSERT INTO employee1 VALUES ('5','Jerry','Pinto','650000','01-02-2013','Insurance','3')
INSERT INTO employee1 VALUES ('6','Philip','Mathew','750000','01-01-2013','Services','3')
INSERT INTO employee1 VALUES ('7','TestName1','123','650000','01-01-2013','Services','2')
INSERT INTO employee1 VALUES ('8','TestName2','Lname%','600000','01-02-2013','Insurance','2')

INSERT INTO incentives VALUES ('1','01-02-2013','5000')
INSERT INTO incentives VALUES ('2','01-02-2013','3000')
INSERT INTO incentives VALUES ('3','01-02-2013','4000')


--1.Get difference between JOINING_DATE and INCENTIVE_DATE from employee and incentives table.
select A.Firstname,B.incentivedate, A.JoinDate AS StartDate , B.incentivedate AS EndDate, DATEDIFF( DAY, A.JoinDate , B.incentivedate ) AS Diff
from employee1 A inner join incentives B
on A.empID = B.emp_ref_ID;


--2.Select first_name, incentive amount from employee and incentives table for those employees who have incentives and incentive amount greater than 3000.
select A.Firstname,B.incentiveAmount 
from employee1 A inner join incentives B
on A.empID = B.emp_ref_ID AND incentiveAmount>3000

--3.Select first_name, incentive amount from employee and incentives table for all employees even if they didn’t get incentives.
select A.Firstname,B.incentiveAmount 
from employee1 A left join incentives B
on A.empID = B.emp_ref_ID 

--4.Select EmployeeName, ManagerName from the employee table.
select e.Firstname,m.Firstname AS managername
from employee1 e
join employee1 m on e.managerID=m.empID

--5.Select first_name, incentive amount from employee and incentives table for all employees even if they didn’t get incentives and set incentive amount as 0 for those employees who didn’t get incentives.
select A.Firstname,isnull(B.incentiveAmount,0) 
from employee1 A left join incentives B
on A.empID = B.emp_ref_ID 


