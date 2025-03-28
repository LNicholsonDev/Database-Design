-- Name:  Leah Nicholson
-- Date:  March 23RD, 2025
-- Description:  Final Project Part 2 - Data Definition Language


-- DATABASE AND TABLE CREATION -- 

-- Create the database zCourseOutcomes
USE master;
GO

DROP DATABASE IF EXISTS zCourseOutcomes;
GO

CREATE DATABASE zCourseOutcomes;
GO

USE zCourseOutcomes;
GO


-- Create Divison Table
DROP TABLE IF EXISTS Division;
GO

CREATE TABLE Division
(
DivisionKey INT NOT NULL PRIMARY KEY IDENTITY,  
DivisionName nvarchar(255)
);
GO


-- Create Program Table
DROP TABLE IF EXISTS Program;
GO

CREATE TABLE Program
(
ProgramKey INT NOT NULL PRIMARY KEY IDENTITY,  
ProgramName nvarchar(255),
DivisionKey int NOT NULL,
FOREIGN KEY (DivisionKey) REFERENCES Division(DivisionKey)
);
GO


-- Create ProgramChair Table
DROP TABLE IF EXISTS ProgramChair;
GO

CREATE TABLE ProgramChair
(
ProgramChairKey INT NOT NULL PRIMARY KEY IDENTITY,  
ProgramChairFName nvarchar(50),
ProgramChairLName nvarchar(50)
);
GO


-- Create Course Table
DROP TABLE IF EXISTS Course;
GO

CREATE TABLE Course
(
CourseKey INT NOT NULL PRIMARY KEY IDENTITY,  
CourseID nvarchar(10),
--CourseName nvarchar(255),		-- CourseName not required per Professor March 18 (Project Discussion)
ProgramKey INT, 
FOREIGN KEY (ProgramKey) REFERENCES Program(ProgramKey)
);
GO



-- Create Outcome Table
DROP TABLE IF EXISTS Outcome;
GO

CREATE TABLE Outcome
(
OutcomeKey INT NOT NULL PRIMARY KEY IDENTITY,  
OutcomeDescription nvarchar(50)
);
GO



-- Create Course Outcome Table (Links Course and Outcome tables)
DROP TABLE IF EXISTS CourseOutcome;
GO

CREATE TABLE CourseOutcome
(
CourseOutcomeKey INT NOT NULL PRIMARY KEY IDENTITY,
CourseKey INT NOT NULL, 
OutcomeKey INT NOT NULL,
FOREIGN KEY (CourseKey) REFERENCES Course(CourseKey),
FOREIGN KEY (OutcomeKey) REFERENCES Outcome(OutcomeKey)
);
GO



-- Create Program Chair Map Table (Links Program and ProgramChair tables)

DROP TABLE IF EXISTS ProgramChairMap;
GO

CREATE TABLE ProgramChairMap
(
ProgramChairMapKey INT NOT NULL PRIMARY KEY IDENTITY,
ProgramKey INT NOT NULL,
ProgramChairKey INT NOT NULL,
FOREIGN KEY (ProgramKey) REFERENCES Program(ProgramKey),
FOREIGN KEY (ProgramChairKey) REFERENCES ProgramChair(ProgramChairKey)
);
GO



-- START OF DATA INSERTION -- 


-- Insert Division Name Data into Division Table
INSERT INTO Division (DivisionName) VALUES ('Arts and Humanities');
INSERT INTO Division (DivisionName) VALUES ('Health Sciences');
INSERT INTO Division (DivisionName) VALUES ('IBIT');
INSERT INTO Division (DivisionName) VALUES ('Science');
INSERT INTO Division (DivisionName) VALUES ('Social Science');


-- Insert ProgramName and DivisionKey into Program Table
INSERT INTO Program (ProgramName, DivisionKey) VALUES ('ENGLISH',1);
INSERT INTO Program (ProgramName, DivisionKey) VALUES ('PHILOSOPHY',1);
INSERT INTO Program (ProgramName, DivisionKey) VALUES ('WORLD LANGUAGE',1);
INSERT INTO Program (ProgramName, DivisionKey) VALUES ('ALLIED HEALTH',2);
INSERT INTO Program (ProgramName, DivisionKey) VALUES ('NURSING',2);
INSERT INTO Program (ProgramName, DivisionKey) VALUES ('ACCOUNTING',3);
INSERT INTO Program (ProgramName, DivisionKey) VALUES ('BUS INTELLIGENCE',3);
INSERT INTO Program (ProgramName, DivisionKey) VALUES ('DATA ANALYTICS',3);
INSERT INTO Program (ProgramName, DivisionKey) VALUES ('DIGITAL MEDIA ARTS',3);
INSERT INTO Program (ProgramName, DivisionKey) VALUES ('INFO SYSTMS/TECHNLGY',3);
INSERT INTO Program (ProgramName, DivisionKey) VALUES ('BIOLOGY',4);
INSERT INTO Program (ProgramName, DivisionKey) VALUES ('MATH',4);
INSERT INTO Program (ProgramName, DivisionKey) VALUES ('ANTHROPOLOGY',5);


