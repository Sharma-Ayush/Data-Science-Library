--Project: Relational Database Design

/*
Problem Statement:
How to convert a relational design into tables in SQL Server?
*/

/*
Topics:
In this project, you will work on converting a relational design that enlists various
users, their roles, user accounts and their statuses into different tables in SQL
Server and insert data into them. Having at least two rows in each of the tables,
you have to ensure that you have created respective foreign keys
*/

/*
Tasks To Be Performed:
-Define relations/attributes
-Define primary keys
-Create foreign keys
*/

create table role (id int primary key,
				   role_name varchar(100) not null);

create table status (id int primary key,
					 status_name varchar(100) not null,
					 is_user_working bit not null);

create table user_account (id int primary key,
						   [user_name] varchar(100) not null,
						   email varchar(254) not null,
						   [password] varchar(200) not null,
						   password_salt varchar(50),
						   password_hash_algorithm varchar(50) not null);

create table user_has_status (id int primary key,
							  status_start_time datetime not null,
							  status_end_time datetime,
							  user_account_id int foreign key references user_account(id),
							  status_id int foreign key references [status](id));

create table user_has_role (id int primary key, 
							role_start_time datetime not null,
							role_end_time datetime,
							user_account_id int foreign key references user_account(id),
							role_id int foreign key references role(id));


--1. Insert data into each of the above tables. With at least two rows in each of
--the tables. Make sure that you have created respective foreign keys.

insert into dbo.role(id, role_name) values(1, 'Engineer'),
										  (2, 'Senior Engineer'),
										  (3, 'Lead Engineer'),
										  (4, 'Manager');

insert into dbo.status(id, status_name, is_user_working) values(1, 'Employeed', 1),
															   (2, 'Sabatical', 0),
															   (3, 'Retired', 0),
															   (4, 'Resigned', 0);

insert into dbo.user_account(id, [user_name], email, [password], password_hash_algorithm)
					  values(1, 'Ayush123', 'ayush123@gmail.com', 'Pass0123', 'Linear'),
					        (2, 'Ayushi456', 'ayushi456@gmail.com', 'Pass0456', 'Linear'),
					        (3, 'Abhi0789', 'abhi789@gmail.com', 'Pass0789', 'Linear');

insert into user_has_status (id, status_start_time, status_end_time, user_account_id, status_id)
					  values(1, '20121202', NULL, 1, 1),
						    (2, '20150601', '20160101', 2, 4),
							(3, '20161031', NULL, 3, 2);

insert into user_has_role (id, role_start_time, role_end_time, user_account_id, role_id)
                    values(1, '20121202', '20151202', 1, 1),
					      (2, '20151203', NULL, 1, 2),
						  (3, '20150601', '20160101', 2, 4),
						  (4, '20161031', '20171031', 3, 3),
						  (5, '20171101', NULL, 3, 4);

--2. Delete all the data from each of the tables.

Delete from dbo.user_has_role;
Delete from dbo.user_has_status;
Delete from dbo.user_account;
Delete from dbo.role;
Delete from dbo.status;
