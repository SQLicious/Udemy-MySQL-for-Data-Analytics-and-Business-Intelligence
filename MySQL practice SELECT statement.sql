# Date created and Last ran : 07-07-2023 
# This files contains queries that were executed to practice SELECT statements on Employees Database 
# Course : Udemy- 365 Careers MySQL for Data Analytics and Business Intelligence
# Refer employees.sql to create and load data into Employees database before you begin
# Clauses practiced SELECT FROM, WHERE, AND , OR , IN, NOT-IN, LIKE-NOT LIKE , BETWEEN AND , IS NOT NULL- IS NULL, SELECT DISTINCT
# ORDER BY, GROUP BY, HAVING, WHERE VS HAVING, LIMIT

SELECT  FIRST_NAME,
        LAST_NAME
FROM    EMPLOYEES;      

SELECT * FROM EMPLOYEES;
SELECT * FROM DEPARTMENTS;  #Lists  all the rows in department table 

-# Q3. Select all people from the “employees” table whose first name is “Elvis”.
SELECT * FROM EMPLOYEES
WHERE FIRST_NAME = 'Elvis'; -- 246 rows returned 

# Q4. Select all male employees whose first name is Dennis 

SELECT 
    *
FROM
    employees
WHERE
    first_name = 'DENIS' AND gender = 'M';

#Q5. Retrieve a list with all female employees whose first name is Kellie. 
SELECT 
    *
FROM
    employees
WHERE
    first_name = 'KELLIE' AND gender = 'F'; -- 86 ROWS retrieved 
    
#Q6. Retrieve a list with all employees whose first name is either Kellie or Aruna.
SELECT 
    *
FROM
    employees
WHERE
    first_name = 'Kellie' OR 'Aruna'; -- 226 rows retrieved 

#Q7. Retrieve a list with all female employees whose first name is either Kellie or Aruna.
SELECT 
    *
FROM
    employees
WHERE
    gender = 'F' AND (first_name = 'Kellie' OR first_name ='Aruna'); -- 167 ROWS retrieved 
    
#Q8. Use the IN operator to select all individuals from the “employees” table, whose first name is either “Denis”, or “Elvis”.

SELECT 
    *
FROM
    employees
WHERE
    first_name IN ('Denis' OR 'Elvis');
    
#Q9. Extract all records from the ‘employees’ table, aside from those with employees named John, Mark, or Jacob.
SELECT * FROM employees 
WHERE first_name NOT IN ('JOHN','MARK','JACOB');

#Q10 use the LIKE operator to select the data about all individuals, whose first name starts with “Mark”; 
# specify that the name can be succeeded by any sequence of characters.

SELECT * FROM employees 
WHERE first_name LIKE ('MARK%');

#Q11 Retrieve a list with all employees who have been hired in the year 2000.

SELECT * FROM employees 
WHERE hire_date LIKE ('%2000%');

#Q12 Retrieve a list with all employees whose employee number is written with 5 characters, and starts with “1000”
SELECT * FROM employeeS
WHERE emp_no LIKE ('1000_');

#Q13 Extract all individuals from the ‘employees’ table whose first name contains “Jack”
SELECT * FROM employees 
WHERE first_name LIKE ('%JACK%'); -- 256 rows returned

#Q14 Extract another list containing the names of employees that do not contain “Jack”.
SELECT * FROM employees 
WHERE first_name NOT LIKE ('%JACK%'); -- 1000 rows returned 

#Q15 BETWEEN - AND - exercise
# Select all the information from the “salaries” table regarding contracts from 66,000 to 70,000 dollars per year.
SELECT * FROM salaries 
WHERE salary BETWEEN 66000 AND 70000; #1000 rows returned 

#Q16 Retrieve a list with all individuals whose employee number is not between ‘10004’ and ‘10012’.
SELECT * FROM employees
WHERE emp_no NOT BETWEEN '10004' AND '10012';  # 1000 ROWS returned

#Q17 Select the names of all departments with numbers between ‘d003’ and ‘d006’.
SELECT * FROM departments
WHERE depT_no BETWEEN 'D003' AND 'D006'; # 4 rows returned 

#Q18 Select the names of all departments whose department number value is not null

SELECT  * FROM
    departments
WHERE
    dept_no IS NOT NULL;
    
# OTHER COMPARISON OPERATORS
#Q19. Retrieve a list with data about all female employees who were hired in the year 2000 or after.
SELECT * FROM employees 
WHERE hire_date > '2000-01-01' AND gender = 'F'; #7 rows returned 

#Q20. Extract a list with all employees’ salaries higher than $150,000 per annum.

SELECT * FROM salaries
WHERE salary > 150000.00; #16 rows returned 

# Q21. Obtain a list with all different “hire dates” from the “employees” table
SELECT DISTINCT hire_date 
FROM employees ;

#Q22. How many annual contracts with a value higher than or equal to $100,000 
# have been registered in the salaries table?

SELECT COUNT(*)
FROM salaries
WHERE salary > 100000.00;

#Q23 How many managers do we have in the “employees” database?

SELECT COUNT(*)
FROM dept_manager;

#Q24. Select all data from the “employees” table, ordering it by “hire date” in descending order

SELECT * FROM employees 
ORDER BY hire_date DESC;

#Q25. Write a query that obtains two columns. The first column must contain annual salaries higher than 80,000 dollars. 
# The second column, renamed to “emps_with_same_salary”, must show the number of employees contracted to that salary. Lastly, sort the output
# by the first column.

SELECT salary AS Annual_salary,
COUNT( emp_no) AS emps_with_same_salary
FROM salaries
WHERE salary > 80000.00
GROUP BY salary
ORDER BY salary;

#Q26. Select all employees whose average salary is higher than $120,000 per annum.

SET sql_mode=(SELECT REPLACE(@@sql_mode,'ONLY_FULL_GROUP_BY',''));
SELECT *,
AVG(SALARY)
FROM salaries
WHERE salary > 120000
GROUP BY emp_no
ORDER BY emp_no; 

#Q27 Select the employee numbers of all individuals who have signed more than 1 contract after the 1st of January 2000.

SELECT emp_no, from_date
FROM  dept_emp
WHERE from_date > '2000-01-01'
GROUP BY emp_no
HAVING count(from_date) > 1
ORDER BY emp_no;

# Q28 Select the first 100 rows from the ‘dept_emp’ table.
SELECT *
FROM
    dept_emp
LIMIT 100;












