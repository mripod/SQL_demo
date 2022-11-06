-- �������� TOP �������� ��� ������ ������ � �������
USE [AdventureWorks2019];
SELECT
	TOP 3 *
FROM
	Sales.SalesOrderDetail;

-- ����������� ������ � ����������� �� �������� QrderQty
SELECT
	TOP 3 *
FROM
	Sales.SalesOrderDetail
ORDER BY
	[OrderQty] DESC ;

-- ����������� ������ � ����������� �� �������� QrderQty WITH TIES
SELECT
	TOP 3 WITH TIES *
FROM
	Sales.SalesOrderDetail
ORDER BY
	[OrderQty] DESC ;

-- ������� ��� �������� �� ������ persontype ������� Person
SELECT
	ALL PersonType
FROM 
	[Person].[Person];

-- ������� ���������� �������� ����� ������
SELECT
	DISTINCT PersonType
FROM 
	[Person].[Person];

-- ������� ���� ����� �� ������ London �� ������� person.address
SELECT
	*
FROM
	[Person].[Address]
WHERE 
	[City] = 'LONDON';

-- ������� �� ���� �� ������� ���� ������������� ADdressID = 667
SELECT
	*
FROM
	[Person].[Address]
WHERE 
	[AddressID] = '667';


























