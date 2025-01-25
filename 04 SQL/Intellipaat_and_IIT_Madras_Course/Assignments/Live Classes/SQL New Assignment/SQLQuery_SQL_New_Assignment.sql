--SQL Assignment

--Perform the tasks mentioned below.
--Tasks To Be Performed:

--1. Display the “FIRST_NAME” from Employee table using the alias name as Employee_name.
Select First_name as Employee_name
from dbo.Employee;

--2. Display “LAST_NAME” from Employee table in upper case.
Select UPPER(Last_name) as LAST_NAME 
from dbo.Employee;

--3. Display unique values of DEPARTMENT from EMPLOYEE table.
Select Distinct Department 
from dbo.Employee;

--4. Display the first three characters of LAST_NAME from EMPLOYEE table.
Select LEFT(Last_name, 3) as LAST_NAME 
from dbo.Employee;

--5. Display the unique values of DEPARTMENT from EMPLOYEE table and prints its length.
Select Distinct Department, LEN(DEPARTMENT) as Length 
from dbo.Employee;

--6. Display the FIRST_NAME and LAST_NAME from EMPLOYEE table into a single column AS FULL_NAME. A space char should separate them.
Select CONCAT(First_Name, ' ', Last_name) as FULL_NAME 
from dbo.Employee;

--7. DISPLAY all EMPLOYEE details from the employee table order by FIRST_NAME Ascending.
Select * 
from dbo.Employee
order by First_name;

--8. Display all EMPLOYEE details order by FIRST_NAME Ascending and DEPARTMENT Descending.
Select * 
from dbo.Employee
order by First_name, Department Desc;

--9. Display details for EMPLOYEE with the first name as “VEENA” and “KARAN” from EMPLOYEE table.
Select * 
from dbo.Employee
where First_Name in ('Veena', 'Karan');

--10. Display details of EMPLOYEE with DEPARTMENT name as “Admin”.
Select * 
from dbo.Employee
where Department = 'Admin';

--11. DISPLAY details of the EMPLOYEES whose FIRST_NAME contains ‘V’.
Select * 
from dbo.Employee
where First_Name like 'V%';

--12. DISPLAY details of the EMPLOYEES whose SALARY lies between 100000 and 500000.
Select * 
from dbo.Employee
where Salary between 100000 and 500000;

--13. Display details of the employees who have joined in Feb-2020.
Select * 
from dbo.Employee
where Joining_date >= '20200201' and Joining_date < '20200301';

--14. Display employee names with salaries >= 50000 and <= 100000.
Select * 
from dbo.Employee
where Salary between 50000 and 100000;

--15. Display the number of employees for each department in descending order.Select Department, count(*) as [Employee count]from dbo.Employeegroup by Departmentorder by [Employee count] Desc;
--16. DISPLAY details of the EMPLOYEES who are also Managers.
Select * 
from dbo.Employee
where Employee_id in (Select Employee_ref_id 
					  from dbo.[Employee title]
					  where Employee_title = 'Manager');

--17 DISPLAY duplicate records having matching data in some fields of a table.
--considering First_name, last_name, salary, joining date for matching
Select *
from dbo.Employee as E1
where EXISTS(Select * 
			 from dbo.Employee as E2
			 where E1.Employee_id <> E2.Employee_id
				   and (E2.First_name = E1.First_name or
					    E2.Last_name = E1.Last_name or
						E2.Salary = E1.Salary or
						E2.Joining_date = E1.Joining_date));

--18. Display only odd rows from a table.
--Adding row number based on Employee_id in Employee table
Select *
from (Select E1.*, ROW_NUMBER() OVER(order by E1.Employee_id) as rownum from dbo.Employee as E1) as E2
where rownum % 2 = 1
order by E2.rownum;

--19. Clone a new table from EMPLOYEE table.
Select * into dbo.Clone_Employee from dbo.Employee;

--20. DISPLAY the TOP 2 highest salary from a table.
Select TOP(2) Salary
from (Select Distinct Salary from dbo.Employee) as E
order by Salary Desc;

--21. DISPLAY the list of employees with the same salary.
Select *
from dbo.Employee as E1
where EXISTS(Select * 
			 from dbo.Employee as E2
			 where E1.Salary = E2.Salary and E1.Employee_id <> E2.Employee_id);

--22. Display the second highest salary from a table.
Select E1.Salary
from dbo. Employee as E1
	 cross join dbo.Employee as E2
where E1.salary < E2.salary
group by E1.salary
having count(Distinct E2.Salary) = 1;

--23. Display the first 50% records from a table.
Select TOP(50) PERCENT *
from dbo.Employee;

--24. Display the departments that have less than 4 people in it.
Select Department
from dbo.Employee
group by Department
having count(*) < 4;

--25. Display all departments along with the number of people in there.
Select Department, count(*) as [Employee Count]
from dbo.Employee
group by Department;

--26. Display the name of employees having the highest salary in each department.
Select CONCAT(First_name, ' ', Last_name) as Full_name, salary, department
from dbo.Employee as E1
where salary = (Select MAX(E2.Salary) 
				from dbo.Employee as E2 
				where E1.department = E2.department);

--27. Display the names of employees who earn the highest salary.
Select CONCAT(First_name, ' ', Last_name) as Full_name, salary
from dbo.Employee as E1
where salary = (Select MAX(E2.Salary) 
				from dbo.Employee as E2);

--28. Diplay the average salaries for each department.
Select Department, AVG(Salary) as [Average Salary]
from dbo.Employee
group by Department;

--29. display the name of the employee who has got maximum bonus
Select TOP(1) WITH TIES CONCAT(First_name, ' ', Last_name) as Full_name
from dbo.Employee as E1
	 inner join dbo.[Employee Bonus] as E2
		on E1.Employee_id = E2.Employee_ref_id
order by E2.Bonus_Amount Desc;

--30. Display the first name and title of all the employees
Select E1.First_name, E2.Employee_title
from dbo.Employee as E1
	 left join dbo.[Employee Title] as E2
		on E1.Employee_id = E2.Employee_ref_id;