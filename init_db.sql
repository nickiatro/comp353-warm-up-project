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
    section_id INT NOT NULL,
    num_hours INT NOT NULL,
    PRIMARY KEY (student_id, section_id),
    CONSTRAINT FK_Student_TeachingAssistant FOREIGN KEY (student_id) REFERENCES Student(id),
    CONSTRAINT FK_Course_TeachingAssistant FOREIGN KEY (section_id) REFERENCES Course(id)
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
    granted_funding BOOLEAN DEFAULT FALSE,
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

DELIMITER $$
CREATE TRIGGER one_or_more_programs AFTER INSERT ON Department FOR EACH ROW
BEGIN
    INSERT INTO Program(name, degree, is_thesis_based, department_id) VALUES("General Program", "undergraduate", 0, NEW.id);
END$$

DELIMITER $$
CREATE TRIGGER passing_grade_prereqs BEFORE INSERT ON Class FOR EACH ROW
BEGIN
    IF EXISTS (SELECT gpa FROM Grade, Class, Section, Course, Prerequisite WHERE
    New.section_id = Section.id AND New.student_id = Class.student_id AND Section.course_id = Prerequisite.course_id AND Class.grade_id = Grade.id AND gpa < 0.7) THEN
    SET New.student_id = -1;
    END IF;
END$$

DELIMITER $$
CREATE TRIGGER only_one_section_of_same_class BEFORE INSERT ON Class FOR EACH ROW
BEGIN
    IF EXISTS (SELECT course_id, term_id FROM Section WHERE NEW.section_id = Section.id IN (
        SELECT 1 FROM Class, Section WHERE
        NEW.student_id = Class.student_id AND Class.section_id = Section.id)) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = "invalid action: Student is already registered in this course for this term.";
    END IF;
END$$

DELIMITER $$
CREATE TRIGGER no_conflicting_time_courses_instructor BEFORE INSERT ON Section FOR EACH ROW
BEGIN
    IF EXISTS (SELECT start_time, end_time FROM Section WHERE (NEW.instructor_id = Section.instructor_id AND NEW.term_id = Section.term_id) AND ((New.start_time >= Section.start_time AND NEW.start_time < Section.end_time OR (NEW.start_time <= Section.start_time AND NEW.end_time > Section.end_time)))) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = "Instructor is already teaching a course at this time";
    END IF;
END$$

-- new section to be added = n, old sections already there = o
DELIMITER $$
CREATE TRIGGER no_conflicting_time_courses_student BEFORE INSERT ON Class FOR EACH ROW
BEGIN
    IF EXISTS  (SELECT n.start_time, n.end_time  FROM Section AS n, Section as o, Class WHERE NEW.student_id = Class.student_id AND Class.section_id = o.id AND n.id = New.section_id AND n.term_id = o.term_id AND ((n.start_time >= o.start_time AND n.start_time < o.end_time OR (n.start_time >= o.start_time AND n.end_time > o.end_time)))) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = "Student is already taking a course at this time";
    END IF;
END$$

DELIMITER $$
CREATE TRIGGER grad_student_supervisor_funding_insert BEFORE INSERT ON StudentSupervisor FOR EACH ROW
BEGIN
    IF EXISTS(SELECT * FROM Student, Supervisor WHERE NEW.supervisor_id = Supervisor.id AND Student.id = NEW.student_id AND (has_research_funding = FALSE OR Student.gpa < 3.0) AND NEW.granted_funding = TRUE) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = "Supervisor has no funding available, or student has insufficient GPA";
    END IF;
END$$

DELIMITER $$
CREATE TRIGGER grad_student_supervisor_funding_update BEFORE UPDATE ON StudentSupervisor FOR EACH ROW
BEGIN
    IF EXISTS(SELECT * FROM Student,Supervisor WHERE NEW.supervisor_id = Supervisor.id AND Student.id = NEW.student_id AND (has_research_funding = FALSE OR Student.gpa < 3.0) AND NEW.granted_funding = TRUE) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = "Supervisor has no funding available, or student has insufficient GPA";
    END IF;
END$$

DELIMITER $$
CREATE TRIGGER grad_student_TA_signup BEFORE INSERT ON TeachingAssistant FOR EACH ROW
BEGIN
    IF EXISTS(SELECT * FROM Student, TeachingAssistant WHERE NEW.student_id = Student.id = TeachingAssistant.student_id AND (Student.gpa < 3.2 OR Student.degree = "undergraduate")) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = "Student has insufficient GPA, or is an undergrad.";
    END IF;
    IF EXISTS(SELECT * FROM Student, TeachingAssistant WHERE NEW.student_id = Student.id = TeachingAssistant.student_id GROUP BY TeachingAssistant.student_id HAVING count(TeachingAssistant.student_id) >= 2) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = "Student is teaching too many courses";
    END IF;
END$$

DELIMITER $$
CREATE TRIGGER grad_student_TA_signup_hours AFTER INSERT ON TeachingAssistant FOR EACH ROW
BEGIN
    IF EXISTS(SELECT TeachingAssistant.num_hours FROM TeachingAssistant, Section, Term WHERE TeachingAssistant.section_id = Section.id AND Section.term_id = Term.id AND NEW.student_id = TeachingAssistant.student_id GROUP BY Term.year HAVING SUM(TeachingAssistant.num_hours) > 260) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = "Student is teaching too many courses or has insufficient GPA";
        DELETE FROM TeachingAssistant WHERE TeachingAssistant.student_id= New.student_id AND TeachingAssistant.section_id = NEW.section_id AND TeachingAssistant.num_hours = NEW.num_hours;
    END IF;
END$$


DELIMITER ;
