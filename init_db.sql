CREATE TABLE Department (
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    name CHAR(100) NOT NULL
);

CREATE TABLE Term (
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    season ENUM("Fall", "Winter", "Summer") NOT NULL,
    year YEAR(4) NOT NULL
);

CREATE TABLE Program (
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    name CHAR(100) NOT NULL,
    degree ENUM("undergraduate", "graduate") NOT NULL,
    credit_req INT UNSIGNED,
    is_thesis_based BOOLEAN NOT NULL,
    department_id INT NOT NULL,
    CONSTRAINT FK_Department_Program FOREIGN KEY (department_id) REFERENCES Department(id)
);

CREATE TABLE Course (
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    name CHAR(100) NOT NULL,
    code CHAR(15) NOT NULL,
    number INT NOT NULL,
    department_id INT NOT NULL,
    CONSTRAINT FK_Department_Course FOREIGN KEY (department_id) REFERENCES Department(id)
);

CREATE TABLE Student (
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    first_name CHAR(100) NOT NULL,
    last_name CHAR(100) NOT NULL,
    gpa DECIMAL(3, 2) UNSIGNED NOT NULL,
    degree ENUM("undergraduate", "graduate") NOT NULL
);

CREATE TABLE Instructor (
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    first_name CHAR(100) NOT NULL,
    last_name CHAR(100) NOT NULL
);

CREATE TABLE TeachingAssistant (
    student_id INT NOT NULL,
    course_id INT NOT NULL,
    term_id INT NOT NULL,
    num_hours INT NOT NULL,
    PRIMARY KEY (student_id, course_id, term_id),
    CONSTRAINT FK_Student_TeachingAssistant FOREIGN KEY (student_id) REFERENCES Student(id),
    CONSTRAINT FK_Course_TeachingAssistant FOREIGN KEY (course_id) REFERENCES Course(id),
    CONSTRAINT FK_Term_TeachingAssistant FOREIGN KEY (term_id) REFERENCES Term(id)
);

CREATE TABLE Grade (
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    letter_grade CHAR(5) NOT NULL,
    gpa DECIMAL(3,2) NOT NULL
);

CREATE TABLE Section (
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    course_id INT NOT NULL,
    term_id INT NOT NULL,
    instructor_id INT NOT NULL,
    classroom CHAR(50) NOT NULL,
    capacity INT NOT NULL,
    start_time TIME NOT NULL,
    end_time TIME NOT NULL,
    CONSTRAINT FK_Course_Section FOREIGN KEY (course_id) REFERENCES Course(id),
    CONSTRAINT FK_Term_Section FOREIGN KEY (term_id) REFERENCES Term(id),
    CONSTRAINT FK_Instructor_Section FOREIGN KEY (instructor_id) REFERENCES Instructor(id)
);

CREATE TABLE Class (
    student_id INT NOT NULL,
    section_id INT NOT NULL,
    grade_id INT NOT NULL,
    --gpa DECIMAL(3,2) NOT NULL,
    PRIMARY KEY (student_id, section_id),
    CONSTRAINT FK_Student_Class FOREIGN KEY (student_id) REFERENCES Student(id),
    CONSTRAINT FK_Section_Class FOREIGN KEY (section_id) REFERENCES Section(id),
    CONSTRAINT FK_Grade_Class FOREIGN KEY (grade_id) REFERENCES Grade(id)
);

CREATE TABLE StudentProgram (
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    student_id INT NOT NULL,
    program_id INT NOT NULL,
    CONSTRAINT FK_Student_StudentProgram FOREIGN KEY (student_id) REFERENCES Student(id),
    CONSTRAINT FK_Program_StudentProgram FOREIGN KEY (program_id) REFERENCES Program(id)
);

CREATE TABLE ResearchFunding (
    student_id INT PRIMARY KEY,
    CONSTRAINT FK_Student_ResearchFunding FOREIGN KEY (student_id) REFERENCES Student(id)
);

