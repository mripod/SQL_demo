--CREATE TABLE table_name (
--column1 datatype,
--column2 datatype,
--column3 datatype
--...
--);

USE [AdventureWorks2019]
CREATE TABLE Person 
(
	PersonID INT PRIMARY KEY,
	LastName VARCHAR(255),
	FirstName VARCHAR(255),
	Address VARCHAR(255),
	City VARCHAR(255)
);

USE [AdventureWorks2019]
DROP TABLE [dbo].[Person];

--SELECT
--column1, column2
--INTO new_table_name
--FROM
--existing_table_name
--WHERE ... ;

SELECT
	AddressID,
	AddressLine1,
	City
INTO Address_Berlin
FROM
	[Person].Address
WHERE 
	City = 'Berlin';

SELECT
	*
FROM
	[dbo].[Address_Berlin];

ALTER TABLE Person
ADD DateCreated date;


INSERT INTO Person (PersonID, LastName, FirstName,  Address, City, DateCreated)
VALUES ('1', 'Ivanov', 'Ivan', 'Ukraine', 'Kiyv', '2020-12-01');

SELECT
	*
FROM
	Person;


INSERT INTO Person (PersonID, LastName, FirstName,  Address, City, DateCreated)
VALUES 
('2', 'Ivanov', 'Sergey', 'Ukraine', 'Kiyv', '2022-10-10')	
,('3', 'Ivanov', 'Kirill', 'Ukraine', 'Kiyv', '2022-10-10')	
,('4', 'Ivanov', 'Artem', 'Ukraine', 'Kiyv', '2022-10-10')
,('5', 'Ivanov', 'Kirill', 'Ukraine', '', '2022-10-10');	

--UPDATE table_name
--SET column1 = value1, ...
--WHERE [condition];

UPDATE Person
SET City = 'Dnepr'
WHERE LastName = 'Ivanov';

UPDATE Person
SET City = 'Unknown'
WHERE City IS NULL;

--DELETE
--FROM table_name
--WHERE search_condition 

DELETE
FROM Person
WHERE FirstName = 'Ivan';

SELECT
	*
FROM 
	[dbo].[Person]
WHERE 
	LastName LIKE '%v%';

CREATE TABLE Personinfo2 (
	ID INT UNIQUE
	, LastName VARCHAR (255) NOT NULL
	, FirstName VARCHAR (255) NOT NULL
	, Age INT 
	);

INSERT INTO [dbo].[Personinfo2]
VALUES ('1', 'Petrov', 'Artem', '38');

SELECT *
FROM [dbo].[Personinfo2];

INSERT INTO [dbo].[Personinfo2]
VALUES ('2', 'Ivanov', 'Artem', '37');

CREATE TABLE Personinfo3 (
	ID INT NOT NULL PRIMARY KEY
	, LastName VARCHAR (255) NOT NULL
	, FirstName VARCHAR (255) NOT NULL
	, Age INT 
	);

SELECT *
FROM [dbo].[Personinfo3];


INSERT INTO [dbo].[Personinfo3]
VALUES ('1', 'Petrov', 'Artem', '38');

INSERT INTO [dbo].[Personinfo3]
VALUES ('2', 'Alekseev', 'Alexey', '22');


CREATE TABLE Personinfo4 (
	ID INT NOT NULL 
	, LastName VARCHAR (255) NOT NULL
	, FirstName VARCHAR (255) NOT NULL
	, Age INT CHECK (Age >=18)
	); 

INSERT INTO [dbo].[Personinfo4]
VALUES ('1', 'Petrov', 'Artem', '18');

SELECT *
FROM [dbo].[Personinfo4];

INSERT INTO [dbo].[Personinfo4]
VALUES ('1', 'Petrov', 'Arsenii', '26');

CREATE TABLE OrderInfo (
	ID INT NOT NULL 
	, OrderNumber INT NOT NULL
	, OrderDate DATE DEFAULT GETDATE()
	); 

INSERT INTO dbo.OrderInfo (ID, OrderNumber)
VALUES (1, '25636');

 CREATE TABLE OrderDetails (
	OrderID INT PRIMARY KEY 
	, OrderNumber INT NOT NULL
	, OrderDate DATE DEFAULT GETDATE()
	, ID INT FOREIGN KEY REFERENCES [dbo].[Personinfo3]
	); 

INSERT INTO dbo.OrderDetails([OrderID], OrderNumber, PersonID)
VALUES (1, '25636', 1); 

SELECT *
FROM dbo.OrderDetails;


INSERT INTO dbo.OrderDetails([OrderID], OrderNumber, PersonID)
VALUES (2, '25637', 2); 

SELECT *
FROM [dbo].[OrderDetails] AS A
JOIN [dbo].[Personinfo3] AS B
ON A.OrderID = B.ID;

CREATE TABLE Student (
	ID INT NOT NULL 
	, LastName VARCHAR (255) nOT NULL
	, FirstName VARCHAR (255) nOT NULL
	, Age INT NOT NULL
	);  

INSERT INTO Student (ID, LastName, FirstName, Age)
VALUES (1, 'Ivan', 'Petrov', 18);

SELECT*
FROM Student;

--INSERT INTO Student (ID, LastName, FirstName, Age)
--VALUES (1, 'Ivan', 'Petrov');

INSERT INTO Student (ID, LastName, FirstName, Age)
VALUES (2, 'Ivan', 'Sidorov', 19);

--ALTER TABLE Student
--ADD UNIQUE (FirstName);

