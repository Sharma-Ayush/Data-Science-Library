----------------Assignment SQL Queries--------------------
/*
Problem statement:
Consider yourself to be Sam and you have been given the below tasks to complete using
the Table – STUDIES, SOFTWARE & PROGRAMMER.
*/

--Assumptions:
--By package it means title in dbo.software table
--By sales it is meant SCOST * SOLD

--Task to be done:
--1. Find out the selling cost AVG for packages developed in Pascal.
Select AVG(SCOST) as [Average Selling Cost]
from dbo.software 
where DEVELOPIN = 'PASCAL';

--2. Display Names, Ages of all Programmers.
Select PNAME, DATEDIFF(MONTH,DOB,GETDATE())/12 as Age
from dbo.programmer;

--3. Display the Names of those who have done the DAP Course.
Select PNAME 
from dbo.studies
where COURSE='DAP';

--4. Display the Names and Date of Births of all Programmers Born in January.
Select PNAME, DOB 
from dbo.programmer 
where MONTH(DOB) = 1;

--5. What is the Highest Number of copies sold by a Package?
Select PNAME, TITLE, DEVELOPIN, SOLD 
from dbo.software 
where SOLD = (Select max(S.SOLD)
			  from dbo.software as S);
--or
Select TOP(1) WITH TIES PNAME, TITLE, DEVELOPIN, SOLD 
from dbo.software 
order by SOLD DESC;

--6. Display lowest course Fee.
Select Distinct INSTITUTE, COURSE, [COURSE FEE]
from dbo.studies 
where [COURSE FEE] = (Select MIN(ST.[COURSE FEE])
				      from dbo.studies as ST);

--7. How many programmers done the PGDCA Course?
Select count(*) AS [PGDCA Course Count] 
from dbo.studies 
where PNAME in (Select P.PNAME from dbo.programmer as P) and COURSE = 'PGDCA';
--or
Select count(*) as [PGDCA Course Count]
from dbo.programmer as p
	inner join dbo.studies as s
			on p.PNAME=s.PNAME and s.COURSE = 'PGDCA';

--8. How much revenue has been earned through sales of Packages Developed in C.
Select SUM(SCOST*SOLD) as [C Developin Revenue] 
from dbo.software 
where DEVELOPIN = 'C';

--9. Display the Details of the Software Developed by Ramesh.
Select *
from dbo.software 
where PNAME='RAMESH'; 

--10. How many Programmers Studied at Sabhari?
Select count(*) as [Sabhari student count] 
from dbo.studies 
where PNAME in (Select P.PNAME from dbo.programmer as P) and INSTITUTE='SABHARI';
--or
Select count(*) as [Sabhari student count] 
from dbo.programmer as p 
	inner join dbo.studies as s 
		on p.PNAME=s.PNAME and s.INSTITUTE='SABHARI';

--11. Display details of Packages whose sales crossed the 2000 Mark.
Select PNAME, TITLE, DEVELOPIN, SCOST, DCOST, SOLD 
from dbo.software 
where SCOST*SOLD > 2000;

--12. Display the Details of Packages for which Development Cost have been recovered.
Select PNAME, TITLE, DEVELOPIN, SCOST, DCOST, SOLD
from dbo.software 
where DCOST <= SCOST * SOLD;

--13. What is the cost of the costliest software development in Basic?
Select * 
from dbo.software 
where DCOST=(Select MAX(S.DCOST) from dbo.software as S where S.DEVELOPIN='BASIC') and DEVELOPIN='BASIC';
--or
Select TOP(1) WITH TIES * 
from dbo.software 
where DEVELOPIN='BASIC' 
order by DCOST DESC;

--14. How many Packages Developed in DBASE?
Select COUNT(*) as [DBASE PKG. Count] 
from dbo.software 
where DEVELOPIN = 'DBASE';

--15. How many programmers studied in Pragathi?
Select count(*) as [Pragathi student count]
from dbo.studies 
where PNAME in (Select P.PNAME from dbo.programmer as P) and INSTITUTE = 'Pragathi';
--or
Select count(*) as [Pragathi student count] 
from dbo.programmer as p
	inner join dbo.studies as s 
			on p.PNAME=s.PNAME and s.INSTITUTE='Pragathi';

