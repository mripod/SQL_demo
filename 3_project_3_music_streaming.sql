SELECT artist, week, streams_millions, chart_position
	FROM windows_function.streams;
	
-- Значение стрмов текущей недели относительно предыдущей

SELECT
	artist,
	week,
	streams_millions,
	LAG (streams_millions, 1, 0) OVER (ORDER BY week ASC) Стримы_предыдущей_недели
FROM
	windows_function.streams
WHERE 
	artist = 'Drake';
	
-- Показать увеличение или падение количества стримов относительно предыдущего периода

SELECT
	artist,
	week,
	streams_millions,
	streams_millions - LAG (streams_millions, 1, 0) OVER (ORDER BY week ASC) Изменение_количества_стримов
FROM
	windows_function.streams
WHERE 
	artist = 'Drake';
	
-- Расчет изменения 'Изменение_количества_стримов' от недели к неделе для всех артистов с помощью LAG
SELECT
	artist,
	week,
	streams_millions,
	streams_millions - LAG (streams_millions, 1, 0) OVER (PARTITION BY artist ORDER BY week ASC) Изменение_количества_стримов
FROM
	windows_function.streams;
	
-- Расчет изменения позиции в чартах от недели к неделе
SELECT
	artist,
	week,
	streams_millions,
	chart_position,
	streams_millions - LAG (streams_millions, 1, 0) OVER (PARTITION BY artist ORDER BY week ASC) Изменение_количества_стримов,
	LAG (chart_position, 1, 0) OVER (PARTITION BY artist ORDER BY week ASC) - chart_position AS Изменение_места_в_чарте
FROM
	windows_function.streams;
	
-- LEAD показать аналогичный запрос через значение предыдущей строки

SELECT
	artist,
	week,
	streams_millions,
	LEAD (streams_millions, 1, 0) OVER (PARTITION BY artist ORDER BY week ASC) - streams_millions AS Изменение_количества_стримов,
	chart_position,
	chart_position - LEAD (chart_position, 1, 0) OVER (PARTITION BY artist ORDER BY week ASC) AS Изменение_места_в_чарте
FROM
	windows_function.streams;
	
-- Пример функции для нумерации строк ROW_NUMBER
WITH rows AS 
(SELECT
	artist,
	week,
	streams_millions,
	ROW_NUMBER() OVER(ORDER BY streams_millions ASC) AS Row_run
FROM
	windows_function.streams)
	
SELECT 
	*
FROM 
	rows
WHERE 
	row_run BETWEEN '10'AND'30';
	
-- пример функции RANK, которая присваивает ранги значениям
SELECT
	artist,
	week,
	streams_millions,
	RANK() OVER(ORDER BY streams_millions DESC) AS Rank_result,
	DENSE_RANK() OVER(ORDER BY streams_millions DESC) AS Dense_Rank_result
FROM
	windows_function.streams;
	

SELECT
	artist,
	week,
	streams_millions,
	RANK() OVER(PARTITION BY week ORDER BY streams_millions DESC) AS Rank_result,
	DENSE_RANK() OVER(PARTITION BY week ORDER BY streams_millions DESC) AS Dense_Rank_result
FROM
	windows_function.streams;
	
-- Функция NTILE: разбивает данные на группы
SELECT
	artist,
	week,
	streams_millions,
	NTILE(5) OVER(ORDER BY streams_millions DESC) AS недельные_стримы
FROM
	windows_function.streams;
	
--
SELECT
	artist,
	week,
	streams_millions,
	NTILE(4) OVER(PARTITION BY week ORDER BY streams_millions DESC) AS недельные_стримы
FROM
	windows_function.streams;
	
-- 
	
	