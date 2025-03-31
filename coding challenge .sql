CREATE DATABASE PETPALS;

USE PETPALS;

CREATE TABLE Pets (
    PetID INT PRIMARY KEY AUTO_INCREMENT,
    Name VARCHAR(255) NOT NULL,
    Age INT,
    Breed VARCHAR(255),
    Type VARCHAR(255),
    AvailableForAdoption BIT
);
CREATE TABLE PETS(
PETID INT PRIMARY KEY,
NAME VARCHAR(100) NOT NULL,
AGE INT NOT NULL,
BREED VARCHAR(100),
TYPE VARCHAR(100),
  AvailableForAdoption BIT
  );
  INSERT INTO Pets (PetID, Name, Age, Breed, Type, AvailableForAdoption)
VALUES 
(1, 'Bella', 3, 'Labrador', 'Dog', 1),
(2, 'Max', 2, 'Persian', 'Cat', 1),
(3, 'Charlie', 5, 'Golden Retriever', 'Dog', 0),
(4, 'Luna', 1, 'Siamese', 'Cat', 1),
(5, 'Rocky', 4, 'Bulldog', 'Dog', 1);


CREATE TABLE SHELTERS(
SHELTERID INT PRIMARY KEY,
NAME VARCHAR(100),
LOCATION VARCHAR(100)
);

INSERT INTO Shelters (ShelterID, Name, Location)
VALUES 
(1, 'Happy Paws Shelter', 'New York'),
(2, 'Safe Haven Pets', 'Los Angeles'),
(3, 'Furry Friends Home', 'Chicago');

ALTER TABLE Pets
ADD COLUMN ShelterID INT,
ADD FOREIGN KEY (ShelterID) REFERENCES Shelters(ShelterID);

select *from shelters;


CREATE TABLE DONATIONS(
DONATIONID INT PRIMARY KEY,
DONORNAME VARCHAR(100),
DONATIONTYPE VARCHAR(100),
DONATIONAMOUNT DECIMAL(10,2),
DONATIONITEM VARCHAR(100),
DONATIONDATE DATETIME
);
INSERT INTO Donations (DonationID, DonorName, DonationType, DonationAmount, DonationItem, DonationDate)
VALUES 
(1, 'John Doe', 'Cash', 100.00, NULL, '2025-03-01 10:30:00'),
(2, 'Jane Smith', 'Item', NULL, 'Dog Food', '2025-03-05 14:00:00'),
(3, 'Alice Brown', 'Cash', 200.00, NULL, '2025-03-10 12:15:00');


CREATE TABLE IF NOT EXISTS AdoptionEvents (
    EventID INT PRIMARY KEY,
    EventName VARCHAR(100),
    EventDate DATETIME,
    Location VARCHAR(255)
);
INSERT INTO AdoptionEvents (EventID, EventName, EventDate, Location)
VALUES 
(1, 'Spring Adoption Fair', '2025-04-15 11:00:00', 'New York'),
(2, 'Pet Love Expo', '2025-05-10 13:30:00', 'Los Angeles');


CREATE TABLE IF NOT EXISTS Participants (
    ParticipantID INT PRIMARY KEY,
    ParticipantName VARCHAR(100),
    ParticipantType VARCHAR(50),
    EventID INT,
    FOREIGN KEY (EventID) REFERENCES AdoptionEvents(EventID)
);

SHOW TABLES;
INSERT INTO Participants (ParticipantID, ParticipantName, ParticipantType, EventID)
VALUES 
(1, 'Happy Paws Shelter', 'Shelter', 1),
(2, 'Safe Haven Pets', 'Shelter', 2),
(3, 'John Doe', 'Adopter', 1),
(4, 'Jane Smith', 'Adopter', 2);

CREATE TABLE Adoptions (
    AdoptionID INT PRIMARY KEY AUTO_INCREMENT,
    PetID INT,
    AdopterParticipantID INT, -- Or AdopterID referencing a separate Adopters table
    AdoptionDate DATE,
    FOREIGN KEY (PetID) REFERENCES Pets(PetID),
    FOREIGN KEY (AdopterParticipantID) REFERENCES Participants(ParticipantID)
);
INSERT INTO Adoptions (PetID, AdopterParticipantID, AdoptionDate) VALUES
(1, 3, '2025-04-20'),  
(4, 4, '2025-05-15');  

/*5) Write an SQL query that retrieves a list of available pets (those marked as available for adoption)
from the "Pets" table. Include the pet's name, age, breed, and type in the result set. Ensure that
the query filters out pets that are not available for adoption.*/

SELECT *FROM PETS WHERE   AvailableForAdoption=1;

/*6)  Write an SQL query that retrieves the names of participants (shelters and adopters) registered
for a specific adoption event. Use a parameter to specify the event ID. Ensure that the query
joins the necessary tabl 
es to retrieve the participant names and types.*/

SELECT p.ParticipantName, p.ParticipantType
FROM Participants p
JOIN AdoptionEvents ae ON p.EventID = ae.EventID
WHERE p.EventID = 1 AND 2;

/* 7) Create a stored procedure in SQL that allows a shelter to update its information (name and
location) in the "Shelters" table. Use parameters to pass the shelter ID and the new information.
Ensure that the procedure performs the update and handles potential errors, such as an invalid
shelter ID.*/

DELIMITER //

CREATE PROCEDURE UpdateShelterInfo (
    IN ShelterID INT,
    IN NewName VARCHAR(255),
    IN NewLocation VARCHAR(255)
)
BEGIN
    -- Check if the shelter exists
    IF NOT EXISTS (SELECT 1 FROM Shelters WHERE ShelterID = ShelterID) THEN
        -- Raise an error if the shelter does not exist
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Shelter with specified ID not found.';
    ELSE
        -- Update the shelter's information
        UPDATE Shelters
        SET Name = NewName,
            Location = NewLocation
        WHERE ShelterID = ShelterID;
    END IF;
