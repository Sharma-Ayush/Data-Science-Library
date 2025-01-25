/*
1978. Employees Whose Manager Left the Company

Table: Employees

+-------------+----------+
| Column Name | Type     |
+-------------+----------+
| employee_id | int      |
| name        | varchar  |
| manager_id  | int      |
| salary      | int      |
+-------------+----------+
In SQL, employee_id is the primary key for this table.
This table contains information about the employees, their salary, and the ID of their manager. Some employees do not have a manager (manager_id is null). 
 

Find the IDs of the employees whose salary is strictly less than $30000 and whose manager left the company. When a manager leaves the company, their information is deleted from the Employees table, but the reports still have their manager_id set to the manager that left.

Return the result table ordered by employee_id.
*/

--Schema:
Create table dbo.Employees (employee_id int, name varchar(20), manager_id int, salary int)
Truncate table Employees
insert into Employees (employee_id, name, manager_id, salary) values ('3', 'Mila', '9', '60301')
insert into Employees (employee_id, name, manager_id, salary) values ('12', 'Antonella', NULL, '31000')
insert into Employees (employee_id, name, manager_id, salary) values ('13', 'Emery', NULL, '67084')
insert into Employees (employee_id, name, manager_id, salary) values ('1', 'Kalel', '11', '21241')
insert into Employees (employee_id, name, manager_id, salary) values ('9', 'Mikaela', NULL, '50937')
insert into Employees (employee_id, name, manager_id, salary) values ('11', 'Joziah', '6', '28485')

--Solution:
Select employee_id
from dbo.Employees as E1
where salary < 30000 and NOT EXISTS(Select * from dbo.Employees as E2
									where E1.manager_id = E2.employee_id) and  E1.manager_id is not null
order by employee_id;
--or
Select E1.employee_id
from dbo.Employees as E1
	 left join dbo.Employees as E2 
		on E1.manager_id = E2.employee_id
where E2.employee_id is NULL and E1.manager_id is not null and E1.salary < 30000
order by E1.employee_id;