/*
1075. Project Employees I

Table: Project

+-------------+---------+
| Column Name | Type    |
+-------------+---------+
| project_id  | int     |
| employee_id | int     |
+-------------+---------+
(project_id, employee_id) is the primary key of this table.
employee_id is a foreign key to Employee table.
Each row of this table indicates that the employee with employee_id is working on the project with project_id.
 

Table: Employee

+------------------+---------+
| Column Name      | Type    |
+------------------+---------+
| employee_id      | int     |
| name             | varchar |
| experience_years | int     |
+------------------+---------+
employee_id is the primary key of this table. It's guaranteed that experience_years is not NULL.
Each row of this table contains information about one employee.
 

Write an SQL query that reports the average experience years of all the employees for each project, rounded to 2 digits.

Return the result table in any order.
*/

--Schema:
Create table dbo.Project (project_id int, employee_id int)
Create table dbo.Employee (employee_id int, name varchar(10), experience_years int)
Truncate table Project
insert into Project (project_id, employee_id) values ('1', '1')
insert into Project (project_id, employee_id) values ('1', '2')
insert into Project (project_id, employee_id) values ('1', '3')
insert into Project (project_id, employee_id) values ('2', '1')
insert into Project (project_id, employee_id) values ('2', '4')
Truncate table Employee
insert into Employee (employee_id, name, experience_years) values ('1', 'Khaled', '3')
insert into Employee (employee_id, name, experience_years) values ('2', 'Ali', '2')
insert into Employee (employee_id, name, experience_years) values ('3', 'John', '1')
insert into Employee (employee_id, name, experience_years) values ('4', 'Doe', '2')

--Solution:
Select P.project_id, CAST(ROUND(AVG(CAST(E.experience_years as decimal(4,2)))), 2) as decimal(4,2)) as average_years
from dbo.Project as P
	 inner join dbo.Employee as E
		on P.employee_id = E.employee_id
group by P.project_id;
--or 
Select project_id, (Select CAST(ROUND(AVG(CAST(E.experience_years as decimal(4,2))), 2) as decimal(4,2)) 
					from dbo.Employee as E where E.employee_id in (Select P1.employee_id 
																   from dbo.Project as P1
																   where P1.project_id = P2.project_id)) as average_years
from dbo.Project as P2
group by project_id;