USE SHOP;



------------------------------------------------------PROCEDURES-----------------------------------------------------------

--a. modify the type of a column

GO
CREATE OR ALTER PROCEDURE do1 --usp_ChangeClientTelephoneType
AS
BEGIN
	ALTER TABLE Client
	ALTER COLUMN telephone INT
END
GO

GO
CREATE OR ALTER PROCEDURE undo1 --usp_RevertChangeClientTelephoneType
AS
BEGIN
	ALTER TABLE Client
	ALTER COLUMN telephone VARCHAR(50)
END
GO


-- b. add/remove a column

GO
CREATE OR ALTER PROCEDURE do2 --usp_AddColumnClientPassword
AS
BEGIN
	ALTER TABLE Client
	ADD password INT;
END
GO

GO
CREATE OR ALTER PROCEDURE undo2 --usp_RevertAddColumnClientPassword
AS
BEGIN
	ALTER TABLE Client
	DROP COLUMN password;
END
GO


-- c. add/remove a DEFAULT constraint


GO
CREATE OR ALTER PROCEDURE do3 --usp_AddDefaultConstraintNewPrice
AS
BEGIN
	ALTER TABLE New
	ADD CONSTRAINT DC_NewPrice DEFAULT 1 FOR price; -- DC ---> Default Constraint
END
GO

CREATE OR ALTER PROCEDURE undo3 --usp_RevertAddDefaultConstraintNewPrice
AS
BEGIN
	ALTER TABLE New
	DROP CONSTRAINT DC_NewPrice;
END
GO



-- d. add/remove a primary key

GO
CREATE OR ALTER PROCEDURE do4 --usp_AddPrimaryKeyCloseoutsName
AS
BEGIN
	CREATE TABLE Mock_Table_PKC
	(
		id INT NOT NULL
	);
	ALTER TABLE Mock_Table_PKC
	ADD CONSTRAINT PKC_Mock_Table_PKCId PRIMARY KEY(id); -- PKC ---> Primary Key Constraint
END
GO

GO
CREATE OR ALTER PROCEDURE undo4 --usp_RevertAddPrimaryKeyCloseoutsName
 AS
BEGIN
	ALTER TABLE Mock_Table_PKC
	DROP CONSTRAINT PKC_Mock_Table_PKCId;
	DROP TABLE IF EXISTS Mock_Table_PKC
END
GO




-- e. add/remove a candidate key

GO
CREATE OR ALTER PROCEDURE do5 --usp_AddCandidateKeySwordsIdName
AS
BEGIN
	ALTER TABLE Swords
	ADD CONSTRAINT UKC_SwordsIdName UNIQUE(id,name); -- UKC ---> Unique Key Constraint
END
GO


GO
CREATE OR ALTER PROCEDURE undo5 --usp_RevertAddCandidateKeySwordsIdName
AS
BEGIN
	ALTER TABLE Swords
	DROP CONSTRAINT UKC_SwordsIdName;
END
GO


-- f. add/remove a foreign key


GO
CREATE OR ALTER PROCEDURE do6 --usp_AddForeignKeyMock_TableId
AS
BEGIN
	CREATE TABLE Mock_Table_FKC
	    (
		id INT NOT NULL
		);

	ALTER TABLE Mock_Table_FKC
	ADD CONSTRAINT FKC_Mock_Table_FKCId FOREIGN KEY (id) REFERENCES Menu(menu_id);-- FKC ---> Foreign Key Constraint
END
GO

GO
CREATE OR ALTER PROCEDURE undo6 --usp_RevertAddForeignKeyMock_TableId
AS
BEGIN
	ALTER TABLE Mock_Table_FKC
	DROP CONSTRAINT FKC_Mock_Table_FKCId;
	DROP TABLE IF EXISTS Mock_Table_FKC;
END
GO


--g create/drop a table

GO
CREATE OR ALTER PROCEDURE do7 --usp_CreateTableMock_Table
AS
BEGIN
	CREATE TABLE Mock_Table_Create
		(
		id INT PRIMARY KEY NOT NULL,
		name VARCHAR(50)
		);
END
GO

GO
CREATE OR ALTER PROCEDURE undo7 --usp_RevertCreateTableMock_Table
AS
BEGIN
	DROP TABLE IF EXISTS Mock_Table_Create;
END
GO

--------------------------------------------------VERSIONING MECHANISM------------------------------------------------------

DROP TABLE IF EXISTS DB_Version


--Create the Database Versions table
CREATE TABLE DB_Version
(
	id int IDENTITY(1,1) NOT NULL,
	current_version int,
	CONSTRAINT PKC_VersionId Primary KEY CLUSTERED(id)
);

INSERT INTO DB_Version VALUES(0); --from this version the mechanism will start
SELECT * FROM DB_Version


--The versioning mechanism procedure

GO
CREATE OR ALTER PROCEDURE usp_take_me_to_version
	@version_to INT
AS
BEGIN
	DECLARE @version_from INT
	DECLARE @print_message NVARCHAR(50)

	SET @version_from=(SELECT DB_Version.current_version FROM DB_Version)
	DECLARE @query VARCHAR(2000)

	IF @version_to<=7 AND @version_from>=0
		IF @version_to>@version_from
		BEGIN
			WHILE @version_to>@version_from
				BEGIN --simulate a query
					SET @version_from = @version_from+1
					
					SET @print_message=N'Database set to version '+RTRIM(CAST(@version_from AS NVARCHAR(30)))
					PRINT @print_message

					SET @query='do' + CAST(@version_from AS VARCHAR(5))
					EXEC @query
				END
		END
		ELSE
		BEGIN
			WHILE @version_to<@version_from
				BEGIN
					IF @version_from!=0
						BEGIN
							SET @query='undo' + CAST(@version_from AS VARCHAR(5))
							EXEC @query
						END
							SET @version_from=@version_from-1
						
							SET @print_message=N'Database set to version '+RTRIM(CAST(@version_from AS NVARCHAR(30)))
							PRINT @print_message
				 END
		END
		ELSE
		BEGIN
			PRINT 'version has to be bigger or equal to 0 and smaller than 8!'
			RETURN
		END

		UPDATE DB_Version
		SET current_version=@version_to
END
GO

EXEC usp_take_me_to_version 0;

SELECT current_version FROM DB_Version

EXEC do1;
EXEC undo1;
EXEC do2;
EXEC undo2;
EXEC do3;
EXEC undo3;
EXEC do4;
EXEC undo4;
EXEC do5;
EXEC undo5;
EXEC do6;
EXEC undo6;
EXEC do7;
EXEC undo7;




