/*
1527. Patients With a Condition

Table: Patients

+--------------+---------+
| Column Name  | Type    |
+--------------+---------+
| patient_id   | int     |
| patient_name | varchar |
| conditions   | varchar |
+--------------+---------+
In SQL, patient_id is the primary key for this table.
'conditions' contains 0 or more code separated by spaces. 
This table contains information of the patients in the hospital.
 

Find the patient_id, patient_name and conditions of the patients who have Type I Diabetes. Type I Diabetes always starts with DIAB1 prefix.

Return the result table in any order.
*/

--Schema:
Create table dbo.Patients (patient_id int, patient_name varchar(30), conditions varchar(100))
Truncate table Patients
insert into Patients (patient_id, patient_name, conditions) values ('1', 'Daniel', 'YFEV COUGH')
insert into Patients (patient_id, patient_name, conditions) values ('2', 'Alice', '')
insert into Patients (patient_id, patient_name, conditions) values ('3', 'Bob', 'DIAB100 MYOP')
insert into Patients (patient_id, patient_name, conditions) values ('4', 'George', 'ACNE DIAB100')
insert into Patients (patient_id, patient_name, conditions) values ('5', 'Alain', 'DIAB201')

--Solution:
Select *
from dbo.Patients
where conditions like '% DIAB1%' or conditions like 'DIAB1%';