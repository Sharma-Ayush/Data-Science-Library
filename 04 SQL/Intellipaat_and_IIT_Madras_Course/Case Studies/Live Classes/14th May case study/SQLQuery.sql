Select * from Location
Select * from Department
Select * from Job
Select * from Employee

--Simple Queries:
--1. LIST ALL THE EMPLOYEE DETAILS.
Select * from Employee

--2. LIST ALL THE DEPARTMENT DETAILS
Select * from Department

--3. LIST ALL JOB DETAILS.
Select * from Job

--4. LIST ALL THE LOCATIONS.
Select * from Location

--5. LIST OUT THE FIRSTNAME, LASTNAME, SALARY, COMMISSION FOR ALL EMPLOYEES.
Select First_Name, Last_Name, Salary, Comm from Employee

--6. LIST OUT EMPLOYEEID,LAST NAME, DEPARTMENT ID FOR ALL EMPLOYEES AND ALIAS EMPLOYEEID 
--AS "ID OF THE EMPLOYEE", LAST NAME AS "NAME OF THE EMPLOYEE", DEPARTMENTID AS "DEP_ID".
Select Employee_ID as 'ID OF THE EMPLOYEE',Last_Name as 'NAME OF THE EMPLOYEE', EmpDepartment_ID as 'DEP_ID' from Employee

--7. LIST OUT THE EMPLOYEES ANNUAL SALARY WITH THEIR NAMES ONLY.
Select [Annaul Salary]=Salary*12, Name=Concat(First_Name, ' ', Middle_Name, ' ',Last_Name)  from Employee

--WHERE CONSITION:
--1. LIST THE DETAILS ABOUT "SMITH"
Select * from Employee where 'SMITH' in (First_Name,Last_Name)

--2. LIST OUT THE EMPLOYEES WHO ARE WORKING IN DEPARTMENT 20.
Select * from Employee where EmpDepartment_ID=20

--3. LIST OUT THE EMPLOYEES WHO ARE EARNING SALARY BETWEEN 3000 AND 4500.
Select * from Employee where Salary between 3000 and 4500

--4. LIST OUT THE EMPLOYEES WHO ARE WORKING IN DEPARTMENT 10 OR 20.
Select * from Employee where EmpDepartment_ID in (10,20)

--5. FIND OUT THE EMPLOYEES WHO ARE NOT WORKING IN DEPARTMENT 10 OR 30.
Select * from Employee where EmpDepartment_ID not in (10,30)

--6. LIST OUT THE EMPLOYEES WHOSE NAME STARTS WITH 'S'.
Select * from Employee where First_Name like 'S%'

--7. LIST OUT THE EMPLOYEES WHOSE NAME STARTS WITH 'S' AND ENDS WITH 'H'.
Select * from Employee where First_Name like 'S%H'

--8. LIST OUT THE EMPLOYEES WHOSE NAME LENGTH IS 4 AND START WITH 'S'.
Select * from Employee where First_Name like 'S___'

--9. LIST OUT EMPLOYEES WHO ARE WORKING IN DEPARTMENT 10 AND DRAW THE SALARIES MORE THAN 3500.
Select * from Employee where EmpDepartment_ID =10 and Salary>3500

--10. LIST OUT THE EMPLOYEES WHO ARE NOT RECEVING COMMISSION.
Select * from Employee where Comm IS NULL or Comm=0

--Order By Clause:
--1. LIST OUT THE EMPLOYEE ID, LAST NAME IN ASCENDING ORDER BASED ON THE EMPLOYEE ID.
Select Employee_ID, Last_Name from Employee order by Employee_ID

--2. LIST OUT THE EMPLOYEE ID, NAME IN DESCENDING ORDER BASED ON SALARY
Select Employee_ID, Name=Concat(First_Name, ' ', Middle_Name, ' ',Last_Name) from Employee order by Salary Desc

--3. LIST OUT THE EMPLOYEE DETAILS ACCORDING TO THEIR LAST-NAME IN ASCENDING ORDER
Select * from Employee order by Last_Name

--4. LIST OUT THE EMPLOYEE DETAILS ACCORDING TO THEIR LAST-NAME IN ASCENDING ORDER AND THEN ON DEPARTMENT_ID
--IN DESCENDING ORDER.
Select * from Employee order by Last_Name, EmpDepartment_ID Desc

--Group By & Having Clause:
--1. HOW MANY EMPLOYEES WHO ARE IN DIFFERENT DEPARTMENTS WISE IN THE ORGANIZATION.
Select EmpDepartment_ID,[Employee Count]=count(*) from Employee group by EmpDepartment_ID

