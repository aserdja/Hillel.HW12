CREATE DATABASE HillelHW;
USE HillelHW;

-- CREATING TABLES --

CREATE TABLE Students (
	StudentID INT IDENTITY(1,1) PRIMARY KEY,
	FirstName VARCHAR(50) NOT NULL,
	LastName VARCHAR(50) NOT NULL,
	BirthDate DATE NOT NULL,
	EnrollmentDate SMALLDATETIME NOT NULL,
	IsActive BIT NOT NULL
);

CREATE TABLE Courses (
	CourseID INT IDENTITY(1,1) PRIMARY KEY,
	CourseName VARCHAR(100) NOT NULL,
	Credits SMALLINT NOT NULL,
);

CREATE TABLE Enrollments (
	EnrollmentID INT IDENTITY(1,1) PRIMARY KEY,
	StudentID INT NOT NULL,
	FOREIGN KEY (StudentID) REFERENCES Students(StudentID) ON DELETE CASCADE,
	CourseID INT NOT NULL,
	FOREIGN KEY (CourseID) REFERENCES Courses(CourseID) ON DELETE CASCADE
);

-- CREATING AND DROPPING INDEXES --

CREATE INDEX LastNameIdx
ON Students(LastName);

ALTER TABLE Enrollments
DROP CONSTRAINT FK__Enrollmen__Stude__3A81B327;

ALTER TABLE Students
DROP CONSTRAINT PK__Students__32C52A79FEA88512;

CREATE CLUSTERED INDEX EnrollmentDateIdx
ON Students(EnrollmentDate);

-- NEW RECORDS TO STUDENTS --

INSERT INTO Students(FirstName, LastName, BirthDate, EnrollmentDate, IsActive)
VALUES('Andrii', 'Serdiuk', '2004-04-29', '2024-09-13 13:05:00', 1);

INSERT INTO Students(FirstName, LastName, BirthDate, EnrollmentDate, IsActive)
VALUES('Mike', 'Tyson', '1970-08-13', '2024-06-15 12:19:00', 1);

INSERT INTO Students(FirstName, LastName, BirthDate, EnrollmentDate, IsActive)
VALUES('Tuker', 'Carlson', '1980-12-02', '2024-08-23 14:55:00', 1);

-- NEW RECORDS TO COURSES --

INSERT INTO Courses(CourseName, Credits)
VALUES ('OOP', 180);

INSERT INTO Courses(CourseName, Credits)
VALUES ('Math', 120);

INSERT INTO Courses(CourseName, Credits)
VALUES ('Alghoritms and data sctructures', 110);

-- ADDING PRIMARY KEY AFTER CUSTERED INDEX CHANGE --

ALTER TABLE Students
ADD CONSTRAINT PK_Students PRIMARY KEY (StudentID);

ALTER TABLE Enrollments
ADD CONSTRAINT FK_Students
FOREIGN KEY (StudentID)
REFERENCES Students(StudentID) ON DELETE CASCADE;

-- NEW RECORDS TO ENROLLMENTS --

INSERT INTO Enrollments(StudentID, CourseID) 
VALUES (1, 1);
INSERT INTO Enrollments(StudentID, CourseID) 
VALUES (1, 2);
INSERT INTO Enrollments(StudentID, CourseID) 
VALUES (2, 3);
INSERT INTO Enrollments(StudentID, CourseID) 
VALUES (2, 1);
INSERT INTO Enrollments(StudentID, CourseID) 
VALUES (3, 3);

-- TESTING CASCADE DELETE --

DELETE FROM Students
WHERE StudentID = 2;

-- VALUE UPDATING --

UPDATE Courses
SET Credits = 5
WHERE CourseName = 'Math';

-- SELECT --

SELECT * FROM Students s
INNER JOIN Enrollments e on s.StudentID = e.StudentID
INNER JOIN Courses c on c.CourseID = e.CourseID
WHERE c.CourseName = 'OOP';