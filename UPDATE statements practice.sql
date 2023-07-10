# Date created and Last ran : 07-10-2023 
# This files contains queries that were executed to practice INSERT statements on tables contained in the Employees Database 
# Course : Udemy- 365 Careers MySQL for Data Analytics and Business Intelligence

/* EXERCISE 1	 
Select ten records from the “titles” table to get a better idea about its content.
Then, in the same table, insert information about employee number 999903. State that he/she is a “Senior Engineer”, who has started working in this position on October 1st, 1997.
At the end, sort the records from the “titles” table in descending order to check if you have successfully inserted the new record.
*/

SELECT * 
FROM titles 
LIMIT 10;

INSERT INTO employees
VALUES
(    999903,
    '1977-09-14',
    'Johnathan',
    'Creek',
    'M',
    '1999-01-01'
);

INSERT INTO titles (emp_no,title,from_date)
VALUES(
999903,
"Senior Engineer",
"1997-10-01"
);

SELECT *
FROM
    titles
ORDER BY emp_no DESC;

/* EXERCISE 2 
Insert information about the individual with employee number 999903 into the “dept_emp” table. 
He/She is working for department number 5, and has started work on  October 1st, 1997; 
her/his contract is for an indefinite period of time. */

SELECT * FROM dept_emp
LIMIT 5 ;

INSERT INTO dept_emp
(emp_no,
 dept_no,
 from_date,
 to_date
)
VALUES (
999903,
"d005",
"1997-10-01",
"9999-01-01"
);

# Exercise - INSERT INTO SELECT statement 
CREATE TABLE deparments_dup
( dept_no CHAR(4) NOT NULL,
  dept_name Varchar(40) NOT NULL
);

INSERT INTO deparments_dup
( dept_no,
  dept_name
)

SELECT * FROM departments;

-- check the newly created departments_duplicate table 
SELECT * 
FROM deparments_dup
ORDER BY dept_no; 

/* EXERCISE #3 Inserting Data INTO a New Table - exercise
Create a new department called “Business Analysis”. Register it under number ‘d010’ */

INSERT INTO deparments_dup
VALUES (
'd010',
'Business Analysis'
);

-- Validate the latest INSERT statement worked
SELECT * 
FROM deparments_dup
ORDER BY dept_no DESC;