--16. How many Programmers Paid 5000 to 10000 for their course?
Select count(Distinct PNAME) as [student count]
from dbo.studies 
where PNAME in (Select P.PNAME from dbo.programmer as P) and [COURSE FEE] between 5000 and 10000;
--or
Select count(p.PNAME) as [student count] 
from dbo.programmer as p 
	inner join dbo.studies as s 
		on p.PNAME=s.PNAME and s.[COURSE FEE] between 5000 and 10000;

--17. What is AVG Course Fee
--considering the number of students in each course as well 
Select AVG([COURSE FEE]) as [Avg. Course Fee]
from dbo.studies;
--or, considering average of distinct course fees thus not taking in the number of students in each course into account
Select AVG([COURSE FEE]) as [Avg. Course Fee]
from (Select DISTINCT INSTITUTE, COURSE, [COURSE FEE] from dbo.STUDIES ) as S;

--18. Display the details of the Programmers Knowing C.
Select * 
from dbo.programmer 
where 'C' in (PROF1, PROF2);

--19. How many Programmers know either COBOL or PASCAL.
Select count(*) as [Count] 
from dbo.programmer 
where (PROF1 in ('COBOL', 'PASCAL') and PROF2 not in ('COBOL', 'PASCAL')) or (PROF1 not in ('COBOL', 'PASCAL') and PROF2 in ('COBOL', 'PASCAL'));

--20. How many Programmers Don’t know PASCAL and C
Select count(*) as [Count] 
from dbo.programmer 
where PROF1 not in ('C','PASCAL') and PROF2 not in ('C','PASCAL');

--21. How old is the Oldest Male Programmer.
Select MAX([Male Age]) AS [Max Male Age] 
from (Select DATEDIFF(MONTH, DOB, GETDATE())/12 as [Male Age] 
	  from dbo.programmer 
	  where GENDER = 'M') as t;

--22. What is the AVG age of Female Programmers?
Select AVG(DATEDIFF(MONTH, DOB, GETDATE())/12) as [Avg. Female Age] 
from dbo.programmer 
where GENDER = 'F';

--23. Calculate the Experience in Years for each Programmer and Display with their names in Descending order.
Select PNAME, DATEDIFF(MONTH, DOJ, GETDATE())/12 as EXPERIENCE 
from dbo.programmer
order by EXPERIENCE DESC;

--24. Who are the Programmers who celebrate their Birthday’s During the Current Month?
Select PNAME, DOB 
from dbo.programmer 
where MONTH(DOB) = MONTH(GETDATE());

--25. How many Female Programmers are there?
Select count(*) as [Female Count]
from dbo.programmer
where GENDER='F'; 

--26. What are the Languages studied by Male Programmers.
With Male_Programmers as
(
Select *
from dbo.programmer
where GENDER='M'
)
Select PROF1 AS [LANGUAGES]
from Male_Programmers
union 
Select PROF2
from Male_Programmers;

--27. What is the AVG Salary?
Select AVG(Salary) as [Avergae Salary]
from dbo.PROGRAMMER;

--28. How many people draw salary 2000 to 4000?
Select count(*) as [People Count]
from dbo.PROGRAMMER
where SALARY between 2000 and 4000;

--29. Display the details of those who don’t know Clipper, COBOL or PASCAL.
Select *
from dbo.PROGRAMMER
where PROF1 not in ('Clipper', 'COBOL', 'PASCAL') and PROF2 not in ('Clipper', 'COBOL', 'PASCAL');

--30. Display the Cost of Package Developed By each Programmer.
Select P.PNAME, S.TITLE, S.SCOST
from dbo.PROGRAMMER as P
	left join dbo.SOFTWARE as S
		on S.PNAME = P.PNAME;

--31. Display the sales values of the Packages Developed by the each Programmer.
Select P.PNAME, S.TITLE, S.SCOST*S.SOLD as [SALES]
from dbo.PROGRAMMER as P
	left join dbo.SOFTWARE as S
		on S.PNAME = P.PNAME;

--32. Display the Number of Packages sold by Each Programmer.
Select P.PNAME, count(S.TITLE) as [Package Count]
from dbo.PROGRAMMER as P
	left join dbo.SOFTWARE as S
		on S.PNAME = P.PNAME
group by P.PNAME;

--33. Display the sales cost of the packages Developed by each Programmer Language wise.
Select P.PNAME, S.DEVELOPIN, SUM(S.SCOST) AS [SALES COST]
from dbo.PROGRAMMER as P
	left join dbo.SOFTWARE as S
		on S.PNAME = P.PNAME
group by P.PNAME, S.DEVELOPIN;

