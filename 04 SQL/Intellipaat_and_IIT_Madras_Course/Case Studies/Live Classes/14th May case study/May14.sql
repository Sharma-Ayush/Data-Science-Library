create database May14
use May14


CREATE TABLE Location ( Location_ID INT PRIMARY KEY, City VARCHAR(20) )

INSERT INTO Location values
(122, 'New York' ),
(123, 'Dallas' ),
(124, 'Chicago' ),
(167, 'Boston' );

SELECT * FROM Location
---------------------------------------
CREATE TABLE Department ( Department_ID INT PRIMARY KEY, DeptName
VARCHAR(20),
DepLocation_ID INT FOREIGN KEY REFERENCES Location(Location_ID))

INSERT INTO Department values
( 10,'Accounting',122 ),
( 20,'Sales',124 ),
( 30,'Research',123 ),
( 40,'Operations',167);

SELECT * FROM Department
---------------------------------------
CREATE TABLE Job ( Job_ID INT PRIMARY KEY, Designation VARCHAR(20) )

INSERT INTO Job values
( 667,'Clerk' ),
(668,'Staff' ),
(669,'Analyst'),
(670,'Sales Person'),
(671,'Manager' ),
(672,'President');

SELECT * FROM Job
---------------------------------------
CREATE TABLE Employee ( Employee_ID INT, Last_Name VARCHAR(20),
First_Name VARCHAR(20), Middle_Name VARCHAR(20),
EmpJob_ID INT FOREIGN KEY REFERENCES Job(Job_ID),Manager_ID INT,
Hire_Date DATE, Salary INT, Comm INT,
EmpDepartment_ID INT FOREIGN KEY REFERENCES
Department(Department_ID) )

INSERT INTO Employee values
(7369, 'SMITH','JOHN','Q',667, 7902,'17-Dec-84',800, NULL, 20 ),
(7499, 'ALLEN','KEVIN','J',670, 7698,'20-Feb-85',1600, 300, 30 ),
( 7505, 'DOYLE','JEAN','K',671, 7839,'4-Apr-85',2850,NULL, 30),
(7506, 'DENNIS','LYNN','S',671, 7839,'15-May-85',2750, NULL, 30 ),
(7507, 'BAKER','LESLIE','D',671, 7839,'10-Jun-85',2200, NULL, 40 ),
(7521, 'WARK','CYNTHIA','D',670, 7698,'22-Feb-85',1250, 500, 30);

SELECT * FROM Employee


--SIMPLE QUERIES

--1. LIST ALL THE EMPLOYEE DETAILS
select * from Employee

--2. LIST ALL THE DEPARTMENT DETAILS
select * from Department

--3. LIST ALL JOB DETAILS.
select * from Job

--4. LIST ALL THE LOCATIONS.
select * from Location

--5. LIST OUT THE FIRSTNAME, LASTNAME, SALARY, COMMISSION FOR ALL EMPLOYEES
select First_Name, Last_Name, Salary, Comm from Employee

--6. LIST OUT EMPLOYEEID,LAST NAME, DEPARTMENT ID FOR ALL EMPLOYEES AND ALIAS 
--   EMPLOYEEID AS "ID OF THE EMPLOYEE", LAST NAME AS "NAME OF THE EMPLOYEE", 
--   DEPARTMENTID AS "DEP_ID".
select Employee_ID as [ID Of The Employee], Last_Name as [Name of The Employee],
EmpDepartment_ID as [DEP ID] from Employee

--7. LIST OUT THE EMPLOYEES ANNUAL SALARY WITH THEIR NAMES ONLY.
select concat(First_Name,' ',Last_Name) as Name,(Salary * 12) as [Annual Salary] from Employee


--WHERE CONDITION

--1. LIST THE DETAILS ABOUT "SMITH"
select * from Employee where 'smith' in (First_Name,Last_Name)

--2. LIST OUT THE EMPLOYEES WHO ARE WORKING IN DEPARTMENT 20.
select * from Employee where EmpDepartment_ID = 20

--3. LIST OUT THE EMPLOYEES WHO ARE EARNING SALARY BETWEEN 1000 AND 3000.
select * from Employee where Salary between 1000 and 3000

--4. LIST OUT THE EMPLOYEES WHO ARE WORKING IN DEPARTMENT 10 OR 20.
select * from Employee where EmpDepartment_ID in (10,20)

--5. FIND OUT THE EMPLOYEES WHO ARE NOT WORKING IN DEPARTMENT 10 OR 30.
select * from Employee where EmpDepartment_ID not in (10,30)

--6. LIST OUT THE EMPLOYEES WHOSE NAME STARTS WITH 'S'.
select * from Employee where First_Name like 's%'

--7. LIST OUT THE EMPLOYEES WHOSE NAME STARTS WITH 'S' AND ENDS WITH 'H
select * from Employee where First_Name like 's%h'

