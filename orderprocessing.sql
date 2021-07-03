CREATE DATABASE ORDER_DATABASE;
USE ORDER_DATABASE;
CREATE TABLE SALESMAN(
SALESMANID INT,
SNAME VARCHAR(30),
CITY VARCHAR(30),
COMMISSION VARCHAR(30),
PRIMARY KEY (SALESMANID));
CREATE TABLE CUSTOMER(
CUSTOMERID INT,
SALESMANID INT,
CNAME VARCHAR(30),
CITY VARCHAR(20),
GRADE INT,
PRIMARY KEY (CUSTOMERID),
FOREIGN KEY (SALESMANID) REFERENCES SALESMAN(SALESMANID)ON DELETE SET NULL);
CREATE TABLE ORDERS(
ORDERNO INT,
CUSTOMERID INT,
SALESMANID INT,
PURCHASEAMT INT,
ORDERDATE DATE,
PRIMARY KEY (ORDERNO),
FOREIGN KEY (SALESMANID) REFERENCES SALESMAN(SALESMANID) ON DELETE CASCADE,
FOREIGN KEY (CUSTOMERID) REFERENCES CUSTOMER(CUSTOMERID)ON DELETE CASCADE);

INSERT INTO SALESMAN VALUES(1000,'JOHN','BANGALORE','25%');
INSERT INTO SALESMAN VALUES(2000,'RAVI','BANGALORE','20%');
INSERT INTO SALESMAN VALUES(3000,'KUMAR','MYSORE','15%');
INSERT INTO SALESMAN VALUES(4000,'SMITH','DELHI','30%');
INSERT INTO SALESMAN VALUES(5000,'HARSHA','HYDERABAD','15%');

INSERT INTO CUSTOMER VALUES(10,1000,'PREETHI','BANGALORE',100);
INSERT INTO CUSTOMER VALUES(11,1000,'VIVEK','MANGALORE',300);
INSERT INTO CUSTOMER VALUES(12,2000,'BHASKAR','CHENNAI',400);
INSERT INTO CUSTOMER VALUES(13,2000,'CHETAN','BANGALORE',200);
INSERT INTO CUSTOMER VALUES(14,3000,'MAMTHA','BANGALORE',400);

INSERT INTO ORDERS VALUES(50,10,1000,5000,'2017-05-04');
INSERT INTO ORDERS VALUES(51,10,2000,450,'2017-01-20');
INSERT INTO ORDERS VALUES(52,13,2000,1000,'2017-02-24');
INSERT INTO ORDERS VALUES(53,14,3000,3500,'2017-04-13');
INSERT INTO ORDERS VALUES(54,12,2000,550,'2017-03-09');


-- 1. Count the customers with grades above Bangalore’s average.
SELECT GRADE, COUNT(*)
FROM CUSTOMER
GROUP BY GRADE
HAVING GRADE >
    (SELECT AVG(GRADE)
     FROM CUSTOMER
     WHERE CITY = 'BANGALORE');
     
-- 2.Find the name and numbers of all salesmen who had more than one customer.

SELECT SALESMANID, SNAME
FROM SALESMAN A
WHERE 1 < (SELECT COUNT(*)
FROM CUSTOMER
WHERE SALESMANID=A.SALESMANID);


-- 3. List all salesmen and indicate those who have and don’t have customers in their cities (Use UNION operation.)

SELECT SALESMAN.SALESMANID,SNAME, CNAME, COMMISSION
FROM SALESMAN, CUSTOMER
WHERE SALESMAN.CITY = CUSTOMER.CITY
UNION
SELECT SALESMANID, SNAME, 'NO MATCH', COMMISSION FROM SALESMAN
          WHERE NOT CITY = ANY
         (SELECT CITY
         FROM CUSTOMER)
         ORDER BY 2 DESC;
         
-- 4. Create a view that finds the salesman who has the customer with the highest order of a day.

CREATE VIEW VIEWSALESMAN AS
SELECT B.ORDERDATE, A.SALESMANID, A.SNAME
FROM SALESMAN A, ORDERS B
WHERE A.SALESMANID = B.SALESMANID
AND B.PURCHASEAMT=(SELECT max(PURCHASEAMT)
FROM ORDERS C
WHERE C.ORDERDATE = B.ORDERDATE);

SELECT * FROM VIEWSALESMAN;
-- 5.5. Demonstrate the DELETE operation by removing salesman with id 1000. All his orders must also be deleted.


DELETE FROM SALESMAN
WHERE SALESMANID=1000;
SELECT * FROM SALESMAN;