--34. Display each language name with AVG Development Cost, AVG Selling Cost and AVG Price per Copy.
Select DEVELOPIN, AVG(DCOST) AS [AVERAGE DCOST], AVG(SCOST) AS [AVERAGE SCOST], IIF(SUM(SOLD) <> 0, SUM(SCOST*SOLD)/SUM(SOLD), NULL) AS [AVERAGE PRICE PER COPY]
from dbo.SOFTWARE
group by DEVELOPIN;

--35. Display each programmer’s name, costliest and cheapest Packages Developed by him or her.
Select PNAME, (SELECT TOP(1) S2.TITLE
			   from dbo.SOFTWARE as S2
			   where S2.PNAME = P.PNAME
			   order by S2.SCOST DESC) as [COSTLIEST PACKAGE], 
			   (SELECT TOP(1) S3.TITLE
			   from dbo.SOFTWARE as S3
			   where S3.PNAME = P.PNAME
			   order by S3.SCOST ASC) as [CHEAPEST PACKAGE]
from dbo.Programmer as P;

--36. Display each institute name with number of Courses, Average Cost per Course.
Select INSTITUTE, COUNT(*) as [NO. OF COURSES], AVG([COURSE FEE]) as [AVG. COURSE FEE]
from (Select Distinct INSTITUTE, COURSE, [COURSE FEE] from dbo.STUDIES) as S
group by INSTITUTE;

--37. Display each institute Name with Number of Students.
Select INSTITUTE, COUNT(Distinct PNAME) as [STUDENT COUNT]
from dbo.STUDIES
group by INSTITUTE;

--38. Display Names of Male and Female Programmers. Gender also.
Select PNAME, GENDER from dbo.PROGRAMMER where GENDER in ('M', 'F');

--39. Display the Name of Programmers and Their Packages.
Select P.PNAME, S.TITLE
from dbo.PROGRAMMER as P
	INNER join dbo.SOFTWARE as S
		on S.PNAME = P.PNAME;

--40. Display the Number of Packages in Each Language Except C and C++.
Select DEVELOPIN, count(*) as [NO. OF PACKAGES]
from dbo.SOFTWARE
where DEVELOPIN not in ('C', 'CPP')
group by DEVELOPIN;

--41. Display the Number of Packages in Each Language for which Development Cost is less than 1000.
Select DEVELOPIN, count(*) as [NO. OF PACKAGES]
from dbo.SOFTWARE
where DCOST < 1000
group by DEVELOPIN;

--42. Display AVG Difference between SCOST, DCOST for Each Package.
Select TITLE, DEVELOPIN, ABS(DCOST - SCOST) as [DIFFERENCE]
from dbo.SOFTWARE;

--43. Display the total SCOST, DCOST and amount to Be Recovered for each Programmer for Those Whose Cost has not yet been Recovered.
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


--44. Display Highest, Lowest and Average Salaries for those earning more than 2000.
Select MAX(SALARY) AS [HIGHEST SALARY], MIN(SALARY) AS [LOWEST SALARY], AVG(SALARY) as [AVERAGE SALARY]
from dbo.PROGRAMMER
where SALARY > 2000;

--45. Who is the Highest Paid C Programmers?
Select TOP(1) WITH TIES PNAME, PROF1, PROF2, SALARY
from dbo.PROGRAMMER
where 'C' in (PROF1, PROF2)
order by SALARY DESC;

--46. Who is the Highest Paid Female COBOL Programmer?
Select TOP(1) WITH TIES PNAME, GENDER, PROF1, PROF2, SALARY
from dbo.PROGRAMMER
where 'COBOL' in (PROF1, PROF2) AND GENDER = 'F'
order by SALARY DESC;

--47. Display the names of the highest paid programmers for each Language.
With LANGUAGES_TABLE AS
(
Select PROF1 as LANGUAGES 
from dbo.PROGRAMMER
UNION
Select PROF2
from dbo.PROGRAMMER
)
Select L.LANGUAGES, P1.PNAME, P1.SALARY
from LANGUAGES_TABLE as L
	cross apply
		(Select TOP(1) WITH TIES P.* 
		 from dbo.PROGRAMMER as P
		 where L.LANGUAGES in (P.PROF1, P.PROF2)
		 order by P.SALARY DESC) as P1;

--48. Who is the least experienced Programmer.
Select TOP(1) WITH TIES PNAME, DOJ, EXPERIENCE
from (Select PNAME, DOJ, DATEDIFF(MONTH, DOJ, GETDATE())/12 AS EXPERIENCE
	  from dbo.PROGRAMMER) as P
