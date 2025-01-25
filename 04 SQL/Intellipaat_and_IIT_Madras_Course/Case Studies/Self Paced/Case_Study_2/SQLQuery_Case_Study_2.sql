--SQL Case STUDY - 2

--Simple Queries:

--1. List all the employee details.
Select * 
from dbo.EMPLOYEE;

--2. List all the department details.
Select * 
from dbo.DEPARTMENT;

--3. List all job details.
Select * 
from dbo.JOB;

--4. List all the locations.
Select * 
from dbo.LOCATION;

--5. List out the First Name, Last Name, Salary, Commission for all Employees.
Select FIRST_NAME, LAST_NAME, SALARY, COMM 
from dbo.EMPLOYEE;

--6. List out the Employee ID, Last Name, Department ID for all employees and alias
--Employee ID as "ID of the Employee", Last Name as "Name of the
--Employee", Department ID as "Dep_id".
Select EMPLOYEE_ID as [ID of the Employee],
	   LAST_NAME as [Name of the Employee],
	   DEPARTMENT_ID as [Dep_id]
from dbo.EMPLOYEE;

--7. List out the annual salary of the employees with their names only.
Select SALARY * 12 as [Annaul Salary], 
       Concat(FIRST_NAME, ' ', MIDDLE_NAME, ' ',LAST_NAME) as [Full Name]  
from dbo.EMPLOYEE;

--WHERE Condition:

--1. List the details about "Smith".
Select * 
from dbo.EMPLOYEE 
where 'Smith' in (FIRST_NAME,LAST_NAME);

--2. List out the employees who are working in department 20.
Select * 
from dbo.EMPLOYEE 
where DEPARTMENT_ID = 20;

--3. List out the employees who are earning salaries between 3000 and 4500.
Select * 
from dbo.EMPLOYEE 
where SALARY between 3000 and 4500;

--4. List out the employees who are working in department 10 or 20.
Select * 
from dbo.EMPLOYEE 
where DEPARTMENT_ID in (10, 20);

--5. Find out the employees who are not working in department 10 or 30.
Select * 
from dbo.EMPLOYEE 
where DEPARTMENT_ID not in (10, 30) or DEPARTMENT_ID is NULL;

--6. List out the employees whose name starts with 'S'.
Select * 
from dbo.EMPLOYEE 
where FIRST_NAME like 'S%';

--7. List out the employees whose name starts with 'S' and ends with 'H'.
Select * 
from dbo.EMPLOYEE 
where FIRST_NAME like 'S%H';

--8. List out the employees whose name length is 4 and start with 'S'.
Select * 
from dbo.EMPLOYEE 
where FIRST_NAME like 'S___';

--9. List out employees who are working in department 10 and draw salaries more than 3500.
Select * 
from dbo.EMPLOYEE 
where DEPARTMENT_ID = 10 and SALARY > 3500;

--10. List out the employees who are not receiving commission.
Select * 
from dbo.EMPLOYEE
where COMM IS NULL or COMM = 0;

--ORDER BY Clause:
--1. List out the Employee ID and Last Name in ascending order based on the Employee ID.
Select EMPLOYEE_ID, LAST_NAME 
from dbo.EMPLOYEE
order by EMPLOYEE_ID;

--2. List out the Employee ID and Name in descending order based on salary.
Select EMPLOYEE_ID, Concat(FIRST_NAME, ' ', MIDDLE_NAME, ' ',LAST_NAME) as [NAME], SALARY 
from dbo.EMPLOYEE
order by SALARY Desc;

--3. List out the employee details according to their Last Name in ascending-order.
Select * 
from dbo.EMPLOYEE 
order by LAST_NAME;

--4. List out the employee details according to their Last Name in ascending
--order and then Department ID in descending order.
Select * 
from dbo.EMPLOYEE 
order by LAST_NAME, DEPARTMENT_ID Desc;

--GROUP BY and HAVING Clause:

--1. How many employees are in different departments in the organization?
Select D.Department_Id, count(E.DEPARTMENT_ID) as [EMPLOYEE COUNT]
from dbo.DEPARTMENT as D
	 left join dbo.EMPLOYEE as E
		on D.Department_Id = E.DEPARTMENT_ID
group by D.Department_Id;

--2. List out the department wise maximum salary, minimum salary and
--average salary of the employees.
Select DEPARTMENT_ID, 
	   MIN(SALARY) as [Min. Salary],
	   MAX(SALARY) as [Max. Salary],
	   AVG(SALARY) as [AVG. Salary]
