# Date created and Last ran : 07-20-2023 
# Queries to practice RANK() AND DENSE_RANK() WINDOW functions on the Employees Database from this Udemy course 
# Course: Udemy- 365 Careers MySQL for Data Analytics and Business Intelligence

# The MySQL RANK() and DENSE_RANK() Window Functions - Exercises

/* Exercise #1: Write a query containing a window function to obtain all salary values that 
employee number 10560 has ever signed a contract for. Order & display the salary values from highest to lowest. */

SELECT
		emp_no,
		salary,
		ROW_NUMBER() OVER w AS row_num
FROM
		salaries
WHERE emp_no = 10560
WINDOW w AS (PARTITION BY emp_no ORDER BY salary DESC);

/* Exercise #2: Write a query that displays the number of salary contracts that each manager
 has ever signed while working in the company. */
 
 SELECT
		dm.emp_no,
		COUNT(salary) AS no_of_salary_contracts
FROM
		dept_manager dm
        JOIN 
        salaries s on dm.emp_no = s.emp_no
GROUP BY dm.emp_no
ORDER BY dm.emp_no;       
 
 /* Exercise #3: Write a query that retrieves a result set containing all salary values
 that employee 10560 has ever signed a contract for. Use a window function to rank all salary values 
 from highest to lowest in a way that equal salary values bear the same rank and that gaps in the
 obtained ranks for subsequent rows are allowed. */
 
SELECT
		emp_no,
		salary,
		RANK() OVER w AS rank_num
FROM
		salaries
WHERE 	emp_no = 10560
WINDOW w AS (PARTITION BY emp_no ORDER BY salary DESC);
--  Result grid: Employee 10560’s six salaries ranked from 1 to 6: 46950, …, 40000
 
 /* Exercise #4: Write a query that retrieves a result set containing all salary values
 that employee 10560 has ever signed a contract for. 
 - Use a window function to rank all salary values from highest to lowest in a way that equal salary values
 bear the same rank and that gaps in the obtained ranks for subsequent rows are not allowed. */
 
 SELECT
		emp_no,
		salary,
		RANK() OVER w AS rank_num
FROM
		salaries
WHERE 	emp_no = 10560
WINDOW w AS (PARTITION BY emp_no ORDER BY salary DESC);
/*  query returns 6 rows , row # 2 and 3 displaying same rank 
emp_no  salary  rank_num
10560	46950	1
10560	44789	2 > Equal salary values($44,789) ranked same 
10560	44789	2 > Equal salary values ($44,789) ranked same 
10560	44500	4
10560	41797	5
10560	40000	6
*/


 
 
