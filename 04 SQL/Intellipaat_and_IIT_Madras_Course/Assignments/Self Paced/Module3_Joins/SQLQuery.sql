--Question 1
Select Count(*) as [Count] from PROGRAMMER where PROF1 Not in ('PASCAL', 'C') and PROF2 Not in ('PASCAL', 'C')
--or
Select Count(*) as [Count] from PROGRAMMER where PROF1='PASCAL' and PROF2='C' OR PROF1='C' and PROF2='PASCAL'

--Question 2
Select PNAME, DOB, DOJ, GENDER, SALARY from PROGRAMMER where PROF1 Not in ('PASCAL', 'COBOL', 'CLIPPER') and PROF2 Not in ('PASCAL', 'COBOL', 'CLIPPER')

--Question 3
Select DEVELOPIN, AVG(DCOST) as [Average DCOST], AVG(SCOST) as [Average SCOST], AVG(SCOST*SOLD) as [Average Price] from SOFTWARE group by DEVELOPIN

--Question 4
Select PNAME, [Count]=
IIF(Programmer.PNAME in (Select PNAME from Software), (Select Count(*) from SOFTWARE group by PNAME having SOFTWARE.PNAME=PROGRAMMER.PNAME), 0)
from PROGRAMMER
--or
Select PNAME, [Count]=IIF(PNAME in (Select PNAME from SOFTWARE), Count(*), 0)
from (Select t1.PNAME, t2.TITLE from Programmer as t1 left join Software as t2 on t1.PNAME=t2.PNAME) as t
group by PNAME
--or
Select PNAME, [Count]=SUM([Boolean])
from (Select t1.PNAME, [Boolean]=IIF(t2.TITLE IS NOT NULL, 1, 0) from Programmer as t1 left join Software as t2 on t1.PNAME=t2.PNAME) as t
group by PNAME

--Question 5
Select PROFIT, Count(Distinct PNAME) as PROGRAMMERS, Count(Distinct DEVELOPIN) as LANGUAGES from (Select *, PROFIT=(SCOST*SOLD-DCOST) from SOFTWARE) as t group by profit having profit>0

--Question 6


--Question 7
Select count(*) from 
(Select * from PROGRAMMER where GENDER='F' and salary>(Select Max(Salary) from Programmer where Gender='M')) as t1 inner join SOFTWARE as t2 on t1.PNAME=t2.PNAME

--Question 8
Select * from PROGRAMMER as t1 inner join STUDIES as t2 on t1.PNAME=t2.PNAME
LEFT JOIN SOFTWARE as t3 on t1.PNAME=t3.PNAME
where t3.SOLD=(Select MAX(SOLD) from SOFTWARE)

--Question 9
Select institute from 
(Select t1.SCOST, t2.institute from SOFTWARE as t1 left join STUDIES as t2 on t1.PNAME=t2.PNAME) as t
where SCOST in (Select MAX(SCOST) from SOFTWARE) 

--Question 10
Select t1.PNAME from PROGRAMMER as t1 left join SOFTWARE AS t2 on t1.PNAME=t2.PNAME where t2.TITLE is NULL

--Question 11
Select TITLE, DEVELOPIN, SCOST, DCOST, SOLD from SOFTWARE where DEVELOPIN not in 
(Select PROF1 from PROGRAMMER Union Select PROF2 from PROGRAMMER)

--Question 12


--Question 13
Select t1.INSTITUTE, ISNULL(SUM(t2.SOLD),0) as [No. of copies sold], COUNT(t2.TITLE) as [No. of packages], ISNULL(SUM(t2.SCOST*t2.SOLD),0) as [Sales Value] from Studies as t1 left join Software as t2 on t1.PNAME=t2.PNAME group by t1.INSTITUTE

--Question 14
Select t1.TITLE, t1. DEVELOPIN, t1.SCOST, t1.DCOST, t1.SOLD from SOFTWARE as t1 left join PROGRAMMER as t2 on t1.PNAME=t2.PNAME where t2.GENDER='M' and t2.SALARY>3000

--Question 15
Select PNAME from PROGRAMMER where GENDER='F' and Salary>(Select MAX(SALARY) FROM PROGRAMMER WHERE GENDER='M')

--Question 16
Select PNAME from PROGRAMMER where GENDER='M' and Salary<(Select AVG(SALARY) FROM PROGRAMMER WHERE GENDER='F')

--Question 17
Select Distinct DEVELOPIN from SOFTWARE where SCOST=(Select MIN(SCOST) FROM SOFTWARE) or SCOST=(Select MAX(SCOST) FROM SOFTWARE)

--Question 18
Select TITLE FROM SOFTWARE where SOLD<(Select AVG(SOLD) from SOFTWARE)

--Question 19
Select TITLE from SOFTWARE where SCOST=(Select MAX(SCOST) FROM SOFTWARE WHERE DEVELOPIN='PASCAL') and DEVELOPIN='PASCAL'
--or
Select t1.* from SOFTWARE as t1 right join (Select DEVELOPIN, MAX(SCOST) as Max_SCOST FROM SOFTWARE GROUP BY DEVELOPIN ) as t2 on t2.DEVELOPIN=t1.DEVELOPIN and t1.SCOST=t2.Max_SCOST
--or
Select t1.TITLE from (Select * from SOFTWARE where DEVELOPIN='PASCAL') as t1 left join SOFTWARE as t2 on t1.DEVELOPIN=t2.DEVELOPIN and t1.SCOST<t2.SCOST where t2.SOLD is NULL

--Question 20
Select TITLE, SOLD FROM SOFTWARE WHERE DCOST-SCOST=(Select MIN(DCOST-SCOST) from SOFTWARE)
--OR
Select t1.TITLE, t1.SOLD from SOFTWARE as t1 left join SOFTWARE as t2 on ABS(t1.DCOST-t1.SCOST)>ABS(t2.DCOST-t2.SCOST) where t2.SOLD is NULL

--Question 21
Select Distinct t1.DEVELOPIN from SOFTWARE as t1 left join SOFTWARE as t2 on t1.SOLD<t2.SOLD where t2.SOLD is NULL

--Question 22
Select t1.PNAME from SOFTWARE as t1 left join SOFTWARE as t2 on t1.SOLD>t2.SOLD where t2.SOLD is NULL


--Question 23
Select COURSE from STUDIES where [COURSE FEE]-(Select AVG([COURSE FEE]) from STUDIES) between -1000 and 1000


--Question 24
Select Institute, course from STUDIES where [COURSE FEE]<(SELECT AVG([COURSE FEE]) FROM STUDIES)

--Question 25
Select t1.INSTITUTE from STUDIES as t1 left join STUDIES as t2 on t1.[COURSE FEE]<t2.[COURSE FEE] where t2.[COURSE FEE] is NULL

--Question 26
Select t1.COURSE, t1.[COURSE FEE] from STUDIES as t1 left join STUDIES as t2 on t1.[COURSE FEE]<t2.[COURSE FEE] where t2.[COURSE FEE] is NULL


