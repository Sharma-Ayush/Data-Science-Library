create database sa2
use sa2
CREATE TABLE studies (PNAME varchar(20), INSTITUTE varchar(20), COURSE 
varchar(20), COURSE_FEE int )
SELECT * FROM studies
INSERT INTO studies values
('ANAND','SABHARI','PGDCA',4500 ),
('ALTAF','COIT','DCA',7200 ),
('JULIANA','BDPS','MCA',22000 ),
('KAMALA','PRAGATHI','DCA',5000 ),
('MARY','SABHARI','PGDCA ',4500 ),
('NELSON','PRAGATHI','DAP',6200 ),
('PATRICK','PRAGATHI','DCAP',5200 ),
('QADIR','APPLE','HDCA',14000 ),
('RAMESH','SABHARI','PGDCA',4500 ),
('REBECCA','BRILLIANT','DCAP',11000 ),
('REMITHA','BDPS','DCS',6000),
('REVATHI','SABHARI','DAP',5000 ),
('VIJAYA','BDPS','DCA',48000);
CREATE TABLE software (PNAME varchar(20), TITLE varchar(20), DEVELOPIN 
varchar(20), SCOST decimal(10,2), DCOST int, SOLD int)
SELECT * FROM software
INSERT INTO software values
('MARY','README','CPP',300, 1200, 84), 
('ANAND','PARACHUTES','BASIC',399.95, 6000, 43 ),
('ANAND','VIDEO TITLING','PASCAL',7500, 16000, 9 ),
('JULIANA','INVENTORY','COBOL',3000, 3500, 0 ),
('KAMALA','PAYROLL PKG.','DBASE',9000, 20000, 7),
('MARY','FINANCIAL ACCT.','ORACLE',18000, 85000, 4), 
('MARY','CODE GENERATOR','C',4500, 20000, 23),
('PATTRICK','README','CPP',300, 1200, 84),
('QADIR','BOMBS AWAY','ASSEMBLY',750, 3000, 11 ),
('QADIR','VACCINES','C',1900, 3100, 21 ),
('RAMESH','HOTEL MGMT.','DBASE',13000, 35000, 4),
('RAMESH','DEAD LEE','PASCAL',599.95, 4500, 73 ),
('REMITHA','PC UTILITIES','C',725, 5000, 51 ),
('REMITHA','TSR HELP PKG.','ASSEMBLY',2500, 6000, 7 ),
('REVATHI','HOSPITAL MGMT.','PASCAL',1100, 75000, 2 ),
('VIJAYA','TSR EDITOR','C',900, 700, 6);
CREATE TABLE programmer (PNAME varchar(20), DOB date, DOJ date, GENDER 
varchar(2), PROF1 varchar(20), PROF2 varchar(20), SALARY int)
SELECT * FROM programmer
INSERT INTO programmer values
('ANAND','12-Apr-66','21-Apr-92','M','PASCAL','BASIC',3200 ),
('ALTAF','02-Jul-64','13-Nov-90','M','CLIPPER','COBOL',2800 ),
('JULIANA','31-Jan-60','21-Apr-90','F','COBOL','DBASE',3000 ),
('KAMALA','30-Oct-68','02-Jan-92','F','C','DBASE',2900 ),
('MARY','24-Jun-70','01-Feb-91','F','CPP','ORACLE',4500 ),
('NELSON','11-Sep-85','11-Oct-89','M','COBOL','DBASE',2500 ),
('PATTRICK','10-Nov-65','21-Apr-90','M','PASCAL','CLIPPER',2800 ),
( 'QADIR','31-Aug-65','21-Apr-91','M','ASSEMBLY','C',3000 ),
('RAMESH','03-May-67','28-Feb-91','M','PASCAL','DBASE',3200 ),
('REBECCA','01-Jan-67','01-Dec-90','F','BASIC','COBOL',2500 ),
('REMITHA','19-Apr-70','20-Apr-93','F','C','ASSEMBLY',3600 ),
('REVATHI','02-Dec-69','02-Jan-92','F','PASCAL','BASIC',3700 ),
('VIJAYA','14-Dec-65','02-May-92','F','FOXPRO','C',3500);

