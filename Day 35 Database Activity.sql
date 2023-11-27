CREATE TABLE Students (
    StudentID INT PRIMARY KEY,
    Name VARCHAR(255),
    DateOfBirth DATE,
    GradeLevel INT
);


CREATE TABLE Courses (
    CourseID INT PRIMARY KEY,
    CourseName VARCHAR(255),
    Instructor VARCHAR(255)
);


CREATE TABLE Enrollments (
    EnrollmentID INT PRIMARY KEY,
    StudentID INT,
    CourseID INT,
    FOREIGN KEY (StudentID) REFERENCES Students(StudentID),
    FOREIGN KEY (CourseID) REFERENCES Courses(CourseID)
);

INSERT INTO Students (StudentID, Name, DateOfBirth, GradeLevel)
VALUES
    (1, 'Jose Rizal', '1998-05-15', 11),
    (2, 'Andres Bonifacio', '1999-08-22', 10),
    (3, 'Juan Luna', '2000-02-10', 12);


INSERT INTO Courses (CourseID, CourseName, Instructor)
VALUES
    (101, 'Mathematics', 'Prof. Dela Cruz'),
    (102, 'History', 'Prof. Perez'),
    (103, 'Science', 'Prof. David');


INSERT INTO Enrollments (EnrollmentID, StudentID, CourseID)
VALUES
    (1, 1, 101),
    (2, 1, 102),
    (3, 2, 103),
    (4, 3, 101);

SELECT Students.*
FROM Students
JOIN Enrollments ON Students.StudentID = Enrollments.StudentID
JOIN Courses ON Enrollments.CourseID = Courses.CourseID
WHERE Courses.CourseName = 'Mathematics';

ALTER TABLE Courses
ADD Credits INT;

UPDATE Courses
SET Credits = 
    CASE CourseID
        WHEN 101 THEN 3  
        WHEN 102 THEN 4  
        WHEN 103 THEN 3  
        
        ELSE 0  
    END;
    
SELECT Students.StudentID, Students.Name, SUM(Credits) AS TotalCredits
FROM Students
JOIN Enrollments ON Students.StudentID = Enrollments.StudentID
JOIN Courses ON Enrollments.CourseID = Courses.CourseID
GROUP BY Students.StudentID, Students.Name;


SELECT Courses.CourseID, Courses.CourseName, COUNT(Enrollments.StudentID) AS NumEnrolledStudents
FROM Courses
LEFT JOIN Enrollments ON Courses.CourseID = Enrollments.CourseID
GROUP BY Courses.CourseID, Courses.CourseName;

-- Create Teachers table
CREATE TABLE Teachers (
    TeacherID INT PRIMARY KEY,
    TeacherName VARCHAR(255),
    DepartmentID INT,
    FOREIGN KEY (DepartmentID) REFERENCES Departments(DepartmentID)
);

-- Create Departments table
CREATE TABLE Departments (
    DepartmentID INT PRIMARY KEY,
    DepartmentName VARCHAR(255)
);


INSERT INTO Departments (DepartmentID, DepartmentName) VALUES
(1, 'Computer Science'),
(2, 'Mathematics'),
(3, 'History');


INSERT INTO Teachers (TeacherID, TeacherName, DepartmentID) VALUES
(101, 'John Smith', 1),
(102, 'Jane Doe', 2),
(103, 'Mark Johnson', 3);

ALTER TABLE Students ADD COLUMN DepartmentID INT;

UPDATE Students
SET DepartmentID = (SELECT DepartmentID FROM Department ORDER BY RAND() LIMIT 1)
WHERE DepartmentID IS NULL;





