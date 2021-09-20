--CREATE TABLE
CREATE TABLE Person
(
	PersonID INT PRIMARY KEY,
	Name VARCHAR(30),
	Gender VARCHAR(7),
	City VARCHAR(20),
	Salary MONEY
)

INSERT INTO  Person (
						PersonID,
						Name,
						Gender,
						City,
						Salary		
				    )
			VALUES (
						3,
						'Punam',
						'Female',
						'Gandhinagar',
						25000
					),
					(
						1,
						'Rishi',
						'Male',
						'Bhavnagar',
						45000
					),
					(
						4,
						'Samir',
						'Male',
						'Junagadh',
						40000
					),
					(
						2,
						'Pooja',
						'Female',
						'Morbi',
						50000
					)
SELECT * FROM Person

EXEC sp_helpindex Person


--CREATE CLUSTERED INDEX
CREATE CLUSTERED INDEX IX_tblPerson_Name
ON Person(Name)

--DROP INDEX
DROP INDEX PK__Person__AA2FFB85CC4306DC ON Person

--NON-CLUSTERED INDEX
CREATE NONCLUSTERED INDEX IX_tblPerson_GS
ON Person(Gender DESC , Salary ASC)

 sp_helpindex Employees


 --UNIQUE INDEX
CREATE UNIQUE NONCLUSTERED INDEX
UIX_Name ON Employees
(FirstName, LastName)

SELECT * FROM Employees

ALTER TABLE Employees
ADD CONSTRAINT UQ_Emp_PhoneNo
UNIQUE (PhoneNumber)