--2. LIST OUT THE DEPARTMENT WISE MAXIMUM SALARY, MINIMUM SALARY, AVERAGE SALARY OF THE EMPLOYEES.
Select EmpDepartment_ID, [Max. Salary]=MAX(Salary), [Min. Salary]=MIN(Salary), [Avg. Salary]=AVG(Salary) from Employee group by EmpDepartment_ID

--3. LIST OUT JOB WISE MAXIMUM SALARY, MINIMUM SALARY, AVERAGE SALARIES OF THE EMPLOYEES.
Select EmpJob_ID, [Max. Salary]=MAX(Salary), [Min. Salary]=MIN(Salary), [Avg. Salary]=AVG(Salary) from Employee group by EmpJob_ID

--4. LIST OUT THE NUMBER OF EMPLOYEES JOINED IN EVERY MONTH IN ASCENDING ORDER.
Select [Hiring Month]=Datepart(Month,Hire_Date),[Employee Count]=Count(*) from Employee group by Datepart(Month,Hire_Date) order by Datepart(Month,Hire_Date)

--5. LIST OUT THE NUMBER OF EMPLOYEES FOR EACH MONTH AND YEAR, IN THE ASCENDING ORDER BASED ON THE YEAR, MONTH.
Select [Hiring Month]=concat(Datepart(Month,Hire_Date), '-',Datepart(Year,Hire_Date)),[Employee Count]=Count(*) from Employee group by Datepart(Month,Hire_Date),Datepart(Year,Hire_Date) order by Datepart(Year,Hire_Date),Datepart(Month,Hire_Date)

--6. LIST OUT THE DEPARTMENT ID HAVING ATLEAST FOUR EMPLOYEES.
Select EmpDepartment_ID,[Employee Count]=Count(*) from Employee group by EmpDepartment_ID having Count(*)>=4

--7. HOW MANY EMPLOYEES JOINED IN JANUARY MONTH.
Select [Hiring Month]=Datepart(Month,Hire_Date),[Employee Count]=Count(*) from Employee group by Datepart(Month,Hire_Date) having Datepart(Month,Hire_Date)=1

--8. HOW MANY EMPLOYEES JOINED IN JANUARY OR SEPTEMBER MONTH.
Select [Hiring Month]=Datepart(Month,Hire_Date),[Employee Count]=Count(*) from Employee group by Datepart(Month,Hire_Date) having Datepart(Month,Hire_Date) in (1,9)

--9. HOW MANY EMPLOYEES WERE JOINED IN 1985?
Select [Employee Count]=Count(*) from Employee WHERE Datepart(Year, Hire_Date)=1985 group by Datepart(Year, Hire_Date)

--10. HOW MANY EMPLOYEES WERE JOINED EACH MONTH IN 1985.
Select [Hiring Month]=Datepart(Month,Hire_Date),[Employee Count]=Count(*) from Employee WHERE Datepart(Year, Hire_Date)=1985 group by Datepart(Month,Hire_Date)

--11. HOW MANY EMPLOYEES WERE JOINED IN MARCH 1985?
Select [Hiring Month]=Datepart(Month,Hire_Date),[Employee Count]=Count(*) from Employee WHERE Datepart(Year, Hire_Date)=1985 group by Datepart(Month,Hire_Date) HAving Datepart(Month,Hire_Date)=3

--12. WHICH IS THE DEPARTMENT ID, HAVING GREATER THAN OR EQUAL TO 3 EMPLOYEES JOINED IN APRIL 1985?
Select EmpDepartment_ID, [Employee Count]=Count(*) from Employee where Datepart(Month, Hire_Date)=4 and Datepart(Year, Hire_Date)=1985 group by EmpDepartment_ID having count(*)>=3

--Joins:
--1. LIST OUT EMPLOYEES WITH THEIR DEPARTMENT NAMES.
Select e.*,d.DeptName from Employee as e inner join Department as d on e.EmpDepartment_ID=d.Department_ID

--2. DISPLAY EMPLOYEES WITH THEIR DESIGNATIONS.
Select e.*,j.Designation from Employee as e inner join Job as j on e.EmpJob_ID=j.Job_ID

--3. DISPLAY THE EMPLOYEES WITH THEIR DEPARTMENT NAMES AND REGIONAL GROUPS.
Select e.*,d.DeptName ,l.City
from 
Employee as e 
inner join
Department as d on e.EmpDepartment_ID=d.Department_ID
inner join
Location as l on d.DepLocation_ID=l.Location_ID

