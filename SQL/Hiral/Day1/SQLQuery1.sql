CREATE TABLE countries ( 
COUNTRY_ID int primary key identity(1,1),
COUNTRY_NAME varchar(40) CHECK(COUNTRY_NAME IN('Italy','India','China')) ,
REGION_ID int,
);
select * from countries
insert into countries values ('India', '1') , ('China' , '2')