--8.  LIST OUT THE EMPLOYEES WHOSE NAME LENGTH IS 4 AND START WITH 'S'
select * from Employee where First_Name like 's___'

--9. LIST OUT EMPLOYEES WHO ARE WORKING IN DEPARRTMENT 10 AND DRAW THE 
--   SALARIES MORE THAN 2500.
select * from Employee where EmpDepartment_ID = 10 and Salary > 2500

--10. LIST OUT THE EMPLOYEES WHO ARE NOT RECEVING COMMISSION.
select * from Employee where Comm is null


--ORDER BY CLAUSE

--1. LIST OUT THE EMPLOYEE ID, LAST NAME IN ASCENDING ORDER BASED ON THE EMPLOYEE ID
select Employee_ID, Last_Name from Employee order by Employee_ID

--2. LIST OUT THE EMPLOYEE ID, NAME IN DESCENDING ORDER BASED ON SALARY.
select Employee_ID, CONCAT(First_Name,' ',Last_Name) as Name from Employee
order by Salary desc

--3. LIST OUT THE EMPLOYEE DETAILS ACCORDING TO THEIR LAST-NAME IN ASCENDING ORDER
select * from Employee order by Last_Name

--4. LIST OUT THE EMPLOYEE DETAILS ACCORDING TO THEIR LAST-NAME IN ASCENDING ORDER AND 
--   THEN ON DEPARTMENT_ID IN DESCENDING ORDER.
select * from Employee order by Last_Name, EmpDepartment_ID desc


--GROUP BY AND HAVING CLAUSE

--1. HOW MANY EMPLOYEES WHO ARE IN DIFFERENT DEPARTMENTS WISE IN THE ORGANIZATION
select EmpDepartment_ID, count(Employee_ID) as [No of Employees] from Employee
group by EmpDepartment_ID

--2. LIST OUT THE DEPARTMENT WISE MAXIMUM SALARY, MINIMUM SALARY, AVERAGE SALARY OF 
--   THE EMPLOYEES.
select EmpDepartment_ID, max(Salary) as max_salary,
       min(Salary) as min_salary, avg(salary) as avg_salary
from Employee
group by EmpDepartment_ID

--3. LIST OUT JOB WISE MAXIMUM SALARY, MINIMUM SALARY, AVERAGE SALARIES OF THE EMPLOYEES.
select EmpJob_ID, max(Salary) as max_salary,
       min(Salary) as min_salary, avg(salary) as avg_salary
from Employee
group by EmpJob_ID

--4. LIST OUT THE NUMBER OF EMPLOYEES JOINED IN EVERY MONTH IN ASCENDING ORDER
select month(Hire_Date) as months, count(Employee_ID) as [count of employees] from Employee
group by MONTH(Hire_Date)
order by months

--5. LIST OUT THE NUMBER OF EMPLOYEES FOR EACH MONTH AND YEAR, IN THE ASCENDING 
--   ORDER BASED ON THE YEAR, MONTH.
select year(Hire_Date) as Years, month(Hire_Date) as Months, count(Employee_ID) as [count of employee]
from Employee
group by year(Hire_Date) , month(Hire_Date)
order by year(Hire_Date), month(Hire_Date)

--6. LIST OUT THE DEPARTMENT ID HAVING ATLEAST FOUR EMPLOYEES.
select EmpDepartment_ID, count(Employee_ID) as [count of employee] from Employee
group by EmpDepartment_ID
having count(Employee_ID) >= 4

--7. HOW MANY EMPLOYEES JOINED IN JANUARY MONTH.
select month(Hire_Date) as months, count(Employee_ID) as [count of employee] from Employee
where month(Hire_Date) = 1
group by MONTH(Hire_Date)

--8. HOW MANY EMPLOYEES JOINED IN JANUARY OR SEPTEMBER MONTH.
select month(Hire_Date) as months, count(Employee_ID) as [count of employee] from Employee
where month(Hire_Date) in (1,9)
group by MONTH(Hire_Date)

--9. HOW MANY EMPLOYEES WERE JOINED IN 1985?
select year(Hire_Date) as Years,count(Employee_ID) as [count of employee] from Employee
where year(Hire_Date) = 1985
group by YEAR(Hire_Date)

--10. HOW MANY EMPLOYEES WERE JOINED EACH MONTH IN 1985.
select month(Hire_Date) as months, count(Employee_ID) as [count of employee] from Employee
where year(Hire_Date) = 1985
group by month(Hire_Date)

--11. HOW MANY EMPLOYEES WERE JOINED IN MARCH 1985?
select count(Employee_ID) as [count of employee] from Employee
where year(Hire_Date) = 1985 and month(Hire_Date) = 3

