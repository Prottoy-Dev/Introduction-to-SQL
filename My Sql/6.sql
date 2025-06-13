-- Switch to the database named 'sql_intro'
use sql_intro;

-- Show all tables in the current database
show tables;

-- Select all columns and rows from the 'employees' table
select * from employees;

-- Select employee name, department, and salary for employees
-- whose salary is greater than the average salary of all employees
select emp_name, dept, salary
from employees
where salary > (select avg(salary) from employees);

-- Select employee name, gender, department, and salary for employees
-- whose salary is greater than that of 'Fiona Davis'
select emp_name, gender, dept, salary
from employees
where salary > (select salary from employees where emp_name = 'Fiona Davis');

-- Show all databases available on the MySQL server
show databases;

-- Switch to the database named 'classicmodels'
use classicmodels;

-- Select all records from the 'products' table
select * from products;

-- Select all records from the 'orderdetails' table
select * from orderdetails;

-- Select product code, product name, and MSRP from products
-- where the product code is found in the orderdetails table
-- with price each less than 100
select productcode, productname, msrp from products
where productcode in (
  select productcode from orderdetails
  where priceeach < 100
);
