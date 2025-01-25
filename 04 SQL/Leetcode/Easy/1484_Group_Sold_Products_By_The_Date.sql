/*
1484. Group Sold Products By The Date

Table Activities:

+-------------+---------+
| Column Name | Type    |
+-------------+---------+
| sell_date   | date    |
| product     | varchar |
+-------------+---------+
This table may contain duplicates (In other words, there is no primary key for this table in SQL).
Each row of this table contains the product name and the date it was sold in a market.
 

Find for each date the number of different products sold and their names.

The sold products names for each date should be sorted lexicographically.

Return the result table ordered by sell_date.
*/

--Schema:
Create table dbo.Activities (sell_date date, product varchar(20))
Truncate table Activities
insert into Activities (sell_date, product) values ('2020-05-30', 'Headphone')
insert into Activities (sell_date, product) values ('2020-06-01', 'Pencil')
insert into Activities (sell_date, product) values ('2020-06-02', 'Mask')
insert into Activities (sell_date, product) values ('2020-05-30', 'Basketball')
insert into Activities (sell_date, product) values ('2020-06-01', 'Bible')
insert into Activities (sell_date, product) values ('2020-06-02', 'Mask')
insert into Activities (sell_date, product) values ('2020-05-30', 'T-Shirt')
insert into Activities (sell_date, product) values ('2020-05-30', NULL)

--Solution:
with cte as
(
Select distinct sell_date, product
from dbo.Activities
)
select sell_date,
count(*) as num_sold,
string_agg(product, ',') WITHIN GROUP (ORDER BY product) as products
from cte
group by sell_date
order by sell_date;