Create Table dbo.Employee 
	        (Employee_id int primary key,
			 First_name varchar(10) NOT NULL,
			 Last_Name varchar(10) NOT NULL,
			 Salary int NOT NULL,
			 Joining_date smalldatetime NOT NULL,
			 Department varchar(10) NOT NULL);

Insert into dbo.Employee values 
			(1, 'Anika', 'Arora', 100000, '20200214 09:00:00.000', 'HR'),
			(2, 'Veena', 'Verma', 80000, '20110615 09:00:00.000', 'Admin'),
			(3, 'Vishal', 'Singhal', 300000, '20200216 09:00:00.000', 'HR'),
			(4, 'Sushanth', 'Singh', 500000, '20200217 09:00:00.000', 'Admin'),
			(5, 'Bhupal', 'Bhati', 500000, '20110618 09:00:00.000', 'Admin'),
			(6, 'Dheeraj', 'Diwan', 200000, '20110619 09:00:00.000', 'Account'),
			(7, 'Karan', 'Kumar', 75000, '20200114 09:00:00.000', 'Account'),
			(8, 'Chandrika', 'Chauhan', 90000, '20110415 09:00:00.000', 'Admin');

Create Table dbo.[Employee Bonus]
			(Employee_ref_id INT references Employee(Employee_id),
			 Bonus_Amount int not null,
			 Bonus_Date smalldatetime not null);

Insert into dbo.[Employee Bonus] values
			(1, 5000, '20200216'),
			(2, 3000, '20110616'),
			(3, 4000, '20200216'),
			(1, 4500, '20200216'),
			(2, 3500, '20110616');

Create Table dbo.[Employee Title] 
			(Employee_ref_id int references Employee(Employee_id),
			 Employee_title varchar(20) not null,
			 Affective_Date smalldatetime not null);

Insert into dbo.[Employee Title] values 
		   (1, 'Manager', '20160220'),
		   (2, 'Executive', '20160611'),
		   (8, 'Executive', '20160611'),
		   (5, 'Manager', '20160611'),
		   (4, 'Asst. Manager', '20160611'),
		   (7, 'Executive', '20160611'),
		   (6, 'Lead', '20160611'),
		   (3, 'Lead', '20160611');


