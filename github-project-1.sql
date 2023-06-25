create table employee
( emp_ID int
, emp_NAME varchar(50)
, DEPT_NAME varchar(50)
, SALARY int);

insert into employee values(101, 'Mohan', 'Admin', 4000);
insert into employee values(102, 'Rajkumar', 'HR', 3000);
insert into employee values(103, 'Akbar', 'IT', 4000);
insert into employee values(104, 'Dorvin', 'Finance', 6500);
insert into employee values(105, 'Rohit', 'HR', 3000);
insert into employee values(106, 'Rajesh',  'Finance', 5000);
insert into employee values(107, 'Preet', 'HR', 7000);
insert into employee values(108, 'Maryam', 'Admin', 4000);
insert into employee values(109, 'Sanjay', 'IT', 6500);
insert into employee values(110, 'Vasudha', 'IT', 7000);
insert into employee values(111, 'Melinda', 'IT', 8000);
insert into employee values(112, 'Komal', 'IT', 10000);
insert into employee values(113, 'Gautham', 'Admin', 2000);
insert into employee values(114, 'Manisha', 'HR', 3000);
insert into employee values(115, 'Chandni', 'IT', 4500);
insert into employee values(116, 'Satya', 'Finance', 6500);
insert into employee values(117, 'Adarsh', 'HR', 3500);
insert into employee values(118, 'Tejaswi', 'Finance', 5500);
insert into employee values(119, 'Cory', 'HR', 8000);
insert into employee values(120, 'Monica', 'Admin', 5000);
insert into employee values(121, 'Rosalin', 'IT', 6000);
insert into employee values(122, 'Ibrahim', 'IT', 8000);
insert into employee values(123, 'Vikram', 'IT', 8000);
insert into employee values(124, 'Dheeraj', 'IT', 11000);

select * from employee;

-- Using Aggregate function as Window Function
-- Without window function, SQL will reduce the no of records.
select dept_name, max(salary) from employee
group by dept_name;


--###############################Practice##############################

--How many employees are there in the table?
select count(*) from employee

--What is the name of the employee with emp_id 103?
select emp_name from employee where emp_id = 103

--Which department does Rajesh belong to?
select dept_name from employee where emp_name = 'Rajesh'

--What is the salary of employee Preet?
select salary from employee where emp_name='Preet'

--How many employees work in the HR department?
select count(*) as total from employee where dept_name= 'HR' group by dept_name

--List the names of employees who have a salary of 4000.
select emp_name from employee where salary = 4000

--Which department has the highest average salary?
select dept_name from employee group by dept_name order by avg(salary) desc limit 1

--What is the total salary expense of the company?
select sum(salary) from employee

--Who is the highest-paid employee?
select emp_name from employee order by salary desc limit 1

--How many employees have the same salary of 6500?
select count(emp_name) from employee where salary = 6500

--What is the average salary of employees in the IT department?
select avg(salary) from employee where dept_name = 'IT'

--List the names of employees who belong to either the Admin or HR departments.
select emp_name from employee where dept_name in ('IT','Admin')

--Which department has the lowest number of employees?
----------------------Method 1
SELECT dept_name FROM employee GROUP BY dept_name ORDER BY COUNT(*) ASC LIMIT 1;

----------------------Method 2: Using window function
with cte as(
	select dept_name, count(dept_name) over(PARTITION by dept_name) as rnk 
from employee order by rnk, dept_name limit 1)
select dept_name from cte

--How many employees have a salary greater than 5000?
select count(*) from employee where salary > 5000

--Who is the employee with the highest salary in the Admin department?
select * from employee where dept_name= 'Admin' order by salary desc limit 1

--List the names of employees whose names start with the letter 'M'
select emp_name from employee where emp_name like 'M%'

--How many distinct departments are there in the table?
SELECT COUNT(DISTINCT dept_name) FROM employee;

--What is the total salary expense for each department?
select dept_name, sum(salary) from employee group by dept_name

--List the employees in descending order of their salaries
select emp_name, salary from employee order by salary desc

--What is the average salary of employees whose names contain the letter 'a'?
select avg(salary) from employee where emp_name like '%a%'

--How many departments have an average salary greater than 4000?
select count(*) from employee group by dept_name having avg(salary) > 4000 

--What is the maximum salary among departments with fewer than 5 employees?
select max(salary) from employee group by dept_name having count(*)<5

--Which department(s) have the highest total salary?
select dept_name, max(salary) as max from employee group by dept_name order by max desc limit 1

--Which department(s) have more than two employees with a salary greater than 5000?
select dept_name from employee where salary>5000 group by dept_name having count(*)>2

--Which department(s) have an employee with the highest salary?
select dept_name from employee where salary =(select max(salary) from employee)

--Which department(s) have at least one employee with a salary greater than 8000 and
--at least one employee with a salary less than 3000?
SELECT dept_name FROM employee WHERE salary > 8000 union SELECT dept_name FROM employee WHERE salary < 3000;

--Which department has the highest total salary expense?
select dept_name from employee group by dept_name order by sum(salary) desc limit 1