from dbo.EMPLOYEE
group by DEPARTMENT_ID;

--3. List out the job wise maximum salary, minimum salary and average
--salary of the employees.
Select JOB_ID, 
	   MIN(SALARY) as [Min. Salary],
	   MAX(SALARY) as [Max. Salary],
	   AVG(SALARY) as [AVG. Salary]
from dbo.EMPLOYEE
group by JOB_ID;

--4. List out the number of employees who joined each month in ascendingorder.
Select [Hire Month], Count(*) as [Employee Count]
from (Select *, Datepart(Month, HIRE_DATE) as [Hire Month]
	  from dbo.EMPLOYEE) as E 
group by [Hire Month]
order by [Hire Month];

--5. List out the number of employees for each month and year in
--ascending order based on the year and month.
Select [Hire Year], [Hire Month], Count(*) as [Employee Count]
from (Select *, 
		     Datepart(Month, HIRE_DATE) as [Hire Month],
			 Datepart(Year, HIRE_DATE) as [Hire Year]
	  from dbo.EMPLOYEE) as E 
group by [Hire Year], [Hire Month]
order by [Hire Year], [Hire Month];

--6. List out the Department ID having at least four employees.
Select *
from (Select DEPARTMENT_ID, Count(*) as [Employee Count]
	  from dbo.EMPLOYEE 
	  group by DEPARTMENT_ID) as E
where [Employee Count] >= 4;

--7. How many employees joined in the month of January?
Select COUNT(*) as [Hire count]
from (Select *
	  from dbo.EMPLOYEE
	  where DATEPART(MONTH, HIRE_DATE) = 1) as E;
--or
Declare @month as varchar(15) = 'January'
Select @month as [HIRE MONTH], COUNT(*) as [HIRE COUNT]
from dbo.EMPLOYEE
where DATENAME(MONTH, HIRE_DATE) = @month;

--8. How many employees joined in the month of January or September?
Declare @month1 as varchar(15) = 'January', @month2 as varchar(15) = 'September'
Select @month1 as [HIRE MONTH 1],@month2 as [HIRE MONTH 2], COUNT(*) as [HIRE COUNT]
from dbo.EMPLOYEE
where DATENAME(MONTH, HIRE_DATE) in (@month1, @month2);

--9. How many employees joined in 1985?
Select Count(*) as [EMPLOYEE COUNT]
from dbo.EMPLOYEE 
where HIRE_DATE < '19860101' and HIRE_DATE >= '19850101';

--10. How many employees joined each month in 1985?
Select [HIRE MONTH], [HIRE YEAR], COUNT(*) as [EMPLOYEE COUNT]
from (Select *, 
             DATEPART(MONTH, HIRE_DATE) as [HIRE MONTH],
			 DATEPART(YEAR, HIRE_DATE) as [HIRE YEAR]
	  from dbo.EMPLOYEE) as E
where [HIRE YEAR] = 1985
group by [HIRE MONTH], [HIRE YEAR];

--11. How many employees joined in March 1985?
Select COUNT(*) as [EMPLOYEE COUNT]
from (Select *
	  from dbo.EMPLOYEE
	  where DATEPART(YEAR, HIRE_DATE) = 1985 and DATEPART(MONTH, HIRE_DATE) = 3) as E;

--12. Which is the Department ID having greater than or equal to 3 employees
--joining in April 1985?
with cte as
(
Select DEPARTMENT_ID, COUNT(*) AS [EMPLOYEE COUNT]
from dbo.EMPLOYEE
where HIRE_DATE >= '19850401' AND HIRE_DATE < '19850501'
group by DEPARTMENT_ID
)
Select DEPARTMENT_ID, [EMPLOYEE COUNT]
from cte
where [EMPLOYEE COUNT] >= 3;

--Joins:
--1. List out employees with their department names.
Select E.*,D.Name 
from dbo.EMPLOYEE as E 
	 left join dbo.DEPARTMENT as D 
		on E.DEPARTMENT_ID = D.Department_ID;

--2. Display employees with their designations.
Select E.*,J.Designation 
from dbo.EMPLOYEE as E
	 left join Job as J 
		on E.JOB_ID = J.Job_ID;

--3. Display the employees with their department names and regional groups.
Select E.*,D.Name ,L.City
from dbo.EMPLOYEE as E 
	 left join dbo.DEPARTMENT as D 
		on E.DEPARTMENT_ID = D.Department_ID
	 left join dbo.LOCATION as L 
		on D.Location_ID = L.Location_ID;

