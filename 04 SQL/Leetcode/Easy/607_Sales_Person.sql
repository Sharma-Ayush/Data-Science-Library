/*
607. Sales Person

Table: SalesPerson

+-----------------+---------+
| Column Name     | Type    |
+-----------------+---------+
| sales_id        | int     |
| name            | varchar |
| salary          | int     |
| commission_rate | int     |
| hire_date       | date    |
+-----------------+---------+
In SQL, sales_id is the primary key column for this table.
Each row of this table indicates the name and the ID of a salesperson alongside their salary, commission rate, and hire date.
 

Table: Company

+-------------+---------+
| Column Name | Type    |
+-------------+---------+
| com_id      | int     |
| name        | varchar |
| city        | varchar |
+-------------+---------+
In SQL, com_id is the primary key column for this table.
Each row of this table indicates the name and the ID of a company and the city in which the company is located.
 

Table: Orders

+-------------+------+
| Column Name | Type |
+-------------+------+
| order_id    | int  |
| order_date  | date |
| com_id      | int  |
| sales_id    | int  |
| amount      | int  |
+-------------+------+
In SQL, order_id is the primary key column for this table.
com_id is a foreign key (join key in Pandas) to com_id from the Company table.
sales_id is a foreign key (join key in Pandas) to sales_id from the SalesPerson table.
Each row of this table contains information about one order. This includes the ID of the company, the ID of the salesperson, the date of the order, and the amount paid.

Find the names of all the salespersons who did not have any orders related to the company with the name "RED".

Return the result table in any order.
*/

--Solution:
Select name
from dbo.SalesPerson
where sales_id not in (Select O.sales_id 
					   from dbo.Orders as O 
					   where O.com_id = (Select C.com_id 
										 from dbo.Company as C 
										 where C.name = 'RED'));
--or
with cte as 
(
Select S.sales_id, S.name, O.order_id, C.name as comp_name
from dbo.SalesPerson as S
	 left join dbo.Orders as O
		on S.sales_id = O.sales_id
	 left join dbo.Company as C
		on O.com_id = C.com_id
where C.name = 'RED'
)
Select name
from dbo.SalesPerson as S
where NOT EXISTS(Select *
				 from cte as c
				 where S.sales_id = c.sales_id);