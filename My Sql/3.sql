-- Create a new database named 'sql_joins'
CREATE DATABASE sql_joins;

-- Show all available databases
SHOW DATABASES;

-- Switch to the 'sql_joins' database
USE sql_joins;

-- Create 'cricket' table with auto-incremented primary key
CREATE TABLE cricket (
  cricket_id INT AUTO_INCREMENT,
  name VARCHAR(30),
  PRIMARY KEY (cricket_id)
);

-- Create 'football' table with auto-incremented primary key
CREATE TABLE football (
  football_id INT AUTO_INCREMENT,
  name VARCHAR(30),
  PRIMARY KEY (football_id)
);

-- Insert sample player names into the 'cricket' table
INSERT INTO cricket(name) VALUES
('Stuart'),
('Michael'),
('Johnson'),
('Hayden'),
('fleming');

-- Display all rows from the 'cricket' table
SELECT * FROM cricket;

-- Insert sample player names into the 'football' table
INSERT INTO football (name) VALUES
('Stuart'),
('Johnson'),
('Hayden'),
('Langer'),
('Astle');

-- Display all rows from the 'football' table
SELECT * FROM football;

-- Perform INNER JOIN to get players common to both 'cricket' and 'football'
SELECT c.cricket_id, c.name, f.football_id, f.name
FROM cricket AS c 
INNER JOIN football AS f 
ON c.name = f.name;

-- Switch to the classicmodels sample database
USE classicmodels;

-- Show all available tables in 'classicmodels'
SHOW TABLES;

-- Display all rows from the 'products' table
SELECT * FROM products;

-- Display all rows from the 'productlines' table
SELECT * FROM productlines;

-- Join 'products' with 'productlines' using the common column 'productline'
SELECT productcode, productname, textdescription
FROM products
INNER JOIN productlines 
USING (productline);

-- Display all rows from the 'orders' table
SELECT * FROM orders;

-- Display all rows from the 'orderdetails' table
SELECT * FROM orderdetails;

-- Calculate total revenue for each order by joining 'orders', 'orderdetails', and 'products'
SELECT o.ordernumber, o.status, p.productname,
       SUM(quantityordered * priceeach) AS revenue
FROM orders AS o
INNER JOIN orderdetails AS od 
ON od.ordernumber = o.ordernumber
INNER JOIN products AS p 
ON p.productcode = od.productcode
GROUP BY ordernumber;

-- Display all rows from the 'customers' table
SELECT * FROM customers;

-- Display all rows from the 'orders' table
SELECT * FROM orders;

-- LEFT JOIN to find customers who haven't placed any orders
SELECT c.customernumber, c.customername, ordernumber, status
FROM customers AS c 
LEFT JOIN orders AS o 
ON c.customernumber = o.customernumber
WHERE ordernumber IS NULL;

-- Display all rows from the 'customers' table again
SELECT * FROM customers;

-- Display all rows from the 'employees' table
SELECT * FROM employees;

-- RIGHT JOIN to list all employees, including those not assigned as sales reps to any customer
SELECT c.customername, c.phone, e.employeenumber, e.email
FROM customers AS c 
RIGHT JOIN employees AS e
ON e.employeenumber = c.salesrepemployeenumber
ORDER BY employeenumber;

-- (Fixing mistake) This table doesn't exist: 'employeenumber' is a column, not a table
-- The correct query is below for manager-employee relationship

-- SELF JOIN to list employees and their managers
SELECT CONCAT(m.lastname, ',', m.firstname) AS manager,
       CONCAT(e.lastname, ',', e.firstname) AS employee
FROM employees AS e
INNER JOIN employees AS m 
ON m.employeenumber = e.reportsto
ORDER BY manager;

-- FULL OUTER JOIN alternative using UNION: combine LEFT and RIGHT joins on 'customers' and 'orders'
SELECT c.customername, o.ordernumber 
FROM customers AS c
LEFT JOIN orders AS o 
ON c.customernumber = o.customernumber
UNION
SELECT c.customername, o.ordernumber 
FROM customers AS c
RIGHT JOIN orders AS o 
ON c.customernumber = o.customernumber;