-- Insert Program Chair Names (First and Last) into ProgramChair Table
INSERT INTO ProgramChair(ProgramChairFName, ProgramChairLName) VALUES ('Sean','Allen');
INSERT INTO ProgramChair(ProgramChairFName, ProgramChairLName) VALUES ('Russ','Payne');
INSERT INTO ProgramChair(ProgramChairFName, ProgramChairLName) VALUES ('Anne','Stewart');
INSERT INTO ProgramChair(ProgramChairFName, ProgramChairLName) VALUES ('Ann','Minks');
INSERT INTO ProgramChair(ProgramChairFName, ProgramChairLName) VALUES ('Lisa','Tedeschi');
INSERT INTO ProgramChair(ProgramChairFName, ProgramChairLName) VALUES ('Donald','Rowe');
INSERT INTO ProgramChair(ProgramChairFName, ProgramChairLName) VALUES ('Dena','Laney');
INSERT INTO ProgramChair(ProgramChairFName, ProgramChairLName) VALUES ('Kyle','Barber');
INSERT INTO ProgramChair(ProgramChairFName, ProgramChairLName) VALUES ('Liz','Hollerman');
INSERT INTO ProgramChair(ProgramChairFName, ProgramChairLName) VALUES ('Allison','Kang');
INSERT INTO ProgramChair(ProgramChairFName, ProgramChairLName) VALUES ('Andria','Villines');
INSERT INTO ProgramChair(ProgramChairFName, ProgramChairLName) VALUES ('Anthony','Tessandori');


-- Insert OutcomeDescription into Outcome Table
INSERT INTO Outcome (OutcomeDescription) VALUES ('Critical Thinking/Problem Solving');
INSERT INTO Outcome (OutcomeDescription) VALUES ('Quantitative/Symbolic Reasoning');
INSERT INTO Outcome (OutcomeDescription) VALUES ('Research /Information Literacy');
INSERT INTO Outcome (OutcomeDescription) VALUES ('Scientific Inquiry (Nature of Science)');
INSERT INTO Outcome (OutcomeDescription) VALUES ('Aesthetic Awareness');
INSERT INTO Outcome (OutcomeDescription) VALUES ('Reading');
INSERT INTO Outcome (OutcomeDescription) VALUES ('Writing');
INSERT INTO Outcome (OutcomeDescription) VALUES ('Listening');
INSERT INTO Outcome (OutcomeDescription) VALUES ('Visual');
INSERT INTO Outcome (OutcomeDescription) VALUES ('Computer Literacy');
INSERT INTO Outcome (OutcomeDescription) VALUES ('Self-Assessment/Life Goals');
INSERT INTO Outcome (OutcomeDescription) VALUES ('Group Processes');
INSERT INTO Outcome (OutcomeDescription) VALUES ('Ethics');
INSERT INTO Outcome (OutcomeDescription) VALUES ('Global Citizenship');
INSERT INTO Outcome (OutcomeDescription) VALUES ('Historical and Intellectual Perspectives');
INSERT INTO Outcome (OutcomeDescription) VALUES ('Cultural Diversity');
INSERT INTO Outcome (OutcomeDescription) VALUES ('Natural Systems (Science and the Natural World)');
INSERT INTO Outcome (OutcomeDescription) VALUES ('Technology and Society');


-- Insert CourseID and ProgramKey into Course Table
INSERT INTO Course (CourseID, ProgramKey) VALUES ('ENGL&101',1);
INSERT INTO Course (CourseID, ProgramKey) VALUES ('ENGL&235',1);
INSERT INTO Course (CourseID, ProgramKey) VALUES ('PHIL 102',2);
INSERT INTO Course (CourseID, ProgramKey) VALUES ('CHIN&121',3);
INSERT INTO Course (CourseID, ProgramKey) VALUES ('AHE  120',4);
INSERT INTO Course (CourseID, ProgramKey) VALUES ('NURS 121',5);
INSERT INTO Course (CourseID, ProgramKey) VALUES ('ACCT 101',6);
INSERT INTO Course (CourseID, ProgramKey) VALUES ('BUSIT103',7);
INSERT INTO Course (CourseID, ProgramKey) VALUES ('DA   410',8);
INSERT INTO Course (CourseID, ProgramKey) VALUES ('DMA  100',9);
INSERT INTO Course (CourseID, ProgramKey) VALUES ('ISIT 331',10);
INSERT INTO Course (CourseID, ProgramKey) VALUES ('BIOL&160',11);
INSERT INTO Course (CourseID, ProgramKey) VALUES ('MATH&141',12);
INSERT INTO Course (CourseID, ProgramKey) VALUES ('ANTH&100',13);




-- Insert Data into Linking Tables ----------------------------------------


-- Insert CourseKey and OutcomeKey into CourseOutcome Table
INSERT INTO CourseOutcome(CourseKey, OutcomeKey)
VALUES 
    (1, 1),		         -- OutcomeKey 1 is "Critical Thinking"
	(2, 1),
	(6, 1),
	(8, 1), 
	(11, 1),
	(13, 1), 
	(7, 2),			    -- Outcome 2 is "Quantitative symbolic reasoning"
	(9, 2),
	(13, 2),
	(2, 3),			    -- Outcome 3 is "research information literacy"
	(12, 4),			-- Outcome 4 is "scientific inquiry"
	(1, 7),			    -- Outcome 7 is "Writing"
	(2, 7),
	(4, 8),			    -- Outcome 8 is "Listening"
	(10, 9),			-- Outcome 9 is "Visual"
	(5, 12),			-- Outcome 12 is "Group Processes"
	(3, 13),			-- Outcome 13 is "Ethics"
	(14, 16)			-- Outcome 16 is "Cultural Diversity"
;


-- Insert ProgramKey and ProgramChairKey into ProgramChairMap Table
INSERT INTO ProgramChairMap(ProgramKey, ProgramChairKey)
VALUES
	(1,	1),			-- ProgramKey 1 = English
	(2, 2),
	(3, 3), 
	(4, 4), 
	(5, 5), 
	(6, 6),
	(7, 7),
	(8, 8),
	(8, 7),			-- Dena Laney teaches with Kyle Barber
	(9, 9),
	(10, 7),
	(11, 10), 
	(12, 11),
	(13, 12)
;
