/*
610. Triangle Judgement

Table: Triangle

+-------------+------+
| Column Name | Type |
+-------------+------+
| x           | int  |
| y           | int  |
| z           | int  |
+-------------+------+
(x, y, z) is the primary key column for this table.
Each row of this table contains the lengths of three line segments.
 

Write an SQL query to report for every three line segments whether they can form a triangle.

Return the result table in any order.
*/

--Solution:
Select x, y, z, case
				when ((x+y)>z) and ((y+z)>x) and ((z+x)>y) then 'Yes'
				else 'No'
				end as triangle
from dbo.Triangle;