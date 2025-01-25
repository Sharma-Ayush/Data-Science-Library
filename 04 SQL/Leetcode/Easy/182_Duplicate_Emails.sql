/*
182. Duplicate Emails

Table: Person

+-------------+---------+
| Column Name | Type    |
+-------------+---------+
| id          | int     |
| email       | varchar |
+-------------+---------+
id is the primary key column for this table.
Each row of this table contains an email. The emails will not contain uppercase letters.
 

Write an SQL query to report all the duplicate emails. Note that it's guaranteed that the email field is not NULL.

Return the result table in any order.
*/

--Solution:
Select distinct P1.email as Email
from dbo.Person as P1
where EXISTS(Select * 
			 from dbo.Person as P2
			 where P1.id <> P2.id and P1.email = P2.email);
--or
Select email as Email
from dbo.Person
group by email
having count(*) > 1;

