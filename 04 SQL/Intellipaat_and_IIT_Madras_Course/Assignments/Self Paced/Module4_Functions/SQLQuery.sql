--1. What is the cost of the costliest software development in Basic?
Select * 
from dbo.software 
where DCOST=(Select MAX(S.DCOST) from dbo.software as S where S.DEVELOPIN='BASIC') and DEVELOPIN='BASIC';
--or
Select TOP(1) WITH TIES * 
from dbo.software 
where DEVELOPIN='BASIC' 
order by DCOST DESC;

--2. Display details of packages whose sales crossed the 2000 mark.
Select PNAME, TITLE, DEVELOPIN, SCOST, DCOST, SOLD 
from dbo.software 
where SCOST*SOLD > 2000;

--3. Who are the programmers who celebrate their birthdays during the current month?
Select PNAME, DOB 
from dbo.programmer 
where MONTH(DOB) = MONTH(GETDATE());

--4. Display the cost of the package developed by each programmer.
Select P.PNAME, S.TITLE, S.SCOST
from dbo.PROGRAMMER as P
	left join dbo.SOFTWARE as S
		on S.PNAME = P.PNAME

--5. Display the sales values of the packages developed by each programmer.
Select P.PNAME, S.TITLE, S.SCOST*S.SOLD as [SALES]
from dbo.PROGRAMMER as P
	left join dbo.SOFTWARE as S
		on S.PNAME = P.PNAME;

--6. Display the number of packages sold by each programmer.
Select P.PNAME, count(S.TITLE) as [Package Count]
from dbo.PROGRAMMER as P
	left join dbo.SOFTWARE as S
		on S.PNAME = P.PNAME
group by P.PNAME;

--7. Display each programmer’s name, costliest and cheapest packages developed by him or her.
Select PNAME, (SELECT TOP(1) S2.TITLE
			   from dbo.SOFTWARE as S2
			   where S2.PNAME = P.PNAME
			   order by S2.SCOST DESC) as [COSTLIEST PACKAGE], 
			   (SELECT TOP(1) S3.TITLE
			   from dbo.SOFTWARE as S3
			   where S3.PNAME = P.PNAME
			   order by S3.SCOST ASC) as [CHEAPEST PACKAGE]
from dbo.Programmer as P;

--8. Display each institute’s name with the number of courses and average cost per course.
Select INSTITUTE, COUNT(*) as [NO. OF COURSES], AVG([COURSE FEE]) as [AVG. COURSE FEE]
from (Select Distinct INSTITUTE, COURSE, [COURSE FEE] from dbo.STUDIES) as S
group by INSTITUTE;

--9. Display each institute’s name with the number of students.
Select INSTITUTE, COUNT(Distinct PNAME) as [STUDENT COUNT]
from dbo.STUDIES
group by INSTITUTE;

--10. List the programmers (from the software table) and the institutes they studied at.
Select P.PNAME, S1.INSTITUTE
from dbo.PROGRAMMER as P
	 left join dbo.STUDIES as S1
		on P.PNAME = S1.PNAME
where P.PNAME in (Select S2.PNAME from dbo.SOFTWARE as S2);

--11. How many packages were developed by students who studied in institutes that charge the lowest course fee?
Select ST.INSTITUTE, count(SO.TITLE) as [PACKAGE COUNT]
from dbo.STUDIES as ST
	 left join dbo.SOFTWARE as SO
		on ST.PNAME = SO.PNAME
where ST.INSTITUTE in (Select top(1) with ties S.INSTITUTE from dbo.STUDIES as S order by S.[COURSE FEE])
group by ST.INSTITUTE;

--12. What is the average salary for those whose software sales are more than 50,000?
Select AVG(SALARY) as [AVERAGE SALARY]
from dbo.PROGRAMMER
where PNAME in (Select S.PNAME 
				from dbo.SOFTWARE as S 
				where S.SCOST * S.SOLD > 50000);

--13. Which language listed in PROF1, PROF2 has not been used to develop any package?
WITH LANGUAGES_TABLE AS 
(
Select PROF1 as LANGUAGES 
from dbo.PROGRAMMER
UNION
Select PROF2
from dbo.PROGRAMMER
)
Select LANGUAGES
from LANGUAGES_TABLE as L
where NOT EXISTS(Select * from dbo.SOFTWARE as S where S.DEVELOPIN = L.LANGUAGES);

