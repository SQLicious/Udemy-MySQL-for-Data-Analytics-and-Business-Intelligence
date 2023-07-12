# Date created and Last ran : 07-12-2023 
# This files contains queries that were executed to practice JOINS on tables contained in the Employees Database 
# Course : Udemy- 365 Careers MySQL for Data Analytics and Business Intelligence

/* Intro to JOINs - exercise 1. If ‘departments_dup’ table is set up, 
use DROP COLUMN to remove the ‘dept_manager’ column from the ‘departments_dup’ table. */

SELECT * FROM 
deparments_dup;

ALTER TABLE deparments_dup
DROP COLUMN dept_manager;

/*Then, use CHANGE COLUMN to change the ‘dept_no’ and ‘dept_name’ columns to NULL.*/
ALTER TABLE deparments_dup
CHANGE COLUMN dept_no dept_no VARCHAR(255) NULL,
CHANGE COLUMN dept_name dept_name VARCHAR(255) NULL;

DELETE FROM deparments_dup
WHERE     dept_no = 'd002'; 
SELECT * FROM deparments_dup;

/*Intro to JOINs - exercise 2
Create and fill in the ‘dept_manager_dup’ table, using the following code */

DROP TABLE IF EXISTS dept_manager_dup;

CREATE TABLE dept_manager_dup (
    emp_no INT(11) NOT NULL,
    dept_no CHAR(4) NULL,
    from_date DATE NOT NULL,
    to_date DATE NULL
);

INSERT INTO dept_manager_dup
select * from dept_manager;

INSERT INTO dept_manager_dup (emp_no, from_date)
VALUES (999904, '2017-01-01'),
       (999905, '2017-01-01'),
       (999906, '2017-01-01'),
       (999907, '2017-01-01');
DELETE FROM dept_manager_dup
WHERE dept_no = 'd001';

INSERT INTO deparments_dup (dept_name)
VALUES ('Public Relations');

DELETE FROM deparments_dup
WHERE dept_no = 'd002'; 

/* Extract a list containing information about all managers’ employee number, 
first and last name, department number, and hire date.*/

SELECT e.emp_no,
	   e.first_name,
       e.last_name,
       dm.dept_no,
       e.hire_date
FROM
       employees e
JOIN
       dept_manager dm ON e.emp_no = dm.emp_no;
       
  /*Join the 'employees' and the 'dept_manager' tables to return a subset of all the employees whose last name is Markovitch. 
       See if the output contains a manager with that name. */
       
       SELECT E.emp_no,
              E.first_name,
              E.last_name,
              DM.dept_no,
              DM.from_date
              
       FROM employees E 
       LEFT OUTER JOIN dept_manager DM
       ON E.emp_no = DM.emp_no
       WHERE E.last_name = 'Markovitch'
       ORDER BY DM.dept_no DESC,E.emp_no;

/* Extract a list containing information about all managers’ employee number, first and last name, department number, 
and hire date. Use the old type of join syntax to obtain the result. */

SELECT 
    e.emp_no, e.first_name, e.last_name, dm.dept_no, e.hire_date
FROM
    employees e,
    dept_manager dm
WHERE
    e.emp_no = dm.emp_no;
    
    select @@global.sql_mode;
    set @@global.sql_mode := replace(@@global.sql_mode, 'ONLY_FULL_GROUP_BY', '');

/* Select the first and last name, the hire date, and the job title of all employees whose first name is “Margareta”
 and have the last name “Markovitch”. */
 
SELECT 
    e.first_name, e.last_name, e.hire_date, t.title
FROM
    employees e
        JOIN
    titles t ON e.emp_no = t.emp_no
WHERE
    first_name = 'Margareta'
        AND last_name = 'Markovitch'
ORDER BY e.emp_no ;   

/* Use a CROSS JOIN to return a list with all possible combinations between managers from the dept_manager table
 and department number 9. */
 
SELECT 
    dm.*, d.*
FROM
    departments d
        CROSS JOIN
    dept_manager dm
WHERE
    d.dept_no = 'd009'
ORDER BY d.dept_no;

/*Return a list with the first 10 employees with all the departments they can be assigned to.*/
SELECT 
    e.*, d.*
FROM
    employees e
        CROSS JOIN
    departments d
WHERE
    e.emp_no < 10011
ORDER BY e.emp_no , d.dept_name;

/* Select all managers’ first and last name, hire date, job title, start date, and department name. */

SELECT 
    e.first_name,
    e.last_name,
    e.hire_date,
    t.title,
    m.from_date,
    d.dept_name
FROM
    employees e
        JOIN
    dept_manager m ON e.emp_no = m.emp_no
        JOIN
    departments d ON m.dept_no = d.dept_no
        JOIN
    titles t ON e.emp_no = t.emp_no
WHERE
    t.title = 'Manager'
ORDER BY e.emp_no;

/* How many male and how many female managers do we have in the ‘employees’ database? */

SELECT 
    e.gender, COUNT(dm.emp_no)
FROM
    employees e
        JOIN
    dept_manager dm ON e.emp_no = dm.emp_no
GROUP BY gender;

/* Go forward to the solution and execute the query. What do you think is the meaning of the minus 
sign before subset A in the last row (ORDER BY -a.emp_no DESC)? */

SELECT 
    *
FROM
    (SELECT 
        e.emp_no,
            e.first_name,
            e.last_name,
            NULL AS dept_no,
            NULL AS from_date
    FROM
        employees e
    WHERE
        last_name = 'Denis' UNION SELECT 
        NULL AS emp_no,
            NULL AS first_name,
            NULL AS last_name,
            dm.dept_no,
            dm.from_date
    FROM
        dept_manager dm) AS a
ORDER BY - a.emp_no DESC;