--4. HOW MANY EMPLOYEES WHO ARE WORKING IN DIFFERENT DEPARTMENTS AND DISPLAY WITH DEPARTMENT NAMES.
Select d.Department_ID,d.DeptName,[Employee Count]=Count(*) from Employee as e inner join Department as d on e.EmpDepartment_ID=d.Department_ID group by d.Department_ID,d.DeptName

--5. HOW MANY EMPLOYEES WHO ARE WORKING IN SALES DEPARTMENT.
Select d.DeptName,[Employee Count]=Count(*) from Employee as e inner join Department as d on e.EmpDepartment_ID=d.Department_ID group by d.DeptName having d.DeptName='Sales'

--6. WHICH IS THE DEPARTMENT HAVING GREATER THAN OR EQUAL TO 5
--EMPLOYEES AND DISPLAY THE DEPARTMENT NAMES IN ASCENDING ORDER.
Select d.DeptName,[Employee Count]=Count(*) from Employee as e inner join Department as d on e.EmpDepartment_ID=d.Department_ID group by d.DeptName having Count(*)>5 order by d.DeptName

--7. HOW MANY JOBS IN THE ORGANIZATION WITH DESIGNATIONS.
Select j.Designation,[Employee Count]=count(*) from Employee as e inner join Job as j on e.EmpJob_ID=j.Job_ID group by j.Designation

--8. HOW MANY EMPLOYEES ARE WORKING IN "NEW YORK".
Select l.City, [Employee Count]=count(*)
from 
Employee as e 
inner join
Department as d on e.EmpDepartment_ID=d.Department_ID
inner join
Location as l on d.DepLocation_ID=l.Location_ID
group by l.City
having l.City='New York'

--9. DISPLAY THE EMPLOYEE DETAILS WITH SALARY GRADES.
Select *, case
when salary between 500 and 1000 then 'C'
when salary between 1001 and 1500 then 'B'
when salary between 1501 and 2000 then 'A'
when salary between 2001 and 2500 then 'A+'
when salary between 2501 and 3000 then 'O'
end
as Grade
from Employee

--10. LIST OUT THE NO. OF EMPLOYEES ON GRADE WISE.
Select Grade, [Employee Count]=count(*) from (Select *, case
when salary between 500 and 1000 then 'C'
when salary between 1001 and 1500 then 'B'
when salary between 1501 and 2000 then 'A'
when salary between 2001 and 2500 then 'A+'
when salary between 2501 and 3000 then 'O'
end
as Grade
from Employee) AS E group by grade

--11. DISPLAY THE EMPLOYEE SALARY GRADES AND NO. OF EMPLOYEES BETWEEN 2000 TO 5000 RANGE OF SALARY.
Select Grade, [Employee Count]=count(*) from (Select *, case
when salary between 500 and 1000 then 'C'
when salary between 1001 and 1500 then 'B'
when salary between 1501 and 2000 then 'A'
when salary between 2001 and 2500 then 'A+'
when salary between 2501 and 3000 then 'O'
end
as Grade
from Employee ) AS E where Salary between 2000 and 5000 group by grade

--16. DISPLAY ALL EMPLOYEES IN SALES OR OPERATION DEPARTMENTS.
Select * from Employee where EmpDepartment_ID in (Select Department_ID from Department where DeptName IN ('Sales','Operations'))

--SET OPERATORS:
--1. LIST OUT THE DISTINCT JOBS IN SALES AND ACCOUNTING DEPARTMENTS.
Select Distinct Designation from Job where Job_ID in (Select EmpJob_ID from Employee where EmpDepartment_ID in (Select Department_ID from Department where DeptName IN ('Sales','Accounting')))
--or
Select distinct j.Designation from 
Employee as e
inner join 
Department as d on e.EmpDepartment_ID=d.Department_ID
inner join
Job as j on e.EmpJob_ID=j.Job_ID
where d.DeptName in ('Sales','Accounting')
--or
Select j.Designation from 
Employee as e
inner join 
Department as d on e.EmpDepartment_ID=d.Department_ID
inner join
Job as j on e.EmpJob_ID=j.Job_ID
where D.DeptName='Accounting' 
union
Select j.Designation from 
Employee as e
inner join 
Department as d on e.EmpDepartment_ID=d.Department_ID
inner join
Job as j on e.EmpJob_ID=j.Job_ID
where D.DeptName='Sales'

