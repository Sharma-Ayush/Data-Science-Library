/*
181. Employees Earning More Than Their Managers

Table: Employee

+-------------+---------+
| Column Name | Type    |
+-------------+---------+
| id          | int     |
| name        | varchar |
| salary      | int     |
| managerId   | int     |
+-------------+---------+
id is the primary key column for this table.
Each row of this table indicates the ID of an employee, their name, salary, and the ID of their manager.
 

Write an SQL query to find the employees who earn more than their managers.

Return the result table in any order.

The query result format is in the following example.
*/

--Solution:
Select E1.name as Employee
from dbo.Employee as E1
where E1.salary > (Select E2.salary 
				   from dbo.Employee as E2
				   where E2.id = E1.managerID);

--or
Select E1.name as Employee
from dbo.Employee as E1
	 inner join dbo.Employee as E2
		on E1.managerId = E2.id and E1.salary > E2.salary;