--4. How many employees are working in different departments? Display with
--department names.
Select D.Name, Count(E.EMPLOYEE_ID) as [EMPLOYEE COUNT] 
from dbo.Department as D 
	 left join dbo.EMPLOYEE as E
		on E.DEPARTMENT_ID = D.Department_ID
group by D.Name;

--5. How many employees are working in the sales department?
Select D.Name, Count(E.EMPLOYEE_ID) as [EMPLOYEE COUNT] 
from dbo.Department as D 
	 left join dbo.EMPLOYEE as E
		on E.DEPARTMENT_ID = D.Department_ID
group by D.Name
having D.Name = 'Sales';

--6. Which is the department having greater than or equal to 5 employees?
--Display the department names in ascending order.
with cte as
(
Select D.Name, Count(E.EMPLOYEE_ID) as [EMPLOYEE COUNT] 
from dbo.Department as D 
	 left join dbo.EMPLOYEE as E
		on E.DEPARTMENT_ID = D.Department_ID
group by D.Name
)
Select Name, [EMPLOYEE COUNT]
from cte
where [EMPLOYEE COUNT] >= 5;

--7. How many jobs are there in the organization? Display with designations.
Select *
from dbo.JOB
where Job_ID in (Select E.JOB_ID from dbo.EMPLOYEE as E);

--8. How many employees are working in "New York"?
Select L.Location_ID, L.City, count(E.EMPLOYEE_ID) as [EMPLOYEE COUNT]
from dbo.LOCATION as L
	 left join dbo.DEPARTMENT as D
		on L.Location_ID = D.Location_Id
	 left join dbo.EMPLOYEE as E
		on D.Department_Id = E.DEPARTMENT_ID
group by L.Location_ID, L.City
having L.City = 'New York';

--9. Display the employee details with salary grades. Use conditional statement to create a grade column.
Select *, case 
		  when SALARY between 500 and 1000 then 'C'
		  when SALARY between 1001 and 1500 then 'B'
		  when SALARY between 1501 and 2000 then 'A'
		  when SALARY between 2001 and 2500 then 'A+'
		  when SALARY between 2501 and 3000 then 'O'
		  end as Grade
from dbo.EMPLOYEE;

--10. List out the number of employees grade wise. Use conditional statementto create a grade column.
with cte as
(
Select *, case 
		  when SALARY between 500 and 1000 then 'C'
		  when SALARY between 1001 and 1500 then 'B'
		  when SALARY between 1501 and 2000 then 'A'
		  when SALARY between 2001 and 2500 then 'A+'
		  when SALARY between 2501 and 3000 then 'O'
		  end as Grade
from dbo.EMPLOYEE
)
Select grade, count(*) as [EMPLOYEE COUNT]
from cte
group by grade;

--11. Display the employee salary grades and the number of employees between 2000 to 5000 range of salary.
with cte as
(
Select *, case 
		  when SALARY between 500 and 1000 then 'C'
		  when SALARY between 1001 and 1500 then 'B'
		  when SALARY between 1501 and 2000 then 'A'
		  when SALARY between 2001 and 2500 then 'A+'
		  when SALARY between 2501 and 3000 then 'O'
		  end as Grade
from dbo.EMPLOYEE
where SALARY between 2000 and 5000
)
Select grade, count(*) as [EMPLOYEE COUNT]
from cte
group by grade;

--12. Display all employees in sales or operation departments.
Select E.*, D.Name
from dbo.EMPLOYEE as E
	 left join dbo.Department as D 
		on E.DEPARTMENT_ID = D.Department_ID
where D.Name in ('Sales', 'Operations');

--SET Operators:

--1. List out the distinct jobs in sales and accounting departments.
with cte as
(
Select J.Designation, D.Name as [Department Name]
from dbo.EMPLOYEE as E
	 left join dbo.DEPARTMENT as D
		on E.DEPARTMENT_ID = D.Department_Id
	 left join dbo.JOB as J
		on J.Job_Id = E.JOB_ID
), distinct_jobs as 
(
Select Designation from cte where [Department Name] = 'Sales'
Union
Select Designation from cte where [Department Name] = 'Accounting'
)
Select * from distinct_jobs;