--1. Find out the selling cost AVG for packages developed in Pascal.

   Select avg(scost) from software WHERE Developin='PASCAL'

 --2. Display Names, Ages of all Programmers

   Select PNAME,DOB,DATEDIFF(Month,DOB,GETDATE())/12 as Age FROM Programmmer

-- 3. Display the Names of those who have done the DAP Course.
	Select * from studies where Course='DAP'

--4. Display the Names and Date of Births of all Programmers Born in January.

	Select PNAME,DOB from Programmmer Group by PNAME,DOB Having Month(DOB)=1

--5. What is the Highest Number of copies sold by a Package?

	Select TITLE,MAX(sold) MaX_Sold from software where TITLE  Like '%PKG%' GROUP BY TITLE
	
--6. Display lowest course Fee.
	select * from Studies
	select min(courseFee) as Min_CourseFee from Studies


--7. How many programmers done the PGDCA Course?


Select Count(Course) Programer_Count from 
	(Select A.PNAME,B.Course from Programmmer AS A
	left join Studies AS B
	on A.PNAME=B.PNAME 
	WHERE Course='PGDCA' Group by A.PNAME,B.Course) temp


--8. How much revenue has been earned thru sales of Packages Developed in C.

	select DEVELOPIN,SUM(Sold) AS Total_Revenu from software where DEVELOPIN='C' GROUP BY DEVELOPIN

--9. Display the Details of the Software Developed by Ramesh.

	Select * from software where PNAME='Ramesh'

--10. How many Programmers Studied at Sabhari?

	select * from Programmmer AS A
	left join Studies AS B on A.PNAME=B.PNAME
	Where INSTTUTE='SABHARI'

--11. Display details of Packages whose sales crossed the 2000 Mark.
	
	Select * FROM software where SCOST>2000

	
--12. Display the Details of Packages for which Development Cost have been recovered.

     SELECT * FROM SOFTWARE WHERE SCOST*SOLD >= DCOST;

--13. What is the cost of the costliest software development in Basic?

--14. How many Packages Developed in DBASE?
	Select Count(Developin)  Count_Num from software where DEVELOPIN='DBASE'
	SELECT COUNT(1) FROM software WHERE DEVELOPIN='DBASE'

--15. How many programmers studied in Pragathi?
	
	Select Count(PNAME)  Count_Num from Studies where INSTITUTE='PRAGATHI'
	SELECT COUNT(1) FROM studies WHERE INSTITUTE='PRAGATHI'

--16. How many Programmers Paid 5000 to 10000 for their course?
		
	Select Count(PNAME)  Count_Num from Studies where COURSE_FEE BETWEEN 5000 and 100000



--17. What is AVG Course Fee
	Select AVG(Course_Fee)  Avg_Fees from Studies

--18. Display the details of the Programmers Knowing C.
     select * from Programmmer where Prof1='C'


--19. How many Programmers know either COBOL or PASCAL.

	Select * from Programmmer Where Prof1='C' or Prof2='Cobol' or Prof2='C' OR Prof1='Cobol' 

--20. How many Programmers Don’t know PASCAL and C
	Select * from Programmmer Where Prof1<>'C' and Prof2<>'PASCAL' and Prof2<>'C' and Prof1<>'PASCAL' 

--21. How old is the Oldest Male Programmer.
	Select * from Programmmer
	Select Max(Age) as Max_Age from
	(select *,DATEDIFF(MONTH,DOB,GETDATE())/12 Age FROM Programmmer
	GROUP BY PNAME,DOB,DOJ,Gender,Prof1,Prof2,Salary) Temp


	--Select COLUMN_NAME from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME ='Programmmer'


--22. What is the AVG age of Female Programmers?

	Select Avg(Age) as Avg_Age from
	(select *,DATEDIFF(MONTH,DOB,GETDATE())/12 Age FROM Programmmer
	GROUP BY PNAME,DOB,DOJ,Gender,Prof1,Prof2,Salary) Temp



