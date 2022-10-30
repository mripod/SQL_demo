SELECT state, year, tempf, tempc
	FROM windows_function.state_climate;
	
-- 	Посмотреть, как изменяется средняя температура в каждом штате
SELECT
	state, 
	year, 
	tempf, 
	AVG (tempf) OVER (PARTITION BY state ORDER BY year) AS Ф_температура,
	tempc,
	AVG (tempc) OVER (PARTITION BY state ORDER BY year) AS ц_температура
FROM
	windows_function.state_climate;
	
-- Найти самую низкую темепературу по штатам
SELECT
	state, 
	year, 
	tempf, 
	FIRST_VALUE (tempf) OVER (PARTITION BY state ORDER BY tempf) AS Ф_мин_температура,
	tempc,
	FIRST_VALUE (tempc) OVER (PARTITION BY state ORDER BY tempc) AS ц_мин_температура
FROM
	windows_function.state_climate;
	
-- Найти самую высокую температуру по каждому штату
SELECT
	state, 
	year, 
	tempf, 
	FIRST_VALUE (tempf) OVER (PARTITION BY state ORDER BY tempf DESC) AS Ф_макс_температура,
	tempc,
	FIRST_VALUE (tempc) OVER (PARTITION BY state ORDER BY tempc DESC) AS ц_макс_температура
FROM
	windows_function.state_climate;
	
-- На сколько меняется температура каждый год в каждом штате
SELECT
	state, 
	year, 
	tempf, 
	tempf - LAG(tempf) OVER (PARTITION BY state ORDER BY year) AS Ф_изменение,
	tempc,
	tempc - LAG(tempc) OVER (PARTITION BY state ORDER BY year) AS ц_изменение
FROM
	windows_function.state_climate;
	
-- Найти самую низкую температуру за всю историю
SELECT
	state, 
	year, 
	tempf, 
	RANK() OVER (ORDER BY tempf) AS tempf_min,
	tempc,
	RANK() OVER (ORDER BY tempc) AS tempc_min
FROM
	windows_function.state_climate;
	
-- Найти самую высокую температуру, отдельно по каждому штату
SELECT
	state, 
	year, 
	tempf, 
	RANK() OVER (PARTITION BY state ORDER BY tempf DESC) AS tempf_max_as_state,
	tempc,
	RANK() OVER (PARTITION BY state ORDER BY tempc DESC) AS tempc_max_as_state
FROM
	windows_function.state_climate;
	
-- Вывести среднегодовую температуру в квартилях и квантилях (не в рейтингах), для каждого штата
SELECT
	state, 
	year, 
	tempf, 
	NTILE(4) OVER (PARTITION BY state ORDER BY tempf) AS quartile_f,
	NTILE(5) OVER (PARTITION BY state ORDER BY tempf) AS quintile_f,
	tempc,
	NTILE(4) OVER (PARTITION BY state ORDER BY tempc) AS quartile_c,
	NTILE(5) OVER (PARTITION BY state ORDER BY tempc) AS quintile_c
FROM
	windows_function.state_climate

	
	
	
	
	
	
	
	
	
	
	
	
	