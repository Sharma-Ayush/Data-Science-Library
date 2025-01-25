/*
1179. Reformat Department Table

Table: Department

+-------------+---------+
| Column Name | Type    |
+-------------+---------+
| id          | int     |
| revenue     | int     |
| month       | varchar |
+-------------+---------+
(id, month) is the primary key of this table.
The table has information about the revenue of each department per month.
The month has values in ["Jan","Feb","Mar","Apr","May","Jun","Jul","Aug","Sep","Oct","Nov","Dec"].
 

Write an SQL query to reformat the table such that there is a department id column and a revenue column for each month.

Return the result table in any order.
*/

--Schema:
Create table dbo.Department (id int, revenue int, month varchar(5))
Truncate table Department
insert into Department (id, revenue, month) values ('1', '8000', 'Jan')
insert into Department (id, revenue, month) values ('2', '9000', 'Jan')
insert into Department (id, revenue, month) values ('3', '10000', 'Feb')
insert into Department (id, revenue, month) values ('1', '7000', 'Feb')
insert into Department (id, revenue, month) values ('1', '6000', 'Mar')

--Solution:
Select id, [Jan] as Jan_Revenue,
		   [Feb] as Feb_Revenue,
		   [Mar] as Mar_Revenue,
		   [Apr] as Apr_Revenue,
		   [May] as May_Revenue,
		   [Jun] as Jun_Revenue,
		   [Jul] as Jul_Revenue,
		   [Aug] as Aug_Revenue,
		   [Sep] as Sep_Revenue,
		   [Oct] as Oct_Revenue,
		   [Nov] as Nov_Revenue,
		   [Dec] as Dec_Revenue
from dbo.Department
	 pivot (SUM(revenue)
			for [month] in ([Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dec])) as D;