--23. Calculate the Experience in Years for each Programmer and Display with their
      --names in Descending order.
	  Select * from Programmmer
	  
	  Select *,DATEDIFF(MONTH,DOJ,'2022-07-30')/12  Total_Exp FROM Programmmer 
	  GROUP BY PNAME,DOB,DOJ,Gender,Prof1,Prof2,Salary 
	  ORDER BY Total_Exp Desc 


--24. Who are the Programmers who celebrate their Birthday’s During the Current
--Month?
	select *,MONTH(DOB) Month_Num FROM Programmmer WHERE MONTH(DOB)=7
	
--25. How many Female Programmers are there?
	Select * from Programmmer where Gender='F'

--26. What are the Languages studied by Male Programmers.
	
	Select * from Programmmer where Gender='M'

--27. What is the AVG Salary?

	Select Avg(Salary) Avg_Salary from Programmmer


--28. How many people draw salary 2000 to 4000?
	
	Select * from Programmmer where Salary between 200 and 4000

--29. Display the details of those who don’t know Clipper, COBOL or PASCAL.

	Select * from Programmmer Where Prof1<>'Clipper' and Prof1<>'COBOL' and Prof1<>'PASCAL' and 
	Prof2<>'Clipper' and Prof2<>'COBOL' and Prof2<>'PASCAL' 
	

--30. Display the Cost of Package Developed By each Programmer.
	
	select * from Programmmer


--31. Display the sales values of the Packages Developed by the each Programmer.

	Select *,(SOLD*SCOST) Sale_value FROM software


--32. Display the Number of Packages sold by Each Programmer.

	Select Pname,count(Developin) Number_PakageSold from software GROUP BY PNAME


--33. Display the sales cost of the packages Developed by each Programmer Language wise.
	
	Select Title,Sum(SCOST) Number_PakageSold from software GROUP BY PNAME,Title
	



--34. Display each language name with AVG Development Cost, AVG Selling Cost and
--AVG Price per Copy.
	Select Title,Avg(DCOST) AVG_Dcost,Avg(SCOST) AVG_Scost from software group by Title

--35. Display each programmer’s name, costliest and cheapest Packages Developed by him or
--her.
	
	Select PNAME,Max(Sold),min(sold) from software group by PNAME


--36. Display each institute name with number of Courses, Average Cost per Course.

	Select insttute,Count(Course) Count_Course,Avg(CourseFee) Avg_Cost from Studies group by insttute



--37. Display each institute Name with Number of Students.
	
		Select INSTTUTE,count(Pname) Number_Student from Studies group by INSTTUTE


--38. Display Names of Male and Female Programmers. Gender also.
	Select PNAME,Gender from Programmmer

--39. Display the Name of Programmers and Their Packages.

	Select PNAME,Salary from Programmmer
		

	
--40. Display the Number of Packages in Each Language Except C and C++.
		Select * from Programmmer
		select DEVELOPIN,COUNT(Pname) from software group by DEVELOPIN
	




--41. Display the Number of Packages in Each Language for which Development Cost is
--less than 1000.

	Select TITLE,COunt(DEVELOPIN) Number_of_Packages from software where DCOST<1000 group by TITLE



--42. Display AVG Difference between SCOST, DCOST for Each Package. (Not Done)

	Select DEVELOPIN,(DCOST-SCOST) FROM software

	
	


--43. Display the total SCOST, DCOST and amount to Be Recovered for each
--Programmer for Those Whose Cost has not yet been Recovered.

     SELECT SUM(SCOST),SUM(DCOST) FROM SOFTWARE WHERE SCOST*SOLD <= DCOST;

--44. Display Highest, Lowest and Average Salaries for those earning more than 2000.
	
	Select max(Salary) Max_Salary, Min(Salary) Min_Salary,Avg(Salary) Avg_Salary from Programmmer

--45. Who is the Highest Paid C Programmers?

SELECT TOP 1 * FROM programmer WHERE 'C' IN (PROF1,PROF2)
ORDER BY SALARY DESC

--46. Who is the Highest Paid Female COBOL Programmer?
	
Select Top 1 Salary from (select * from Programmmer order by salary desc) as Temp1



