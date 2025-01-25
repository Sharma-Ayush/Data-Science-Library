create database May13
use May13

select * from Fact
select * from Locations
select * from Product

--1. How many states are there where products have been sold ?
select count(distinct state) as counts_state from Locations

--2. How many products are of regular type ?
select count(distinct Product) as counts_product from Product where Type = 'regular'

--3. How much spending has been done on marketing of product id 1
select sum(Marketing) as marketing_of_1 from Fact where ProductId = 1

--4. What is the minimum sales of a product ?
select min(sales) as min_sales from Fact

--5. Display max Cost of Good Sold(COGS).
select max(cogs) as max_cogs from Fact

--6.  Display the Details of the productid where product type is coffee
select ProductId from Product where Product_Type = 'coffee'

--7. Display the details where total_expenses is greater than 40.
select * from fact where Total_Expenses > 40

--8. What is the average sales in Area_Code 719 ?
select avg(Sales) as avg_Sales_719 from Fact where Area_Code = 719

--9. Find out the total profit generated by Colorado state.
select sum(f.Profit) as profit_colorado from fact f
inner join Locations l
on f.Area_Code = l.Area_Code
where l.State = 'colorado'

--or

select sum(Profit) as profit_colorado from fact where Area_Code in
(select Area_Code from Locations where State = 'colorado' )


--10. Display the average inventory for each product id.
select ProductId, avg(Inventory) as avg_inventory from Fact
group by ProductId
order by ProductId

--11. Display state in a sequential order in a location table.
select distinct State from Locations order by State

--12. Display the average budget margin of the area_code
--    where average budget margin should be greater than 100.
select Area_Code, avg(Budget_Margin) as avg_margin from Fact
group by Area_Code
having avg(Budget_Margin) > 100
order by Area_Code

--13. What is the total sales done on date 2010-01-01
select sum(sales) as total_sales from Fact where Date = '2010-01-01'

--14. Display the average total expense of each product id on individual date
select Date, ProductId, avg(Total_Expenses) as avg_expenses from Fact
group by Date, ProductId
order by date,ProductId

--15. Display the table with the following attributes 
--    such as Date, productid, product_type, product, Sales, profit, state, area_code
select f.Date, p.ProductId, p.Product_Type,p.Product,f.Sales,f.Profit,l.State,l.Area_Code
from Fact f
inner join Locations l
on f.Area_Code = l.Area_Code
inner join Product p
on f.ProductId = p.ProductId

--16. Display the rank without any gap to show the Sales wise rank.
select sales,DENSE_RANK()over(order by sales desc) as dranks from Fact

--17. Find the State wise Profit and Sales.
select l.State, sum(f.Profit) as total_profit, sum(f.Sales) as total_sales from Fact f
inner join Locations l
on f.Area_Code = l.Area_Code
group by l.State
order by l.State

--18.  Find the State wise Profit and Sales along with the Product Name.
select l.State,p.Product,sum(f.Profit) as total_profit, sum(f.Sales) as total_sales from fact f
inner join Locations l
on f.Area_Code = l.Area_Code
inner join Product p
on f.ProductId = p.ProductId
group by l.State,p.Product
order by l.State,p.Product

--19.  If there is an increase in sales of 5%. Calculate the increased sales.
select sales,(sales * 1.05) as increased_sales from Fact

--20. Find the maximum profit along with the Product id and Product Type
select p.ProductId,p.Product_Type,max(f.Profit) as max_profit from Fact f
inner join Product p
on f.ProductId = p.ProductId
group by p.ProductId,p.Product_Type
order by p.ProductId,p.Product_Type

--21. Create a Stored Procedure to fetch the result according to the product type from Product
create procedure proc_product @type varchar(30)
as
select * from Product where Product_Type = @type

exec proc_product 'coffee'
exec proc_product 'tea'

--22. Write a query by creating a condition in which if the total expenses is less than 60 then it is a profit or else loss.
select Total_Expenses, iif(Total_Expenses < 60,'Profit','Loss') as Result from fact

--23. Give the total sales value with the Date and productid details. 
--    Use roll-up to pull the data in hierarchical order.
select date, ProductId, sum(sales) as total_sales from Fact
group by date, ProductId with rollup
order by date, ProductId

--24. Apply union and intersection operator on the tables which consist of attribute area code.
select area_code from Fact
union
select area_code from Locations

select area_code from Fact
intersect
select area_code from Locations

--25. Create a user-defined function for the product table to fetch a particular product type based upon the user�s preference.
create function fun_product(@type varchar(30))
returns table
return
(select * from Product where Product_Type = @type)

select * from fun_product('coffee')

--26. Change the product type from coffee to tea where product id is 1 and undo it.
begin transaction
update Product
set Product_Type = 'tea'
where ProductId = 1

rollback transaction

select * from Product


--27. Display the Date, productid and sales where total expenses are between 100 to 200
select date, ProductId, Sales from Fact where Total_Expenses between 100 and 200

--28.  Delete the records in the product table for regular type.
begin transaction
delete from Product where Type = 'regular'

rollback transaction

select * from Product

--29. Display the ASCII value of the fifth character from the column product.
--ASCII -> American Standard Code for Information Interchange
select Product, SUBSTRING(Product,5,1) as characters, ASCII(SUBSTRING(Product,5,1)) as ASCII
from Product