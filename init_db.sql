-- Run this to initialise the database by creating the correct schemas.
-- This does not populate the database.

DROP DATABASE IF EXISTS proj;
CREATE DATABASE proj;
USE proj;

CREATE TABLE Departments(
    ID INT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    name CHAR(100));

CREATE TABLE Programs(
    ID INT UNSIGNED PRIMARY KEY,
    name CHAR(100),
    degree ENUM("undergraduate", "graduate") NOT NULL,
    credit_req INT UNSIGNED);

-- This is necessary to fulfill the "one or more" requirement.
-- If you have a better idea, feel free to change this.
CREATE TABLE Department_Programs (
    Department_ID INT UNSIGNED REFERENCES Departments(ID),
    Program_ID INT UNSIGNED REFERENCES Programs(ID));

CREATE TABLE Students(
    id INT PRIMARY KEY,
    first_name CHAR(100) NOT NULL,
    last_name CHAR(100) NOT NULL,
    department CHAR(100),
    degree ENUM("undergraduate", "graduate") NOT NULL,
    FOREIGN KEY (department) REFERENCES Departments(name)
);

CREATE TABLE Instructors(
    id INT PRIMARY KEY,
    first_name CHAR(100) NOT NULL,
    last_name CHAR(100) NOT NULL,
    department CHAR(100),
    FOREIGN KEY (department) REFERENCES Departments(name)
);
