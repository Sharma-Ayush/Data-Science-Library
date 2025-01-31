//MODULE 3 ASSIGNMENT

//QUESTION 1 SOLUTION

CREATE TABLE ORDERS(ORDER_ID INT,ORDER_DATE INT,AMOUNT INT, CUSTOMER_ID INT);

INSERT INTO ORDERS VALUES(100,2020-10-01,9000,20),
						(110,2020-10-01,9000,1),
						(111,2020-10-02,8000,2),
						(112,2020-10-03,7000,3),
						(113,2020-10-04,6000,4),
						(114,2020-10-05,5000,5);


//QUESTION 2 SOLUTION

CREATE TABLE CUSTOMERS1(
CUSTOMER_ID INT,
FIRST_NAME VARCHAR(50),
LAST_NAME VARCHAR(50),
EMAIL VARCHAR(50),
ADDRESS VARCHAR(50),
CITY VARCHAR(50),
STATE VARCHAR(50),
ZIP VARCHAR(10)
)


INSERT INTO CUSTOMERS1 VALUES
	  (1,'JEMMI','SWQ','JEM@GMAIL.COM','2ND FLOOR','LEH','MYSORE','33222'),

	  (2,'JEMMI','AVANTHIKA','JEMMI@GMAIL.COM','2ND FLOOR','LEH','KASHMIR','22222'),

      (3,'JESSICA','VANYA','VANYA@GMAIL.COM','3RD FLOOR','SAN_JOSE','KERALA','33333'),

	  (4,'JERUSHA','JERU','JERU@GMAIL.COM','4TH FLOOR','OOTY','BANGLORE','44444'),

	  (50,'GRACE','ZIPPORA','GRACE@GMAIL.COM','5TH FLOOR','SAN JOSE','LA','55555');

	 
	  SELECT * FROM CUSTOMERS1;
	  

SELECT CUSTOMERS1.CUSTOMER_ID,FIRST_NAME,LAST_NAME,EMAIL ,ADDRESS ,CITY ,STATE ,ZIP ,ORDER_ID,ORDER_DATE,AMOUNT FROM CUSTOMERS1 INNER JOIN ORDERS ON 
 CUSTOMERS1.CUSTOMER_ID =ORDERS.CUSTOMER_ID;

 
 //QUESTION 3 SOLUTION

 SELECT CUSTOMERS1.CUSTOMER_ID,FIRST_NAME,LAST_NAME,EMAIL ,ADDRESS ,CITY ,STATE ,ZIP ,ORDER_ID,ORDER_DATE,AMOUNT FROM CUSTOMERS1 LEFT JOIN ORDERS ON 
 CUSTOMERS1.CUSTOMER_ID =ORDERS.CUSTOMER_ID;


 SELECT CUSTOMERS1.CUSTOMER_ID,FIRST_NAME,LAST_NAME,EMAIL ,ADDRESS ,CITY ,STATE ,ZIP ,ORDER_ID,ORDER_DATE,AMOUNT FROM CUSTOMERS1 RIGHT JOIN ORDERS ON 
 CUSTOMERS1.CUSTOMER_ID =ORDERS.CUSTOMER_ID;


 // QUESTION 4 SOLUTION

 UPDATE ORDERS SET AMOUNT=100 WHERE CUSTOMER_ID=3;

 SELECT *FROM ORDERS;