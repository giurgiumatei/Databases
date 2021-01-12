CREATE DATABASE Seminar6
USE Seminar6;


GO

DROP TABLE RoutesStations
DROP TABLE Stations
DROP TABLE Routes
DROP TABLE Trains
DROP TABLE TrainTypes
GO

CREATE TABLE TrainTYpes
(
	TrainTypeId INT PRIMARY KEY,
	TTName VARCHAR(70),
	TTDescription VARCHAR(300)
)


CREATE TABLE Trains
(
	TrainId INT PRIMARY KEY,
	TName VARCHAR(70),
	TrainTypeId INT REFERENCES TrainTypes(TrainTypeId)
)


CREATE TABLE Routes
(
	RouteId INT PRIMARY KEY,
	RName VARCHAR(70) UNIQUE,
	TrainId INT REFERENCES Trains(TrainId)
)

CREATE TABLE Stations
(
	StationId INT PRIMARY KEY,
	SName VARCHAR(70) UNIQUE

)

CREATE TABLE RoutesStations
(
	RouteId INT REFERENCES Routes(RouteID),
	StationId INT REFERENCES Stations(StationId),
	Arrival TIME,
	Departure TIME,
	PRIMARY KEY(RouteId,StationId)
)


GO


--2
CREATE OR ALTER PROC uspUpdateRoute (@RName VARCHAR(70), @SName VARCHAR(70), @Arrival TIME,@Departure TIME)
AS
	DECLARE @RID INT, @SID INT
	IF NOT EXISTS(SELECT * 
				FROM Routes 
				WHERE RName=@RName
				 )
	BEGIN
		RAISERROR('Invalid route name.',16,1)
		RETURN
	END

	IF NOT EXISTS(SELECT * 
				FROM Stations 
				WHERE SName=@SName
				 )
	BEGIN
		RAISERROR('Invalid station name.',16,1)
		RETURN
	END

	SELECT @RID=(SELECT RouteId FROM Routes WHERE RName=@RName),
	@SID=(SELECT StationId FROM Stations WHERE SName=@SName)

	IF NOT EXISTS(SELECT *
				FROM RoutesStations
				WHERE RouteId=@RID AND StationId=@SID)
			
			INSERT RoutesStations(RouteId, StationId, Arrival, Departure)
			VALUES(@RID,@SID,@Arrival,@Departure)
	ELSE
		UPDATE RoutesStations
		SET Arrival =@Arrival, Departure=@Departure
		WHERE RouteId=@RID AND StationId=@SID

GO


INSERT TrainTYpes VALUES(1,'type1','type1descr'),(2,'type2','type2descr')
INSERT Trains VALUES (1,'t1',1),(2,'t2',2), (3,'t3',2),(4,'t4',2)
INSERT Routes VALUES (1,'r1',1),(2,'r2',2), (3,'r3',3),(4,'r4',4)
INSERT Stations VALUES (1,'s1'),(2,'s2'),(3,'s3'),(4,'s4')

SELECT * FROM TrainTYpes
SELECT * FROM Trains
SELECT * FROM Routes
SELECT * FROM Stations

SELECT * FROM RoutesStations

EXEC uspUpdateRoute @RName='r1',@SName='s10',@Arrival='8:10',@Departure='8:20'

EXEC uspUpdateRoute @RName='r1',@SName='s1',@Arrival='7:00',@Departure='7:10'
EXEC uspUpdateRoute @RName='r1',@SName='s2',@Arrival='7:40',@Departure='8:00'
EXEC uspUpdateRoute @RName='r1',@SName='s3',@Arrival='8:10',@Departure='8:20'
EXEC uspUpdateRoute @RName='r1',@SName='s4',@Arrival='9:00',@Departure='9:10'

EXEC uspUpdateRoute @RName = 'r2', @SName = 's1', @Arrival = '10:00', @Departure = '10:10'
EXEC uspUpdateRoute @RName = 'r2', @SName = 's2', @Arrival = '10:40', @Departure = '11:00'
EXEC uspUpdateRoute @RName = 'r2', @SName = 's3', @Arrival = '11:10', @Departure = '11:20'
EXEC uspUpdateRoute @RName = 'r2', @SName = 's4', @Arrival = '12:00', @Departure = '12:10'

EXEC uspUpdateRoute @RName = 'r3', @SName = 's1', @Arrival = '11:00', @Departure = '11:10'
GO
--3

CREATE OR ALTER  VIEW vRoutesWithAllStations
AS
	SELECT r.RName
	FROM Routes r
	WHERE NOT EXISTS
		(SELECT StationId
		FROM Stations
		EXCEPT
		SELECT StationId
		FROM RoutesStations
		WHERE RouteId=r.RouteId
		)
GO

SELECT *
FROM vRoutesWithAllStations

--4

SELECT * FROM RoutesStations
ORDER BY StationId
GO

CREATE OR ALTER FUNCTION ufFilterStationsByNumRoutes(@R INT)
RETURNS TABLE
RETURN SELECT S.SName
FROM Stations S
WHERE S.StationId IN
	(SELECT RS.StationId
	FROM RoutesStations RS
	GROUP BY RS.StationId
	HAVING COUNT(*) > @R
	)
GO

SELECT *
FROM ufFilterStationsByNumRoutes(3)




