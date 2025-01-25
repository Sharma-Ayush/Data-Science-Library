/*
619. Biggest Single Number

Table: MyNumbers

+-------------+------+
| Column Name | Type |
+-------------+------+
| num         | int  |
+-------------+------+
There is no primary key for this table. It may contain duplicates.
Each row of this table contains an integer.
 

A single number is a number that appeared only once in the MyNumbers table.

Write an SQL query to report the largest single number. If there is no single number, report null.
*/

--Schema:
Create table dbo.MyNumbers (num int)
Truncate table dbo.MyNumbers
insert into MyNumbers (num) values ('8')
insert into MyNumbers (num) values ('8')
insert into MyNumbers (num) values ('3')
insert into MyNumbers (num) values ('3')
insert into MyNumbers (num) values ('1')
insert into MyNumbers (num) values ('4')
insert into MyNumbers (num) values ('5')
insert into MyNumbers (num) values ('6')

--Solution:
Select (Select top(1) num
		from dbo.MyNumbers
		group by num 
		having count(*) = 1
		order by num DESC) as num;
--or
with cte as
(
Select num
from dbo.MyNumbers
group by num
having count(*) = 1
)
Select MAX(num) as num from cte;