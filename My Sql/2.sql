show databases;
use sql_intro;
show tables;
create table employees(
Emp_Id int primary key, 
Emp_name varchar(25),
Age int,
Gender char(1),
Doj date,
Dept varchar(20),
City varchar(15),
Salary float
);

describe employees;

insert into employees values
(101, 'Alice Johnson', 28, 'F', '2020-03-15', 'HR', 'New York', 75000.00),
(102, 'Bob Smith', 35, 'M', '2018-07-22', 'IT', 'Los Angeles', 82000.50),
(103, 'Charlie Lee', 30, 'M', '2019-11-01', 'Finance', 'Chicago', 69500.75),
(104, 'Diana Prince', 26, 'F', '2021-06-10', 'Marketing', 'Houston', 72000.00),
(105, 'Ethan Clark', 40, 'M', '2015-01-05', 'Sales', 'Phoenix', 91000.25),
(106, 'Fiona Davis', 32, 'F', '2017-09-17', 'HR', 'Philadelphia', 78500.00),
(107, 'George Allen', 29, 'M', '2022-04-18', 'IT', 'San Diego', 76500.00),
(108, 'Helen Brooks', 31, 'F', '2020-08-12', 'Finance', 'Dallas', 80000.00),
(109, 'Ian Thomas', 27, 'M', '2023-01-20', 'Marketing', 'Austin', 73000.00),
(110, 'Julia White', 38, 'F', '2016-03-03', 'Sales', 'San Jose', 86000.00);

select * from employees;

select distinct city from employees;
select distinct dept from employees;
select avg(age) from employees;

select dept, round(avg(age),2) as average_age from employees group by dept;

select dept, sum(salary) as total_salaray from employees group by dept;

select count(emp_id), city from employees 
group by city
order by count(emp_id) desc;

select year(doj) as year, count(emp_id)
from employees
group by year(doj);

create table sales (
product_id int,
sell_price float, 
quantity int, 
state varchar(20)
);
INSERT INTO sales VALUES
(201, 299.99, 10, 'California'),
(202, 199.99, 5, 'Texas'),
(203, 299.99, 8, 'California'),
(204, 149.50, 12, 'Florida'),
(205, 199.99, 7, 'Texas'),  
(206, 99.99, 15, 'New York'),
(207, 149.50, 6, 'Florida'),      
(208, 299.99, 4, 'Nevada');  

select * from sales;

select product_id, sum(sell_price*quantity) as revenue
from sales group by product_id;

create table c_product(
product_id int,
cost_price float
);
insert into c_product values
(204,270.0),
(208, 250.0);

select c.product_id, sum((s.sell_price - c.cost_price) * s.quantity) as profit
from sales as s inner join c_product as c
where s.product_id = c.product_id
group by c.product_id;

select * from employees;

select dept, avg(salary) as avg_salary
from employees
group by dept
having avg(salary)>75000.0;

select city, sum(salary) as total
from employees
group by city
having sum(salary) > 20000;

select dept, count(*) as emp_count
from employees
group by dept
having count(*)>2;

select city, count(*) as emp_count
from employees
where city != "Chicago"
group by city
having count(*)>0;

select dept, count(*) as emp_count
from employees
group by dept
having avg(salary)>75000;