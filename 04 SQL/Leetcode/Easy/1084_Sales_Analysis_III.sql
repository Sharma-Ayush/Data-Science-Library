/*
1084. Sales Analysis III

Table: Product

+--------------+---------+
| Column Name  | Type    |
+--------------+---------+
| product_id   | int     |
| product_name | varchar |
| unit_price   | int     |
+--------------+---------+
product_id is the primary key of this table.
Each row of this table indicates the name and the price of each product.

Table: Sales

+-------------+---------+
| Column Name | Type    |
+-------------+---------+
| seller_id   | int     |
| product_id  | int     |
| buyer_id    | int     |
| sale_date   | date    |
| quantity    | int     |
| price       | int     |
+-------------+---------+
This table has no primary key, it can have repeated rows.
product_id is a foreign key to the Product table.
Each row of this table contains some information about one sale.

Write an SQL query that reports the products that were only sold in the first quarter of 2019. That is, between 2019-01-01 and 2019-03-31 inclusive.

Return the result table in any order.
*/

--Schema:
Create table dbo.Product (product_id int, product_name varchar(10), unit_price int)
Create table dbo.Sales (seller_id int, product_id int, buyer_id int, sale_date date, quantity int, price int)
Truncate table Product
insert into Product (product_id, product_name, unit_price) values ('1', 'S8', '1000')
insert into Product (product_id, product_name, unit_price) values ('2', 'G4', '800')
insert into Product (product_id, product_name, unit_price) values ('3', 'iPhone', '1400')
Truncate table Sales
insert into Sales (seller_id, product_id, buyer_id, sale_date, quantity, price) values ('1', '1', '1', '2019-01-21', '2', '2000')
insert into Sales (seller_id, product_id, buyer_id, sale_date, quantity, price) values ('1', '2', '2', '2019-02-17', '1', '800')
insert into Sales (seller_id, product_id, buyer_id, sale_date, quantity, price) values ('2', '2', '3', '2019-06-02', '1', '800')
insert into Sales (seller_id, product_id, buyer_id, sale_date, quantity, price) values ('3', '3', '4', '2019-05-13', '2', '2800')

--Solution:
Select P.product_id, P.product_name
from dbo.Product as P
where EXISTS(Select * 
			 from dbo.Sales as S
			 where S.sale_date >= '20190101' and S.sale_date <= '20190331' and S.product_id = P.product_id)
	  AND NOT EXISTS(Select * 
					 from dbo.Sales as S
					 where not(S.sale_date >= '20190101' and S.sale_date <= '20190331') and S.product_id = P.product_id);
--or
Select P.product_id, P.product_name
from dbo.Product as P 
where P.product_id in (Select S.product_id 
					   from dbo.Sales as S 
					   where S.sale_date >= '20190101' and S.sale_date <= '20190331' and S.product_id = P.product_id)
EXCEPT
Select P.product_id, P.product_name
from dbo.Product as P 
where P.product_id in (Select S.product_id 
					   from dbo.Sales as S 
					   where not(S.sale_date >= '20190101' and S.sale_date <= '20190331') and S.product_id = P.product_id)
--or
with cte as
(
Select product_id, case 
		  when sale_date >= '20190101' and sale_date <= '20190331' then 'in'
		  else 'out'
		  end as result
from dbo.Sales
), cte_except as
(
Select product_id
from cte
where result = 'in' and product_id is not null
except
Select product_id
from cte
where result = 'out' and product_id is not null
)
Select c.product_id, P.product_name
from cte_except as c
	 inner join dbo.Product as P
	 on c.product_id = P.product_id;

