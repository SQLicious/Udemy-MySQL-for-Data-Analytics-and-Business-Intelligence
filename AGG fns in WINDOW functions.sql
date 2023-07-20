# Date created and Last ran : 07-20-2023 
# Queries to practice MySQL Aggregate Functions in the Context of Window Functions on the Employees Database from this Udemy course 
# Course: Udemy- 365 Careers MySQL for Data Analytics and Business Intelligence

/*Exercise #1: Create a query that upon execution returns a result set containing the employee numbers, contract salary values, start, and end dates 
of the first ever contracts that each employee signed for the company. To obtain the desired output, refer to the data stored in the "salaries" table. */

SELECT 
    s1.emp_no,
    s.salary,
    s.from_date,
    s.to_date
FROM
    salaries s
        JOIN
    (SELECT 
        emp_no, MIN(from_date) AS from_date
    FROM
        salaries
    GROUP BY emp_no) s1 ON s.emp_no = s1.emp_no
WHERE
    s.from_date = s1.from_date;
    
    /* MySQL Aggregate Functions in the Context of Window Functions - Part II-Exercises */ 
    /*  Exercise #1: Consider the employees' contracts that have been signed after the 1st of January 2000 and terminated before the 1st of January 2002 (as registered in the "dept_emp" table).
Create a MySQL query that will extract the following information about these employees:
- Their employee number
- The salary values of the latest contracts they have signed during the suggested time period
- The department they have been working in (as specified in the latest contract they've signed during the suggested time period)
- Use a window function to create a fourth field containing the average salary paid in the department the employee was last working in during the suggested time period. Name that field "average_salary_per_department".
Note1: This exercise is not related neither to the query you created nor to the output you obtained while solving the exercises after the previous lecture.
Note2: Now we are asking you to practically create the same query as the one we worked on during the video lecture; the only difference being to refer to contracts that have been valid within the period between the 1st of January 2000 and the 1st of January 2002.
Note3: We invite you solve this task after assuming that the "to_date" values stored in the "salaries" and "dept_emp" tables are greater than the "from_date" values stored in these same tables. If you doubt that, you could include a couple of lines in your code to ensure that this is the case anyway!
Hint: If you've worked correctly, you should obtain an output containing 200 rows. */

SELECT 		de2.emp_no,
			d.dept_name,
			s2.salary,
			AVG(s2.salary) OVER w AS average_salary_per_department
FROM (
		SELECT  	de.emp_no,
					de.dept_no,
					de.from_date,
					de.to_date
		FROM dept_emp de 
        -- Subquery 1 , Step 2: Join the "dept_emp" table with the result of Step 1 to get the latest contract information
		-- for each employee during the specified time period.
		JOIN ( 	
				-- Subquery 1: Step 1
				SELECT emp_no, 
						MAX(from_date) AS from_date --  Retrieve the latest "from_date" for each employee from the "dept_emp" table within the specified time period
						FROM dept_emp
						GROUP BY emp_no
		    ) de1 ON de1.emp_no = de.emp_no
		WHERE de.to_date < '2002-01-01' AND de.from_date > '2000-01-01'
		AND de.from_date = de1.from_date
	) de2
JOIN (  -- Step 3: Retrieve the latest salary information for each employee from the "salaries" table within the specified time period.
		SELECT s1.emp_no,
				s.salary,
				s.from_date,
				s.to_date
		FROM salaries s
		JOIN (	-- Subquery 2: Step 1
					SELECT emp_no,
						   MAX(from_date) AS from_date
					FROM salaries
					GROUP BY emp_no
		     ) s1 ON s.emp_no = s1.emp_no
				  WHERE s.to_date < '2002-01-01' AND s.from_date > '2000-01-01'
				  AND s.from_date = s1.from_date
	) s2 ON s2.emp_no = de2.emp_no
JOIN 
-- Step 4: Join the results of Steps 2 and 3 with the "departments" table to get the department names.
	departments d ON d.dept_no = de2.dept_no
GROUP BY de2.emp_no,d.dept_name
WINDOW w AS (PARTITION BY de2.dept_no)
ORDER BY de2.emp_no,salary;