-- 1) Find ID, first name and last name of all the students who have taken Database course and received an A or A+ grade for the course.
SELECT 
    Student.Id AS ID,
    Student.first_name AS First_Name,
    Student.last_name AS Last_Name
FROM
    Class
        INNER JOIN
    Section ON Class.section_id = Section.id
        INNER JOIN
    Course ON Section.course_id = Course.id
        INNER JOIN
    Student ON Class.student_id = Student.id
        INNER JOIN
    Grade ON Class.grade_id = Grade.id
WHERE
    Grade.letter_grade = 'A+'
        OR Grade.letter_grade = 'A'
        AND Course.name = 'Databases';


-- 2) Find ID, first name, last name and number of programs of students who are enrolled in at least two different programs in the Computer Science department.
SELECT 
    StudentProgram.student_id AS ID,
    Student.first_name AS First_Name,
    Student.last_name AS Last_Name,
    COUNT(StudentProgram.id) AS NumProgramsEnrolled
FROM
    StudentProgram
        INNER JOIN
    Student ON StudentProgram.student_id = Student.id
        INNER JOIN
    Program ON StudentProgram.program_id = Program.id
        INNER JOIN
    Department ON Program.department_id = Department.id
WHERE
    Department.name = 'Computer Science and Engineering'
GROUP BY StudentProgram.student_id
HAVING COUNT(StudentProgram.id) >= 2

-- (3) Find the name of all the instructors who taught Comp 352 in the fall term of 2018 but have never taught the same course before.
SELECT DISTINCT
    Instructor.id AS ID,
    CONCAT(Instructor.last_name,
            ', ',
            Instructor.first_name) AS Name
FROM
    Section
        INNER JOIN
    Term ON Section.term_id = Term.id
        INNER JOIN
    Course ON Section.course_id = Course.id
        INNER JOIN
    Instructor ON Section.instructor_id = Instructor.id
WHERE
    (Term.season = 'Fall'
        AND Term.year = 2018)
        AND Instructor.Id NOT IN (SELECT DISTINCT
            Section.instructor_id
        FROM
            Section
                INNER JOIN
            Term ON Section.term_id = Term.id
                INNER JOIN
            Course ON Section.course_id = Course.id
                INNER JOIN
            Instructor ON Section.instructor_id = Instructor.id
        WHERE
            Term.year < 2018
                OR (Term.season = 'Winter'
                AND Term.year = 2018)
                OR (Term.season = 'Summer'
                AND Term.year = 2018)
                AND Course.Code = 'COMP'
                AND Course.number = 352);

-- (4) Find the name and IDs of all the undergraduate students who do not have an advisor.

SELECT 
    Program.name AS Name, Program.credit_req AS Credits_Required
FROM
    Program
        INNER JOIN
    Department ON Program.department_id = Department.id
        AND Department.name = 'Computer Science and Engineering';

-- (5) Find the name and IDs of all the undergraduate students who do not have an advisor
SELECT 
    Student.id AS ID,
    CONCAT(Student.last_name,
            ', ',
            Student.first_name) AS Name
FROM
    Student
WHERE
    degree = 'Undergraduate'
        AND id NOT IN (SELECT 
            Student.id
        FROM
            StudentAdvisor
                INNER JOIN
            StudentProgram ON StudentAdvisor.student_program_id = StudentProgram.id
                INNER JOIN
            Student ON StudentProgram.student_id = Student.id
        WHERE
            Student.degree = 'Undergraduate');

-- (6) Find the ID, name and assignment mandate of all the graduate students who are assigned as teaching assistants to Comp 353 for the summer term of 2019
SELECT 
    TeachingAssistant.student_id AS ID,
    CONCAT(Student.last_name,
            ', ',
            Student.first_name) AS Name,
    CONCAT(TeachingAssistant.num_hours, ' hours') AS Mandate
FROM
    TeachingAssistant
        INNER JOIN
    Course ON TeachingAssistant.course_id = Course.id
        INNER JOIN
    Term ON TeachingAssistant.term_id = Term.id
        INNER JOIN
    Student ON TeachingAssistant.student_id = Student.id
WHERE
    Course.Code = 'COMP'
        AND Course.number = 353
        AND Term.season = 'Summer'
        AND Term.year = 2019;

-- (7) Find the name of all the supervisors in the Computer Science department who have supervised at least 20 students.
SELECT 
    CONCAT(Supervisor.last_name,
            ', ',
            Supervisor.first_name) AS Name
FROM
    StudentSupervisor
        INNER JOIN
    Supervisor ON StudentSupervisor.supervisor_id = Supervisor.id
GROUP BY StudentSupervisor.supervisor_id
HAVING COUNT(StudentSupervisor.student_id) >= 20;

-- (8) Find the details of all the courses offered by the Computer Science department for the summer term of 2019. Details include Course name, section, room location, start and end time, professor teaching the course, max class capacity and number of enrolled students.
SELECT 
    Course.name AS Name,
    Section.Id AS Section,
    Section.classroom AS Location,
    CONCAT(Instructor.last_name,
            ', ',
            Instructor.first_name) AS Instructor,
    Section.start_time AS Start_time,
    Section.end_time AS End_time,
    Section.capacity AS Max_class_capacity,
    (SELECT 
            COUNT(*)
        FROM
            Class
        WHERE
            Class.section_id = Section.Id) AS Num_enrolled_students
FROM
    Section
        INNER JOIN
    Course ON Section.course_id = Course.id
        INNER JOIN
    Instructor ON Section.instructor_id = Instructor.id
        INNER JOIN
    Department ON Course.department_id = Department.id
        INNER JOIN
    Term ON Section.term_id = Term.id
WHERE
    Department.name = 'Computer Science and Engineering'
        AND Term.season = 'Summer'
        AND Term.year = 2019;

-- (9) For each department, find the total number of courses offered by the department.
SELECT 
    Department.name AS Name, COUNT(Course.id) AS Num_of_courses
FROM
    Course
        INNER JOIN
    Department ON Course.department_id = Department.id
GROUP BY department_id;

-- (10) For each program, find the total number of students enrolled into the program.
SELECT 
    Program.name AS Name, COUNT(student_id) AS Num_of_students
FROM
    StudentProgram
        INNER JOIN
    Program ON StudentProgram.program_id = Program.id
GROUP BY program_id;

-- Part V: For each relation R created in your database, report the result of the following SQL statement: SELECT COUNT(*) FROM R;
