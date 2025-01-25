--SQL Case Study - 3

/*
Problem Statement:
You are the database developer of an international bank. You are responsible for
managing the bank’s database. You want to use the data to answer a few
questions about your customers regarding withdrawal, deposit and so on,
especially about the transaction amount on a particular date across various
regions of the world. Perform SQL queries to get the key insights of a customer.
*/

/*
Dataset:
The 3 key datasets for this case study are:
a. Continent: The Continent table has two attributes i.e., region_id and
region_name, where region_name consists of different continents such as
Asia, Europe, Africa etc., assigned with the unique region id.
b. Customers: The Customers table has four attributes named customer_id,
region_id, start_date and end_date which consists of 3500 records.
c. Transaction: Finally, the Transaction table contains around 5850 records
and has four attributes named customer_id, txn_date, txn_type and
txn_amount.
*/

--1. Display the count of customers in each region who have done the transaction in the year 2020.
Select Cont.region_id, Cont.region_name, count(distinct Cst.customer_id) as [Customer count] 
from dbo.Continent as Cont
	 left join dbo.Customers as Cst
		on Cst.region_id = Cont.region_id
where Cst.customer_id in (Select T.customer_id 
						  from dbo.[Transaction] as T
						  where YEAR(T.txn_date) = 2020)
group by Cont.region_id, Cont.region_name;
--or
with cte as 
(
Select region_id, count(distinct customer_id) as [Customer Count]
from dbo.Customers
where customer_id in (Select T.customer_id 
					  from dbo.[Transaction] as T
					  where YEAR(T.txn_date) = 2020)
group by region_id
)
Select C.region_id, C.region_name, ISNULL(cte.[Customer Count], 0) as [Customer count]
from dbo.Continent as C
	 left join cte
		on cte.region_id = C.region_id;
--or
Select Cont.region_id, Cont.region_name, count(distinct Cst.customer_id) as [Customer count]
from dbo.Continent as Cont
	 left join dbo.Customers as Cst
		on Cst.region_id = Cont.region_id
	left join dbo.[Transaction] as T
		on Cst.customer_id = T.customer_id 
where Cst.customer_id is NULL or year(T.txn_date) = 2020
group by Cont.region_id, Cont.region_name;

--2. Display the maximum and minimum transaction amount of each transaction type.
Select txn_type, MIN(txn_amount) as [Min. Transaction Amt.], MAX(txn_amount) as [Max. Transaction Amt.]
from dbo.[Transaction]
group by txn_type;

--3. Display the customer id, region name and transaction amount where transaction type is deposit and transaction amount > 2000.
Select Cst.customer_id, Cont.region_id, T.txn_type, T.txn_amount
from (Select distinct customer_id, region_id from dbo.Customers) as Cst
	 inner join dbo.[Transaction] as T
		on Cst.customer_id = T.customer_id and T.txn_type = 'deposit' and T.txn_amount > 100
	 left join dbo.Continent as Cont
		on Cst.region_id = Cont.region_id;

--4. Find duplicate records in customer table.
--assuming this means duplicate of customer_id(primary key)
with cte as
(
Select customer_id, count(*) as [Count]
from dbo.Customers
group by customer_id
)
Select * 
from dbo.Customers
where customer_id in (Select C.customer_id 
					  from cte as C 
					  where C.[Count] > 1)
order by customer_id;
--or
Select customer_id, region_id, start_date, end_date
from (Select *, SUM(customer_id) over(partition by customer_id) as [SUM] from dbo.Customers ) as C
where [SUM] > customer_id
order by customer_id;

--5. Display the customer id, region name, transaction type and transaction amount for the minimum transaction amount in deposit.
Select TOP(1) WITH TIES Cst.customer_id, Cont.region_id, T.txn_type, T.txn_amount
from (Select distinct customer_id, region_id from dbo.Customers) as Cst
	 inner join dbo.[Transaction] as T
		on Cst.customer_id = T.customer_id and T.txn_type = 'deposit'
	 left join dbo.Continent as Cont
		on Cst.region_id = Cont.region_id
order by T.txn_amount;

--6. Create a stored prcedure to display details of customers in the Transaction table where the transaction date is greater than Jun 2020.
Create Procedure dbo.sp_trans_after_jun_2020
as
begin
Select * from dbo.[Transaction] where txn_date > '20200630'
end

