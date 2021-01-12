CREATE DATABASE EXERCITIU_PRACTIC_1;
USE EXERCITIU_PRACTIC_1;

CREATE TABLE S
(
	ID VARCHAR(2) PRIMARY KEY,
	A VARCHAR(2),
	B VARCHAR(2) ,
	C VARCHAR(150),
	D INT,
	E INT,
	F INT,
)

INSERT S VALUES ('t1','a1','b2','Si abia pleaca batranul, Ce mai freamat, ce mai zbucium!',0,1,0);
INSERT S VALUES ('t2','a1','b2','Codrul clocoti de zgomot si de arme si de bucium!!',1,2,1);
INSERT S VALUES ('t3','a1','b3','Iar la poala lui cea verde mii de capete pletoase,',0,3,0);
INSERT S VALUES ('t4','a1','b3','Mii de coifuri lucitoare ies din umbra-ntunecoasa;',2,123,-1);
INSERT S VALUES ('t5','a1','b3','Calaretii umplu campul si roiesc dupa un semn',-1,4,-1);

SELECT * FROM S;


UPDATE S 
SET C='Codrul clocoti de zgomot si de arme si de bucium,'
WHERE ID='t2';


SELECT * FROM S;



SELECT DISTINCT A, B FROM S;

SELECT * FROM S WHERE B='b3'
UNION 
SELECT * FROM S WHERE B='b3';

SELECT * FROM S WHERE E <> 4;

SELECT * FROM(
(SELECT ID,A,B,C,F as 'F1' FROM S) t1
INNER JOIN
(SELECT D,E,F as 'F2' FROM S) t2
ON t1.F1=t2.F2) 
 

 SELECT * FROM S WHERE D >= 0
EXCEPT SELECT * FROM S WHERE E <> 4



 SELECT B,C,COUNT(*)
 FROM S
 GROUP BY B,C
 HAVING D <=1

 SELECT *
 FROM S
 WHERE C LIKE 'de%'


 CREATE TABLE  Customer
 (
	id INT PRIMARY KEY,
	name VARCHAR(20),
	date_of_birth DATE,
	
 )

 CREATE TABLE Account
 (
	id INT PRIMARY KEY,
	iban VARCHAR(20) ,
	balance FLOAT,
	customer_id INT,
	FOREIGN KEY(customer_id) REFERENCES Customer(id)

 )
 
 CREATE TABLE Card
 (
	id INT PRIMARY KEY,
	number INT,
	cvv VARCHAR(3),
	account_id INT,
	FOREIGN KEY(account_id) REFERENCES Account(id)
)


CREATE TABLE ATM
(
	id INT PRIMARY KEY,
	address VARCHAR(30),
)


CREATE TABLE Transactions
(
	id INT PRIMARY KEY,
	sum_of_money FLOAT,
	atm_id INT,
	card_id INT,
	FOREIGN KEY(atm_id) REFERENCES ATM(id),
	FOREIGN KEY(card_id) REFERENCES Card(id)
)