--14. Display the total sales value of the software institute wise.
Select ST.INSTITUTE, SUM(SO.SCOST*SO.SOLD) AS [SALES VALUE]
from dbo.STUDIES as ST
	 left join dbo.PROGRAMMER as P
		on P.PNAME = ST.PNAME
	 left join dbo.SOFTWARE as SO
		on P.PNAME = SO.PNAME
group by ST.INSTITUTE;

--15. Display the details of the software developed in C by female programmers of Pragathi.
Select SO.*, ST.INSTITUTE, P.GENDER
from dbo.PROGRAMMER as P
	 inner join dbo.STUDIES as ST
		on P.PNAME = ST.PNAME and P.GENDER = 'F' and ST.INSTITUTE = 'PRAGATHI'
	 inner join dbo.SOFTWARE as SO
		on P.PNAME = SO.PNAME;

--16. Display the details of the packages developed in Pascal by female programmers.
Select P.PNAME, S.TITLE, S.DEVELOPIN, S.SCOST, S.DCOST, S.SOLD
from (Select * from dbo.PROGRAMMER where GENDER = 'F') AS P
	  inner join (Select * from dbo.SOFTWARE where DEVELOPIN = 'PASCAL') as S
		on P.PNAME = S.PNAME;
--or
Select S.*, P.SALARY
from dbo.PROGRAMMER AS P
	  inner join dbo.SOFTWARE as S
		on P.PNAME = S.PNAME and P.GENDER = 'F' and S.DEVELOPIN = 'PASCAL';

--17. Which language has most of the programmers stated as being proficient in?
WITH LANGUAGES_TABLE AS 
(
Select PNAME, PROF1 as LANGUAGES 
from dbo.PROGRAMMER
UNION ALL
Select PNAME, PROF2
from dbo.PROGRAMMER
)
Select TOP(1) WITH TIES LANGUAGES, COUNT(*) as [PROGRAMMER COUNT]
from LANGUAGES_TABLE
group by LANGUAGES
order by [PROGRAMMER COUNT] DESC;

--18. Who is the author of the costliest package?
Select PNAME, TITLE, DEVELOPIN, SCOST
from dbo.SOFTWARE
where SCOST = (Select MAX(S.SCOST) from dbo.SOFTWARE as S);

--19. Which package has the highest development cost?
Select TOP(1) WITH TIES *
from dbo.SOFTWARE
order by DCOST DESC;

--20. Who is the highest paid female COBOL programmer?
Select TOP(1) WITH TIES PNAME, GENDER, PROF1, PROF2, SALARY
from dbo.PROGRAMMER
where 'COBOL' in (PROF1, PROF2) AND GENDER = 'F'
order by SALARY DESC;

--21. Display the names and packages of the programmers.
Select P.PNAME, S.TITLE
from dbo.PROGRAMMER as P
	INNER join dbo.SOFTWARE as S
		on S.PNAME = P.PNAME;

--22. Display the number of packages in each language except C and C++.
Select DEVELOPIN, count(*) as [NO. OF PACKAGES]
from dbo.SOFTWARE
where DEVELOPIN not in ('C', 'CPP')
group by DEVELOPIN;

--23. Display the average difference between SCOST and DCOST for each package.
Select TITLE, DEVELOPIN, ABS(DCOST - SCOST) as [DIFFERENCE]
from dbo.SOFTWARE;

--24. Display the total SCOST and DCOST and the amount to be recovered for each programmer for those whose cost has not yet been recovered.
With Programmer_Summary as
(
Select P.PNAME, SUM(SCOST) AS [TOTAL SCOST], SUM(DCOST) AS [TOTAL DCOST], SUM(S.SCOST*S.SOLD) AS [SALES]
from dbo.PROGRAMMER as P
	LEFT join dbo.SOFTWARE as S
		on S.PNAME = P.PNAME
group by P.PNAME
)
Select PNAME, [TOTAL SCOST], [TOTAL DCOST], [SALES], [TOTAL DCOST] - [SALES] as [AMOUNT TO BE RECOVERED]
from Programmer_Summary
where [TOTAL DCOST] > [SALES];

--25. Who is the highest paid C programmer?
Select TOP(1) WITH TIES PNAME, PROF1, PROF2, SALARY
from dbo.PROGRAMMER
where 'C' in (PROF1, PROF2)
order by SALARY DESC;

--26. Who is the highest paid female COBOL programmer?
Select TOP(1) WITH TIES PNAME, GENDER, PROF1, PROF2, SALARY
from dbo.PROGRAMMER
where 'COBOL' in (PROF1, PROF2) AND GENDER = 'F'
order by SALARY DESC;