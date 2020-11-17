--OP DATABASE SHOP;
CREATE DATABASE SHOP;
USE SHOP
CREATE TABLE New
(
	id INT PRIMARY KEY IDENTITY(1,1),
	weapon_type VARCHAR(20),
	name VARCHAR(20),
	price INT
)

CREATE TABLE Closeouts
(
	id INT PRIMARY KEY IDENTITY(1,1),
	name VARCHAR(20),
	old_price INT,
	new_price INT,
	quantity INT
)

CREATE TABLE Swords_Brand
(
	id INT PRIMARY KEY IDENTITY(1,1),
	name VARCHAR(20),
)

CREATE TABLE Knives_Brand
(
	id INT PRIMARY KEY IDENTITY(1,1),
	name VARCHAR(20),
)

CREATE TABLE Ninja_Weapons_Brand
(
	id INT PRIMARY KEY IDENTITY(1,1),
	name VARCHAR(20),
)


CREATE TABLE Swords
(
	id INT PRIMARY KEY IDENTITY(1,1),
	name VARCHAR(20) ,
	brand_id INT,
	price INT,
	stars INT,
	FOREIGN KEY(brand_id) REFERENCES Swords_Brand(id),
	
)

CREATE TABLE Knives
(
	id INT PRIMARY KEY IDENTITY(1,1),
	name VARCHAR(20) ,
	brand_id INT,
	price INT,
	stars INT,
	FOREIGN KEY(brand_id) REFERENCES Knives_Brand(id),
)

CREATE TABLE Ninja_Weapons
(
	id INT PRIMARY KEY IDENTITY(1,1),
	name VARCHAR(20) ,
	brand_id INT,
	price INT,
	stars INT,
	FOREIGN KEY(brand_id) REFERENCES Ninja_Weapons_Brand(id) 
)

CREATE TABLE Client
(
 id INT PRIMARY KEY IDENTITY(1,1),
 name VARCHAR(20),
 telephone VARCHAR(10),
 email VARCHAR(20),
)
 
 CREATE TABLE Swords_Providers
(
	id INT PRIMARY KEY IDENTITY(1,1),
	name VARCHAR(20),
)

CREATE TABLE Knives_Providers
(
	id INT PRIMARY KEY IDENTITY(1,1),
	name VARCHAR(20),
)

CREATE TABLE Ninja_Weapons_Providers
(
	id INT PRIMARY KEY IDENTITY(1,1),
	name VARCHAR(20),
)

 CREATE TABLE Swords__Swords_Providers__Bridge
 (

	provider_id INT,
	product_id INT,
	FOREIGN KEY(provider_id) REFERENCES Swords_Providers(id),
	FOREIGN KEY(product_id) REFERENCES Swords(id),
	
)


 CREATE TABLE Knives__Knives_Providers__Bridge
 (

	provider_id INT,
	product_id INT,
	FOREIGN KEY(provider_id) REFERENCES Knives_Providers(id),
	FOREIGN KEY(product_id) REFERENCES Knives(id),
	
)


CREATE TABLE Ninja_Weapons__Ninja_Weapons_Providers__Bridge
(

	provider_id INT,
	product_id INT,
	FOREIGN KEY(provider_id) REFERENCES Ninja_Weapons_Providers(id),
	FOREIGN KEY(product_id) REFERENCES Ninja_Weapons(id),
	
)

CREATE TABLE Cart
(
	id INT PRIMARY KEY,
	client_id INT,
	product_name VARCHAR(20) ,
	quantity INT,
	price INT,
	FOREIGN KEY(client_id) REFERENCES Client(id)
)


CREATE TABLE Menu
(
	menu_id INT PRIMARY KEY,
	new_id INT,
	closeouts_id INT,
	swords_id INT,
	knives_id INT,
	ninja_weapons_id INT,
	cart_id INT,
	FOREIGN KEY(new_id) REFERENCES New(id),
	FOREIGN KEY(closeouts_id) REFERENCES Closeouts(id),
	FOREIGN KEY(swords_id) REFERENCES Swords(id),
	FOREIGN KEY(knives_id) REFERENCES Knives(id),
	FOREIGN KEY(ninja_weapons_id) REFERENCES Ninja_Weapons(id),
	FOREIGN KEY(cart_id) REFERENCES Cart(id)
)
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
 DELETE  FROM Closeouts
 
 DELETE  FROM New
 
 DELETE FROM Swords_Providers
 WHERE name='' OR name=NULL


 --Alter Closeouts and Ninja_Weapons_Brand Table
 ALTER TABLE Closeouts ALTER COLUMN name VARCHAR(50);
 ALTER TABLE Ninja_Weapons_Brand ALTER COLUMN name VARCHAR(50);

 -- UPDATES 

 -- UPDATE Swords_Brand Table
 UPDATE Swords_Brand
 SET name='Lord Of The Rings'
 WHERE name='LOTR'

 UPDATE Closeouts
 SET quantity=quantity-1
 WHERE quantity>10 AND quantity<20

 Update New
 SET weapon_type='Sword'
 WHERE weapon_type is NULL
 
 -- Reset indexes for Identity(1,1) for some tables
 DBCC CHECKIDENT('Swords',RESEED,0)
 DBCC CHECKIDENT('Knives',RESEED,0)
 DBCC CHECKIDENT('Ninja_Weapons',RESEED,0)
 DBCC CHECKIDENT('New',RESEED,0)
 DBCC CHECKIDENT('Swords_Brand',RESEED,0)
 DBCC CHECKIDENT('Closeouts',RESEED,0)
 DBCC CHECKIDENT('Swords_Providers',RESEED,0)
 DBCC CHECKIDENT('Knives_Providers',RESEED,1)
 DBCC CHECKIDENT('Ninja_Weapons_Providers',RESEED,1)