EXEC dbo.sp_trans_after_jun_2020;

--7. Create a stored procedure to insert a record in the Continent table.
Create Procedure dbo.sp_insert_in_continent (@region_id as tinyint, @region_name as nvarchar(50) = NULL)
as
begin
Insert into dbo.Continent values (@region_id, @region_name)
end

EXEC dbo.sp_insert_in_continent @region_id = 6, @region_name = N'Antarctica';


--8. Create a stored procedure to display the details of transactions that happened on a specific day.
Create Procedure dbo.sp_trans_on_a_day (@date as char(8))
as
begin
Select * from dbo.[Transaction] where txn_date = @date
end

EXEC dbo.sp_trans_on_a_day '20200101';

--9. Create a user defined function to add 10% of the transaction amount in a table.
Create function dbo.fn_add_10pc_to_trans()
returns table
as
return select customer_id, txn_date, txn_type, cast(round(txn_amount * 1.1, 0) as smallint) as [new_txn_amount] from dbo.[Transaction]

Select * from dbo.fn_add_10pc_to_trans() as T;

--10. Create a user defined function to find the total transaction amount for a given transaction type.
Create function dbo.fn_total_txn_amt(@TxnType as nvarchar(50))
returns int
as
begin
Declare @var as int = (Select SUM(txn_amount) from dbo.[Transaction] where txn_type = @TxnType)
return @var
end

Select dbo.fn_total_txn_amt('withdrawal');

--11. Create a table value function which comprises the columns customer_id, region_id ,txn_date , txn_type , txn_amount
--which will retrieve data from the above table.
Create function dbo.fn_fetch_txn_data()
returns table
as
return Select C.customer_id, C.region_id, T.txn_date, T.txn_type, T.txn_amount
	   from (Select distinct customer_id, region_id from dbo.Customers) as C
	   inner join dbo.[Transaction] as T
		on C.customer_id = T.customer_id;

Select * from dbo.fn_fetch_txn_data() as T order by customer_id;

--12. Create a TRY...CATCH block to print a region id and region name in a single column.
BEGIN TRY
Select region_id + ' ' + region_name as region from dbo.Continent
END TRY
BEGIN CATCH
PRINT ERROR_MESSAGE()
END CATCH

--13. Create a TRY...CATCH block to insert a value in the Continent table.
BEGIN TRY
Insert into dbo.Continent values(6, 'Antarctica')
END TRY
BEGIN CATCH
PRINT ERROR_MESSAGE()
END CATCH

Select * from dbo.Continent;

--14. Create a trigger to prevent deleting from a table in a database.
Create trigger trg_continent_delete on dbo.Continent instead of delete
as
Begin
PRINT 'Unable to delete from continent table'
End

Delete from dbo.Continent;

--15. Create a trigger to audit the data in a table.
--assuming insertion data to be audited
Create table audit ([Action] varchar(10),
					[Timestamp] datetime Default(GETDATE()),
					region_id tinyint, 
					region_name nvarchar(50));

Create trigger trg_continent_insert on dbo.Continent after insert
as
begin
insert into audit([Action], region_id, region_name)
Select 'Insert', region_id, region_name from inserted
end

insert into dbo.Continent values (6, 'XYZ'), (7, 'ABC');

select * from dbo.Continent;

select * from dbo.Audit;

--16. Create a trigger to prevent login of the same user id in multiple pages.
create trigger tr_limituserconnection on all server for logon
as
begin
Declare @login as nvarchar(100);
Set @login = original_login();
if (select count(*)
	from sys.dm_exec_sessions
	where is_user_process = 1 and original_login_name = @login) > 2
begin
print 'you are not allowed to have more than two connections- login by ' + @login + ' failed'
rollback
end
end 

--17. Display top n customers on the basis of transaction type.
Declare @n as smallint = 5
Select top(@n) * from dbo.[Transaction] where txn_type = 'deposit';

--18. Create a pivot table to display the total purchase, withdrawal and deposit for all the customers.
Select *
from (Select customer_id, txn_type, txn_amount from dbo.[Transaction]) as T
	  pivot (SUM(txn_amount)
			 for txn_type in (purchase, deposit, withdrawal)) as pivot_T
order by pivot_T.customer_id;