END//

DELIMITER ;

/*8)Write an SQL query that calculates and retrieves the total donation amount for each shelter (by
shelter name) from the "Donations" table. The result should include the shelter name and the
total donation amount. Ensure that the query handles cases where a shelter has received no
donations.*/

-- here we can add the column shelterid in donation
ALTER TABLE Donations
ADD COLUMN ShelterID INT,
ADD FOREIGN KEY (ShelterID) REFERENCES Shelters(ShelterID);

SELECT s.Name AS ShelterName, COALESCE(SUM(d.DonationAmount), 0) AS TotalDonationAmount
FROM Shelters s
LEFT JOIN Donations d ON s.ShelterID = d.ShelterID --  Assuming ShelterID in Donations
GROUP BY s.ShelterID, s.Name;

SHOW COLUMNS FROM Donations;

/*9)Write an SQL query that retrieves the names of pets from the "Pets" table that do not have an
owner (i.e., where "OwnerID" is null). Include the pet's name, age, breed, and type in the result
set.*/
-- Here we can add the column ownerid in pets table  .
ALTER TABLE Pets
ADD COLUMN OwnerID INT;  -- Or VARCHAR(255), depending on how you want to store the owner's ID
SELECT Name, Age, Breed, Type FROM Pets WHERE OwnerID IS NULL;

/*10)Write an SQL query that retrieves the total donation amount for each month and year (e.g.,
January 2023) from the "Donations" table. The result should include the month-year and the
corresponding total donation amount. Ensure that the query handles cases where no donations
were made in a specific month-year.*/

SELECT DATE_FORMAT(DonationDate, '%M %Y') AS MonthYear, SUM(DonationAmount) AS TotalDonations
FROM Donations
GROUP BY MonthYear;

/*11)Retrieve a list of distinct breeds for all pets that are either aged between 1 and 3 years or older
than 5 years.*/

SELECT DISTINCT Breed FROM Pets WHERE Age BETWEEN 1 AND 3 OR Age > 5;

/*12)Retrieve a list of pets and their respective shelters where the pets are currently available for
adoption.*/

SELECT p.Name AS PetName, s.Name AS ShelterName
FROM Pets p
JOIN Shelters s ON p.ShelterID = s.ShelterID
WHERE p.AvailableForAdoption = 1;


/*13)Find the total number of participants in events organized by shelters located in specific city.
*/

-- here we can add shelterid in pets tabel 
ALTER TABLE Pets
ADD COLUMN ShelterID INT,
ADD FOREIGN KEY (ShelterID) REFERENCES Shelters(ShelterID);

SHOW COLUMNS FROM Pets LIKE 'ShelterID';

-- here we also perfrom same thing of adding column.
ALTER TABLE AdoptionEvents
ADD COLUMN ShelterID INT,
ADD FOREIGN KEY (ShelterID) REFERENCES Shelters(ShelterID);

SELECT COUNT(p.ParticipantID) AS TotalParticipants
FROM Participants p
JOIN AdoptionEvents ae ON p.EventID = ae.EventID
JOIN Shelters s ON ae.ShelterID = s.ShelterID
WHERE s.Location = 'Chicago,Los Angeles';

/*14)Retrieve a list of unique breeds for pets with ages between 1 and 5 years.*/
SELECT DISTINCT Breed
FROM Pets
WHERE Age BETWEEN 1 AND 5;

/*15)15. Find the pets that have not been adopted by selecting their information 
from the 'Pet' table.*/
SELECT p.*
FROM Pets p
WHERE p.PetID NOT IN (SELECT a.PetID FROM Adoptions a);

/*16)Retrieve the names of all adopted pets along with the adopter's name from the 'Adoption' and
'User' tables.*/


SELECT p.Name AS PetName, pa.ParticipantName AS AdopterName
FROM Adoptions a  -- Changed alias to 'a' for clarity
JOIN Pets p ON a.PetID = p.PetID
JOIN Participants pa ON a.AdopterParticipantID = pa.ParticipantID
WHERE pa.ParticipantType = 'Adopter';

/*17)Retrieve a list of all shelters along with the count of pets currently available for adoption in each
shelter.*/

UPDATE Pets SET ShelterID = 1 WHERE PetID IN (1, 3);
UPDATE Pets SET ShelterID = 2 WHERE PetID IN (2, 4, 5);

SELECT s.Name AS ShelterName, COUNT(p.PetID) AS AvailablePetCount
FROM Shelters s
LEFT JOIN Pets p ON s.ShelterID = p.ShelterID
WHERE p.AvailableForAdoption = 1
GROUP BY s.ShelterID, s.Name;

/*18)Find pairs of pets from the same shelter that have the same breed.*/

SELECT p1.Name AS Pet1Name, p2.Name AS Pet2Name
FROM Pets p1
JOIN Pets p2 ON p1.ShelterID = p2.ShelterID AND p1.Breed = p2.Breed AND p1.PetID < p2.PetID;


/*19)19. List all possible combinations of shelters and adoption events.*/

SELECT s.Name AS ShelterName, ae.EventName AS AdoptionEventName
FROM Shelters s
CROSS JOIN AdoptionEvents ae;

/*20)Determine the shelter that has the highest number of adopted pets.*/


SELECT s.Name AS ShelterName
FROM Shelters s
JOIN Pets p ON s.ShelterID = p.ShelterID
JOIN Adoptions a ON p.PetID = a.PetID
GROUP BY s.ShelterID, s.Name
ORDER BY COUNT(a.PetID) DESC
LIMIT 1;