order by DOJ DESC;

--49. Who is the most experienced male programmer knowing PASCAL.
Select TOP(1) WITH TIES PNAME, DOJ, EXPERIENCE
from (Select PNAME, DOJ, DATEDIFF(MONTH, DOJ, GETDATE())/12 AS EXPERIENCE
	  from dbo.PROGRAMMER where GENDER = 'M' AND 'PASCAL' in (PROF1, PROF2)) as P
order by DOJ;

--50. Which Language is known by only one Programmer?
WITH LANGUAGES_TABLE AS 
(
Select PROF1 as LANGUAGES 
from dbo.PROGRAMMER
UNION ALL
Select PROF2
from dbo.PROGRAMMER
)
Select LANGUAGES
from LANGUAGES_TABLE
group by LANGUAGES
having COUNT(*) = 1;

--51. Who is the Above Programmer Referred in 50?
WITH LANGUAGES_TABLE AS 
(
Select PNAME, PROF1 as LANGUAGES 
from dbo.PROGRAMMER
UNION ALL
Select PNAME, PROF2
from dbo.PROGRAMMER
),SINGLE_LANGUAGES AS
(
Select LANGUAGES
from LANGUAGES_TABLE
group by LANGUAGES
having COUNT(*) = 1
)
Select PNAME, LANGUAGES
from LANGUAGES_TABLE
where LANGUAGES in (Select LANGUAGES from SINGLE_LANGUAGES);

--52. Who is the Youngest Programmer knowing DBASE?
Select TOP(1) WITH TIES PNAME, DATEDIFF(MONTH, DOB, GETDATE())/12 AS AGE
from dbo.PROGRAMMER
where 'DBASE' in (PROF1, PROF2)
order by DOB DESC;

--53. Which Female Programmer earning more than 3000 does not know C, C++, ORACLE or DBASE?
Select *
from dbo.PROGRAMMER
where GENDER = 'F' and PROF1 not in ('C', 'CPP', 'ORACLE', 'DBASE') And PROF2 not in ('C', 'CPP', 'ORACLE', 'DBASE') and salary > 3000;

--54. Which Institute has most number of Students?
Select TOP(1) WITH TIES INSTITUTE, COUNT(Distinct PNAME) as [STUDENT COUNT]
from dbo.STUDIES
group by INSTITUTE
order by [STUDENT COUNT] DESC;

--55. What is the Costliest course?
Select DISTINCT INSTITUTE, COURSE, [COURSE FEE]
from dbo.STUDIES
where [COURSE FEE] = (Select MAX(ST.[COURSE FEE]) from dbo.studies as ST);

--56. Which course has been done by the most of the Students?
Select TOP(1) WITH TIES COURSE, COUNT(*) as [STUDENT COUNT]
from dbo.STUDIES
group by COURSE
order by [STUDENT COUNT] DESC;

--57. Which Institute conducts costliest course.
Select DISTINCT INSTITUTE, COURSE, [COURSE FEE]
from dbo.STUDIES
where [COURSE FEE] = (Select MAX(ST.[COURSE FEE]) from dbo.studies as ST);

--58. Display the name of the Institute and Course, which has below AVG course fee.
With Distinct_courses as
(
Select DISTINCT INSTITUTE, COURSE, [COURSE FEE] from dbo.STUDIES
)
Select *
from Distinct_courses
where [COURSE FEE] < (Select AVG(DC.[COURSE FEE]) from Distinct_courses as DC);

--59. Display the names of the courses whose fees are within 1000 (+ or -) of the Average Fee
Create view VW_distinct_course as
(
Select DISTINCT INSTITUTE, COURSE, [COURSE FEE] from dbo.STUDIES
)

DECLARE @AVG_COURSE_FEE AS REAL = (Select AVG([COURSE FEE]) as [Avg. Course Fee]
								   from dbo.VW_distinct_course)

Select *
from dbo.VW_distinct_course
where [COURSE FEE] BETWEEN @AVG_COURSE_FEE - 1000 AND @AVG_COURSE_FEE + 1000;

--60. Which package has the Highest Development cost?
Select TOP(1) WITH TIES *
from dbo.SOFTWARE
order by DCOST DESC;

