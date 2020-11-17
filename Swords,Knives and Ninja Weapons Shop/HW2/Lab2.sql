USE SHOP

SELECT * FROM Knives

Select * FROM Client


--- INSERTS


-- Insert values into Swords table
INSERT INTO Swords(name,brand_id,price,stars) VALUES ('Honshu Boshin Katana',3,127,5),('Sword of Boromir',1,200,4),
('Illuminated Moria Staff of Gandalf',1,207,5),('Pearl Moon Samurai Sword Set',5,398,4),('Mirkwood Infantry Sword',2,200,5)

-- Insert values into Swords_Brand table
INSERT INTO Swords_Brand(name) VALUES ('LOTR'),('The Hobbit'),('Honshu'),('Kit Rae'),('Shinwa')

-- Insert values into Knives table
INSERT INTO Knives(name,brand_id,price,stars) VALUES ('Throwing Knives 8 in 6 Pack',1,39,5),('Battle Scarred Drab Cyclone',
 2,60,4),('Tanto Knife',3,47,4),('Karambit Knife',4,95,5),('Damascus Short Sword',5,100,5)

 -- Insert values into Knives_Brand table
 INSERT INTO Knives_Brand(name) VALUES ('Smith & Wesson'),('M48'),('Honshu'),('Viper Tec'),('Timber Wolf')

 --Insert values into Ninja_weapons table
 INSERT INTO Ninja_Weapons(name,brand_id,price,stars) VALUES ('Makaku Katana',1,130,4),('Throwing Card Set of Five',
 2,20,5),('Sleek Black Throwing Star',3,18,5),('Hand Claws',4,13,4),('Carbon Spear',5,67,5) 
 
-- Insert values into Ninja_Weapons_Brand table 
 INSERT INTO Ninja_Weapons_Brand(name) VALUES ('Shinwa'),('Royal Flush'),('Honshu'),('Black Hornet'),('Forged Warrior')

 -- Insert values into New table
 INSERT INTO New(weapon_type,name,price) Values ('Knife','Dragonfire Butterfly Knife',35)

 --Insert values into Closeouts table
 INSERT INTO Closeouts(name,old_price,new_price,quantity) Values ('Kommando Talon Spear',77,59,10)

 --Insert values into Swords_Providers table
 INSERT INTO Swords_Providers(name) Values ('Lockheed Martin'),('Boeing'),('Raytheon'),('BAE Systems'),('Northrop Grumman')

 --Insert values into Knives_Providers table
 INSERT INTO Knives_Providers(name) Values ('Lockheed Martin'),('Boeing'),('Raytheon'),('BAE Systems'),('Northrop Grumman')

 --Insert values into table Ninja_Weapons_Providers
 INSERT INTO Ninja_Weapons_Providers(name) Values ('Lockheed Martin'),('Boeing'),('Raytheon'),('BAE Systems'),('Northrop Grumman')

 --Insert values into table Swords__Swords_Providers__Bridge
 INSERT INTO Swords__Swords_Providers__Bridge(product_id,provider_id) VALUES (1,1),(1,2),(2,2),(3,1)

  --Insert values into table Knives__Knives_Providers__Bridge
 INSERT INTO Knives__Knives_Providers__Bridge(product_id,provider_id) VALUES (1,1),(1,2),(2,2),(3,1)

  --Insert values into table Ninja_Weapons__Ninja_Weapons__Providers__Bridge
 INSERT INTO Ninja_Weapons__Ninja_Weapons_Providers__Bridge(product_id,provider_id) VALUES (1,1),(1,2),(2,2),(3,1)


 -- DELETES

 -- Delete elements from Ninja_Weapons Table where id<5
 DELETE FROM Ninja_Weapons
 WHERE id<5

 -- Deletes all data from Closeouts
 
 -- Deletes everything from closeouts
 DELETE  FROM Closeouts
 
 -- Deletes from New rows with ids between 90 and 100
 DELETE  FROM New
 WHERE id BETWEEN 90 AND 100
 
 -- Deletes from Swords_Providers rows with empty names or name is NULL value
 DELETE FROM Swords_Providers
 WHERE name='' OR name=NULL


 --Alter Closeouts and Ninja_Weapons_Brand Table
 ALTER TABLE Closeouts ALTER COLUMN name VARCHAR(50);
 ALTER TABLE Ninja_Weapons_Brand ALTER COLUMN name VARCHAR(50);

 -- UPDATES 

 -- UPDATE Swords_Brand Table
 
 -- Updates so that rows with the name 'LOTR' are now with 'Lord Of The Rings'
 UPDATE Swords_Brand
 SET name='Lord Of The Rings'
 WHERE name='LOTR'

 -- Updates the price of the rows with the name beginning with 'Tanto' to 100
 UPDATE Knives
 SET price=100
 WHERE name like 'Tanto%'

 -- Decrements the quantity of the rows with the quantity in the (10,20) range
 UPDATE Closeouts
 SET quantity=quantity-1
 WHERE quantity>10 AND quantity<20

 -- Updates the weapon_type to be 'Sword' if it is NULL
 Update New
 SET weapon_type='Sword'
 WHERE weapon_type is NULL
 
 -- Reset indexes for Identity(1,1) for some tables (WAS NOT MANDATORY!)
 DBCC CHECKIDENT('Swords',RESEED,0)
 DBCC CHECKIDENT('Knives',RESEED,0)
 DBCC CHECKIDENT('Ninja_Weapons',RESEED,0)
 DBCC CHECKIDENT('New',RESEED,0)
 DBCC CHECKIDENT('Swords_Brand',RESEED,0)
 DBCC CHECKIDENT('Closeouts',RESEED,0)
 DBCC CHECKIDENT('Swords_Providers',RESEED,0)
 DBCC CHECKIDENT('Knives_Providers',RESEED,1)
 DBCC CHECKIDENT('Ninja_Weapons_Providers',RESEED,1)




