/*
1729. Find Followers Count

Table: Followers

+-------------+------+
| Column Name | Type |
+-------------+------+
| user_id     | int  |
| follower_id | int  |
+-------------+------+
(user_id, follower_id) is the primary key for this table.
This table contains the IDs of a user and a follower in a social media app where the follower follows the user.
 

Write an SQL query that will, for each user, return the number of followers.

Return the result table ordered by user_id in ascending order.
*/

--Schema:
Create table dbo.Followers(user_id int, follower_id int)
Truncate table Followers
insert into Followers (user_id, follower_id) values ('0', '1')
insert into Followers (user_id, follower_id) values ('1', '0')
insert into Followers (user_id, follower_id) values ('2', '0')
insert into Followers (user_id, follower_id) values ('2', '1')

--Solution:
Select [user_id], count(*) as followers_count
from dbo.Followers
group by [user_id]
order by [user_id];