--47. Display the names of the highest paid programmers for each Language.
CREATE TABLE #PLangSal(PROF VARCHAR(20), SAL INT)

INSERT INTO #PLangSal 
SELECT PROF1, MAX(SALARY) AS HighestPay FROM programmer
GROUP BY PROF1


INSERT INTO #PLangSal 
SELECT PROF2, MAX(SALARY) AS HighestPay FROM programmer
GROUP BY PROF2


CREATE TABLE #PLangSalMax(PROF VARCHAR(20), SAL INT)

INSERT INTO #PLangSalMax

SELECT PROF, MAX(SAL) FROM #PLangSal GROUP BY PROF


SELECT PNAME,PROF,SAL FROM programmer INNER JOIN #PLangSalMax
ON PROF=PROF1 OR PROF=PROF2
WHERE SAL=SALARY ORDER BY PROF



	

--48. Who is the least experienced Programmer.

	  
	  
	Select * ,DATEDIFF(MONTH,DOJ,'2022-07-30')/12 Total_EXP from Programmmer where 
	DATEDIFF(MONTH,DOJ,'2022-07-30')/12=
	  (Select Min(DATEDIFF(MONTH,DOJ,'2022-07-30')/12)  Total_Exp FROM Programmmer ) 
	  

--49. Who is the most experienced male programmer knowing PASCAL.

	Select * ,DATEDIFF(MONTH,DOJ,'2022-07-30')/12 Total_EXP from Programmmer where 
	DATEDIFF(MONTH,DOJ,'2022-07-30')/12=
	  (Select Max(DATEDIFF(MONTH,DOJ,'2022-07-30')/12)  Total_Exp FROM Programmmer ) AND  Prof1='PASCAL' AND Gender='M'

--50. Which Language is known by only one Programmer?
WITH MYCTE
AS
(
Select PNAME,Prof1 as AllLanguage from Programmmer
union ALL (Select Pname,Prof2 from Programmmer)
)
Select PNAME,COUNT(PNAME) FROM MYCTE group BY PNAME HAVING COUNT(PNAME)=1 

--51. Who is the Above Programmer Referred in 50?

	Select * from Programmmer where year(doj)=1950

--52. Who is the Youngest Programmer knowing DBASE?

SELECT FLOOR((SYSDATE-DOB)/365) AGE, NAME, PROF1, PROF2 FROM PROGRAMMER WHERE FLOOR((SYSDATE-DOB)/365) = (SELECT MIN(FLOOR((SYSDATE-DOB)/365)) FROM PROGRAMMER WHERE PROF1 LIKE 'DBASE' OR PROF2 LIKE 'DBASE');

--53. Which Female Programmer earning more than 3000 does not know C, C++,
--ORACLE or DBASE?

	Select * from Programmmer where Salary>3000 and Prof1 not in ('C','ORACLE','DBASE')


--54. Which Institute has most number of Students?
	 
	Select INSTTUTE,count(Pname) Count_num FROM Studies group by INSTTUTE

	
--55. What is the Costliest course?
	
	Select Course,CourseFee from studies where Coursefee=(Select max(coursefee) from Studies)

--56. Which course has been done by the most of the Students?
	
	--SELECT COURSE FROM STUDIES GROUP BY COURSE HAVING COUNT(COURSE)= (SELECT MAX(COUNT(COURSE)) FROM STUDIES GROUP BY COURSE);
	--Select * from Studies


	Select max(mycount) from (Select Course,count(course) mycount from Studies group by Course) Temp1 GROUP BY COURSE




--57. Which Institute conducts costliest course.
	select INSTTUTE,max(coursefee) from Studies group by INSTTUTE


--58. Display the name of the Institute and Course, which has below AVG course fee.
	
	Select * from Studies where Coursefee<(Select avg(Coursefee) from Studies)




--59. Display the names of the courses whose fees are within 1000 (+ or -) of the
--Average Fee,

SELECT COURSE FROM STUDIES WHERE CCOST < (SELECT AVG(CCOST)+1000 FROM STUDIES) AND CCOST > (SELECT AVG(CCOST)-1000 FROM STUDIES);

--60. Which package has the Highest Development cost?

