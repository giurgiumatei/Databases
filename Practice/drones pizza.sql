

CREATE DATABASE EXERCITIU_PRACTIC_2;

USE EXERCITIU_PRACTIC_2;


CREATE TABLE Drone_Manufacturer
(
	id INT PRIMARY KEY,
	name VARCHAR(50),
	
)

CREATE TABLE Drone_Model
(	
	id INT PRIMARY KEY,
	manufacturer_id INT FOREIGN KEY REFERENCES Drone_Manufacturer(id),
	name VARCHAR(50),
	battery INT,
	maximum_speed INT

)

CREATE TABLE Drone
(
	id INT PRIMARY KEY,
	model INT FOREIGN KEY REFERENCES Drone_Model(id),
	serial_number INT,

)

CREATE TABLE Pizza_Shop
(
	id INT PRIMARY KEY,
	name VARCHAR(50),
	address VARCHAR(50),
)


CREATE TABLE Customer
(
	id INT PRIMARY KEY,
	name VARCHAR(50),
	loyalty_score INT,
)

CREATE TABLE Delivery
(
	shop_id INT FOREIGN KEY REFERENCES Pizza_Shop(id),
	customer_id INT FOREIGN KEY REFERENCES Customer(id),
	drone_id INT FOREIGN KEY REFERENCES Drone(id),
	date TIME,
)
GO


--b


CREATE OR ALTER PROC uspInsertDelivery @shop_id INT,@customer_id INT,@drone_id INT,@date TIME
AS
	INSERT INTO Delivery VALUES (@shop_id,@customer_id,@drone_id,@date)
GO


--c

CREATE OR ALTER VIEW fav_manufacturers
AS
	
	SELECT Drone_Manufacturer.name,Drone_Model.id  FROM Drone_Model
	INNER JOIN
	Drone
	ON Drone_Model.id=Drone.id
	INNER JOIN
	Drone_Manufacturer
	ON Drone_Manufacturer.id=Drone_Model.id
	GROUP BY Drone_Manufacturer.name
	ORDER BY COUNT(*)
GO


--d

CREATE OR ALTER FUNCTION at_least_d(@d INT)
RETURNS TABLE
AS
RETURN
	SELECT *
	FROM Customer
	WHERE @d<=
			(SELECT COUNT(*)
			 FROM Delivery
			 WHERE Customer.name=Delivery.customer_id
			 )
GO

SELECT * FROM at_least_d(2)





	







