--6_Stored Procedure in SQL

/*
Problem Statement:
You have successfully cleared your fifth semester. In the final semester you will
work with views, transactions and exception handling.*/--Tasks To Be Performed:--1. Create a view named ‘customer_san_jose’ which comprises of only those customers who are from San Jose
Create view dbo.customer_san_jose as
Select * 
from dbo.customer 
where city='San Jose';
Go

/*
2. Inside a transaction, update the first name of the customer to Francis where the last name is Jordan:
a. Rollback the transaction
b. Set the first name of customer to Alex, where the last name is Jordan
*/
Begin Transaction
Update dbo.customer set first_name = 'Francis' where last_name = 'Jordan';
Select * from dbo.customer;
Rollback Transaction
Update dbo.customer set first_name = 'Alex' where last_name = 'Jordan';

--3. Inside a TRY... CATCH block, divide 100 with 0, print the default error message.Begin TrySelect 100/0 as Answer;End TryBegin CatchPRINT ERROR_MESSAGE()End Catch