SELECT TITLE,DCOST FROM SOFTWARE WHERE DCOST = (SELECT MAX(DCOST) FROM SOFTWARE);

	
--61. Which course has below AVG number of Students?

--SeLECT COURSE FROM STUDIES GROUP BY COURSE HAVING COUNT(PNAME)<(SELECT AVG(COUNT(PNAME)) FROM STUDIES GROUP BY COURSE);


Select INSTTUTE,COUNT(PNAME) Count_name from Studies GROUP BY INSTTUTE
Having COUNT(PNAME) <
(Select Avg(Count_name) from 
(Select INSTTUTE,COUNT(PNAME) Count_name from Studies GROUP BY INSTTUTE) TEMP1) 


--62. Which Package has the lowest selling cost?
	Select Distinct Developin,SCOST from software Where SCOST = (Select min(SCOST) from software)

--63. Who Developed the Package that has sold the least number of copies?

	Select PNAME,SOLD from software where sold=(Select min(sold) from software)

--64. Which language has used to develop the package, which has the highest
--sales amount?
		Select Distinct TITLE,DEVELOPIN,SOLD from software where sold=(Select max(sold) from software)

--65. How many copies of package that has the least difference between
--development and selling cost where sold.

Select SCOST,DCOST,DCOST-SCOST Diff from  SOFTWARE group by SCOST,DCOST Having (DCOST-SCOSt)=(Select min((DCOST-SCOST)) from software)



--66. Which is the costliest package developed in PASCAL.

	Select Developin,DCOST from software where DEVELOPIN='PASCAL' and 
	 DCOST=(Select MAX(DCOST) from software where DEVELOPIN='PASCAL')
	


--67. Which language was used to develop the most number of Packages.
	
	SELECT PROF1 FROM Programmmer GROUP BY PROF1 HAVING PROF1 = (SELECT MAX(PROF1) FROM Programmmer);
	
--68. Which programmer has developed the highest number of Packages?

	Select PNAME,count(DEVELOPIN) as Count_Num from software group by PNAME HAVING
	count(DEVELOPIN)=
	(Select max(count_number)from 
	(Select PNAME,count(DEVELOPIN) count_number from software group by PNAME) temp1)

--69. Who is the Author of the Costliest Package?

		 SELECT PNAME,DCOST FROM SOFTWARE WHERE DCOST = (SELECT MAX(DCOST) FROM   SOFTWARE);

--70. Display the names of the packages, which have sold less than the AVG
--number of copies.

	select * from  software where sold<(Select Avg(sold) from software)



--71. Who are the authors of the Packages, which have recovered more than double the
--Development cost?
	
	SELECT PNAME FROM SOFTWARE WHERE SOLD*SCOST > 2*DCOST;

--72. Display the programmer Name and the cheapest packages developed by them in
--each language.
	
	SELECT PNAME,TITLE FROM SOFTWARE WHERE DCOST IN (SELECT MIN(DCOST) FROM SOFTWARE GROUP BY DEVELOPIN);



--73. Display the language used by each programmer to develop the Highest
--Selling and Lowest-selling package.
	
	Select DISTINCT TITLE,max(sold) Max_sold From software where SOLD=(Select max(sold) from software) group by title
	
	Select DISTINCT TITLE,min(sold) min_sold From software where SOLD=(Select min(sold) from software) group by title


--74. Who is the youngest male Programmer born in 1965?

Select * from Programmmer where Dob= 	
(Select max(dob) from Programmmer where YEAR(DOB)='1965')

--75. Who is the oldest Female Programmer who joined in 1992?

Select * from Programmmer where DOJ= 	
(Select max(DOJ) from Programmmer where YEAR(DOJ)='1992' AND Gender='F')

--Select * from Programmmer where YEAR(DOJ)='1992'

--76. In which year was the most number of Programmers born.

with New_CTE
AS
(Select Year(dob) Year_num,count(dob) count_num from Programmmer group by year(dob))
Select * from New_CTE where count_num=(select max(count_num) from New_CTE)


--77. In which month did most number of programmers join?

