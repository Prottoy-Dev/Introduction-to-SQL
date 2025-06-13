-- Show all databases on the MySQL server
SHOW DATABASES;

-- Select the database named 'password_manager' (if it exists)
USE password_manager;

-- Switch to the 'mysql' system database (contains MySQL configuration tables)
USE mysql;

-- Show all tables in the current selected database
SHOW TABLES;

-- Select all records from a table named 'db' (commonly exists in 'mysql' database)
SELECT * FROM db;

-- Show the structure/schema of the 'db' table
DESCRIBE db;

-- Create a new database named 'sql_intro'
CREATE DATABASE sql_intro;

-- Show all databases again to confirm creation of 'sql_intro'
SHOW DATABASES;

-- Switch to the newly created database
USE sql_intro;

-- Create a table named 'emp_details' with relevant columns
CREATE TABLE emp_details (
    Name VARCHAR(25),
    Age INT,
    Sex CHAR(1),
    doj DATE,
    city VARCHAR(15),
    salary FLOAT
);

-- View the structure/schema of the 'emp_details' table
DESCRIBE emp_details;

-- Insert 6 employee records into the 'emp_details' table
INSERT INTO emp_details
VALUES
('Alice Johnson', 28, 'F', '2020-03-15', 'New York', 75000.00),
('Bob Smith', 35, 'M', '2018-07-22', 'Los Angeles', 82000.50),
('Charlie Lee', 30, 'M', '2019-11-01', 'Chicago', 69500.75),
('Diana Prince', 26, 'F', '2021-06-10', 'Houston', 72000.00),
('Ethan Clark', 40, 'M', '2015-01-05', 'Phoenix', 91000.25),
('Fiona Davis', 32, 'F', '2017-09-17', 'Philadelphia', 78500.00);

-- Display all records from the 'emp_details' table
SELECT * FROM emp_details;

-- Show distinct values in the 'Sex' column
SELECT DISTINCT Sex FROM emp_details;

-- Count the number of employee names (non-NULL values)
SELECT COUNT(Name) AS count_name FROM emp_details;

-- Calculate the total salary of all employees
SELECT SUM(salary) FROM emp_details;

-- Calculate the average salary
SELECT AVG(salary) FROM emp_details;

-- Display selected columns (name, age, city) from employee records
SELECT name, age, city FROM emp_details;

-- Show records of employees whose age is greater than 30
SELECT * FROM emp_details WHERE age > 30;

-- Show name, sex, and city for female employees
SELECT name, sex, city FROM emp_details WHERE sex = 'F';

-- Show employees who are in either 'Chicago' or 'Asutin' (note: 'Asutin' might be a typo for 'Austin')
SELECT * FROM emp_details WHERE city = 'Chicago' OR city = 'Asutin';

-- Alternative syntax using IN clause
SELECT * FROM emp_details WHERE city IN ('Chicago', 'Asutin');

-- Select employees who joined between 2000 and 2010
SELECT * FROM emp_details WHERE doj BETWEEN '2000-01-01' AND '2010-12-31';

-- Group by sex and calculate total salary per gender
SELECT sex, SUM(salary) AS total_salary FROM emp_details GROUP BY sex;

-- Show all employees sorted by salary in descending order
SELECT * FROM emp_details ORDER BY salary DESC;

-- Perform a simple arithmetic operation
SELECT (10 + 20) AS addition;

-- Find the length of the string 'Bangladesh'
SELECT LENGTH('Bangladesh') AS total_len;

-- Repeat the character '@' 10 times
SELECT REPEAT('@', 10);

-- Convert the string 'Bangladesh' to uppercase
SELECT UPPER('Bangladesh');

-- Show the current system date
SELECT CURRENT_DATE();

-- Show the current system date and time
SELECT NOW();

# String functions

select upper('Bangladesh') as upper_case;

select character_length('Bangladesh') as total_len;

select concat('bangladesh', 'is', 'a', 'secular') as merged;

select name, sex, concat(name, ' ', age) as name_age from emp_details;

select reverse('Bangladesh');

select replace('Orange is a vegetable', 'vegetable', 'fruit');

select ltrim('          Bangladesh           ');

select position('fruit' in 'Orange is a fruit') as name;

select ascii('a');
