CREATE DATABASE BANK
USE BANK

CREATE TABLE Bank_Customer(
Id INT PRIMARY KEY,
Name VARCHAR(30),
Balance MONEY
)


INSERT INTO Bank_Customer(Id , Name , Balance)
		VALUES ( 1,'Puja',50000),
			(2,'Samir',90000),
			(3,'Shital',70000)


CREATE PROCEDURE spBalance @sourceId INT , @destId INT ,@amt INT
AS
BEGIN

DECLARE @Count1 INT, @Count2 INT

UPDATE Bank_Customer SET Balance = Balance - @amt 
WHERE Id=@sourceId
SET @Count1=@@ROWCOUNT

UPDATE Bank_Customer SET Balance = Balance + @amt 
WHERE Id=@destId
SET @Count2=@@ROWCOUNT

IF @Count1=@Count2
BEGIN 
	COMMIT 
	PRINT'AMOUNT HAS BEEN TRANSFERRED'
END

ELSE

BEGIN
		ROLLBACK
		PRINT'AMOUNT TRANFERRED FAILED'
	END

END

SELECT * FROM Bank_Customer
EXEC spBalance 1 , 2 , 7000