--61. Which course has below AVG number of Students?
With COURSE_COUNT as
(
Select COURSE, COUNT(*) AS [STUDENT COUNT]
from dbo.STUDIES
group by COURSE
)
Select COURSE 
from COURSE_COUNT 
where [STUDENT COUNT] < (Select SUM(C.[STUDENT COUNT])/CAST(COUNT(*) AS REAL) from COURSE_COUNT as C);

--62. Which Package has the lowest selling cost?
Select TOP(1) WITH TIES *
from dbo.SOFTWARE
order by SCOST;

--63. Who Developed the Package that has sold the least number of copies?
Select TOP(1) WITH TIES PNAME, TITLE, SOLD
from dbo.SOFTWARE
order by SOLD;

--64. Which language has used to develop the package, which has the highest sales amount?
Select Distinct DEVELOPIN
from dbo.SOFTWARE
where SCOST*SOLD = (Select MAX(S.SOLD*S.SOLD) from dbo.SOFTWARE as S);

--65. How many copies of package that has the least difference between development and selling cost where sold.
Select TOP(1) WITH TIES PNAME, TITLE, SOLD, ABS(DCOST-SCOST) as [COST DIFFERENCE]
from dbo.SOFTWARE
order by [COST DIFFERENCE];

--66. Which is the costliest package developed in PASCAL.
Select TOP(1) WITH TIES TITLE, DEVELOPIN, SCOST
from dbo.SOFTWARE
where DEVELOPIN = 'PASCAL'
order by SCOST DESC;

--67. Which language was used to develop the most number of Packages.
Select TOP(1) WITH TIES DEVELOPIN, COUNT(*) AS [PACKAGE COUNT]
from dbo.SOFTWARE
group by DEVELOPIN
ORDER BY [PACKAGE COUNT] DESC;

--68. Which programmer has developed the highest number of Packages?
Select TOP(1) WITH TIES P.PNAME, count(S.TITLE) as [PACKAGE COUNT]
from dbo.PROGRAMMER as P
	left join dbo.SOFTWARE as S
		on P.PNAME = S.PNAME
group by P.PNAME
order by [PACKAGE COUNT] DESC;

--69. Who is the Author of the Costliest Package?
Select PNAME, TITLE, DEVELOPIN, SCOST
from dbo.SOFTWARE
where SCOST = (Select MAX(S.SCOST) from dbo.SOFTWARE as S);

--70. Display the names of the packages, which have sold less than the AVG number of copies.
Select TITLE, SOLD
from dbo.SOFTWARE
where SOLD < (Select AVG(S.SOLD) from dbo.SOFTWARE as S);

--71. Who are the authors of the Packages, which have recovered more than double the Development cost?
Select PNAME, TITLE
from dbo.SOFTWARE
where 2*DCOST < SCOST*SOLD;

--72. Display the programmer Name and the cheapest packages developed by them in each language.
with prog_soft as
(
Select P.PNAME, S.TITLE, S.DEVELOPIN, S.SCOST
from dbo.PROGRAMMER as P
	inner join dbo.SOFTWARE as S
		on P.PNAME = S.PNAME
)
Select DEVELOPIN, PNAME, TITLE as [CHEAPEST PACKAGE], SCOST
from prog_soft as PS
where SCOST = (Select MIN(S.SCOST) from dbo.SOFTWARE as S where PS.DEVELOPIN = S.DEVELOPIN)
order by DEVELOPIN;

--73. Display the language used by each programmer to develop the Highest Selling and Lowest-selling package.
CREATE VIEW VW_prog_soft as
(
Select P.PNAME, S.TITLE, S.DEVELOPIN, S.SOLD
from dbo.PROGRAMMER as P
	inner join dbo.SOFTWARE as S
		on P.PNAME = S.PNAME
)

Select PNAME, TITLE, DEVELOPIN, SOLD
from dbo.VW_prog_soft as PS
where SOLD = (Select MIN(S.SOLD) from dbo.SOFTWARE as S);

Select PNAME, TITLE, DEVELOPIN, SOLD
from dbo.VW_prog_soft as PS
where SOLD = (Select MAX(S.SOLD) from dbo.SOFTWARE as S);

--74. Who is the youngest male Programmer born in 1965?
Select TOP(1) WITH TIES PNAME, DOB
from dbo.PROGRAMMER
where DOB >= '19650101' and DOB < '19660101' and GENDER = 'M'
order by DOB DESC;

