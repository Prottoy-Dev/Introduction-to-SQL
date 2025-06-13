-- list all available databases
show databases;

-- select the working database
use sql_intro;

-- show all tables in the selected database
show tables;

-- display all records from the employees table
select * from employees;

-- select employee name, department, and salary for those earning below average salary
select emp_name, dept, salary 
from employees 
where salary < (
    select avg(salary) from employees
);

-- create a table to store product details
create table products (
    prod_id int,
    item varchar(30),
    sell_price float, 
    product_type varchar(30)
);

-- insert sample products into the products table
insert into products values
(1, 'laptop', 799.99, 'electronics'),
(2, 'coffee maker', 59.99, 'home appliance'),
(3, 'wireless mouse', 25.50, 'accessories'),
(4, 'office chair', 149.00, 'furniture'),
(5, 'smartphone', 699.00, 'electronics'),
(6, 'notebook', 2.99, 'stationery'),
(7, 'led monitor', 199.99, 'electronics'),
(8, 'water bottle', 15.25, 'kitchenware'),
(9, 'backpack', 45.00, 'accessories'),
(10, 'table lamp', 35.75, 'home decor');

-- view all products
select * from products;

-- create a table to store orders based on products sold
create table orders (
    order_id int, 
    product_sold varchar(30),
    selling_price float
);

-- insert products with a sell price greater than 100 into the orders table
insert into orders 
select prod_id, item, sell_price
from products 
where prod_id in (
    select prod_id from products where sell_price > 100
);

-- view all orders
select * from orders;

-- display all employees
select * from employees;

-- update employee salary to 35% of current salary where age matches employees_b and is greater than 30
update employees
set salary = salary * 0.35
where age in (
    select age from employees_b where age > 30
);

-- delete employees whose age is less than or equal to 32 and matches age in employees_b
delete from employees 
where age in (
    select age from employees_b where age <= 32
);
