/*
511. Game Play Analysis I

Table: Activity

+--------------+---------+
| Column Name  | Type    |
+--------------+---------+
| player_id    | int     |
| device_id    | int     |
| event_date   | date    |
| games_played | int     |
+--------------+---------+
In SQL, (player_id, event_date) is the primary key of this table.
This table shows the activity of players of some games.
Each row is a record of a player who logged in and played a number of games (possibly 0) before logging out on someday using some device.

Find the first login date for each player.

Return the result table in any order.
*/

--Solution:
Select player_id, event_date as first_login
from (Select player_id, event_date, RANK() OVER(partition by player_id order by event_date) as [rank]
	  from dbo.Activity) as A
where [rank] = 1;
--or
With cte as
(
Select distinct player_id
	  from dbo.Activity
)
Select cte.player_id, (Select top(1) event_date 
					   from dbo.Activity as A1 
					   where A1.player_id = cte.player_id 
					   order by A1.event_date) as first_login
from cte;
--or
Select A1.player_id, A1.event_date as first_login
from dbo.Activity as A1
	 left join dbo.Activity as A2
		on A1.player_id = A2.player_id and A1.event_date > A2.event_date
where A2.event_Date is NULL;