--75. Who is the oldest Female Programmer who joined in 1992?
Select TOP(1) WITH TIES PNAME, DOJ, DOB
from dbo.PROGRAMMER
where DOJ >= '19920101' and DOJ < '19930101' and GENDER = 'F'
order by DOB;

--76. In which year was the most number of Programmers born.
Select TOP(1) WITH TIES [BIRTH YEAR], count(*) as [COUNT]
from (Select *, YEAR(DOB) AS [BIRTH YEAR]
	  from dbo.PROGRAMMER) as P
group by [BIRTH YEAR]
order by [COUNT] DESC;

--77. In which month did most number of programmers join?
Select TOP(1) WITH TIES [JOIN MONTH], count(*) as [COUNT]
from (Select *, DATENAME(MONTH, DOJ) AS [JOIN MONTH]
	  from dbo.PROGRAMMER) as P
group by [JOIN MONTH]
order by [COUNT] DESC;

--78. In which language are most of the programmer’s proficient.
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

--79. Who are the male programmers earning below the AVG salary of Female Programmers?
Select PNAME, GENDER, SALARY
from dbo.PROGRAMMER
where GENDER = 'M' and SALARY < (Select AVG(P.SALARY) from dbo.PROGRAMMER as P where P.GENDER = 'F');

--80. Who are the Female Programmers earning more than the Highest Paid?
Select PNAME, GENDER, SALARY
from dbo.PROGRAMMER
where GENDER = 'F' and SALARY > (Select MAX(P.SALARY) from dbo.PROGRAMMER as P);

--81. Which language has been stated as the proficiency by most of the Programmers?
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

--82. Display the details of those who are drawing the same salary.
Select *
from dbo.PROGRAMMER as P1
where SALARY in (Select P.SALARY from dbo.PROGRAMMER as P group by P.SALARY having COUNT(*) > 1);

--83. Display the details of the Software Developed by the Male Programmers Earning More than 3000/-.
Select S.*, P.SALARY
from (Select * from dbo.PROGRAMMER where GENDER = 'M' and SALARY > 3000) AS P
	  left join dbo.SOFTWARE as S
		on P.PNAME = S.PNAME;

--84. Display the details of the packages developed in Pascal by the Female Programmers.
Select P.PNAME, S.TITLE, S.DEVELOPIN, S.SCOST, S.DCOST, S.SOLD
from (Select * from dbo.PROGRAMMER where GENDER = 'F') AS P
	  inner join (Select * from dbo.SOFTWARE where DEVELOPIN = 'PASCAL') as S
		on P.PNAME = S.PNAME;
--or
Select S.*, P.SALARY
from dbo.PROGRAMMER AS P
	  inner join dbo.SOFTWARE as S
		on P.PNAME = S.PNAME and P.GENDER = 'F' and S.DEVELOPIN = 'PASCAL';

--85. Display the details of the Programmers who joined before 1990.
Select *
from dbo.PROGRAMMER
where DOJ < '19900101';

--86. Display the details of the Software Developed in C By female programmers of Pragathi.
Select SO.*, ST.INSTITUTE, P.GENDER
from dbo.PROGRAMMER as P
	 inner join dbo.STUDIES as ST
		on P.PNAME = ST.PNAME and P.GENDER = 'F' and ST.INSTITUTE = 'PRAGATHI'
	 inner join dbo.SOFTWARE as SO
		on P.PNAME = SO.PNAME;

--87. Display the number of packages, No. of Copies Sold and sales value of each programmer institute wise.
Select ST.INSTITUTE, count(SO.TITLE) as [NO.OF PACKAGES], SUM(SO.SOLD) AS [NO.OF COPIES SOLD], SUM(SO.SCOST*SO.SOLD) AS [SALES VALUE]
from dbo.STUDIES as ST
	 left join dbo.PROGRAMMER as P
		on P.PNAME = ST.PNAME
	 left join dbo.SOFTWARE as SO
		on P.PNAME = SO.PNAME
group by ST.INSTITUTE;

--88. Display the details of the software developed in DBASE by Male Programmers, who belong to the institute in which most number of Programmers studied.
With INSTITUTE_SUMMARY AS
(
Select TOP(1) WITH TIES ST.INSTITUTE, count(P.PNAME) as [PROGRAMMER COUNT]
from dbo.STUDIES as ST
	 left join dbo.PROGRAMMER as P
		on P.PNAME = ST.PNAME
group by ST.INSTITUTE
order by [PROGRAMMER COUNT] DESC
)
Select *
from dbo.SOFTWARE
where DEVELOPIN = 'DBASE' and PNAME in (Select P.PNAME from dbo.PROGRAMMER as P
				inner join dbo.STUDIES as S
					on P.PNAME = S.PNAME and P.GENDER = 'M' and S.INSTITUTE IN (Select IST.INSTITUTE 
																				from INSTITUTE_SUMMARY as IST)) ;

