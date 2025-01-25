/*
197. Rising Temperature

Table: Weather

+---------------+---------+
| Column Name   | Type    |
+---------------+---------+
| id            | int     |
| recordDate    | date    |
| temperature   | int     |
+---------------+---------+
id is the primary key for this table.
This table contains information about the temperature on a certain day.
 

Write an SQL query to find all dates' Id with higher temperatures compared to its previous dates (yesterday).

Return the result table in any order.
*/

--Solution:
Select W1.id
from dbo.Weather as W1
where W1.temperature > (Select W2.temperature
						from dbo.Weather as W2
						where W2.recordDate = DATEADD(DAY, -1, W1.recordDate));
--or
Select W1.id
from dbo.Weather as W1
	 inner join dbo.Weather as W2
		on DATEADD(DAY, -1, W1.recordDate) = W2.recordDate and W1.temperature > W2.temperature;
--or
SELECT w1.id as Id
FROM dbo.Weather as w1
	   inner join dbo.Weather as w2
		 	on DATEDIFF(DAY, w1.recordDate, w2.recordDate) = -1 AND w1.temperature > w2.temperature;