-- Give the UNIQUE constraint to the name column
ALTER TABLE Swords
ADD UNIQUE(name);

-- Statement that violates the constraint
-- Violates the constraint of name being UNIQUE
INSERT INTO Swords(name,brand_id,price,stars) VALUES ('Honshu Boshin Katana',5,100,5)

--Statement that violates referential integrity constraint
-- Violates the referential integrity to brand id, there is no brand with id 10
INSERT INTO Swords(name,brand_id,price,stars) VALUES ('Wood Sword',10,227,5)

-- a. 2 queries with the union operation; use UNION [ALL] and OR;

-- Shows the names of all items from Sword and Knives table
SELECT DISTINCT name FROM Swords
UNION -- distinct values
SELECT name FROM Knives

-- Shows the UNION between all ids from Knives table and the ids from Ninja_Weapons table with the id=2 or id>5 
SELECT id FROM Knives
UNION ALL -- all values
SELECT id 
FROM Ninja_Weapons
WHERE id>5 OR id=2

-- b. 2 queries with the intersection operation; use INTERSECT and IN;

-- Shows the INTERSECTION of ids from New and Closeouts (ids both in New and in Closeouts)
SELECT id FROM New
INTERSECT 
SELECT id FROM Closeouts

--Shows the INTERSECTION between entries of Knives_Brand and Knives based on id (ids both in Knives and Knives_Brand)
SELECT * FROM Knives_Brand 
WHERE Knives_Brand.id IN (SELECT id FROM Knives) 

-- c. 2 queries with the difference operation; use EXCEPT and NOT IN;

-- Shows the name of the entries from Swords table that are not in the New table, based on name
SELECT Swords.name
FROM Swords
EXCEPT
SELECT New.name
FROM New

-- Shows the name of the providers that have the id not in range of (1,2)
SELECT Ninja_Weapons_Providers.name
FROM Ninja_Weapons_Providers 
WHERE Ninja_Weapons_Providers.id NOT IN (1,2)

-- d. 4 queries with INNER JOIN, LEFT JOIN, RIGHT JOIN, and FULL JOIN (one query per operator); 
-- one query will join at least 3 tables, while another one will join at least two many-to-many relationships;

-- Returns the knife name and price only if there is a match in both tables (Knives and Knives_Brand) based on id
SELECT Knives.name, Knives.price
From Knives -- select knife name and price, inner join for knife_brand id, merges the 2 tables
INNER JOIN Knives_Brand 
ON Knives_Brand.id=Knives.id

-- Joins the Sword, Sword Providers and Sword Brand tables based on id, returning the rows from the table to the left
-- even if there is no match in the table to the right
SELECT Swords.name, Swords.price, Swords.stars,Swords_Brand.name AS Brand_Name,Swords_Providers.name AS Providers_Name
FROM Swords 
LEFT JOIN Swords_Providers 
ON Swords.id=Swords_Providers.id 
LEFT JOIN Swords_Brand 
ON Swords.id=Swords_Brand.id

-- Join the Ninja_Weapons,Ninja_Weapons_Providers, returning the rows from the table to the right
-- even if there is no match in the  table to the left
SELECT Ninja_Weapons.name,Ninja_Weapons.stars,Ninja_Weapons.id,Ninja_Weapons_Providers.id AS Providers_id
FROM Ninja_Weapons
INNER JOIN Ninja_Weapons_Providers 
ON Ninja_Weapons.id=Ninja_Weapons_Providers.id

-- Joining the m:m relations of the Knives entities and Swords entities, combining the results if the left and right joins
SELECT DISTINCT Knives.name, Knives_Providers.name AS Providers_Name
FROM Knives,Knives__Knives_Providers__Bridge AS Bridge
FULL JOIN Knives_Providers 
ON Bridge.provider_id=Knives_Providers.id --Joined Knives and Knives_Providers based on id
FULL JOIN
( -- full join of two m:m relations, id of swords have to be smaller than id of knives_providers
SELECT Swords.id,Swords_Providers.id AS Providers_id
FROM Swords,Swords__Swords_Providers__Bridge AS Bridge
FULL JOIN Swords_Providers 
ON Bridge.provider_id=Swords_Providers.id --Joined Swords and Swords_Providers based on id
)S 
ON S.id<Knives_Providers.id


