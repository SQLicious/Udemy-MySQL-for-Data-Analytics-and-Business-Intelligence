# Date created and Last ran : 07-11-2023 
# This files contains queries that were executed to practice AGGREGATE FUNCTIONS on tables contained in the Employees Database 
# Course : Udemy- 365 Careers MySQL for Data Analytics and Business Intelligence

/* EXERCISE 1 COUNT 
How many departments are there in the “employees” database? Use the ‘dept_emp’ table to answer the question. */ 

SELECT COUNT(DISTINCT dept_no)
FROM dept_emp; 

#EXERCISE 2 What is the total amount of money spent on salaries for all contracts starting after the 1st of January 1997?

SELECT SUM(salary)
FROM salaries 
WHERE from_date > '1997-01-01';

#EXERCISE 3 1. Which is the lowest employee number in the database? 2. Which is the highest employee number in the database? */
SELECT MIN(emp_no)
FROM employees;

SELECT
MAX(emp_no)
FROM employees;

#EXERCISE 4 What is the average annual salary paid to employees who started after the 1st of January 1997?

SELECT ROUND(AVG(salary))
FROM salaries
WHERE from_date > '1997-01-01';

#EXERCISE 5 Round the average amount of money spent on salaries for all contracts that started after the 1st of January 1997 to a precision of cents.

SELECT ROUND(AVG(salary),2)
FROM salaries
WHERE from_date > '1997-01-01';

# COALESCE () PREP
ALTER TABLE deparments_dup
CHANGE COLUMN dept_name dept_name VARCHAR(40) NULL; 

INSERT INTO deparments_dup(dept_no) VALUES ('d010'), ('d011');

SELECT *
FROM deparments_dup
ORDER BY dept_no ASC; 

/*Add a third column “Department manager”. It will indicate the manager of the respective department. 
For now, we will leave it empty, and will add the NULL constraint.*/

ALTER TABLE employees.deparments_dup
ADD COLUMN dept_manager VARCHAR(255) NULL AFTER dept_name;

#Let’s check the state of the “Departments duplicate” table now.
SELECT * FROM
deparments_dup
ORDER BY dept_no ASC;
COMMIT;

/* Select the department number and name from the ‘departments_dup’ table and 
add a third column where you name the department number (‘dept_no’) as ‘dept_info’. 
If ‘dept_no’ does not have a value, use ‘dept_name’.*/

SELECT dept_no,
       dept_name,
      COALESCE(dept_no, dept_name) AS dept_info
FROM
    deparments_dup
ORDER BY dept_no ASC;

/*Modify the code obtained from the previous exercise in the following way. Apply the IFNULL() function to the values
 from the first and second column, so that ‘N/A’ is displayed whenever a department number has no value, 
 and ‘Department name not provided’ is shown if there is no value for ‘dept_name’. */
 
 SELECT
    IFNULL(dept_no, 'N/A') as dept_no,
    IFNULL(dept_name,'Department name not provided') AS dept_name,
    COALESCE(dept_no, dept_name) AS dept_info
FROM
    deparments_dup
ORDER BY dept_no ASC;




