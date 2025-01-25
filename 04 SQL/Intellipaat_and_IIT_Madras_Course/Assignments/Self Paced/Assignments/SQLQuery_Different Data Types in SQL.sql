----------------Module 2 Assignment--------------------
/*
Problem statement:
You have successfully cleared the first semester. 
In your second semester you will learn how to create tables, work with where clause and basic operators
*/

--Tasks to be done:
--1. Create a customer table which comprises of these columns – 
--‘customer_id’, ‘first_name’, ‘last_name’, ‘email’, ‘address’, ‘city’,’state’,’zip’
create table customer (customer_id int,
					   first_name varchar(20),
					   last_name varchar(20),
					   email varchar(30),
					   address varchar(30),
					   city varchar(20),
					   state varchar(20),
					   zip int);

--2. Insert 5 new records into the table
insert into customer values (1,'Ayush','Sharma','ayush@gmail.com','xyz','Ghaziabad','Uttar Pradesh',201005),
							(2,'Ayushi','Mishra','ayushi@gmail.com','abc','Ghaziabad','Uttar Pradesh',201005),
							(3,'Abhinav','Sharma','abhinav@rediff.com','def','Ghaziabad','Uttar Pradesh',201005),
							(4,'Garv','Sharma','garv@gmail.com','ghi','Chennai','Tamil Nadu',603004),
							(5,'Gaurav','Raut','gaurav@outlook.com','jkl','San Jose','California',94088);

--3. Select only the ‘first_name’ & ‘last_name’ columns from the customer table
Select first_name, last_name from customer

--4. Select those records where ‘first_name’ starts with “G” and city is ‘San Jose’
Select * from customer where first_name like 'G%' and city='San Jose'