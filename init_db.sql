-- Run this to initialise the database by creating the correct schemas.
-- This does not populate the database.

DROP DATABASE IF EXISTS proj;
CREATE DATABASE proj;
USE proj;




CREATE TABLE Departments(
    id INT AUTO_INCREMENT PRIMARY KEY,
    name CHAR(100) );

-- needs a trigger to insert default credit count if credit req is null, based on degree enum
CREATE TABLE Programs(
    id INT AUTO_INCREMENT PRIMARY KEY,
    name CHAR(100),
    degree ENUM("undergraduate", "graduate") NOT NULL,
    department_id INT REFERENCES Departments(id),
    credit_req INT UNSIGNED
);

CREATE TABLE Term(
    id INT AUTO_INCREMENT PRIMARY KEY,
    season ENUM("Fall", "Winter", "Summer"),
    year YEAR(4)
);

CREATE TABLE AdvisorTermProgram(
    instructor_id INT REFERENCES Instructors(id),
    term_id INT REFERENCES Term(id),
    year YEAR(4)
);


CREATE TABLE course (
    name CHAR(100),
    department_name CHAR(100),
    courseNumber INT,
    section CHAR(4)
);

--CREATE TABLE Prereqs (
--
--);

CREATE TABLE Students(
    id INT PRIMARY KEY,
    first_name CHAR(100) NOT NULL,
    last_name CHAR(100) NOT NULL,
    gpa DECIMAL(3, 2) UNSIGNED,
    department_id INT REFERENCES Departments(id),
    degree ENUM("undergraduate", "graduate") NOT NULL
);

-- needs a trigger to verify existence of pair (program_name, department_name)
CREATE TABLE StudentsPrograms(
    student_id INT REFERENCES Students(id),
    program_id INT REFERENCES Programs(id),
    department_id INT REFERENCES Departments(id),
    PRIMARY KEY(student_id, program_id, department_id)
);
--
CREATE TABLE Instructors(
    id INT PRIMARY KEY,
    first_name CHAR(100) NOT NULL,
    last_name CHAR(100) NOT NULL,
    department_id INT REFERENCES Departments(id)
);
