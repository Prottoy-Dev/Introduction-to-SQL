-- Create the 'triggers' database and switch to it
create database triggers;
use triggers;

-- View tables in the database
show tables;

-- Create 'customers' table with columns: cust_id, age, name
create table customers(
    cust_id int,
    age int,
    name varchar(30)
);

-- Create a trigger to prevent negative ages before inserting into 'customers'
delimiter //
create trigger age_verify
before insert on customers
for each row 
if new.age < 0 then 
    set new.age = 0;  -- Set age to 0 if a negative value is inserted
end if; //
delimiter ;

-- Insert data into 'customers', includes negative ages to test trigger
insert into customers values
(101, 27, "James"),
(102, -40, "Ammy"),
(103, 32, "Ben"),
(104, -39, "Angela");

-- Display data from 'customers' to verify trigger execution
select * from customers;

-- Create 'customers1' table to store user details including optional birthdate
create table customers1(
    id int auto_increment primary key,
    name varchar(40) not null,
    email varchar(30),
    birthdate date
);

-- Create 'message' table to store notification messages
create table message(
    id int auto_increment,
    messageId int,
    message varchar(300) not null,
    primary key(id, messageId)
);

-- Create a trigger that sends a message if 'birthdate' is missing during insert
delimiter //
create trigger check_null_dob
after insert on customers1
for each row
begin
    if new.birthdate is null then
        insert into message(messageId, message)
        values (new.id, concat('Hi ', new.name, ' please update your date of birth.'));
    end if;
end //
delimiter ;

-- Insert sample users into 'customers1', some with null birthdates
insert into customers1(
    name,
    email, 
    birthdate
)
values
('Nancy', 'nancy@abc.com', NULL),
('Ronald', 'ronald@xyz.com', '1998-12-16'),
('Chris', 'chris@xyz.com', '1997-08-20'),
('Alice', 'alice@anc.com', NULL);

-- View messages generated by the 'check_null_dob' trigger
select * from message;

-- Create 'employees' table to store employee data
create table employees(
    emp_id int primary key,
    emp_name varchar(25),
    age int,
    salary float
);

-- Insert employee records
insert into employees values
(1, 'Alice Johnson', 30, 55000.00),
(2, 'Bob Smith', 45, 72000.50),
(3, 'Carol Davis', 28, 48000.75),
(4, 'David Wilson', 35, 64000.00),
(5, 'Eve Thompson', 40, 70000.25);

-- Create a trigger to adjust salary values before update
-- If salary = 10000, it becomes 85000
-- If salary < 10000, it becomes 72000
delimiter //
create trigger upd_trigger
before update
on employees
for each row
begin
    if new.salary = 10000 then
        set new.salary = 85000;
    elseif new.salary < 10000 then
        set new.salary = 72000;
    end if;
end //
delimiter ;

-- Update salaries to test the 'upd_trigger'
update employees
set salary = 8000;

-- Check updated employee data
select * from employees;

-- Create 'salary' table to store salary history
create table salary(
    eid int primary key,
    validfrom date not null,
    amount float not null
);

-- Insert sample salary records
insert into salary(eid, validfrom, amount) values 
(101, '2023-01-01', 50000.00),
(102, '2023-02-15', 60000.00),
(103, '2023-03-10', 45000.00),
(104, '2023-04-01', 70000.00),
(105, '2023-05-20', 80000.00);

-- View current salary records
select * from salary;

-- Drop 'salarydel' table if it already exists
DROP TABLE IF EXISTS salarydel;

-- Create 'salarydel' table to log deleted salary records
create table salarydel(
    id int primary key auto_increment,
    eid int, 
    validfrom date not null,
    amount float not null,
    deletedat timestamp default now()
);

-- Create a trigger to log deletions from 'salary' into 'salarydel'
delimiter $$
create trigger salary_delete
before delete
on salary
for each row
begin
    insert into salarydel(eid, validfrom, amount) 
    value(old.eid, old.validfrom, old.amount);
end$$
delimiter ;

-- Delete a salary record to trigger the logging mechanism
delete from salary
where eid = 103;

-- View contents of 'salarydel' to confirm trigger action
select * from salarydel;
