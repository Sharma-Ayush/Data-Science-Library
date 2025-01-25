/*
1667. Fix Names in a Table

Table: Users

+----------------+---------+
| Column Name    | Type    |
+----------------+---------+
| user_id        | int     |
| name           | varchar |
+----------------+---------+
In SQL, user_id is the primary key for this table.
This table contains the ID and the name of the user. The name consists of only lowercase and uppercase characters.
 

Fix the names so that only the first character is uppercase and the rest are lowercase.

Return the result table ordered by user_id.
*/

--Schema:
Create table dbo.Users (user_id int, name varchar(40))
Truncate table Users
insert into Users (user_id, name) values ('1', 'aLice')
insert into Users (user_id, name) values ('2', 'bOB')

--Solution:
Select user_id, CONCAT(UPPER(LEFT(name, 1)), LOWER(RIGHT(name, LEN(name)-1))) as name 
from dbo.Users
order by user_id;