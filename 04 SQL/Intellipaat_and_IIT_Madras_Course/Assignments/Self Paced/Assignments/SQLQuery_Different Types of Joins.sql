----------------Module 3 Assignment--------------------
/*
Problem statement:
You have successfully cleared the 2nd semester. In your 3rd semester you will work with joins and update statement
*/

--Task to be done:
--1. Create an ‘Orders’ table which comprises of these columns – ‘order_id’, ‘order_date’, ‘amount’, ‘customer_id’
Create table Orders (order_id int,
					 order_date date,
					 amount money,
					 customer_id int);

insert into Orders values (1,'2017-03-15',2000,1),
						  (2,'2018-06-21',5000,8),
						  (3,'2019-01-02',7000,2),
						  (4,'2017-04-20',1000,9),
						  (5,'2018-12-15',3000,3);

--2. Make an inner join on ‘Customer’ & ‘Order’ tables on the ‘customer_id’ column
Select * from Customer as c inner join Orders as o on c.customer_id=o.customer_id

--3. Make left and right joins on ‘Customer’ & ‘Order’ tables on the ‘customer_id’ column
Select * from Customer as c left join Orders as o on c.customer_id=o.customer_id
Select * from Customer as c right join Orders as o on c.customer_id=o.customer_id

--4. Update the ‘Orders’ table, set the amount to be 100 where ‘customer_id’ is 3
Update Orders set amount=100 where customer_id=3