Create table emp
( 
Employeeid int primary key identity(1,1),
Firstname varchar(20) not null,
Lastname varchar(25),
Email varchar(30),
Phonenumber numeric(10),
Hire_date date,
Job_id int constraint Jfkey references job(Job_id) on update cascade,
Salary money,
Commission money,
Manager_id int,
Department_id int constraint dfkey references department (Department_id) on update cascade
)
 select * from emp
  insert into emp values ('Hiral','Mod','hiralmod@gmail.com','1253575567','12/03/2021',2,8000,null, 1,1)
