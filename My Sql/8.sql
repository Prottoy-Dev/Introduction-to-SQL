use sql_intro;
show tables;
select * from employees;
select dept, min(salary) as lowest_salary from employees group by dept;
select distinct dept from employees;
select distinct dept, length(dept) as dept_len from employees;
select datediff("2021-06-10", "2021-05-31") as total_days;
select datediff(now(), '2021-04-20');
select dept, count(emp_id) as total_emp from employees group by dept having count(emp_id)>1;
select * from employees where dept <> "Marketing";
select * from employees where dept != "Marketing";
select * from employees where doj >"2005-05-31" and doj < "2010--03-31";
select * from (select * from employees order by salary desc limit 3) as t order by salary limit 1;
select * from employees where emp_id % 2 = 0;
with CTE as 
(
		select *, row_number() over(order by emp_id) as rn
        from employees
)
select * from cte where rn % 2 = 0;
select * from dup_employees;

select e_id, name, age, count(*) as dup_count from dup_employees
group by e_id, name, age
having count(e_id) > 1 and count(name) > 1 and count(age) > 1;

select * from employees;
select length(replace(upper(emp_name), 'A', '')) from employees;

select * from employees
where length(emp_name) - length(replace(upper(emp_name), 'A', '')) = 2;

select substr("Michael Ballack", 2, 4);
select substr("Michael Ballack", 4, 3);



