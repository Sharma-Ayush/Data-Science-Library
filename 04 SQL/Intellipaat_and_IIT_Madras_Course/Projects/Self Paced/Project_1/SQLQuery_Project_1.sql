--Project: Querying a Large Relational Database

/*
Problem Statement:
How to get details about customers by querying a database?
*/

/*
Topics:
In this project, you will work on downloading a database and restoring it on the
server. You will then query the database to get customer details like name, phone
number, email ID, sales made in a particular month, increase in month-on-month
sales and even the total sales made to a particular customer.
*/

/*
Highlights:
Table basics and data types
Various SQL operators
Various SQL functions
*/


--Tasks To Be Performed:

USE AdventureWorks2012;

Select * from Person.Person;
Select * from [Person].[PhoneNumberType];
Select * from [Sales].[SalesOrderDetail];
Select * from [Sales].[SalesOrderHeader];
Select * from [Sales].[Customer];

--3. Perform the following with help of the above database:
--a. Get all the details from the person table including email ID, phone number and phone number type
Select P.*, EA.[EmailAddress], PP.[PhoneNumber], PNT.[Name] 
from [Person].[Person] as P
	 left join [Person].[EmailAddress] as EA
		on P.[BusinessEntityID] = EA.[BusinessEntityID]
	 left join [Person].[PersonPhone] as PP
		on P.[BusinessEntityID] = PP.[BusinessEntityID]
	 left join [Person].[PhoneNumberType] as PNT
		on PP.[PhoneNumberTypeID] = PNT.[PhoneNumberTypeID];

--b. Get the details of the sales header order made in May 2011
Select * 
from [Sales].[SalesOrderHeader]
where OrderDate >= '20110501' and OrderDate < '20110601';

--c. Get the details of the sales details order made in the month of May 2011
Select * 
from [Sales].[SalesOrderDetail] as S1
where EXISTS(Select * 
	         from [Sales].[SalesOrderHeader] as S2
			 where S1.[SalesOrderID] = S2.[SalesOrderID] and OrderDate >= '20110501' and OrderDate < '20110601');
--or
Select * 
from [Sales].[SalesOrderDetail]
where [SalesOrderID] in (Select [SalesOrderID] 
	         from [Sales].[SalesOrderHeader]
			 where OrderDate >= '20110501' and OrderDate < '20110601');
--or
Select SOD.* 
from [Sales].[SalesOrderHeader] as SOH
	 inner join [Sales].[SalesOrderDetail] as SOD
		on SOH.[SalesOrderID] = SOD.[SalesOrderID] and SOH.OrderDate >= '20110501' and SOH.OrderDate < '20110601';

--d. Get the total sales made in May 2011
Select SUM(S1.[LineTotal]) as [Total Sales] 
from [Sales].[SalesOrderDetail] as S1
where EXISTS(Select * 
	         from [Sales].[SalesOrderHeader] as S2
			 where S1.[SalesOrderID] = S2.[SalesOrderID] and OrderDate >= '20110501' and OrderDate < '20110601');
--or
Select SUM([LineTotal]) as [Total Sales]
from [Sales].[SalesOrderDetail]
where [SalesOrderID] in (Select [SalesOrderID] 
	         from [Sales].[SalesOrderHeader]
			 where OrderDate >= '20110501' and OrderDate < '20110601');
--or
Select SUM(SOD.[LineTotal]) as [Total Sales]
from [Sales].[SalesOrderHeader] as SOH
	 inner join [Sales].[SalesOrderDetail] as SOD
		on SOH.[SalesOrderID] = SOD.[SalesOrderID] and SOH.OrderDate >= '20110501' and SOH.OrderDate < '20110601';

--e. Get the total sales made in the year 2011 by month order by increasing sales
with months as
(
Select 'January' as [Month]
union
Select 'February'
union
Select 'March'
union
Select 'April'
union
Select 'May'
union
Select 'June'
union
Select 'July'
union
Select 'August'
union
Select 'September'
union
Select 'October'
union
Select 'November'
union
Select 'December'
), cte_sales as
(
Select SOD.LineTotal, DATENAME(MONTH, SOH.OrderDate) as [OrderMonth]
from [Sales].[SalesOrderHeader] as SOH
	 inner join [Sales].[SalesOrderDetail] as SOD
		on SOH.[SalesOrderID] = SOD.[SalesOrderID] and SOH.OrderDate >= '20110101' and SOH.OrderDate < '20120101'
), cte_final as
(
Select m.[Month], c.LineTotal
from months as m
	 left join cte_sales as c
		on m.[Month] = c.[OrderMonth]
)
Select [Month], ISNULL(SUM(LineTotal), 0) as [Total Sales]
from cte_final
group by [Month]
order by [Total Sales];

--f. Get the total sales made to the customer with FirstName='Gustavo' and LastName ='Achong'
with cte1 as
(
Select [BusinessEntityID] 
from Person.Person 
where FirstName = 'Gustavo' and LastName = 'Achong'
), cte2 as
(
Select [CustomerID] 
from [Sales].[Customer] 
where [PersonID] in (Select [BusinessEntityID] from cte1)
), cte3 as
(
Select [SalesOrderID] 
from [Sales].[SalesOrderHeader]
where [CustomerID] in (Select [CustomerID] from cte2)
)
Select SUM(LineTotal) as [Total Sales]
from [Sales].[SalesOrderDetail]
where [SalesOrderID] in (Select [SalesOrderID] from cte3);
--or
Select SUM(SOD.LineTotal) as [Total Sales]
from (Select [BusinessEntityID] 
	  from Person.Person 
	  where FirstName = 'Gustavo' and LastName = 'Achong') as P
	  inner join [Sales].[Customer] as C
		on P.[BusinessEntityID] = C.[PersonID]
	  inner join [Sales].[SalesOrderHeader] as SOH
		on C.[CustomerID] = SOH.[CustomerID]
	  inner join [Sales].[SalesOrderDetail] as SOD
		on SOH.[SalesOrderID] = SOD.[SalesOrderID];