--89. Display the details of the software Developed by the male programmers Born before 1965 and female programmers born after 1975.
Select S.*
from dbo.PROGRAMMER AS P
	  inner join dbo.SOFTWARE as S
		on P.PNAME = S.PNAME and ((P.GENDER = 'M' and P.DOB < '19650101') or (P.GENDER = 'F' and P.DOB > '19751231'));
--or
Select *
from dbo.SOFTWARE
where PNAME in (Select P.PNAME from dbo.PROGRAMMER as P where (P.GENDER = 'M' and P.DOB < '19650101') or (P.GENDER = 'F' and P.DOB > '19751231'));

--90. Display the details of the software that has developed in the language which is neither the first nor the second proficiency of the programmers.
WITH LANGUAGES_TABLE AS 
(
Select PROF1 as LANGUAGES 
from dbo.PROGRAMMER
UNION
Select PROF2
from dbo.PROGRAMMER
)
Select *
from dbo.SOFTWARE
where DEVELOPIN not in (Select L.LANGUAGES from LANGUAGES_TABLE AS L)

--91. Display the details of the software developed by the male students of Sabhari.
With students as
(
Select P.PNAME from dbo.PROGRAMMER as P
				    inner join dbo.STUDIES as ST
						on P.PNAME = ST.PNAME and P.GENDER = 'M' and ST.INSTITUTE = 'Sabhari'
)
Select *
from dbo.SOFTWARE 
where PNAME in (Select S.PNAME from students as S);

--92. Display the names of the programmers who have not developed any packages.
Select PNAME
from dbo.PROGRAMMER
where PNAME not in (Select S.PNAME from dbo.SOFTWARE as S);
--or
Select P.PNAME
from dbo.PROGRAMMER as P
	 left join dbo.SOFTWARE as S
		on P.PNAME = S.PNAME
where S.PNAME is NULL;

--93. What is the total cost of the Software developed by the programmers of Apple?
With APPLE_PROGRAMMERS AS
(
Select P.PNAME
from dbo.PROGRAMMER as P
	 inner join dbo.STUDIES as S
		on P.PNAME = S.PNAME and S.INSTITUTE = 'APPLE'
)
Select SUM(SCOST) as [TOTAL COST]
from dbo.SOFTWARE
where PNAME in (Select A.PNAME from APPLE_PROGRAMMERS as A);

--94. Who are the programmers who joined on the same day?
Select PNAME, DOJ
from dbo.PROGRAMMER as P1
where EXISTS(Select * from dbo.PROGRAMMER as P2 where P2.DOJ = P1.DOJ and P2.PNAME <> P1.PNAME)
order by DOJ;
--or
WITH DOJ_LIST AS
(
Select DOJ
from dbo.PROGRAMMER
group by DOJ
having count(*) > 1
)
Select PNAME, DOJ
from dbo.PROGRAMMER
where DOJ IN (Select D.DOJ from DOJ_LIST as D)
order by DOJ;

--95. Who are the programmers who have the same Prof2?
Select PNAME, PROF2
from dbo.PROGRAMMER as P1
where EXISTS(Select * from dbo.PROGRAMMER as P2 where P2.PROF2 = P1.PROF2 and P2.PNAME <> P1.PNAME)
order by PROF2;

--96. Display the total sales value of the software, institute wise.
Select ST.INSTITUTE, SUM(SO.SCOST*SO.SOLD) AS [SALES VALUE]
from dbo.STUDIES as ST
	 left join dbo.PROGRAMMER as P
		on P.PNAME = ST.PNAME
	 left join dbo.SOFTWARE as SO
		on P.PNAME = SO.PNAME
group by ST.INSTITUTE;

--97. In which institute does the person who developed the costliest package studied.
Select SO.PNAME, ST.INSTITUTE
from dbo.SOFTWARE AS SO
	 left join dbo.STUDIES as ST
		on SO.PNAME = ST.PNAME
where SO.SCOST = (Select MAX(S.SCOST) from dbo.SOFTWARE as S);

--98. Which language listed in prof1, prof2 has not been used to develop any package.
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

