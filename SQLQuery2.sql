-- Оператор TOP выбирает три первых записи в запросе
USE [AdventureWorks2019];
SELECT
	TOP 3 *
FROM
	Sales.SalesOrderDetail;

-- Аналогичный запрос с сортировкой по убыванию QrderQty
SELECT
	TOP 3 *
FROM
	Sales.SalesOrderDetail
ORDER BY
	[OrderQty] DESC ;

-- Аналогичный запрос с сортировкой по убыванию QrderQty WITH TIES
SELECT
	TOP 3 WITH TIES *
FROM
	Sales.SalesOrderDetail
ORDER BY
	[OrderQty] DESC ;

-- вывести все значения из стобца persontype таблицы Person
SELECT
	ALL PersonType
FROM 
	[Person].[Person];

-- Вывести уникальные значения этого стобца
SELECT
	DISTINCT PersonType
FROM 
	[Person].[Person];

-- Вывести всех людей из города London из таблицы person.address
SELECT
	*
FROM
	[Person].[Address]
WHERE 
	[City] = 'LONDON';

-- Вывести из этой эе таблицы всех пользователей ADdressID = 667
SELECT
	*
FROM
	[Person].[Address]
WHERE 
	[AddressID] = '667';


