--2. List out all the jobs in sales and accounting departments.
with cte as
(
Select J.Designation, D.Name as [Department Name]
from dbo.EMPLOYEE as E
	 left join dbo.DEPARTMENT as D
		on E.DEPARTMENT_ID = D.Department_Id
	 left join dbo.JOB as J
		on J.Job_Id = E.JOB_ID
), distinct_jobs as 
(
Select Designation from cte where [Department Name] = 'Sales'
Union all
Select Designation from cte where [Department Name] = 'Accounting'
)
Select * from distinct_jobs;

--3. List out the common jobs in research and accounting departments in ascending order.
with cte as
(
Select J.Designation, D.Name as [Department Name]
from dbo.EMPLOYEE as E
	 left join dbo.DEPARTMENT as D
		on E.DEPARTMENT_ID = D.Department_Id
	 left join dbo.JOB as J
		on J.Job_Id = E.JOB_ID
), distinct_jobs as 
(
Select Designation from cte where [Department Name] = 'Research'
Intersect
Select Designation from cte where [Department Name] = 'Accounting'
)
Select * from distinct_jobs;

--Subqueries:

--1. Display the employees list who got the maximum salary.
Select *
from dbo.EMPLOYEE
where SALARY = (Select MAX(E.SALARY) 
				from dbo.EMPLOYEE as E);

--2. Display the employees who are working in the sales department.
Select *
from dbo.EMPLOYEE
where DEPARTMENT_ID in (Select D.Department_Id 
					   from dbo.DEPARTMENT as D 
					   where D.Name = 'Sales');

--3. Display the employees who are working as 'Clerk'.
Select *
from dbo.EMPLOYEE
where JOB_ID in (Select J.Job_Id 
					   from dbo.JOB as J 
					   where J.Designation = 'Clerk');

--4. Display the list of employees who are living in "New York".
Select *
from dbo.EMPLOYEE
where DEPARTMENT_ID in (Select D.Department_Id
					    from dbo.DEPARTMENT as D 
					    where D.Location_Id in (Select J.Location_Id 
												from dbo.LOCATION as J
												where J.City = 'New York'));

--5. Find out the number of employees working in the sales department.
Select count(*) as [EMPLOYEE COUNT]
from dbo.EMPLOYEE
where DEPARTMENT_ID in (Select D.Department_Id 
					   from dbo.DEPARTMENT as D 
					   where D.Name = 'Sales');

--6. Update the salaries of employees who are working as clerks on the basis of 10%.
Update dbo.EMPLOYEE
set SALARY = SALARY * 1.1
where JOB_ID  = (Select J.Job_Id 
				 from dbo.JOB as J
				 where J.Designation = 'Clerk'); 

--7. Delete the employees who are working in the accounting department.
Delete from dbo.EMPLOYEE
where DEPARTMENT_ID  = (Select D.Department_Id 
						from dbo.DEPARTMENT as D
						where D.Name = 'Accounting');

--8. Display the second highest salary drawing employee details.
Select *
from dbo.EMPLOYEE as E1
where (Select count(Distinct E2.SALARY)
	   from dbo.EMPLOYEE as E2
	   where E2.SALARY >= E1.SALARY) = 2;

--9. Display the nth highest salary drawing employee details.
Declare @n as int = 3
Select *
from dbo.EMPLOYEE as E1
where (Select count(Distinct E2.SALARY)
	   from dbo.EMPLOYEE as E2
	   where E2.SALARY >= E1.SALARY) = @n;

--10. List out the employees who earn more than every employee in department 30.
Select *
from dbo.EMPLOYEE
where SALARY > (Select MAX(E.SALARY)
				from dbo.EMPLOYEE as E
				where E.DEPARTMENT_ID = 30);

--11. List out the employees who earn more than the lowest salary in department.
Select *
from dbo.EMPLOYEE
where SALARY > (Select MIN(E.SALARY)
				from dbo.EMPLOYEE as E);

--12. Find out which department has no employees.
with cte as
(
Select D.Department_Id, D.Name, count(E.DEPARTMENT_ID) as [EMPLOYEE COUNT]
from dbo.DEPARTMENT as D
	 left join dbo.EMPLOYEE as E
		on D.Department_Id = E.DEPARTMENT_ID
group by D.Department_Id, D.Name
)
select *
from cte
where [EMPLOYEE COUNT] = 0;

--13. Find out the employees who earn greater than the average salary for their department.
Select *
from dbo.EMPLOYEE as E1
where SALARY > (Select AVG(E2.SALARY)
				from dbo.EMPLOYEE as E2
				where E2.DEPARTMENT_ID = E1.DEPARTMENT_ID);