WITH NEW_CTE
AS
(Select Month(DOJ) Month_num,count(DOJ) count_num from Programmmer group by Month(DOJ))
Select * from NEW_CTE where count_num=(Select max(count_num) from NEW_CTE)



--78. In which language are most of the programmer’s proficient.
	with New_CTE
	AS
	(Select Prof1,count(prof1) count_num from Programmmer group by Prof1)
	Select * from new_cte where count_num=(Select max(count_num) from New_CTE)
	
	

--79. Who are the male programmers earning below the AVG salary of
--Female Programmers?
	Select PNAME,Salary from Programmmer where Gender='M' AND Salary<
	(Select AVG(salary) from Programmmer where Gender='F')


--80. Who are the Female Programmers earning more than the Highest Paid?
	Select Pname,Salary from Programmmer where Salary>=
	(SELECT MAX(SALARY) FROM Programmmer) and Gender='F'
	
--81. Which language has been stated as the proficiency by most of the Programmers?
	
	with New_CTE
	AS
	(Select Prof1,count(prof1) count_num from Programmmer group by Prof1)
	Select * from new_cte where count_num=(Select max(count_num) from New_CTE)
	
--82. Display the details of those who are drawing the same salary.
		
	Select * from Programmmer AS A
	left join Programmmer AS B
	on A.PNAME=B.PNAME
	WHERE A.Salary=B.Salary

--83. Display the details of the Software Developed by the Male Programmers Earning
--More than 3000/-.

	
	Select A.PNAME,DEVELOPIN,Salary from Programmmer A
	INNER JOIN software B 
	ON 
	A.pNAME=B.PNAME 
	where Salary>=3000 and Gender='M'

--84. Display the details of the packages developed in Pascal by the Female
--Programmers.

	Select A.PNAME,DEVELOPIN,Gender from Programmmer A
	INNER JOIN software B 
	ON 
	A.pNAME=B.PNAME 
	Where DEVELOPIN='Pascal'and Gender='F'

	
--85. Display the details of the Programmers who joined before 1990.
	
	Select DOJ,YEAR(DOJ) Year_Num from Programmmer where YEAR(DOJ)<=1990

	
--86. Display the details of the Software Developed in C By female programmers of
--Pragathi.

	Select A.PNAME,DEVELOPIN,Gender from Programmmer A
	INNER JOIN software B 
	ON 
	A.pNAME=B.PNAME 
	Where DEVELOPIN='C'and A.PNAME='Mary'
	
--87. Display the number of packages, No. of Copies Sold and sales value of
--each programmer institute wise.
	


--88. Display the details of the software developed in DBASE by Male Programmers, who
--belong to the institute in which most number of Programmers studied.
	WITH New_CTE
	AS
	(Select A.PNAME,DEVELOPIN,INSTTUTE,Course,Gender from software A
	LEFT JOIN Programmmer B
	on A.PNAME=B.PNAME
	LEFT JOIN Studies C
	on A.PNAME=C.PNAME)
	Select * from New_CTE WHERE DEVELOPIN='DBASE' AND INSTTUTE IN ('SABHARI') AND Gender='M'


	---Most  number of programer studies

	Select INSTTUTE,count(INSTTUTE) Most_studies from Studies group by INSTTUTE


--89. Display the details of the software Developed by the male programmers Born
--before 1965 and female programmers born after 1975.
	
	Select A.PNAME,Developin,Gender,DOB,YEAR(DOB) Year_Born from Programmmer A
	left join software B
	on A.PNAME=B.PNAME
	where YEAR(DOB)<1965 and Gender='F' OR YEAR(DOB)>1965 and Gender='M'

	

--90. Display the details of the software that has developed in the language which is
		--neither the first nor the second proficiency of the programmers.


WITH New_CTE
AS
(
Select Distinct A.pname,Prof1,Prof2,B.DEVELOPIN from Programmmer A
left join software B
on 
Prof1=DEVELOPIN
left join software C
on
Prof2=C.DEVELOPIN)
Select * from New_CTE where DEVELOPIN is null

