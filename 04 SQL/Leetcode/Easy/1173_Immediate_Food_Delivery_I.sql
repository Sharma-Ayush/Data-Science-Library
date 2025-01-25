/*
1173. Immediate Food Delivery I

Table: Delivery

+-----------------------------+---------+
| Column Name                 | Type    |
+-----------------------------+---------+
| delivery_id                 | int     |
| customer_id                 | int     |
| order_date                  | date    |
| customer_pref_delivery_date | date    |
+-----------------------------+---------+
In SQL, delivery_id is the primary key of this table.
The table holds information about food delivery to customers that make orders at some date and specify a preferred delivery date (on the same order date or after it).
 

If the customer's preferred delivery date is the same as the order date, then the order is called immediate; otherwise, it is called scheduled.

Find the percentage of immediate orders in the table, rounded to 2 decimal places.
*/

--Schema:
Create table dbo.Delivery (delivery_id int, customer_id int, order_date date, customer_pref_delivery_date date)
Truncate table Delivery
insert into Delivery (delivery_id, customer_id, order_date, customer_pref_delivery_date) values ('1', '1', '2019-08-01', '2019-08-02')
insert into Delivery (delivery_id, customer_id, order_date, customer_pref_delivery_date) values ('2', '5', '2019-08-02', '2019-08-02')
insert into Delivery (delivery_id, customer_id, order_date, customer_pref_delivery_date) values ('3', '1', '2019-08-11', '2019-08-11')
insert into Delivery (delivery_id, customer_id, order_date, customer_pref_delivery_date) values ('4', '3', '2019-08-24', '2019-08-26')
insert into Delivery (delivery_id, customer_id, order_date, customer_pref_delivery_date) values ('5', '4', '2019-08-21', '2019-08-22')
insert into Delivery (delivery_id, customer_id, order_date, customer_pref_delivery_date) values ('6', '2', '2019-08-11', '2019-08-13')

--Solution:
with cte as
(
Select case
	   when order_date = customer_pref_delivery_date then 'immediate'
	   else 'scheduled'
	   end as status
from dbo.Delivery
)
Select ROUND((count(*)/(Select CAST(count(*) as Float(24)) from cte))*100, 2) as immediate_percentage 
from cte 
where status = 'immediate';
--or
select round((sum(case 
				  when order_date = customer_pref_delivery_date
				  then 1 else 0 end)/ CAST(count(delivery_id) AS FLOAT(24)) * 100),2) as immediate_percentage
from dbo.delivery;

