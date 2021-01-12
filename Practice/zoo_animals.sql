CREATE DATABASE EXERCITIU_PRACTIC_3
USE EXERCITIU_PRACTIC_3

CREATE TABLE Zoo
(
	id INT PRIMARY KEY,
	administrator VARCHAR(50),
	name VARCHAR(50),
)

CREATE TABLE Animal
(

	id INT PRIMARY KEY,
	name VARCHAR(50),
	date_of_birth DATE,
	zoo_id INT FOREIGN KEY REFERENCES Zoo(id)
)

CREATE TABLE Food
(
	id INT PRIMARY KEY,
	name VARCHAR(50),

)

CREATE TABLE System
(
	id INT PRIMARY KEY,
	animal_id INT FOREIGN KEY REFERENCES Animal(id),
	food_id INT FOREIGN KEY REFERENCES Food(id),
	quota INT
)

CREATE TABLE Visitor
(
	id INT PRIMARY KEY,
	name VARCHAR(50),
	age INT
)

CREATE TABLE Visit
(
	id INT PRIMARY KEY,
	visitor_id INT FOREIGN KEY REFERENCES Visitor(id),
	zoo_id INT FOREIGN KEY REFERENCES Zoo(id),
	visit_day INT,
	visit_price INT

)


--b)

GO
CREATE OR ALTER PROCEDURE uspDeleteFromSystem(@animal_id INT)
AS
	DELETE FROM System
	WHERE animal_id=@animal_id

GO

--c)

GO
CREATE OR ALTER VIEW vZooVisit
AS
	SELECT Zoo.name
	FROM Visit
	INNER JOIN
	Zoo
	ON Visit.zoo_id=Zoo.id
	GROUP BY Zoo.name,Visit.id
	ORDER BY COUNT(*) DESC
	LIMIT 1
GO

CREATE OR ALTER FUNCTION ufnVisitorAll(@N INT)
RETURNS TABLE
AS
RETURN

	SELECT * 
	FROM Visit v
	WHERE zoo_id IN
	(SELECT zoo_id
	FROM Animal
	GROUP BY zoo_id
	HAVING COUNT(*) >=1)

)





