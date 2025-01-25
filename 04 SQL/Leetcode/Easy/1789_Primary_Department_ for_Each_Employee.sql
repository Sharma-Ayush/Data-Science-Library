/*
1789. Primary Department for Each Employee

Table: Employee

+---------------+---------+
| Column Name   |  Type   |
+---------------+---------+
| employee_id   | int     |
| department_id | int     |
| primary_flag  | varchar |
+---------------+---------+
(employee_id, department_id) is the primary key for this table.
employee_id is the id of the employee.
department_id is the id of the department to which the employee belongs.
primary_flag is an ENUM of type ('Y', 'N'). If the flag is 'Y', the department is the primary department for the employee. If the flag is 'N', the department is not the primary.
 

Employees can belong to multiple departments. When the employee joins other departments, they need to decide which department is their primary department. Note that when an employee belongs to only one department, their primary column is 'N'.

Write an SQL query to report all the employees with their primary department. For employees who belong to one department, report their only department.

Return the result table in any order.
*/

--Schema:
Create table dbo.Employee (employee_id int, department_id int, primary_flag char(1) check(primary_flag in('Y','N')))
Truncate table Employee
insert into Employee (employee_id, department_id, primary_flag) values ('1', '1', 'N')
insert into Employee (employee_id, department_id, primary_flag) values ('2', '1', 'Y')
insert into Employee (employee_id, department_id, primary_flag) values ('2', '2', 'N')
insert into Employee (employee_id, department_id, primary_flag) values ('3', '3', 'N')
insert into Employee (employee_id, department_id, primary_flag) values ('4', '2', 'N')
insert into Employee (employee_id, department_id, primary_flag) values ('4', '3', 'Y')
insert into Employee (employee_id, department_id, primary_flag) values ('4', '4', 'N')

--Solution:
with cte1 as
(
Select employee_id, sum(case primary_flag when 'Y' then 1 else 0 end) as int_flag, count(*) as row_count
from dbo.Employee
group by employee_id
)
Select employee_id, department_id 
from dbo.Employee
where primary_flag = 'Y'
UNION
Select employee_id, department_id 
from dbo.Employee as E1
where employee_id in (Select employee_id from cte1 where int_flag = 0 and row_count = 1)
order by employee_id;
--or
with cte1 as
(
Select employee_id, sum(case primary_flag when 'Y' then 1 else 0 end) as int_flag, count(*) as row_count
from dbo.Employee
group by employee_id
), cte2 as
(
Select E.*, case 
			when E.primary_flag = 'Y' and c.int_flag = 1 then 1
			when E.primary_flag = 'N' and c.int_flag = 0 and c.row_count = 1 then 1
			else 0 end as filter
from dbo.Employee as E
	 inner join cte1 as c
		on E.employee_id = c.employee_id
)
Select employee_id, department_id
from cte2
where filter = 1
order by employee_id;