--99. How much does the person who developed the highest selling package earn and what course did HE/SHE undergo.
Select SO.PNAME, SO.SOLD, P.SALARY, ST.COURSE
from dbo.SOFTWARE as SO
	 left join dbo.PROGRAMMER as P
		on SO.PNAME = P.PNAME
	left join dbo.STUDIES as ST
	    on ST.PNAME = SO.PNAME
where SO.SOLD = (Select MAX(S.SOLD) from dbo.SOFTWARE as S);

--100. What is the AVG salary for those whose software sales is more than 50,000/-.
Select AVG(SALARY) as [AVERAGE SALARY]
from dbo.PROGRAMMER
where PNAME in (Select S.PNAME 
				from dbo.SOFTWARE as S 
				where S.SCOST * S.SOLD > 50000);

--101. How many packages were developed by students, who studied in institute that charge the lowest course fee?
Select ST.INSTITUTE, count(SO.TITLE) as [PACKAGE COUNT]
from dbo.STUDIES as ST
	 left join dbo.SOFTWARE as SO
		on ST.PNAME = SO.PNAME
where ST.INSTITUTE in (Select top(1) with ties S.INSTITUTE from dbo.STUDIES as S order by S.[COURSE FEE])
group by ST.INSTITUTE;

--102. How many packages were developed by the person who developed the cheapest package, where did HE/SHE study?
With package_count as
(
Select PNAME, count(TITLE) as [PACKAGE COUNT]
from dbo.SOFTWARE
group by PNAME
having MIN(SCOST) = (Select MIN(S.SCOST) from dbo.SOFTWARE as S)
)
Select P.*, S.INSTITUTE
from package_count as P
	 left join dbo.STUDIES as S
		on P.PNAME = S.PNAME;

--103. How many packages were developed by the female programmers earning more than the highest paid male programmer?
WITH FEMALE_PROGRAMMERS AS 
(
Select PNAME 
from dbo.PROGRAMMER
where GENDER = 'F' and SALARY > (Select MAX(P.SALARY) from dbo.PROGRAMMER as P where P.GENDER = 'M')
)
Select F.PNAME, count(S.TITLE) as [PACKAGE COUNT]
from FEMALE_PROGRAMMERS as F
	 left join dbo.SOFTWARE as S
		on F.PNAME = S.PNAME
group by F.PNAME;

--104. How many packages are developed by the most experienced programmer form BDPS.
WITH BPDS_EXP_PROGRAMMERS AS 
(
Select TOP(1) WITH TIES P.PNAME 
from dbo.PROGRAMMER as P
	 inner join dbo.STUDIES as S
		on P.PNAME = S.PNAME and S.INSTITUTE = 'BDPS'
order by P.DOJ 
)
Select B.PNAME, count(S.TITLE) as [PACKAGE COUNT]
from BPDS_EXP_PROGRAMMERS as B
	 left join dbo.SOFTWARE as S
		on B.PNAME = S.PNAME
group by B.PNAME;

--105. List the programmers (form the software table) and the institutes they studied.
Select P.PNAME, S1.INSTITUTE
from dbo.PROGRAMMER as P
	 left join dbo.STUDIES as S1
		on P.PNAME = S1.PNAME
where P.PNAME in (Select S2.PNAME from dbo.SOFTWARE as S2);

--106. List each PROF with the number of Programmers having that PROF and the number of the packages in that PROF.
WITH LANGUAGES_TABLE AS 
(
Select PROF1 as LANGUAGE
from dbo.PROGRAMMER
UNION ALL
Select PROF2
from dbo.PROGRAMMER
), LANGUAGE_COUNT AS
(
Select LANGUAGE, COUNT(*) AS [PROGRAMMER COUNT]
FROM LANGUAGES_TABLE
GROUP BY LANGUAGE
)
Select L.LANGUAGE, L.[PROGRAMMER COUNT], COUNT(S.DEVELOPIN) AS [PACKAGE COUNT]
from LANGUAGE_COUNT as L
	 left join dbo.SOFTWARE as S
		on L.LANGUAGE = S.DEVELOPIN
group by L.LANGUAGE, L.[PROGRAMMER COUNT];

--107. List the programmer names (from the programmer table) and No. Of Packages each has developed.
Select P.PNAME, count(S.TITLE) as [PACKAGE COUNT]
from dbo.PROGRAMMER as P
	 left join dbo.SOFTWARE as S
		on P.PNAME = S.PNAME
group by P.PNAME;