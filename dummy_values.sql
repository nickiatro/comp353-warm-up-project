-- only run this after you have initialised the database.

INSERT INTO Department(name) 
VALUES ('Mathematics'), 
       ('Computer Science and Engineering'), 
       ('Biology'), 
       ('Physics'), 
       ('Chemistry'), 
       ('Humanities'),
       ('Business'),
       ('Social Sciences'),
       ('History'),
       ('Education');

-- Department variables
SET @mathematics := (SELECT id FROM Department WHERE name = 'Mathematics');
SET @computer_science := (SELECT id FROM Department WHERE name = 'Computer Science and Engineering');
SET @biology := (SELECT id FROM Department WHERE name = 'Biology');
SET @physics := (SELECT id FROM Department WHERE name = 'Physics');
SET @chemistry := (SELECT id FROM Department WHERE name = 'Chemistry');
SET @humanities := (SELECT id FROM Department WHERE name = 'Humanities'); 
SET @business := (SELECT id FROM Department WHERE name = 'Business');
SET @social_sciences := (SELECT id FROM Department WHERE name = 'Social Sciences');
SET @history := (SELECT id FROM Department WHERE name = 'History');
SET @education := (SELECT id FROM Department WHERE name = 'Education');

INSERT INTO Term(season, year) 
VALUES  ('Winter', 2017),
        ('Fall', 2017),
        ('Summer', 2017),
        ('Winter', 2018),
        ('Fall', 2018),
        ('Summer', 2018),
        ('Winter', 2019), 
        ('Fall', 2019),
        ('Summer', 2019),
        ('Winter', 2020), 
        ('Summer', 2020),
        ('Fall', 2020);

INSERT INTO Program(name, degree, credit_req, is_thesis_based, department_id) 
VALUES ('Actuarial Mathematics', 'undergraduate', 0, 0, @mathematics),
       ('Computer Science', 'undergraduate', 0, 0, @computer_science),
       ('Software Engineering', 'undergraduate', 0, 0, @computer_science),
       ('Behavioural Neuroscience', 'undergraduate', 0, 0, @biology),
       ('Biophysics', 'undergraduate', 0, 0, @physics),
       ('Biochemistry', 'undergraduate', 0, 0, @chemistry),
       ('Human Relations', 'graduate', 1, 0, @humanities),
       ('Accountancy', 'graduate', 1, 0, @business),
       ('Sociology', 'graduate', 1, 0, @social_sciences),
       ('Art History', 'graduate', 0, 0, @history),
       ('Childhood Education', 'graduate', 0, 0, @education);

INSERT INTO Course(name, code, number, department_id) 
VALUES ('Number Theory', 'MATH', 200, @mathematics), 
       ('Combinatorics', 'COMP', 339, @computer_science), 
       ('Data Structures and Algorithms', 'COMP', 352, @computer_science), 
       ('Databases', 'COMP', 353, @computer_science), 
       ('Fundamental Nutrition', 'BIOL', 203, @biology),
       ('Electromagnetism', 'PHYS', 200, @physics), 
       ('Relativity', 'PHYS', 300, @physics),
       ('Thermodynamics', 'CHEM', 201, @chemistry), 
       ('Methodology', 'HUMA', 888, @humanities),
       ('Financial Reporting III', 'ACCO', 420, @business),
       ('Debates & Challenges in Contemporary Quebec Society', 'SOCI', 280, @social_sciences),
       ('Modern Europe', 'HIST', 202, @history),
       ('Educational Communication', 'EDUC', 270, @education);

-- Course variables
SET @comp353 := (SELECT id FROM Course WHERE code = 'COMP' AND number = 353);
SET @comp352 := (SELECT id FROM Course WHERE code = 'COMP' AND number = 352);
SET @comp339 := (SELECT id FROM Course WHERE code = 'COMP' AND number = 339);

INSERT INTO Student(first_name, last_name, gpa, degree) 
VALUES ('Olivia', 'Benson', 3.0, 'undergraduate'),
       ('Odafin', 'Tutuola', 2.2, 'undergraduate'), 
       ('Amanda', 'Rollins', 3.2, 'graduate'), 
       ('Dominick', 'Carisi', 2.8, 'graduate'), 
       ('Elliot', 'Stabler', 3.0, 'undergraduate'), 
       ('Don', 'Cragen', 4.3, 'graduate'),
       ('Maximina', 'Specht', 2.0, 'undergraduate'),
       ('Laurel', 'Sherrod', 3.3, 'undergraduate'),
       ('Nada', 'Dillard', 3.6, 'graduate'),
       ('Eliseo', 'Piano', 1.3, 'graduate');

