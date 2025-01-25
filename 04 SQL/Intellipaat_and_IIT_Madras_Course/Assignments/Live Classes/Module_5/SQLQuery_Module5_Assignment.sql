----------------Module 5 Assignment--------------------
/*
Problem statement:
You have successfully cleared your 4th semester.
In the 5th semester you will work with group by, having by clauses and set operators
*/

--Task to be done:
--1. Arrange the ‘Orders’ dataset in decreasing order of amount
Select * from Orders order by amount DESC

--2. Create a table with name ‘Employee_details1’ and comprising of these columns – ‘Emp_id’, ‘Emp_name’, ‘Emp_salary’.
--Create another table with name ‘Employee_details2’, which comprises of same columns as first table.
create table Employee_details1 (Emp_id int, Emp_name varchar(20), Emp_salary money)
create table Employee_details2 (Emp_id int, Emp_name varchar(20), Emp_salary money)

insert into Employee_details1 values (1, 'Ayush', 70000),(2,'Ayushi',100000),(3,'Abhinav',120000)
insert into Employee_details2 values (1, 'Ayush', 70000),(2,'Ayushi',100000),(4,'Mukesh',150000),(5,'Indu',180000)

Select * from Employee_details1
Select * from Employee_details2

--3. Apply the union operator on these two tables
Select * from Employee_details1
union
Select * from Employee_details2

--4. Apply the intersect operator on these two tables
Select * from Employee_details1
intersect
Select * from Employee_details2

--5. Apply the except operator on these two tables
Select * from Employee_details1
except
Select * from Employee_details2