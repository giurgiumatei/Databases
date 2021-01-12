CREATE DATABASE EXERCITIU_PRACTIC_4;
USE EXERCITIU_PRACTIC_4


CREATE TABLE Cake_Types
(
	id INT PRIMARY KEY,
	name VARCHAR(50),
	description VARCHAR(50),


)

CREATE TABLE Cakes
(
	id INT PRIMARY KEY,
	name VARCHAR(50),
	shape VARCHAR(50),
	weight INT,
	price INT,
	type INT FOREIGN KEY REFERENCES Cake_Types(id)

)


CREATE TABLE Chefs
(
	id INT PRIMARY KEY,
	name VARCHAR(50),
	gender VARCHAR(50),
	date_of_birth DATE,
)


CREATE TABLE Specialization
(
	id INT PRIMARY KEY,
	chef_id INT FOREIGN KEY REFERENCES Chefs(id),
	cake_id INT FOREIGN KEY REFERENCES Cakes(id),
)





CREATE TABLE Orders
(
	id INT PRIMARY KEY,
	date DATE
)
CREATE TABLE OrderCakes
(
	id INT PRIMARY KEY,
	order_id INT FOREIGN KEY REFERENCES Orders(id),
	cake_id INT FOREIGN KEY REFERENCES Cakes(id),
	pieces INT

)


--b)

GO
CREATE OR ALTER PROCEDURE uspOrderCake
@order_id INT, @cake_name VARCHAR(30), @P INT
AS
	DECLARE @cake_id INT=(SELECT c.id FROM Cakes c
							WHERE c.name=@cake_name)

	IF EXISTS (SELECT * FROM OrderCakes o
				WHERE o.order_id=@order_id AND o.cake_id=@cake_id
				)

	BEGIN
		UPDATE OrderCakes
		SET pieces=@P
		WHERE order_id=@order_id AND cake_id=@cake_id
	END
	ELSE
		INSERT INTO OrderCakes
		VALUES (@order_id,@cake_id,@P)

GO

--c)
GO
CREATE OR ALTER FUNCTION ufn_getchefs()
RETURNS TABLE
AS
RETURN 
SELECT c.name
FROM Chefs c
WHERE NOT EXISTS(
	SELECT c2.id
	FROM Chefs c2
	EXCEPT
	SELECT s.chef_id
	FROM Specialization s
	WHERE s.chef_id=c.id
)

GO






