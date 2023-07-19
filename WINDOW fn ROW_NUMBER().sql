# Date created and Last ran : 07-19-2023 
# Queries to practice Window functions on tables contained in the Employees Database from this Udemy course 
# Course: Udemy- 365 Careers MySQL for Data Analytics and Business Intelligence

#The ROW_NUMBER() Ranking Window Function - Exercises
/* Exercise #1 :Write a query that assigns a row number to all managers we have information for in the "employees" database
 (regardless of their department). Let the numbering disregard the department the managers have worked in. Also, let it start
 from the value of 1.Assign that value to the manager with the lowest employee number.*/

SELECT emp_no,
       dept_no,
	ROW_NUMBER() OVER(ORDER BY emp_no ASC) AS row_num
FROM dept_manager;

/*Exercise #2: Write a query that assigns a sequential number for each employee number registered in the "employees"
 table. Partition the data by the employee's first name and order it by their last name in ascending order (for each partition). */
 
 SELECT emp_no,
	    first_name,
        last_name,
        ROW_NUMBER() OVER( PARTITION BY first_name ORDER BY last_name ASC) AS row_num
FROM employees;

# Using Several Window Functions - Exercises

/* Exercise #1: Use WINDOW functions to analyze the salary data for each manager from the “employees” database.
Hint: Join the “dept_manager” and “salaries” tables using the “emp_no” column. Add two new columns to your output using window functions:
- a column with the row number of each row in the whole output, starting from 1.
- a column with the row number of each row for each manager, starting from 1 for their lowest salary and ending with their highest salary. 
Order your output by the first column, and then by the second column for each manager. */

SELECT
	dm.emp_no,
	salary,
    ROW_NUMBER() OVER () AS row_num1,
    ROW_NUMBER() OVER (PARTITION BY emp_no ORDER BY salary DESC) AS row_num2   
FROM
dept_manager dm
    JOIN 
salaries s ON dm.emp_no = s.emp_no;   

/* Exercise #2: Use WINDOW functions to analyze the salary data for each manager from the “employees” database.
 To get the data, join the “dept_manager” and “salaries” tables using the “emp_no” column. 
 Add two new columns to your output using window functions:
- a column with the row number of each row for each manager, starting from 1 for their lowest salary and ending with their highest salary.
- a column with the row number of each row for each manager, starting from 1 for their highest salary and ending with their lowest salary. Your output should be sorted by the salary values for each manager in descending order.
Hint: You don’t need to use an ORDER BY clause in your query to get the correct output. */  

SELECT
		dm.emp_no,
		salary,
		ROW_NUMBER() OVER () AS row_num1,
		ROW_NUMBER() OVER (PARTITION BY emp_no ORDER BY salary DESC) AS row_num2
FROM
		dept_manager dm
    JOIN 
		salaries s ON dm.emp_no = s.emp_no
ORDER BY row_num1, emp_no, salary ASC; 

# MySQL Window Functions Syntax - Exercise
/*Exercise #1: Write a query that provides row numbers for all workers from the "employees" table, 
partitioning the data by their first names and ordering each partition by their employee number in ascending order. */

SELECT 
		emp_no,
		ROW_NUMBER() OVER W AS row_num
FROM 	employees
WINDOW w AS (PARTITION BY first_name ORDER BY emp_no ASC);

# The PARTITION BY Clause VS the GROUP BY Clause - Exercises

/* Exercise #1: Find out the lowest salary value each employee has ever signed a contract for. 
To obtain the desired output, use a subquery containing a window function, as well as a 
window specification introduced with the help of the WINDOW keyword. */


SELECT a.emp_no,
       MIN(salary) AS min_salary FROM (
				SELECT
				emp_no, salary, ROW_NUMBER() OVER w AS row_num
				FROM
				salaries
				WINDOW w AS (PARTITION BY emp_no ORDER BY salary)) a 
 GROUP BY emp_no; -- 101,796 rows returned 
 
 
 /* My Observation: The GROUP BY clause in the Outer query grouped the rows by emp_no column and reduced the # of rows in the output.
 - Before using the GROUP BY clause, the subquery with the WINDOW function had 967330 rows. 
 - After using the GROUP BY clause, the output had only 101796 rows,  
 This confirms the lecture’s point: GROUP BY reduces rows, PARTITION BY doesn’t. */
 

/* Exercise #2: Again, find out the lowest salary value each employee has ever signed a contract for. Once again,
 to obtain the desired output, use a subquery containing a window function. This time, however, introduce the window 
 specification in the field list of the given subquery. */
 
 SELECT a.emp_no,
       MIN(salary) AS min_salary FROM (
				SELECT
					emp_no,
					salary,
					ROW_NUMBER() OVER(PARTITION BY emp_no ORDER BY salary) AS row_num
				FROM
					salaries) a
				 
 GROUP BY emp_no; -- 101,796 rows returned 
 
/*Exercise #3: Once again, find out the lowest salary value each employee has ever signed a contract for. 
This time, to obtain the desired output, avoid using a window function. Just use an aggregate function and a subquery. */

SELECT a.emp_no,
       MIN(salary) AS min_salary FROM (
				SELECT
					emp_no,
					salary
				FROM
					salaries) a
 GROUP BY emp_no; 


/* Exercise #4: Once more, find out the lowest salary value each employee has ever signed a contract for. 
To obtain the desired output, use a subquery containing a window function, as well as a window specification
 introduced with the help of the WINDOW keyword. Moreover, obtain the output without using a GROUP BY clause in the outer query. */
 
 
 SELECT a.emp_no,
		a.salary as min_salary FROM (
					SELECT
							emp_no, salary, ROW_NUMBER() OVER w AS row_num
					FROM
							salaries
					WINDOW w AS (PARTITION BY emp_no ORDER BY salary)) a
WHERE a.row_num=1;

/* My Observation : This solution filters by row number 1 in the where clause to find the minimum salary 
for each employee without aggregation. The subquery is the same as the solution to Exercise 1. 
 
  /* Exercise #5: Find out the second-lowest salary value each employee has ever signed a contract for. 
  To obtain the desired output, Use a subquery containing a window function, as well as a window specification
  introduced with the help of the WINDOW keyword. Moreover, obtain the desired result set without using a 
  GROUP BY clause in the outer query. */

 SELECT a.emp_no,
		a.salary as second_lowest_salary FROM (
					SELECT
							emp_no, salary, ROW_NUMBER() OVER w AS row_num
					FROM
							salaries
					WINDOW w AS (PARTITION BY emp_no ORDER BY salary)) a
WHERE a.row_num=2;