--List the top 3 departments with the highest average salary.
select dept_name from employee group by dept_name order by avg(salary) desc limit 3

--How many employees have a salary above the average salary of their respective departments?
SELECT COUNT(*) FROM employee e
	WHERE salary > ( SELECT AVG(salary) FROM employee WHERE dept_name = e.dept_name );
--using window function
select count(*) from 
	(select *, avg(salary) over(PARTITION by dept_name) as rnk from employee) as cte where salary > rnk

--List the employees who have a salary greater than the average salary of their departments.
select emp_name from 
	(select *, avg(salary) over(PARTITION by dept_name) as rnk from employee) as cte where salary > rnk
	
--What is the salary difference between the highest-paid and lowest-paid employees?
select max(salary)-min(salary) as difference from employee

--List the departments along with the number of employees working in each department, 
--	sorted in descending order of the employee count.
select dept_name, count(emp_name) as emp_cnt from employee group by dept_name order by emp_cnt desc

--Who are the employees with salaries within the top 10% of the salary range?
SELECT emp_name, salary FROM employee
	WHERE salary > (SELECT 0.9 * MAX(salary) FROM employee) ORDER BY salary DESC;

--List the employees who have the same salary as the highest-paid employee in their respective departments.
SELECT emp_name FROM employee e
	WHERE salary = (SELECT MAX(salary) FROM employee WHERE dept_name = e.dept_name);

--Which department(s) have more than one employee with the same salary?
SELECT dept_name FROM employee GROUP BY dept_name HAVING COUNT(*) > COUNT(DISTINCT salary);

--What is the average salary of employees in each department?
select avg(salary) from employee group by dept_name;

--Which department has the highest number of employees?
select dept_name from employee group by dept_name order by count(*) desc limit 1;

--Who are the employees whose names contain the letter 'a' and have a salary greater than 4000?
select * from employee where emp_name like '%a%' and salary > 4000;

--List the employees in alphabetical order of their names within each department.
select * from employee order by dept_name, emp_name;

--How many employees have the same salary and department as employee with emp_id 101?
select count(*) from employee 
	where dept_name = (select dept_name from employee where emp_id=101) and 
		salary = (select salary from employee where emp_id=101)

--List down the employee who's salary is higher than lowest salary of IT department
select emp_name, salary from employee where salary > (select min(salary) from employee where dept_name = 'IT' )

--How many employees have a salary that is a multiple of 1000(i.e., divisible by 1000 using modulus operator)?
select count(*) from employee where salary % 1000 = 0;

--What is the median salary among all employees?
SELECT salary FROM employee ORDER BY salary OFFSET (SELECT COUNT(*) FROM employee) / 2 LIMIT 1

--How many employees have a salary less than the median salary?
select count(*) from employee where salary < (SELECT salary FROM employee ORDER BY salary OFFSET (SELECT COUNT(*) FROM employee) / 2 LIMIT 1)

--What is the modulus of the salary for the employee with emp_id 113 when divided by 81?
select mod((select salary from employee where emp_id = 113),81)

--What is the mode (most frequent) salary among all employees?
SELECT salary FROM employee GROUP BY salary HAVING COUNT(*) = (SELECT MAX(salary_count) FROM
	(SELECT salary, COUNT(*) AS salary_count FROM employee GROUP BY salary) AS subquery);
	
	
	
	
-------------####################Window function################--------------
-- By using MAX as an window function, SQL will not reduce records but the result will be shown corresponding to each record.
select e.*,
max(salary) over(partition by dept_name) as max_salary
from employee e;


-- row_number(), rank() and dense_rank()
select e.*,
row_number() over(partition by dept_name) as rn
from employee e;


-- Fetch the first 2 employees from each department to join the company.
select * from (
	select e.*,
	row_number() over(partition by dept_name order by emp_id) as rn
	from employee e) x
where x.rn < 3;


-- Fetch the top 3 employees in each department earning the max salary.
select * from (
	select e.*,
	rank() over(partition by dept_name order by salary desc) as rnk
	from employee e) x
where x.rnk < 4;

-- Checking the different between rank, dense_rnk and row_number window functions:
select e.*,
rank() over(partition by dept_name order by salary desc) as rnk,
dense_rank() over(partition by dept_name order by salary desc) as dense_rnk,
row_number() over(partition by dept_name order by salary desc) as rn
from employee e;

-------------- lead and lag-------------

-- fetch a query to display if the salary of an employee is higher, lower or equal to the previous employee.
select e.*,
lag(salary) over(partition by dept_name order by emp_id) as prev_empl_sal,
case when e.salary > lag(salary) over(partition by dept_name order by emp_id) then 'Higher than previous employee'
     when e.salary < lag(salary) over(partition by dept_name order by emp_id) then 'Lower than previous employee'
	 when e.salary = lag(salary) over(partition by dept_name order by emp_id) then 'Same than previous employee' end as sal_range
from employee e;

-- Similarly using lead function to see how it is different from lag.
select e.*,
lag(salary) over(partition by dept_name order by emp_id) as prev_empl_sal,
lead(salary) over(partition by dept_name order by emp_id) as next_empl_sal
from employee e;