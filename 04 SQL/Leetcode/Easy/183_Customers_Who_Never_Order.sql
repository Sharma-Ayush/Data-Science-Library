/*
183. Customers Who Never Order

Table: Customers

+-------------+---------+
| Column Name | Type    |
+-------------+---------+
| id          | int     |
| name        | varchar |
+-------------+---------+
In SQL, id is the primary key column for this table.
Each row of this table indicates the ID and name of a customer.
 

Table: Orders

+-------------+------+
| Column Name | Type |
+-------------+------+
| id          | int  |
| customerId  | int  |
+-------------+------+
In SQL, id is the primary key column for this table.
customerId is a foreign key (join key in Pandas) of the ID from the Customers table.
Each row of this table indicates the ID of an order and the ID of the customer who ordered it.
 

Find all customers who never order anything.

Return the result table in any order.
*/

--Solution:
Select C.name as Customers
from dbo.Customers as C
where C.id not in (Select O.customerId 
				 from dbo.Orders as O 
				 where O.customerId is not null);
--or
Select C.name as Customers
from dbo.Customers as C
where NOT EXISTS(Select * 
				 from dbo.Orders as O 
				 where O.CustomerId = C.id);
--or
Select C.name as Customers
from dbo.Customers as C
	 left join dbo.Orders as O
		on C.id = O.customerId
where O.id is NULL;