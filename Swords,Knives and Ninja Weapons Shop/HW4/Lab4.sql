CREATE DATABASE TEST_DB;
USE TEST_DB;


--Table with single-column primary key and no foreign keys
CREATE TABLE Client
(
	id INT NOT NULL,
	CONSTRAINT PK_Client PRIMARY KEY(id),
);

--Table with single-column primary key and at least one foreign key

CREATE TABLE Cart
(
	id INT NOT NULL,
	CONSTRAINT PK_Cart PRIMARY KEY(id),
	client_id INT,
	FOREIGN KEY(client_id) REFERENCES Client(id),
);

--Table with multicolumn primary key

CREATE TABLE Stock
(
	batch_id INT NOT NULL,
	id INT NOT NULL,
	CONSTRAINT PK_Stock PRIMARY KEY(batch_id,id),
	aditional_field INT,
)

--Table which helps creating the view that operates on 2 tables

CREATE TABLE Grouping_Helper
(
	id INT NOT NULL,
	CONSTRAINT PK_Grouping_Helper PRIMARY KEY(id),

)

INSERT INTO Grouping_Helper VALUES (1),(2),(3);
SELECT * FROM Grouping_Helper;


--View with a SELECT statement operating on one table
GO

CREATE OR ALTER VIEW View_Client
AS
	SELECT * FROM Client

GO

--View with a SELECT statement operating on 2 tables

GO

CREATE OR ALTER VIEW View_Cart
AS
	SELECT Cart.id FROM Cart
	INNER JOIN
	Stock
	ON Cart.id=Stock.id

GO

--View with a SELECT statement that has a GROUP BY clause and operates on 2 tables

GO

CREATE OR ALTER VIEW View_Stock
AS
	SELECT Stock.batch_id FROM Stock
	INNER JOIN
	Grouping_Helper
	ON Stock.batch_id=Grouping_Helper.id
	GROUP BY batch_id

GO


INSERT INTO Tables VALUES ('Client'),('Cart'),('Stock');
SELECT * FROM Tables;

INSERT INTO Views VALUES ('View_Client'),('View_Cart'),('View_Stock');
SELECT * FROM Views;

INSERT INTO Tests VALUES ('Select_View'),('Insert_Client'),('Delete_Client'),('Insert_Cart'),('Delete_Cart'),('Insert_Stock'),('Delete_Stock');
SELECT * FROM Tests;

--inserting into the bridge table tests <->views

INSERT INTO TestViews VALUES (1,1),(1,2),(1,3);
SELECT * FROM TestViews;

--TestTables(testID,tableID,NoOfRows,Position)
--testID is which test to be performed
--tableID is on which table the test will be performed
--NoOfRows is how many insertions/deletions will be made
--Position is the order in which the operations will be performed

INSERT INTO TestTables VALUES (2,1,100,1)
INSERT INTO TestTables VALUES (4,2,100,2)
INSERT INTO TestTables VALUES (6,3,100,3)
SELECT * FROM TestTables;

----------------------------------------Procedures----------------------------

--Operations

GO
CREATE OR ALTER PROC insert_client
AS
	DECLARE @index INT=1
	DECLARE @rows INT
	SELECT @rows = NoOfRows FROM TestTables WHERE TestID=2
	--PRINT (@rows)

	WHILE @index <= @rows
	BEGIN
		INSERT INTO Client VALUES (@index +1)
		SET @index = @index + 1
	END
GO


GO
CREATE OR ALTER PROC delete_client
AS
	DELETE FROM Client WHERE Client.id>1;
GO

GO
CREATE OR ALTER PROC insert_cart
AS
	DECLARE @index INT =1
	DECLARE @rows INT
	SELECT @index =NoOfRows FROM TestTables WHERE TestID=4
	WHILE @index <=@rows
	BEGIN
		INSERT INTO Cart VALUES (@index,1) --foreign key will always reference the first entry in client table
		SET @index=@index+1
	END
GO

GO
CREATE OR ALTER PROC delete_cart
AS
	DELETE FROM Cart
GO

GO
CREATE OR ALTER PROC insert_stock
AS
	DECLARE @index INT=1
	DECLARE @rows INT
	SELECT @rows= NoOfRows FROM TestTables WHERE TestID=6
	--PRINT(@rows)
	WHILE @index <=@rows
	BEGIN
		INSERT INTO Stock VALUES (@index,@index,@index)
		SET @index=@index+1
	END
GO


GO
CREATE OR ALTER PROC delete_stock
AS
	DELETE FROM Stock;
GO

SELECT * FROM Views

--Runnables

