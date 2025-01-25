/*
586. Customer Placing the Largest Number of Orders

Table: Orders

+-----------------+----------+
| Column Name     | Type     |
+-----------------+----------+
| order_number    | int      |
| customer_number | int      |
+-----------------+----------+
In SQL, order_number is the primary key for this table.
This table contains information about the order ID and the customer ID.
 
Find the customer_number for the customer who has placed the largest number of orders.

The test cases are generated so that exactly one customer will have placed more orders than any other customer.
*/

--Solution:
Select TOP(1) customer_number
from dbo.Orders
group by customer_number
order by count(*) DESC;
