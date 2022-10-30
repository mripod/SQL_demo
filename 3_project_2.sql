SELECT username, month, change_in_followers, change_in_following, posts
	FROM windows_function.social_media;
	
-- Вывести данные о сумме прироста подписчиков за весь период
SELECT username, SUM (change_in_followers)
	FROM windows_function.social_media
	WHERE username = 'instagram'
	GROUP BY username;
	
-- Вывести столбцы месяц и кол-во подписчиков для акк Instagram, а также добавить столбец running_total, который будет отображать нарастающую сумму пользователей
SELECT 
	month, 
	change_in_followers, 
	SUM (change_in_followers) OVER (ORDER BY month ASC) AS running_total
	FROM windows_function.social_media
	WHERE username = 'instagram';
	
-- Теперь найти кумулятивное среднее 
SELECT 
	month, 
	change_in_followers, 
	AVG (change_in_followers) OVER (ORDER BY month ASC) AS running_avg
	FROM windows_function.social_media
	WHERE username = 'instagram';
	
-- Пример того, как работает PARTITION
SELECT 
	month, 
	username,
	change_in_followers, 
	SUM (change_in_followers) OVER (PARTITION BY username ORDER BY month ASC) AS running_total,
	AVG (change_in_followers) OVER (PARTITION BY username ORDER BY month ASC) AS running_avg
	FROM windows_function.social_media;
	
-- Пример использования FIRST_VALUE
SELECT 
	month, 
	username,
	posts,
	FIRST_VALUE(posts) OVER (PARTITION BY username ORDER BY posts DESC) AS most_posts
FROM 
	windows_function.social_media;
	
-- Пример использования функции LAST_VALUE ()
SELECT 
	month, 
	username,
	posts,
	LAST_VALUE(posts) OVER (PARTITION BY username ORDER BY posts RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) 
FROM 
	windows_function.social_media
	
	






	