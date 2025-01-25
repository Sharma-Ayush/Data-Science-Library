---Question 1
select DEVELOPIN as [LANGUAGE], AVG(SCOST) as [SCOST AVG] from software group by DEVELOPIN having DEVELOPIN='PASCAL'

--Question 2(to be done for age)


--Question 3
select PNAME from STUDIES where COURSE='DAP'

--Question 4
select PNAME, DOB from PROGRAMMER where DOB like '____-01-__'

--Question 5
select TITLE, DEVELOPIN, SCOST, DCOST, SOLD from SOFTWARE where PNAME='RAMESH' 

--Question 6
select TITLE, DEVELOPIN, SCOST, DCOST, SOLD from SOFTWARE where (SCOST*SOLD-DCOST)>=0 

--Question 7
select PNAME, DOB, DOJ, GENDER, SALARY from PROGRAMMER where PROF1='C' or PROF2='C'

--Question 8
select distinct(PROF1) as [LANGUAGES] from PROGRAMMER where GENDER='M' union select distinct(PROF2) from PROGRAMMER where GENDER='M'

--Question 9(to be done)


--Question 10
select distinct(PNAME) from SOFTWARE where (SCOST*SOLD-2*DCOST)>0


