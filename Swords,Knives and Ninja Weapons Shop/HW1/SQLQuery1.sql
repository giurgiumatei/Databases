
--CREATE DATABASE SHOP;

USE SHOP;


CREATE TABLE New
(
	weapon_type VARCHAR(20),
	id INT PRIMARY KEY,
	name VARCHAR(20),
	price INT
)

CREATE TABLE Swords_Brand
(
	id INT PRIMARY KEY,
	name VARCHAR(20),
)

CREATE TABLE Knives_Brand
(
	id INT PRIMARY KEY,
	name VARCHAR(20),
)

CREATE TABLE Ninja_Weapons_Brand
(
	id INT PRIMARY KEY,
	name VARCHAR(20),
)


CREATE TABLE Swords
(
	id INT PRIMARY KEY,
	name VARCHAR(20) ,
	brand_id INT,
	price INT,
	stars INT,
	


	FOREIGN KEY(brand_id) REFERENCES Swords_Brand(id),
	
)


CREATE TABLE Knives
(
	id INT PRIMARY KEY,
	name VARCHAR(20) ,
	brand_id INT,
	price INT,
	stars INT,
	
	FOREIGN KEY(brand_id) REFERENCES Knives_Brand(id),
)

CREATE TABLE Ninja_Weapons
(
	id INT PRIMARY KEY,
	name VARCHAR(20) ,
	brand_id INT,
	price INT,
	stars INT,
	
	FOREIGN KEY(brand_id) REFERENCES Ninja_Weapons_Brand(id) 
)


CREATE TABLE Closeouts
(
	id INT PRIMARY KEY,
	name VARCHAR(20),
	old_price INT,
	new_price INT,
	quantity INT
)

CREATE TABLE Client
(
 id INT ,
 name VARCHAR(20),
 PRIMARY KEY(id),
 telephone VARCHAR(10),
 email VARCHAR(20),
 )



CREATE TABLE Swords_Providers
(
	id INT PRIMARY KEY,
	name VARCHAR(20),

)
	
CREATE TABLE Knives_Providers
(
	id INT PRIMARY KEY,
	name VARCHAR(20),
)

CREATE TABLE Ninja_Weapons_Providers
(
	id INT PRIMARY KEY,
	name VARCHAR(20),
)

 CREATE TABLE Swords__Swords_Providers__Bridge
 (

	provider_id INT PRIMARY KEY,
	product_id INT,
	FOREIGN KEY(provider_id) REFERENCES Swords_Providers(id),
	FOREIGN KEY(product_id) REFERENCES Swords(id),
	
)

 CREATE TABLE Knives__Knives_Providers__Bridge
 (

	provider_id INT PRIMARY KEY,
	product_id INT,
	FOREIGN KEY(provider_id) REFERENCES Knives_Providers(id),
	FOREIGN KEY(product_id) REFERENCES Knives(id),
	
)

 CREATE TABLE Ninja_Weapons__Ninja_Weapons_Providers__Bridge
 (

	provider_id INT PRIMARY KEY,
	product_id INT,
	FOREIGN KEY(provider_id) REFERENCES Ninja_Weapons_Providers(id),
	FOREIGN KEY(product_id) REFERENCES Ninja_Weapons(id),
	
)



CREATE TABLE Cart
(
	client_id INT PRIMARY KEY,
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
	FOREIGN KEY(cart_id) REFERENCES Cart(client_id)
)