CREATE TABLE Prerequisite (
    course_id INT NOT NULL,
    prerequisite_course_id INT NOT NULL,
    PRIMARY KEY (course_id, prerequisite_course_id),
    CONSTRAINT FK_Course_Prequisite_Base FOREIGN KEY (course_id) REFERENCES Course(id),
    CONSTRAINT FK_Course_Prequisite FOREIGN KEY (prerequisite_course_id) REFERENCES Course(id)
);

CREATE TABLE StudentDepartment (
    student_id INT NOT NULL,
    department_id INT NOT NULL,
    PRIMARY KEY (student_id, department_id),
    CONSTRAINT FK_Student_StudentDepartment FOREIGN KEY (student_id) REFERENCES Student(id),
    CONSTRAINT FK_Department_StudentDepartment FOREIGN KEY (department_id) REFERENCES Department(id)
);

CREATE TABLE InstructorDepartment (
    instructor_id INT NOT NULL,
    department_id INT NOT NULL,
    PRIMARY KEY (instructor_id, department_id),
    CONSTRAINT FK_Instructor_InstructorDepartment FOREIGN KEY (instructor_id) REFERENCES Instructor(id),
    CONSTRAINT FK_Department_InstructorDepartment FOREIGN KEY (department_id) REFERENCES Department(id)
);

CREATE TABLE Advisor (
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    first_name CHAR(100) NOT NULL,
    last_name CHAR(100) NOT NULL
);

CREATE TABLE StudentAdvisor (
    student_program_id INT NOT NULL,
    advisor_id INT NOT NULL,
    term_id INT NOT NULL,
    CONSTRAINT FK_StudentProgram_StudentAdvisor FOREIGN KEY (student_program_id) REFERENCES StudentProgram(id),
    CONSTRAINT FK_Advisor_StudentAdvisor FOREIGN KEY (advisor_id) REFERENCES Advisor(id),
    CONSTRAINT FK_Term_StudentAdvisor FOREIGN KEY (term_id) REFERENCES Term(id)
);

CREATE TABLE Supervisor (
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    first_name CHAR(100) NOT NULL,
    last_name CHAR(100) NOT NULL,
    department_id INT NOT NULL,
    has_research_funding BOOLEAN NOT NULL
);

CREATE TABLE StudentSupervisor (
    student_id INT NOT NULL,
    supervisor_id INT NOT NULL,
    PRIMARY KEY (student_id, supervisor_id),
    CONSTRAINT FK_Student_StudentSupervisor FOREIGN KEY (student_id) REFERENCES Student(id),
    CONSTRAINT FK_Supervisor_StudentSupervisor FOREIGN KEY (supervisor_id) REFERENCES Supervisor(id)
);

-- triggers
DELIMITER $$
CREATE TRIGGER default_credit BEFORE INSERT ON Program FOR EACH ROW
BEGIN
    IF NEW.credit_req = 0 THEN
        IF NEW.degree = "undergraduate" THEN
            SET NEW.credit_req = 90;
        ELSE
            SET NEW.credit_req = 44;
        END IF;
    END IF;
END$$
DELIMITER ;

DELIMITER $$
CREATE TRIGGER one_or_more_programs AFTER INSERT ON Department FOR EACH ROW
BEGIN
    INSERT INTO Program(name, degree, is_thesis_based, department_id) VALUES("General Program", "undergraduate", 0, NEW.id);
END$$
DELIMITER ;

DELIMITER $$
CREATE TRIGGER passing_grade_prereqs BEFORE INSERT ON Class FOR EACH ROW
BEGIN
    IF EXISTS (SELECT gpa FROM Class, Section, Course, Prerequisite WHERE
    New.section_id = Section.id AND New.student_id = Class.student_id AND Section.course_id = Prerequisite.course_id AND gpa < 0.7) THEN
    SET New.student_id = -1;
    END IF;
END$$
DELIMITER ;