GO
CREATE OR ALTER PROC Test_Run_Views
AS
	DECLARE @start1 DATETIME;
	DECLARE @start2 DATETIME;
	DECLARE @start3 DATETIME;
	DECLARE @end1 DATETIME;
	DECLARE @end2 DATETIME;
	DECLARE @end3 DATETIME;

	SET @start1=GETDATE();
	PRINT ('executing SELECT * FROM Client')
	EXEC ('SELECT * FROM View_Client');
	SET @end1=GETDATE();
	INSERT INTO TestRuns VALUES ('test_view_1',@start1,@end1);
	INSERT INTO TestRunViews VALUES (@@IDENTITY,1,@start1,@end1); --@@IDENTITY will take the maximum identity generated, in this case 1,next case 2 and so on...

	SET @start2=GETDATE();
	PRINT ('executing SELECT * FROM Cart')
	EXEC ('SELECT * FROM View_Cart');
	SET @end2=GETDATE();
	INSERT INTO TestRuns VALUES ('test_view_2',@start2,@end2);
	INSERT INTO TestRunViews VALUES (@@IDENTITY,2,@start2,@end2); 

	SET @start3=GETDATE();
	PRINT ('executing SELECT * FROM Stock')
	EXEC ('SELECT * FROM View_Stock');
	SET @end3=GETDATE();
	INSERT INTO TestRuns VALUES ('test_view3',@start3,@end3);
	INSERT INTO TestRunViews VALUES (@@IDENTITY,3,@start3,@end3);
GO

GO
CREATE OR ALTER PROC Test_Run_Tables
AS
	
	DECLARE @start1 DATETIME;
	DECLARE @start2 DATETIME;
	DECLARE @start3 DATETIME;
	DECLARE @start4 DATETIME;
	DECLARE @start5 DATETIME;
	DECLARE @start6 DATETIME;
	DECLARE @end1 DATETIME;
	DECLARE @end2 DATETIME;
	DECLARE @end3 DATETIME;
	DECLARE @end4 DATETIME;
	DECLARE @end5 DATETIME;
	DECLARE @end6 DATETIME;

	SET @start1=GETDATE();
	PRINT('Inserting data into Client');
	EXEC insert_client;
	SET @end1=GETDATE();
	INSERT INTO TestRuns VALUES ('test_insert_client',@start1,@end1);
	INSERT INTO TestRunTables VALUES (@@IDENTITY,1,@start1,@end1);

	
	SET @start2=GETDATE();
	PRINT('Deleting data from Client');
	EXEC delete_client;
	SET @end2=GETDATE();
	INSERT INTO TestRuns VALUES ('test_delete_client',@start2,@end2);
	INSERT INTO TestRunTables VALUES (@@IDENTITY,1,@start2,@end2);

	
	SET @start3=GETDATE();
	PRINT('Inserting data into Cart');
	EXEC insert_cart;
	SET @end3=GETDATE();
	INSERT INTO TestRuns VALUES ('test_insert_cart',@start3,@end3);
	INSERT INTO TestRunTables VALUES (@@IDENTITY,2,@start3,@end3);

	SET @start4=GETDATE();
	PRINT('Deleting data from Cart');
	EXEC delete_cart;
	SET @end4=GETDATE();
	INSERT INTO TestRuns VALUES ('test_delete_cart',@start4,@end4);
	INSERT INTO TestRunTables VALUES (@@IDENTITY,2,@start4,@end4);

	SET @start5=GETDATE();
	PRINT('Inserting data into Stock');
	EXEC insert_stock;
	SET @end5=GETDATE();
	INSERT INTO TestRuns VALUES ('test_insert_stock',@start5,@end5);
	INSERT INTO TestRunTables VALUES (@@IDENTITY,3,@start5,@end5);

	SET @start6=GETDATE();
	PRINT('Deleting data from Stock');
	EXEC delete_stock;
	SET @end6=GETDATE();
	INSERT INTO TestRuns VALUES ('test_delete_stock',@start6,@end6);
	INSERT INTO TestRunTables VALUES (@@IDENTITY,3,@start6,@end6);

GO

EXEC Test_Run_Tables;
EXEC Test_Run_Views;

SELECT * FROM TestRuns
SELECT * FROM TestRunTables
SELECT * FROM TestRunViews

DELETE FROM TestRuns
DELETE FROM TestRunTables
DELETE FROM TestRunViews

DELETE FROM Client
DELETE FROM Cart
DELETE FROM Stock

SELECT* FROM Client
SELECT* FROM Stock
SELECT* FROM Cart


INSERT INTO Client VALUES (1)









