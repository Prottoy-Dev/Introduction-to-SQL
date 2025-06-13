-- Switch to the 'sql_iq' database to run subsequent queries and procedures
use sql_iq;

-- Display all columns and records from the 'players' table
select * from players;

-- Change the statement delimiter to allow creation of multi-line stored procedures
delimiter $$

-- Create a stored procedure named 'top_player'
-- It retrieves players from the 'players' table who have scored more than 6 goals
create procedure top_player()
begin
select name, country, goals
from players where goals>6;
End $$

-- Reset the statement delimiter to the default
delimiter ;

-- Execute the 'top_player' procedure to get the high goal scorers
call top_player();

-- Change delimiter again for another procedure definition
delimiter //

-- Create a procedure named 'sp_sortBySalary'
-- Takes an input parameter 'var' and returns top 'var' highest salaried employees
create procedure sp_sortBySalary(IN var int)
begin
select name, age, salary from emp_details
order by salary desc limit var;
end //

-- Reset the delimiter
delimiter ;

-- Execute the 'sp_sortBySalary' procedure with value 3 to return top 3 earners
call sp_sortBySalary(3);

-- Set a new delimiter to define another procedure
delimiter //

-- Create a procedure to update an employee's salary based on their name
-- Parameters: temp_name (name of employee), new_salary (updated salary value)
create procedure update_salary(IN temp_name varchar(20),in new_salary float)
begin
update emp_details set
salary = new_salary where name = temp_name;
end; //

-- Display all employee records (Note: 'emo_details' likely a typo; should be 'emp_details')
select * from emo_details;

-- Call the procedure to update Marry's salary to 80000
call update_salary('Marry', 80000);

-- Define delimiter for a procedure that returns an output
delimiter //

-- Create a procedure to count total number of female employees
-- Result will be stored in the output parameter Total_Emps
create procedure sp_CountEmployees(OUT Total_Emps int)
begin
select count(name) into Total_Emps from emp_details
where sex='F';
end //

-- Reset the delimiter
delimiter ;

-- Call the procedure and store the result in user-defined session variable
call sp_CountEmployess(@F_emp);

-- Display the value stored in @f_emp, representing total female employees
select @f_emp as female_emps;

-- Create a 'student' table to store student data including marks
create table student
(st_roll int, age int, name varchar(30), mark float);

-- Define a delimiter to allow creation of a trigger
delimiter //

-- Create a BEFORE INSERT trigger on 'student' table
-- If marks inserted are negative, replace them with default value 50
create trigger  marks_verify_st
before insert on student
for each row
if new.marks < 0 then set new.mark=50;
end if; //

-- Insert records into the student table
-- Two of them have invalid negative marks, which should be corrected by the trigger
insert into student values
(501, 10, "Ruth", 75.0),
(502, 12, 'Mike', -20.0),
(503, 13, 'Dave', 90.0),
(504, 10, 'Jacobs', -12.5);

-- Retrieve all student records to verify the trigger functionality
select * from student; 

-- Remove the trigger to stop automatic mark correction on insert
drop trigger marks_verify_st;

-- Switch to the 'classicmodels' database
use classicmodels;

-- Display all customer records
select * from customers;

-- Create a view named 'cust_details'
-- This view shows customer name, phone number, and city only
create view cust_details 
as 
select customerName, phone, city
from customers;

-- View the records in the created 'cust_details' view
select * from cust_details;

-- Display all product line records
select * from productlines;

-- Create a view named 'product_description'
-- It joins 'products' and 'productlines' tables to show product info and descriptions
create view product_description
as 
select productName, quantityinstock, msrp, textdescription
from products as p inner join productlines as pl
on p.productline = pl.productline;

-- View data from the 'product_description' view
select * from product_description;

-- Rename the view from 'product_description' to 'vehicle_description'
rename table product_description
to vehicle_description;

-- Show all views currently available in the database
show full tables
where table_type = 'VIEW';

-- Delete the view 'cust_details'
drop view cust_details;

-- ========================================================
--           WINDOW FUNCTIONS AND ANALYTICS
-- ========================================================

-- View all employee records
select * from employees;

-- Use window function SUM() to calculate total salary for each department
select emp_name, age, dept,
sum(salary) over (partition by dept) as total_salary
from employees;

-- ========================================================
--              ROW NUMBER FUNCTION
-- ========================================================

-- Use row_number() to assign row indices ordered by salary
select row_number() over(order by salary) as row_num,
emp_name, salary from employees order by salary;

-- Create a demo table with sample student records (some duplicates)
create table demo(st_id int, st_name varchar(20));

-- Insert values into demo table
insert into demo values
(101, 'Shame'),
(102, 'Bradley'),
(103, 'Herath'),
(103, 'Herath'),
(104, 'Nethan'),
(105, 'Kevin'),
(105, 'Kevin');

-- Display all records from the 'demo' table
select * from demo;

-- Use row_number() to uniquely identify duplicates based on partition of st_id and st_name
select st_id, st_name, row_number() over
(partition by st_id, st_name order by st_id) as row_num
from demo;

-- ========================================================
--              RANK FUNCTION
-- ========================================================

-- Create a simple demo table for ranking
create table demo1(var_a int);

-- Insert sample numeric values
insert into demo1 value
(101),(102),(103),(104),(105),(106),(107);

-- Use rank() to assign ranks based on value order
select var_a,
rank() over(order by var_a) as test_rank
from demo1;

-- ========================================================
--           FIRST_VALUE() FUNCTION
-- ========================================================

-- Use first_value() to return the name of the highest paid employee (overall)
select emp_name, age, salary, first_value(emp_name)
over(order by salary desc) as highest_salary from employees;

-- Use first_value() per department to get the top earning employee in each dept
select emp_name, dept, salary, first_value(emp_name)
over (partition by dept order by salary desc) as highest_salary
from employees;
