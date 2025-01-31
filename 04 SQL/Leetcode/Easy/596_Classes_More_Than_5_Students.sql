/*
596. Classes More Than 5 Students

Table: Courses

+-------------+---------+
| Column Name | Type    |
+-------------+---------+
| student     | varchar |
| class       | varchar |
+-------------+---------+
In SQL, (student, class) is the primary key column for this table.
Each row of this table indicates the name of a student and the class in which they are enrolled.
 
Find all the classes that have at least five students.

Return the result table in any order.
*/

--Solution:
Select class
from dbo.Courses
group by class
having count(student) >= 5; 