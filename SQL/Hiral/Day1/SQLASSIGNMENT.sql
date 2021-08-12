Create table Employee
(
Empid INT PRIMARY KEY IDENTITY (1,1),
Empname VARCHAR  (15)NOT NULL,
Lastname VARCHAR (15)NOT NULL,
Phonenumber NUMERIC(10)NOT NULL,
Email VARCHAR (15),
Salary money NOT NULL,
Commission int null
)

Create table Inventory
(
productid INT PRIMARY KEY IDENTITY(1,1),
productname VARCHAR (15),
Quantity int
)

CREATE TABLE Sales
(
Salesid int PRIMARY KEY IDENTITY (1,1),
sno int,
Empid int constraint Efkey references Employee(Empid) on update cascade,
productid int constraint Pfkey references Inventory(productid) on update cascade
)


insert into Employee values('abc','bcd','2345678910','gjghh','10000')
insert into Employee values('dfg','jgj','2323354657','vfvdv','8000')

insert into inventory values('Bolero',10)
insert into inventory values('maruti',15)
insert into inventory values('swift',20)

insert into Sales values(1,1,2)
insert into Sales values(2,2,1)

select *from Employee
select * from Inventory
select * from Sales