-- e.2 queries with the IN operator and a subquery in the WHERE clause; 
-- in at least one case, the subquery should include a subquery in its own WHERE clause;

----Show the name and price of the ninja weapons that have a matching id with items from new
SELECT name,price
FROM Ninja_Weapons --show the name and price of the ninja weapons that have a matching id with items from new
WHERE id in (SELECT id FROM New)

---- Show the first sword that has and id appearing in the result from the previous query
SELECT TOP 1 name
FROM Swords
WHERE id in (SELECT id
			FROM Ninja_Weapons 
			WHERE id in (SELECT id FROM New)
			) 

-- f. 2 queries with the EXISTS operator and a subquery in the WHERE clause;

-- Show the name of an item from the New table if it has an id and it's smaller than 3
SELECT New.name
FROM New 
WHERE EXISTS (SELECT New.id FROM New WHERE New.id<3)

-- Show the name and id of a knife where the closeout id matches the knife id and knife id is in (1,2)
SELECT Knives.name,Knives.id AS Knife_id
FROM Knives 
WHERE EXISTS (SELECT Closeouts.id FROM Closeouts WHERE Closeouts.id=Knives.id AND Knives.id in (1,2))

-- g. 2 queries with a subquery in the FROM clause; 

--Show the name and the price of the rows resulting from the LEFT JOIN of the Swords and Ninja_Weapons tables
--on id, that have the price bigger than 200
SELECT DISTINCT *
FROM 
(Select Swords.name,Swords.price
FROM Ninja_Weapons
LEFT JOIN Swords ON (Ninja_Weapons.id=Swords.id) 
) AS price
WHERE price>=200
-- Show the maximum price of a Sword from Swords table
SELECT maxprice
FROM (
SELECT MAX(Swords.price) maxprice 
FROM Swords) AS result 

--h. 4 queries with the GROUP BY clause, 3 of which also contain the HAVING clause;
--2 of the latter will also have a subquery in the HAVING clause; use the aggregation operators: COUNT, SUM, AVG, MIN, MAX;

-- Group by stars and select alphabetically the top 2 rows from Swords table showing the name and the stars
SELECT TOP 2 MAX(name),stars
FROM Swords 
GROUP BY stars

--Group elements from Knives table by id and only show the min(name) and id of those with SUM(id)>2
SELECT MIN(name),id
FROM Knives
GROUP BY id 
HAVING SUM(id) >2

--Group elements from Ninja_Weapons table by id then display the max(name),min(price) and max(stars)
--only if the id of the group is also present in Ninja_Weapons_Bridge table
SELECT id, MAX(name) AS name, MIN(price) AS price,MAX(stars) AS stars
FROM Ninja_Weapons
GROUP BY id 
HAVING id in (SELECT id FROM Ninja_Weapons__Ninja_Weapons_Providers__Bridge)

-- Group the selected items by stars but only those with MAX(id) smaller than the average price of a Sword
SELECT MIN(name) min_name,MAX(id) max_id
FROM Swords
GROUP BY stars 
HAVING MAX(id) < ALL(SELECT AVG(price) FROM Swords)


--i. 4 queries using ANY and ALL to introduce a subquery in the WHERE clause (2 queries per operator); 
--rewrite 2 of them with aggregation operators, and the other 2 with IN / [NOT] IN.

--Show the minimum price of knives table where all the prices are bigger than a price in the swords table
SELECT TOP 1 price
FROM Knives
WHERE price<ANY(SELECT price FROM Swords) 
ORDER BY price 

--rewritten the above query with aggregation operator
SELECT MIN(price)
FROM Knives r
WHERE price<ANY(SELECT price FROM SWORDS)

-- Show the ninja_weapons with the id bigger then every id in the new table
SELECT DISTINCT * 
FROM Ninja_Weapons NW 
WHERE NW.id > ALL(SELECT id FROM New)

--rewritten the above query with aggregation operator
SELECT DISTINCT *
FROM Ninja_Weapons NW 
WHERE NW.id > (SELECT MAX(id) FROM NEW)

-- Only show the quantity that is bigger than all ids in the Closeouts table
SELECT quantity
FROM Closeouts 
WHERE quantity > ALL(SELECT id FROM Closeouts)

-- rewritten the above query using NOT IN
SELECT quantity
FROM Closeouts 
WHERE quantity NOT IN (SELECT MIN(id) FROM Closeouts UNION SELECT MAX(id) FROM Closeouts)

-- Show elements of New that have the id present also in Closeouts 
SELECT *
FROM New
WHERE id=ANY(SELECT id from Closeouts)

-- rewritten the above query using IN
SELECT *
FROM New 
WHERE id IN (SELECT id from Closeouts)















