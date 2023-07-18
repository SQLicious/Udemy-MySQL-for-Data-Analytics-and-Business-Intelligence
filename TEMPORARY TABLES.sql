# Date created and Last ran : 07-15-2023 
# This files contains queries that were executed to practice TEMPORARY TABLES concepts on tables in Employees Database 
# Course : Udemy- 365 Careers MySQL for Data Analytics and Business Intelligence

/*Ex 1 Store the highest contract salary values of all male employees in a temporary table called male_max_salaries.*/
USE employees;
CREATE TEMPORARY TABLE male_max_salaries
SELECT s.emp_no, MAX(s.salary)
FROM   salaries s 
	    INNER JOIN 
       employees e on e.emp_no = s.emp_no and e.gender = 'M'	
GROUP BY s.emp_no;

/*Ex2. Write a query that, upon execution, allows you to check the result set contained
 in the male_max_salaries temporary table you created in the previous exercise. */
 
 SELECT * FROM male_max_salaries; -- instantaneous output received due to the use of temporary table above
 
 /* Exercise 3 Create a temporary table called dates containing the following three columns:
- one displaying the current date and time,
- another one displaying two months earlier than the current date and time, and a
- third column displaying two years later than the current date and time. */

CREATE TEMPORARY TABLE dates
SELECT
    NOW(),
    DATE_SUB(NOW(), INTERVAL 2 MONTH) AS two_months_earlier,
    DATE_SUB(NOW(), INTERVAL -2 YEAR) AS two_years_later;

/* Ex 3: Check the result set contained in the dates temporary table you created in the previous exercise. */   

SELECT * FROM dates;

/* Ex#4: Create a query joining the result sets from the dates temporary table you created during the previous
 lecture with a new Common Table Expression (CTE) containing the same columns. Let all columns in the result set appear on the same row.*/
 
WITH cte1 AS (
SELECT
	NOW() AS current_date_time,
	DATE_SUB(NOW(), INTERVAL 2 MONTH) AS cte_a_month_earlier,
	DATE_SUB(NOW(), INTERVAL -2 YEAR) AS cte_a_year_later
)
SELECT * FROM dates d1 JOIN cte1 c;

/*Ex#5 Create a query joining the result sets from the dates temporary table you created during the previous lecture 
with a new Common Table Expression (CTE) containing the same columns. This time, combine the two sets vertically.*/

WITH cte2 AS (SELECT
	NOW(),
    DATE_SUB(NOW(), INTERVAL 1 MONTH) AS cte_a_month_earlier,
    DATE_SUB(NOW(), INTERVAL -1 YEAR) AS cte_a_year_later)

SELECT * FROM dates UNION SELECT * FROM cte2;


 /* Exercise #6: Drop the male_max_salaries and dates temporary tables you recently created. */
 
 DROP TABLE IF EXISTS male_max_salaries;
 DROP TABLE IF EXISTS dates;
 


