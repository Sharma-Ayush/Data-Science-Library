/*
1581. Customer Who Visited but Did Not Make Any Transactions

Table: Visits

+-------------+---------+
| Column Name | Type    |
+-------------+---------+
| visit_id    | int     |
| customer_id | int     |
+-------------+---------+
visit_id is the primary key for this table.
This table contains information about the customers who visited the mall.
 

Table: Transactions

+----------------+---------+
| Column Name    | Type    |
+----------------+---------+
| transaction_id | int     |
| visit_id       | int     |
| amount         | int     |
+----------------+---------+
transaction_id is the primary key for this table.
This table contains information about the transactions made during the visit_id.
 

Write a SQL query to find the IDs of the users who visited without making any transactions and the number of times they made these types of visits.

Return the result table sorted in any order.
*/

--Schema:
Create table dbo.Visits(visit_id int, customer_id int)
Create table dbo.Transactions(transaction_id int, visit_id int, amount int)
Truncate table Visits
insert into Visits (visit_id, customer_id) values ('1', '23')
insert into Visits (visit_id, customer_id) values ('2', '9')
insert into Visits (visit_id, customer_id) values ('4', '30')
insert into Visits (visit_id, customer_id) values ('5', '54')
insert into Visits (visit_id, customer_id) values ('6', '96')
insert into Visits (visit_id, customer_id) values ('7', '54')
insert into Visits (visit_id, customer_id) values ('8', '54')
Truncate table Transactions
insert into Transactions (transaction_id, visit_id, amount) values ('2', '5', '310')
insert into Transactions (transaction_id, visit_id, amount) values ('3', '5', '300')
insert into Transactions (transaction_id, visit_id, amount) values ('9', '5', '200')
insert into Transactions (transaction_id, visit_id, amount) values ('12', '1', '910')
insert into Transactions (transaction_id, visit_id, amount) values ('13', '2', '970')

--Solution:
Select V.customer_id, count(*) as count_no_trans
from dbo.Visits as V
	 left join dbo.Transactions as T
		on V.visit_id = T.visit_id
where T.transaction_id is NULL
group by V.customer_id;
--or
Select customer_id, count(*) as count_no_trans
from dbo.Visits
where visit_id not in (Select T.visit_id from dbo.Transactions as T where T.visit_id is not null)
group by customer_id;
--or
Select customer_id, count(*) as count_no_trans
from dbo.Visits as V
where NOT EXISTS (Select T.visit_id from dbo.Transactions as T where T.visit_id = V.visit_id)
group by customer_id;