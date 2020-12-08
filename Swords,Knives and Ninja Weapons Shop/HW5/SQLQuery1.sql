CREATE DATABASE HW5
USE HW5
DROP TABLE IF EXISTS Ta

CREATE TABLE Ta
(
	aid INT NOT NULL IDENTITY(1,1),
	a2 INT UNIQUE,
	some_field VARCHAR(50),
	CONSTRAINT PK_Ta PRIMARY KEY (aid)

);

DROP TABLE IF EXISTS Tb

CREATE TABLE Tb
(
	bid INT NOT NULL IDENTITY(1,1),
	b2 INT, --not unique
	some_field VARCHAR(50),
	CONSTRAINT PK_Tb PRIMARY KEY(bid)
)

DROP TABLE IF EXISTS Tc

CREATE TABLE Tc --bridge table
(
	cid INT NOT NULL IDENTITY(1,1),
	CONSTRAINT PK_Tc PRIMARY KEY(cid),
	aid INT FOREIGN KEY REFERENCES Ta(aid),
	bid INT FOREIGN KEY REFERENCES Tb(bid),
)

INSERT INTO Ta VALUES (1,'a'),(2,'b'),(3,'c'),(4,'d'),(5,'e')
INSERT INTO Tb VALUES (11,'f'),(12,'d'),(13,'h'),(14,'i'),(15,'j')
INSERT INTO Tc VALUES (1,1),(2,2),(3,3),(4,4),(4,5)
INSERT INTO Tb VALUES (-122,'k')
INSERT INTO Tb VALUES (100,'l')
INSERT INTO Tb VALUES (1000,'m')
INSERT INTO Tb VALUES (-1000,'n')
--select with the mouse the query  and  click display estimated execution plan
SELECT * FROM Ta  
SELECT * FROM Tb
SELECT * FROM Tc


--if it is a primary key then it will create a clustered index
--if it is unique, not primary key, it will create a non-clustered index

--a)
--clustered index scan

SELECT * FROM Ta;

--clustered index seek

SELECT * 
FROM Ta
WHERE aid>3

--nonclustered index scan

SELECT a2
FROM Ta

--nonclustered index seek

SELECT a2
FROM Ta
WHERE a2=3

--key lookup and nonclustered index seek
SELECT *
FROM Ta
WHERE a2=4



--b)

SELECT *      --clustered index scan
FROM Tb       --estimated subtree cost: 0.0032919
WHERE b2=14   

GO
CREATE NONCLUSTERED INDEX INDEX_NONCLUSTERED_b2 ON Tb(b2)
GO

SELECT bid,b2      --nonclustered index seek
FROM Tb       --estimated subtree cost: 0.0032831
WHERE b2=1000 

GO
DROP INDEX INDEX_NONCLUSTERED_b2 ON Tb
GO

--c)


GO
CREATE OR ALTER VIEW Test
AS
	SELECT aid,a2,a.some_field
	FROM Ta a
	INNER JOIN Tb b ON a.a2=b.b2-10
	
GO

SELECT * FROM Test

--uses the index created at b)
--redistributes the cost of the operations, not really helpful