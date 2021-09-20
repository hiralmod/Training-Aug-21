--CREATE TRIGGER
CREATE TRIGGER TRGSAMPLE 
ON Employees
FOR UPDATE
AS
BEGIN
	SELECT *FROM inserted
	SELECT * FROM deleted
END

UPDATE Employees SET FirstName = 'Tom' WHERE EmployeeID = 102

--INSERT ROW
CREATE TRIGGER TRGDEMO 
ON SUPPLY4
FOR INSERT
AS BEGIN
	INSERT INTO SUPPLY4
	(
		supplyID,
		supplier
	)
	SELECT 
		supplyID,
		supplier

	FROM inserted 

END

INSERT INTO SUPPLY4 
(
		supplyID,
		supplier
	)
vALUES (
		471,'Korea'
		)

	SELECT * FROM SUPPLY4

--DELETE ROW
CREATE TRIGGER TRGDEMO2
ON SUPPLY4
FOR DELETE
AS BEGIN
	INSERT INTO SUPPLY4
	(
		supplyID,
		supplier
	)
	SELECT 
		supplyID,
		supplier

	FROM inserted 

END

DELETE FROM SUPPLY4 WHERE supplyID = 471

	SELECT * FROM SUPPLY4


--ALTER TRIGGER
ALTER TRIGGER TRGSAMPLE 
ON Employees
FOR INSERT
AS
BEGIN
	DECLARE @ID INT,@Name VARCHAR(30)
	SELECT @ID =EmployeeID,
	@Name = FirstName
	FROM inserted

 INSERT INTO Info VALUES (@ID,@Name)
 END
 select * from Info

--AFTER DELETE
CREATE TRIGGER TRGDEL
ON Employees
AFTER DELETE
AS
BEGIN
	PRINT 'Record is Deleted successfully'
END

DROP TRIGGER TRGDEL
GO

--Instead of delete
CREATE TRIGGER TRGDELETE
ON Employees
INSTEAD OF DELETE 
AS
BEGIN
	PRINT 'Sorry you cannot Delete records from this table.'
END

DROP TRIGGER TRGDELETE

DELETE FROM Employees 
WHERE EmployeeID = 105
GO


--ASSIGNMENT

CREATE TABLE Student
(
StudentID INT PRIMARY KEY, 
StudentName VARCHAR(30), 
TotalFees MONEY,
RemainingAmt MONEY
)

CREATE TABLE Course
(
CourseID INT PRIMARY KEY,
CourseName VARCHAR(30),
TotalFees MONEY
)

CREATE TABLE CourseEnrolled
(
StudentID INT CONSTRAINT Sfkey REFERENCES Student(StudentID),
CourseID INT CONSTRAINT Rfkey REFERENCES Course(CourseID),
)

CREATE TABLE FeePayment
(
AmountPaid MONEY,
DateofPayment DATE,
StudentID INT CONSTRAINT Tfkey REFERENCES Student(StudentID)
)

INSERT INTO Student 
			(
				StudentID ,
				StudentName , 
				TotalFees,
				RemainingAmt
			)
		VALUES
			(
				101, 'Riya', 30000, 5000
			),
			(
				102, 'Sneha', 35000, 3000
			),
			(
				103, 'Naina', 25000, 2500
			),
			(
				104, 'Siya', 40000, 6000
			)

INSERT INTO Course 
			(
				CourseID ,
				CourseName,
				TotalFees
			)
		VALUES
			(
				275, 'Fashoin design', 25000
			),
			(
				387, 'Graphic Design', 40000
			),
			(
				963, 'Interior Design', 35000
			),
			(
				104, 'Liberal Arts', 37000
			)
 

SELECT * FROM Student
SELECT * FROM Course
SELECT * FROM CourseEnrolled
SELECT * FROM FeePayment

--1.Create an insert trigger on CourseEnrolled Table, record should be updated in TotalFees Field on the Student table for the respective student.
CREATE TRIGGER TRGSTUDENT
ON CourseEnrolled
FOR INSERT 
AS
BEGIN

DECLARE @CEid INT , @Sid INT, @TotalSid MONEY, @TotalCEid MONEY, @RemainSid MONEY
		
		SELECT @Sid= StudentID 
		FROM inserted

		SELECT @CEid= CourseID 
		FROM inserted
	
		SELECT @TotalSid = TotalFees
		FROM Student
		WHERE StudentID = @Sid

		SELECT @TotalCEid = TotalFees
		FROM Course
		WHERE CourseID = @CEid

		SELECT @RemainSid = RemainingAmt
		FROM Student
		WHERE StudentID = @Sid

	SET @TotalSid = @TotalSid + @TotalCEid
	SET @RemainSid = @RemainSid + @TotalCEid

		UPDATE Student
		SET TotalFees = @TotalSid
			,	RemainingAmt = @RemainSid
		WHERE StudentID = @Sid
		PRINT 'Record Updated Successfully.'
END
GO

DROP TRIGGER TRGSTUDENT

INSERT INTO CourseEnrolled VALUES(101,963)
Go 

SELECT *FROM Student


-- 2. Create an insert trigger on FeePayment, record should be updated in RemainingAmt Field of the Student Table for the respective student.

CREATE TRIGGER TRGFeePayment
ON FeePayment
FOR INSERT 
AS
BEGIN
	DECLARE @Sid INT, @AmountPaid MONEY, @RemainSid MONEY
		
	SELECT @Sid= StudentID 
		,	@AmountPaid = AmountPaid
	FROM inserted
	
	SELECT @RemainSid = RemainingAmt
	FROM Student
	WHERE StudentID = @Sid

	SET @RemainSid =   @AmountPaid - @RemainSid 
	
	IF @RemainSid < 0
	BEGIN
		PRINT 'Record Can not be Updated.'
		ROLLBACK
	END
	ELSE
	BEGIN
		UPDATE Student
		SET RemainingAmt = @RemainSid
		WHERE StudentID = @Sid
		PRINT 'Record Updated Successfully'
	END
END
GO

DROP TRIGGER TRGFeePayment

INSERT INTO FeePayment(StudentID,AmountPaid)
	VALUES(102,7000)

SELECT * FROM Student

SELECT * FROM FeePayment
