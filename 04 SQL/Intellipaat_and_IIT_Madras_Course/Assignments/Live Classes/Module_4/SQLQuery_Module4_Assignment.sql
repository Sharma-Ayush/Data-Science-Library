----------------Module 4 Assignment--------------------
/*
Problem statement:
You have successfully cleared your 3rd semester. 
In the 4th semester, you will work with inbuilt functions and user-defined functions
*/

--Task to be done:
--1. Use the inbuilt functions and find the minimum, maximum and average amount from the orders table
Select MIN(amount) as [Min. Amount], MAX(amount) as [Max. Amount], AVG(amount) as [Avg. Amount] from Orders 

--2. Create a user-defined function, which will multiply the given number with 10
create function [dbo].[fn_multiply_by_10](@num float(23))
returns float(23)
as
begin
return @num*10
end

Declare @val as int=20
print(concat(@val, ' * 10 = ', [dbo].[fn_multiply_by_10](@val)))

--3. Use the case statement to check if 100 is less than 200, greater than 200 or equal to 200 and print the corresponding value
print(
case
when 100<200 then '100 is less than 200'
when 100>200 then '100 is greater than 200'
when 100=200 then '100 is equal to 200'
end);