--91. Display the details of the software developed by the male students of Sabhari.

	Select * from Studies
	Select * from Programmmer
	Select * from software

	Select A.PNAME,Gender,Developin,INSTTUTE from software A
	left join Programmmer B
	ON A.Pname=B.PNAME
	LEFT JOIN Studies C
	ON A.PNAME=B.PNAME
	WHERE Gender='M' AND INSTTUTE='Sabhari'



--92. Display the names of the programmers who have not developed any packages.
	
	Select * from Studies A
	left join Programmmer B
	on A.PNAME=B.PNAME
	Where b.PNAME is null

--93. What is the total cost of the Software developed by the programmers of Apple?
		Select * from software
		select * from Programmmer

--94. Who are the programmers who joined on the same day?

	
	WITH New_CTE
	AS
	(Select Pname,day(doj)  A from Programmmer)
	Select COUNT(A) from NEW_CTE Group by Pname HAVING COUNT(A)>1
	



--95. Who are the programmers who have the same Prof2?

	
	Select * from Programmmer where prof1=Prof2

--96. Display the total sales value of the software, institute wise.
	
	select Developin,SOLD,INSTTUTE from software a
	left join Studies b
	on a.PNAME=b.pname

--97. In which institute does the person who developed the costliest package studied.
	select Developin,SOLD,INSTTUTE from software a
	left join Studies b
	on a.PNAME=b.pname
	where SOLD=(Select  max(sold) from software)


--98. Which language listed in prof1, prof2 has not been used to develop any package.
select * from Programmmer where Prof1<>Prof2
	


--99. How much does the person who developed the highest selling package earn and
--what course did HE/SHE undergo.

Select P.PNAME,Salary,Course from Programmmer p
INNER  join Studies S
on
P.PNAME=S.PNAME
WHERE Salary=(Select max(Salary) from  Programmmer)


--100. What is the AVG salary for those whose software sales is more than 50,000/-.
	
	Select avg(salary) from
	(
	Select S.PNAME,Salary,(SOLD*SCOST) as total_sale from software S
	left join Programmer p
	ON S.PNAME=P.PNAME
   where (SOLD*SCOST)>50000) temp1

   select avg(Salary) from Programmer p,Software s 
where p .PNAME=s.PNAME and SOLD*SCOST >50000;

--101. How many packages were developed by students, who studied in institute that
--charge the lowest course fee?

Select Distinct DEVELOPIN from Studies A --
LEFT JOIN software B
ON A.PNAME=B.PNAME
where CourseFee=(Select min(coursefee) from Studies)

--102. How many packages were developed by the person who developed the
--cheapest package, where did HE/SHE study?

	SELECT PNAME,TITLE FROM SOFTWARE WHERE DCOST IN (SELECT MIN(DCOST) FROM SOFTWARE GROUP BY DEVELOPIN);

--103. How many packages were developed by the female programmers earning more
--than the highest paid male programmer?

Select DEVELOPIN,COUNT(DEVELOPIN)  Develop_Project from software A
left join Programmmer B
on A.PNAME=B.PNAME
Where Gender='F' AND Salary>(select max(salary) from Programmmer where Gender='M')
group by DEVELOPIN



--104. How many packages are developed by the most experienced programmer form
--BDPS.
	With CTE_NEW AS
	
	(Select a.PNAME,DEVELOPIN,DATEDIFF(Year,DOJ,getdate()) as Total_Experince from Programmmer  A
	left join software B
	ON A.PNAME=B.PNAME) 
	Select * from CTE_NEW WHERE Total_Experince=(SELECT MAX(Total_Experince) from CTE_NEW)
	

	
--105. List the programmers (form the software table) and the institutes they studied.
		
		Select A.PNAME,INSTTUTE from Programmmer A
		left join  Studies B
		on A.PNAME=B.PNAME

--106. List each PROF with the number of Programmers having that PROF and the
--number of the packages in that PROF.

Select Count(prof1) from Programmmer

Select Count(Prof2) from Programmmer


--107. List the programmer names (from the programmer table) and No. Of Packages
--each has developed.

Select A.PNAME,Salary,DEVELOPIN from Programmmer A
		left join  software B
		on A.PNAME=B.PNAME



