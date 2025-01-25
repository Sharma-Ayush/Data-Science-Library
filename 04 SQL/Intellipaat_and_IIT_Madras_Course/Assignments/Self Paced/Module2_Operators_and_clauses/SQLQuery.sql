--Question 1(Method-1) Only detects highest number
select MAX(SOLD) from SOFTWARE

--Question 1(Method-2) Detects highest number and corresponding package(s)
DECLARE @VAR AS INT = (SELECT MAX(SOLD) FROM SOFTWARE)
PRINT @VAR
select PNAME, TITLE, SOLD from SOFTWARE where SOLD=@VAR

--Question 2
select min([COURSE FEE]) as [MINIMUM COURSE FEE] from STUDIES

--Question 3(to be done)

--Question 4(to be done)

--Question 5(to be done)

--Question 6
Select COURSE, count(*) as [No of programmaers] from STUDIES group by COURSE having course='PGDCA'
--OR
Select count(*) as [No of programmaers] from STUDIES WHERE course='PGDCA'

--Question 7
select DEVELOPIN, SUM(SOLD*SCOST) AS Revenue from SOFTWARE group by DEVELOPIN HAVING DEVELOPIN='C'
--OR
select SUM(SOLD*SCOST) AS Revenue from SOFTWARE where DEVELOPIN='C'


--Question 8
Select INSTITUTE, count(*) as [No of programmaers] from STUDIES group by INSTITUTE having INSTITUTE='SABHARI'
--OR
Select count(*) as [No of programmaers] from STUDIES where INSTITUTE='SABHARI'

--Question 9
select DEVELOPIN, COUNT(*) as [Count] from SOFTWARE group by DEVELOPIN HAVING DEVELOPIN='DBASE'
--OR
select COUNT(*) as [Count] from SOFTWARE where DEVELOPIN='DBASE'

--Question 10
Select INSTITUTE, COUNT(*) as [Count] FROM STUDIES GROUP BY INSTITUTE HAVING INSTITUTE='PRAGATHI'
--OR
Select COUNT(*) as [Count] FROM STUDIES WHERE INSTITUTE='PRAGATHI'

--Question 11
Select Count(*) as [Count] from STUDIES where [COURSE FEE] between 5000 and 10000

--Question 12
Select Count(*) as [Count] from PROGRAMMER where PROF1 in ('COBOL', 'PASCAL') or PROF2 in ('COBOL', 'PASCAL')

--Question 13
Select Count(*) as [Female Count] from PROGRAMMER where GENDER='F'

--Question 14
Select AVG(SALARY) as [Average Salary] from PROGRAMMER

--Question 15
Select count(*) from PROGRAMMER where SALARY between 2000 and 4000

--Question 16
Select 

--Question 17
Select TITLE, DEVELOPIN, SCOST, DCOST, SOLD from SOFTWARE where PNAME in (Select T1.PNAME from STUDIES as T1 inner join PROGRAMMER as T2 on T1.PNAME=T2.PNAME where T1.INSTITUTE='SABHARI' and T2.GENDER='M')

--Question 18


--Question 19


--Question 20
Select TITLE, SCOST from SOFTWARE where SCOST in (SelEct MIN(SCOST) FROM SOFTWARE)

--Question 21
Select PNAME from PROGRAMMER where GENDER='F' and SALARY>3000 AND PROF1 NOT in ('C','CPP','ORACLE','DBASE') AND PROF2 not in ('C','CPP','ORACLE','DBASE')

--Question 22


--Question 23
Select PROF1, Count(*) as [Count] from 
(Select PROF1 FROM PROGRAMMER
UNION ALL
Select PROF2 FROM PROGRAMMER) as t
group by PROF1
having count(*)=1

--Question 24


--Question 25


--Question 26
Select DEVELOPIN, count(*) as [Count] from SOFTWARE where DCOST<1000 group by DEVELOPIN

--Question 27
Select MAX(Salary) as [MAX], MIN(SALARY) as [MIN], AVG(SALARY) as [AVG] from PROGRAMMER where salary>2000