--12. WHICH IS THE DEPARTMENT ID, HAVING GREATER THAN OR EQUAL TO 3 EMPLOYEES JOINED IN 
--    APRIL 1985?
select EmpDepartment_ID, count(Employee_ID) as [count of employee] from Employee
where year(Hire_Date) = 1985 and month(Hire_Date) = 4
group by EmpDepartment_ID
having count(Employee_ID) >= 3



--JOINS

--1. LIST OUT EMPLOYEES WITH THEIR DEPARTMENT NAMES.
select e.First_Name,e.Last_Name, d.DeptName from Employee e
inner join Department d
on e.EmpDepartment_ID = d.Department_ID

--2. DISPLAY EMPLOYEES WITH THEIR DESIGNATIONS.
select e.First_Name, e.Last_Name, j.Designation from Employee e
inner join Job j
on e.EmpJob_ID = j.Job_ID

--3. DISPLAY THE EMPLOYEES WITH THEIR DEPARTMENT NAMES AND REGIONAL GROUPS.
select e.First_Name, e.Last_Name, d.DeptName,l.City from Employee e
inner join Department d
on e.EmpDepartment_ID = d.Department_ID
inner join Location l
on d.DepLocation_ID = l.Location_ID

--4. HOW MANY EMPLOYEES WHO ARE WORKING IN DIFFERENT DEPARTMENTS AND DISPLAY WITH 
--   DEPARTMENT NAMES
select d.DeptName, count(e.Employee_ID) as [count of employee] from employee e
inner join Department d
on e.EmpDepartment_ID = d.Department_ID
group by d.DeptName

--5. HOW MANY EMPLOYEES WHO ARE WORKING IN SALES DEPARTMENT.
select count(e.Employee_ID) as [count of employee] from Employee e
inner join Department d
on e.EmpDepartment_ID = d.Department_ID
where d.DeptName = 'sales'

--or
select count(Employee_ID) as [count of employee] from Employee where EmpDepartment_ID in
(select Department_ID from Department where DeptName = 'sales')


--6. WHICH IS THE DEPARTMENT HAVING GREATER THAN OR EQUAL TO 3
 --  EMPLOYEES AND DISPLAY THE DEPARTMENT NAMES IN ASCENDING ORDER
 select d.DeptName, count(e.Employee_ID) as [count of employee] from Employee e
 inner join Department d
 on e.EmpDepartment_ID = d.Department_ID
 group by d.DeptName
 having count(e.Employee_ID) >= 3
 order by d.DeptName

 --7. HOW MANY JOBS IN THE ORGANIZATION WITH DESIGNATIONS.
 select Designation, count(Job_ID) as [No of Jobs] from Job
 group by Designation

 --8. HOW MANY EMPLOYEES ARE WORKING IN "NEW YORK".
 select count(Employee_ID) as [count of employee] from Employee e
 inner join Department d
 on e.EmpDepartment_ID = d.Department_ID
 inner join Location l
 on d.DepLocation_ID = l.Location_ID
 where l.City = 'new york'

 --9. DISPLAY THE EMPLOYEE DETAILS WITH SALARY GRADES.
 select *, case
 when salary between 500 and 1000 then 'C'
 when salary between 1001 and 1500 then 'B'
 when salary between 1501 and 2000 then 'A'
 when salary between 2001 and 2500 then 'A+'
 when salary between 2501 and 3000 then 'O'
 end
 as Grade
 from Employee


 --10.  LIST OUT THE NO. OF EMPLOYEES ON GRADE WISE.
 select Grade,count(e.Employee_ID) as [count of employee] from
 (select *, case
 when salary between 500 and 1000 then 'C'
 when salary between 1001 and 1500 then 'B'
 when salary between 1501 and 2000 then 'A'
 when salary between 2001 and 2500 then 'A+'
 when salary between 2501 and 3000 then 'O'
 end
 as Grade
 from Employee) e
 group by Grade


 --11.  DISPLAY THE EMPLOYEE SALARY GRADES AND NO. OF EMPLOYEES BETWEEN 1000 TO 
--      3000 RANGE OF SALARY.
select Grade,count(e.Employee_ID) as [count of employee] from
 (select *, case
 when salary between 500 and 1000 then 'C'
 when salary between 1001 and 1500 then 'B'
 when salary between 1501 and 2000 then 'A'
 when salary between 2001 and 2500 then 'A+'
 when salary between 2501 and 3000 then 'O'
 end
 as Grade
 from Employee) e
 where Salary between 1000 and 3000
 group by Grade


 --16. DISPLAY ALL EMPLOYEES IN SALES OR OPERATION DEPARTMENTS.
 select e.*,d.DeptName from Employee e
 inner join Department d
 on e.EmpDepartment_ID = d.Department_ID
 where d.DeptName in ('sales','operation')