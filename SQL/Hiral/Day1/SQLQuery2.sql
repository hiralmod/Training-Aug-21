CREATE TABLE Jobhistory
(
Employeeid int primary key identity (1,1),
Startdate date not null,
End_date date not null,
Job_id int not null,
Department_id int
)
 select * from Jobhistory
  insert into Jobhistory values('2006/05/01' , CONVERT( date, '13/08/2017', 105),1,5)
