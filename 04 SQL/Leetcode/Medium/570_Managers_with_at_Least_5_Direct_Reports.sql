/*
570. Managers with at Least 5 Direct Reports

Table: Employee

+-------------+---------+
| Column Name | Type    |
+-------------+---------+
| id          | int     |
| name        | varchar |
| department  | varchar |
| managerId   | int     |
+-------------+---------+
In SQL, id is the primary key column for this table.
Each row of this table indicates the name of an employee, their department, and the id of their manager.
If managerId is null, then the employee does not have a manager.
No employee will be the manager of themself.
 

Find the managers with at least five direct reports.

Return the result table in any order.
*/

--Schema:
Create table dbo.Employee (id int, name varchar(255), department varchar(255), managerId int)
Truncate table Employee
insert into Employee (id, name, department, managerId) values ('101', 'John', 'A', NULL)
insert into Employee (id, name, department, managerId) values ('102', 'Dan', 'A', '101')
insert into Employee (id, name, department, managerId) values ('103', 'James', 'A', '101')
insert into Employee (id, name, department, managerId) values ('104', 'Amy', 'A', '101')
insert into Employee (id, name, department, managerId) values ('105', 'Anne', 'A', '101')
insert into Employee (id, name, department, managerId) values ('106', 'Ron', 'B', '101')

--Solution:
Select name
from dbo.Employee
where id in (Select managerId 
			 from dbo.Employee 
			 where managerId is not null 
			 group by managerId 
			 having count(*) >= 5);
--or
Select E1.name
from dbo.Employee as E1
	 inner join dbo.Employee as E2
		on E1.id = E2.managerId
group by E1.id, E1.name
having count(E2.id) >= 5;