/*
1327. List the Products Ordered in a Period

Table: Products

+------------------+---------+
| Column Name      | Type    |
+------------------+---------+
| product_id       | int     |
| product_name     | varchar |
| product_category | varchar |
+------------------+---------+
product_id is the primary key for this table.
This table contains data about the company's products.
 

Table: Orders

+---------------+---------+
| Column Name   | Type    |
+---------------+---------+
| product_id    | int     |
| order_date    | date    |
| unit          | int     |
+---------------+---------+
There is no primary key for this table. It may have duplicate rows.
product_id is a foreign key to the Products table.
unit is the number of products ordered in order_date.
 

Write an SQL query to get the names of products that have at least 100 units ordered in February 2020 and their amount.

Return result table in any order.
*/

--Schema:
Create table dbo.Products (product_id int, product_name varchar(40), product_category varchar(40))
Create table dbo.Orders (product_id int, order_date date, unit int)
Truncate table Products
insert into Products (product_id, product_name, product_category) values ('1', 'Leetcode Solutions', 'Book')
insert into Products (product_id, product_name, product_category) values ('2', 'Jewels of Stringology', 'Book')
insert into Products (product_id, product_name, product_category) values ('3', 'HP', 'Laptop')
insert into Products (product_id, product_name, product_category) values ('4', 'Lenovo', 'Laptop')
insert into Products (product_id, product_name, product_category) values ('5', 'Leetcode Kit', 'T-shirt')
Truncate table Orders
insert into Orders (product_id, order_date, unit) values ('1', '2020-02-05', '60')
insert into Orders (product_id, order_date, unit) values ('1', '2020-02-10', '70')
insert into Orders (product_id, order_date, unit) values ('2', '2020-01-18', '30')
insert into Orders (product_id, order_date, unit) values ('2', '2020-02-11', '80')
insert into Orders (product_id, order_date, unit) values ('3', '2020-02-17', '2')
insert into Orders (product_id, order_date, unit) values ('3', '2020-02-24', '3')
insert into Orders (product_id, order_date, unit) values ('4', '2020-03-01', '20')
insert into Orders (product_id, order_date, unit) values ('4', '2020-03-04', '30')
insert into Orders (product_id, order_date, unit) values ('4', '2020-03-04', '60')
insert into Orders (product_id, order_date, unit) values ('5', '2020-02-25', '50')
insert into Orders (product_id, order_date, unit) values ('5', '2020-02-27', '50')
insert into Orders (product_id, order_date, unit) values ('5', '2020-03-01', '50')

--Solution:
Select P.product_name, sum(O.unit) as unit
from dbo.Products as P
	 inner join dbo.Orders as O
		on P.product_id = O.product_id and O.order_date >= '20200201' and O.order_date < '20200301'
group by P.product_id, P.product_name
having sum(O.unit) >= 100;