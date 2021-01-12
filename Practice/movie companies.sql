CREATE DATABASE EXERCITIU_PRACTIC_5;
USE EXERCITIU_PRACTIC_5;


CREATE TABLE Directors
(
	id INT PRIMARY KEY,
	name VARCHAR(50),
	number_of_awards INT,
)


CREATE TABLE Companies
(
	id INT PRIMARY KEY,
	name VARCHAR(50),

)

CREATE TABLE Movies
(
	id INT PRIMARY KEY,
	name VARCHAR(50),
	release_date DATE,
	company_id INT FOREIGN KEY REFERENCES Companies(id),
	director_id INT FOREIGN KEY REFERENCES Directors(id),
)

CREATE TABLE Actors
(
	id INT PRIMARY KEY,
	name VARCHAR(50),
	ranking INT,

)

CREATE TABLE Cinema_Productions
(
	id INT PRIMARY KEY,
	title VARCHAR(50),
	movie_id INT FOREIGN KEY REFERENCES Movies(id),

)

CREATE TABLE List_of_Actors
(
	id INT PRIMARY KEY,
	cinema_production INT FOREIGN KEY REFERENCES Cinema_Productions(id),
	actor_id INT FOREIGN KEY REFERENCES Actors(id),
	entry_moment VARCHAR(50),
)

--b)
GO
CREATE OR ALTER PROCEDURE uspAddProductions
(@actor_id INT,@moment INT,@cinema_prod_id INT)
AS
INSERT INTO List_of_Actors
VALUES (@cinema_prod_id,@actor_id,@moment)
GO

--c)
GO

SELECT *
FROM Actors act
WHERE NOT EXISTS(
	SELECT a1.actor_id
	FROM List_of_Actors a1
	EXCEPT
	SELECT a2.id
	FROM Actors a2
	WHERE a2.id=act.id)
--d)

GO
CREATE OR ALTER FUNCTION ufnMovies(@p INT)
RETURNS TABLE
AS
RETURN

SELECT m.name 
FROM Movies m
INNER JOIN Cinema_Productions cp
ON m.id=cp.movie_id
WHERE m.release_date>'2018-01-01'
GROUP BY m.name
HAVING COUNT(*)>@p

GO