INSERT INTO Instructor(first_name, last_name) 
VALUES ('Paul', 'Atreides'), 
       ('Leto', 'Atreides'), 
       ('Duncan', 'Idaho'), 
       ('Vladimir', 'Harkonnen'), 
       ('Piter', 'de Vries'),
       ('John', 'Smith'),
       ('Russell', 'Alessi'),
       ('Guillermo', 'Wintheiser'),
       ('Alex', 'Lee'),
       ('Gary', 'Lee');

INSERT INTO TeachingAssistant(student_id, course_id, term_id, num_hours)
VALUES ((SELECT id FROM Student WHERE first_name = 'Don'), @comp353, (SELECT id FROM Term WHERE season = 'Summer' AND year = 2019), 50),
       ((SELECT id FROM Student WHERE first_name = 'Don'), @comp352, (SELECT id FROM Term WHERE season = 'Winter' AND year = 2019), 50),
       ((SELECT id FROM Student WHERE first_name = 'Don'), @comp339, (SELECT id FROM Term WHERE season = 'Fall' AND year = 2019), 50),
       ((SELECT id FROM Student WHERE first_name = 'Nada'), @comp353, (SELECT id FROM Term WHERE season = 'Summer' AND year = 2019), 50),
       ((SELECT id FROM Student WHERE first_name = 'Nada'), @comp352, (SELECT id FROM Term WHERE season = 'Summer' AND year = 2019), 50),
       ((SELECT id FROM Student WHERE first_name = 'Nada'), @comp339, (SELECT id FROM Term WHERE season = 'Fall' AND year = 2019), 50),
       ((SELECT id FROM Student WHERE first_name = 'Eliseo'), @comp353, (SELECT id FROM Term WHERE season = 'Winter' AND year = 2019), 50),
       ((SELECT id FROM Student WHERE first_name = 'Eliseo'), @comp352, (SELECT id FROM Term WHERE season = 'Summer' AND year = 2019), 50),
       ((SELECT id FROM Student WHERE first_name = 'Eliseo'), @comp339, (SELECT id FROM Term WHERE season = 'Fall' AND year = 2019), 50),
       ((SELECT id FROM Student WHERE first_name = 'Amanda'), @comp339, (SELECT id FROM Term WHERE season = 'Fall' AND year = 2019), 50);

INSERT INTO Grade(letter_grade, gpa) VALUES ('A+', 4.3), 
                                            ('A', 4.0), 
                                            ('A-', 3.7), 
                                            ('B+', 3.3), 
                                            ('B', 3.0),
                                            ('B-', 2.7),
                                            ('C+', 2.3),
                                            ('C', 2.0),
                                            ('C-', 1.7),
                                            ('D+', 1.3),
                                            ('D', 1.0),
                                            ('D-', 0.7),
                                            ('F', 0.0);

-- INSERT INTO Section(course_id, term_id, instructor_id, classroom, capacity, start_time, end_time) 
-- VALUES (3, 1, 1, 'H907', 30, '08:00:00', '10:00:00'), 
--        (4, 1, 1, 'H907', 30, '11:00:00', '13:00:00'), 
--        (5, 1, 1, 'H907', 30, '14:00:00', '16:00:00'), 
--        (6, 2, 1, 'H907', 30, '08:00:00', '10:00:00'),
--        (6, 2, 1, 'H907', 30, '08:00:00', '10:00:00'),
--        (6, 2, 1, 'H907', 30, '08:00:00', '10:00:00'),
--        (6, 2, 1, 'H907', 30, '08:00:00', '10:00:00'),
--        (6, 2, 1, 'H907', 30, '08:00:00', '10:00:00'),
--        (6, 2, 1, 'H907', 30, '08:00:00', '10:00:00'),
--        (6, 2, 1, 'H907', 30, '08:00:00', '10:00:00');

-- INSERT INTO Class(student_id, section_id, grade_id) VALUES (1, 1, 1, 4.0), (1, 2, 2, 4.0), (1, 3, 3, 0.0);
-- INSERT INTO StudentProgram(student_id, program_id) VALUES(1, 4); -- olivia benson is a physics student

-- INSERT INTO ResearchFunding;
-- INSERT INTO Prerequisite() VALUES (6, 3), (6, 4), (6, 5);
-- INSERT INTO StudentDepartment
-- INSERT INTO InstructorDepartment
-- INSERT INTO Advisor
-- INSERT INTO StudentAdvisor
-- INSERT INTO Supervisor
-- INSERT INTO StudentSupervisor