--2. LIST OUT ALL THE JOBS IN SALES AND ACCOUNTING DEPARTMENTS.
Select Designation from Job where Job_ID in (Select EmpJob_ID from Employee where EmpDepartment_ID in (Select Department_ID from Department where DeptName IN ('Sales','Accounting')))
--or
Select j.Designation from 
Employee as e
inner join 
Department as d on e.EmpDepartment_ID=d.Department_ID
inner join
Job as j on e.EmpJob_ID=j.Job_ID
where D.DeptName='Accounting' 
union all
Select j.Designation from 
Employee as e
inner join 
Department as d on e.EmpDepartment_ID=d.Department_ID
inner join
Job as j on e.EmpJob_ID=j.Job_ID
where D.DeptName='Sales'


--3. LIST OUT THE COMMON JOBS IN RESEARCH AND ACCOUNTING DEPARTMENTS IN ASCENDING ORDER.
with N as
(Select * from 
Employee as e
inner join 
Department as d on e.EmpDepartment_ID=d.Department_ID
inner join
Job as j on e.EmpJob_ID=j.Job_ID)
Select Designation from N where DeptName='Accounting' 
intersect
Select Designation from N where DeptName='Research'

--SUB QUERIES:
--1. DISPLAY THE EMPLOYEES LIST WHO GOT THE MAXIMUM SALARY.
Select * from Employee where Salary=(Select Max(Salary) from Employee)

--2. DISPLAY THE EMPLOYEES WHO ARE WORKING IN SALES DEPARTMENT.
Select * from Employee where EmpDepartment_ID IN (Select Department_ID from Department where DeptName='Sales')

--3. DISPLAY THE EMPLOYEES WHO ARE WORKING AS 'CLERCK'.
Select * from Employee where EmpJob_ID IN (Select Job_ID from Job where Designation='Clerk')

--4. DISPLAY THE LIST OF EMPLOYEES WHO ARE LIVING IN "NEW YORK".
Select * from Employee where EmpDepartment_ID in (Select Department_ID from Department where DepLocation_ID in (Select Location_ID from Location where city='New York'))

--5. FIND OUT NO. OF EMPLOYEES WORKING IN "SALES" DEPARTMENT.
Select [Employee Count]=count(*) from Employee where EmpDepartment_ID IN (Select Department_ID from Department where DeptName='Sales')

--6. UPDATE THE EMPLOYEES SALARIES, WHO ARE WORKING AS CLERK ON THE BASIS OF 10%.
Update Employee set Salary=Salary*1.1 where EmpJob_ID IN (Select Job_ID from Job where Designation='Clerk')
Select * from Employee

--7. DELETE THE EMPLOYEES WHO ARE WORKING IN ACCOUNTING DEPARTMENT.
Delete from Employee where EmpDepartment_ID IN (Select Department_ID from Department where DeptName='Accounting')

--8. DISPLAY THE SECOND HIGHEST SALARY DRAWING EMPLOYEE DETAILS.
Select max(salary) from Employee where Salary not in (Select Max(Salary) from Employee)

--9. DISPLAY THE N'TH HIGHEST SALARY DRAWING EMPLOYEE DETAILS.
Declare @n as int=7
Select * from Employee as e where @n-1=(Select count(distinct salary) from Employee where salary>e.salary)

--10. LIST OUT THE EMPLOYEES WHO EARN MORE THAN EVERY EMPLOYEE IN DEPARTMENT 30.
Select * from Employee where Salary>(Select Max(Salary) from Employee where EmpDepartment_ID=30)

--11. LIST OUT THE EMPLOYEES WHO EARN MORE THAN THE LOWEST SALARY IN DEPARTMENT 30.
Select * from Employee where Salary>(Select Min(Salary) from Employee where EmpDepartment_ID=30)

--12. FIND OUT WHOSE DEPARTMENT HAS NO OTHER EMPLOYEES.
Select * from Employee as e where (Select count(*) from Employee where EmpDepartment_ID=e.EmpDepartment_ID)=1
--or
Select * from Employee as e where EmpDepartment_ID in (Select EmpDepartment_ID from Employee group by EmpDepartment_ID having count(*)=1)

--13. FIND OUT WHICH DEPARTMENT DOES NOT HAVE ANY EMPLOYEES.
Select DeptName from Department where Department_ID not in (Select EmpDepartment_ID from Employee)

--14. FIND OUT THE EMPLOYEES WHO EARN GREATER THAN THE AVERAGE SALARY FOR THEIR DEPARTMENT.
Select * from Employee as e where Salary>(Select AVG(Salary) FROM Employee where EmpDepartment_ID=e.EmpDepartment_ID)
Select EmpDepartment_ID, AVG(Salary) from Employee group by EmpDepartment_ID
