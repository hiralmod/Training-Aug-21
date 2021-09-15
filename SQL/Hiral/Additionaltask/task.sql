create table branch 
(
Bname Varchar(18) primary key,
City varchar(18)
)

create table customer
(
Cname varchar(19) primary key,
City varchar(18)
)


create table Deposite 
(
Actno varchar(5) primary key,
Cname varchar(19) constraint Cfkey references customer(Cname),
Bname varchar(18) constraint Bfkey references branch(Bname),
Amount int,
Adate date
)

create table borrow
(
Loanid varchar(5) primary key,
Cname varchar(19)constraint C1fkey references customer(Cname),
Bname varchar(18) constraint B1fkey references branch(Bname),
Amount int
)

insert into branch values ('vrce','nagpur')
insert into branch values ('ajni','nagpur')
insert into branch values ('karolbagh','delhi')
insert into branch values ('chandni','delhi')
insert into branch values ('dharampeth','nagpur')
insert into branch values ('M.G. road','banglore')
insert into branch values ('andheri','mumbai')
insert into branch values ('virar','mumbai')
insert into branch values ('nehru place','delhi')
insert into branch values ('powai','mumbai')

insert into customer values ('anil','kolkata')
insert into customer values ('sunil','delhi')
insert into customer values ('mehul','baroda')
insert into customer values ('mandar','patna')
insert into customer values ('madhuri','nagpur')
insert into customer values ('pramod','nagpur')
insert into customer values ('sandip','surat')
insert into customer values ('shivani','mumbai')
insert into customer values ('kranti','mumbai')
insert into customer values ('naren','mumbai')

insert into Deposite values('100','anil','vrce','1000','01-03-1995')
insert into Deposite values('101','sunil','ajni','5000','04-01-1996')
insert into Deposite values('102','mehul','karolbagh','3500','1995-11-17')
insert into Deposite values('104','madhuri','chandni','1200','1995-12-17')
insert into Deposite values('105','pramod','M.G.road','3000','1996-03-27')
insert into Deposite values('106','sandip','andheri','2000','31-03-1996')
insert into Deposite values('107','shivani','virar','1000','05-09-1995')
insert into Deposite values('108','kranti','nehru place','5000','02-07-1995')
insert into Deposite values('109','naren','powai','7000','10-08-1995')

select * from borrow

insert into borrow values ('201','anil','vrce','1000')
insert into borrow values ('206','mehul','ajni','5000')
insert into borrow values ('311','sunil','dharampeth','3000')
insert into borrow values ('321','madhuri','andheri','2000')
insert into borrow values ('375','pamod','virar','8000')
insert into borrow values ('481','kranti','nehru place','3000')


--1--List Names of Customers who are Depositors and have Same Branch City as that of SUNIL.
 select d.Cname  From Deposite d join 
 branch b  ON d.Bname=b.Bname WHERE b.City IN
 (SELECT b.City from branch JOIN 
 Deposite d ON d.Bname = b.Bname WHERE d.Cname='sunil')


 --2--: List All the Depositors Having Depositors Having Deposit in All the Branches where SUNIL is Having Account.
select D.Cname ,D.Bname FROM Deposite D JOIN
branch B ON D.Bname=B.Bname WHERE B.Bname IN( 
(SELECT B.Bname FROM Deposite D JOIN
branch B ON D.Bname =B.Bname WHERE D.Cname ='sunil'),
(SELECT Br.Bname FROM borrow Br JOIN
branch B ON Br.Bname = B.Bname WHERE Br.Cname='sunil'))


--3--: List the Names of Customers Living in the City where the Maximum Number of Depositors are Located.
select C.Cname from customer C where C.City in 
(select TOP(1) C.City from Deposite D join
customer C on D.Cname=C.Cname Group  by C.City Order by count(C.City)DESC)


--4--List Names of Borrowers Having Deposit Amount Greater than 1000 and Loan Amount Greater than 2000
SELECT B.Cname, D.Cname FROM Deposite D join borrow B on D.Cname = B.Cname AND D.Amount > 1000 AND B.Amount > 2000


--5--List All the Customers Living in NAGPUR and Having the Branch City as MUMBAI or DELHI.
SELECT C.Cname ,D.Cname FROM Deposite D join 
customer C on C.Cname = D .Cname join 
branch B on D.Bname = B.Bname 
WHERE C.City= 'NAGPUR' AND B.City IN ('BOMBAY','DELHI');




