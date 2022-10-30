SELECT * 

FROM windows_function.salary; 

  

-- Кто получает больше всех в каждом департаменте? 

SELECT department, MAX(gross_salary) 

FROM windows_function.salary 

GROUP BY department; 

  

-- Кто получает больше всех в каждом департаменте? (вывести идентификатор сотрудника и его имя) 

SELECT s.first_name, s.id, s.department, max_s.max_salary 

FROM windows_function.salary AS s 

JOIN 

(SELECT department, MAX(gross_salary) AS max_salary 

FROM windows_function.salary 

GROUP BY department) AS max_s 

ON max_s.department = s.department 

AND 

max_s.max_salary = s.gross_salary; 

  

-- Вывести тот же запрос, используя USING 

SELECT  

s.first_name, s.id, s.department, max_s.gross_salary 

FROM  

windows_function.salary AS s 

JOIN 

(SELECT  

department, MAX(s.gross_salary) AS gross_salary 

FROM  

windows_function.salary AS s 

GROUP BY  

department) AS max_s 

USING (gross_salary, department); 

-- решить эту же задачу через оконную функцию 

SELECT  

s.first_name, s.id, s.department, s.gross_salary, 

MAX (s.gross_salary) 

OVER (PARTITION BY s.department) AS max_gross_salary 

FROM  

windows_function.salary AS s; 

  

-- фильтровать потенциальных кандидатов под сокращение, выведя запрос в подзапрос 

SELECT 

max_s.id, max_s.first_name, max_s.department, max_s.max_gross_salary 

FROM  

(SELECT  

s.first_name, s.id, s.department, s.gross_salary, 

MAX (s.gross_salary) 

OVER (PARTITION BY s.department) AS max_gross_salary 

FROM  

windows_function.salary AS s) AS max_s 

WHERE 

max_s.max_gross_salary = max_s.gross_salary 

ORDER BY 

max_s.id; 

-- Показать пропорцию зарплат в отделе относительно сумм всех зарплат, а также относительно всего ФОТ 

WITH gross_by_department AS  

(SELECT 

department, 

SUM (s.gross_salary) AS department_gross_salary 

FROM 

windows_function.salary AS s 

GROUP BY  

s.department)  

  

SELECT 

s.first_name,  

s.id, s.department,  

s.gross_salary,  

ROUND(((s.gross_salary::numeric/gbd.department_gross_salary)*100),2) AS department_ratio, 

ROUND(((s.gross_salary::numeric / (SELECT SUM(s.gross_salary) FROM windows_function.salary AS s))*100),2) AS total_ratio 

FROM 

windows_function.salary AS s 

JOIN  

gross_by_department AS gbd 

USING (department) 

ORDER BY  

s.department, 

department_ratio DESC; 

-- Решить задачу с помощью оконных функций 

SELECT 

s.first_name,  

s.id, s.department,  

s.gross_salary,  

ROUND(((s.gross_salary::numeric / SUM(s.gross_salary) OVER(PARTITION BY s.department))*100),2) AS department_ratio, 

ROUND(((s.gross_salary::numeric / SUM(s.gross_salary) OVER())*100), 2) AS total_ratio 

FROM 

windows_function.salary AS s 

ORDER BY  

s.department, 

department_ratio DESC; 

-- Вывести имя сотрудника, у которого самая высокая зарплата в департаменте (через оконные функции) 

SELECT  

s.first_name,  

s.id,  

s.department,  

s.gross_salary, 

FIRST_VALUE(s.first_name) OVER(PARTITION BY s.department ORDER BY s.gross_salary DESC) AS highest_paid 

FROM  

windows_function.salary AS s; 

-- Вывести имя сотрудника с само низкой зарплатой в департаменте 

SELECT  

s.first_name,  

s.id,  

s.department,  

s.gross_salary, 

LAST_VALUE(s.first_name) OVER(PARTITION BY s.department ORDER BY s.gross_salary DESC) AS lowest_paid 

FROM  

windows_function.salary AS s; 