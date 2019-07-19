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

-- Term variables
SET @summer2019 := (SELECT id FROM Term WHERE season = 'Summer' AND year = 2019);
SET @fall2018 := (SELECT id FROM Term WHERE season = 'Fall' AND year = 2018);
SET @winter2019 := (SELECT id FROM Term WHERE season = 'Fall' AND year = 2019);
SET @fall2019 := (SELECT id FROM Term WHERE season = 'Fall' AND year = 2019);
SET @winter2017 := (SELECT id FROM Term WHERE season = 'Winter' AND year = 2017);
SET @fall2017 := (SELECT id FROM Term WHERE season = 'Fall' AND year = 2017);

INSERT INTO Program(name, degree, credit_req, is_thesis_based, department_id)
VALUES ('Actuarial Mathematics', 'undergraduate', 0, 0, @mathematics),
       ('Computer Science', 'undergraduate', 0, 0, @computer_science),
       ('Software Engineering', 'undergraduate', 0, 0, @computer_science),
       ('Behavioural Neuroscience', 'undergraduate', 0, 0, @biology),
       ('Biophysics', 'undergraduate', 0, 0, @physics),
       ('Biochemistry', 'undergraduate', 0, 0, @chemistry),
       ('Human Relations', 'graduate', 0, 1, @humanities),
       ('Accountancy', 'graduate', 0, 1, @business),
       ('Sociology', 'graduate', 0, 1, @social_sciences),
       ('Art History', 'graduate', 0, 1, @history),
       ('Childhood Education', 'graduate', 0, 1, @education);

-- Program variables
SET @actuarial_mathematics := (SELECT id FROM Program WHERE name = 'Actuarial Mathematics');
SET @computer_science_program := (SELECT id FROM Program WHERE name = 'Computer Science');
SET @software_engineering := (SELECT id FROM Program WHERE name = 'Software Engineering');
SET @behavioural_neuroscience := (SELECT id FROM Program WHERE name = 'Behavioural Neuroscience');
SET @biophysics := (SELECT id FROM Program WHERE name = 'Biophysics');
SET @biochemistry := (SELECT id FROM Program WHERE name = 'Biochemistry');
SET @human_relations := (SELECT id FROM Program WHERE name = 'Human Relations');
SET @accountancy := (SELECT id FROM Program WHERE name = 'Accountancy');
SET @sociology := (SELECT id FROM Program WHERE name = 'Sociology');
SET @art_history := (SELECT id FROM Program WHERE name = 'Art History');
SET @childhood_education := (SELECT id FROM Program WHERE name = 'Childhood Education');

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
       ('Educational Communication', 'EDUC', 270, @education),
       ('Object Oriented Programming I', 'COMP', 248, @computer_science),
       ('Object Oriented Programming I', 'COMP', 249, @computer_science),
       ('Principles of Programming Languages', 'COMP', 348, @computer_science);

-- Course variables
SET @comp353 := (SELECT id FROM Course WHERE code = 'COMP' AND number = 353);
SET @comp352 := (SELECT id FROM Course WHERE code = 'COMP' AND number = 352);
SET @comp339 := (SELECT id FROM Course WHERE code = 'COMP' AND number = 339);
SET @chem201 := (SELECT id FROM Course WHERE code = 'CHEM' AND number = 201);
SET @comp248 := (SELECT id FROM Course WHERE code = 'COMP' AND number = 248);
SET @comp249 := (SELECT id FROM Course WHERE code = 'COMP' AND number = 249);
SET @comp348 := (SELECT id FROM Course WHERE code = 'COMP' AND number = 348);

INSERT INTO Student(first_name, last_name, gpa, degree)
VALUES ('Olivia', 'Benson', 3.0, 'graduate'),
       ('Odafin', 'Tutuola', 2.2, 'graduate'),
       ('Amanda', 'Rollins', 3.2, 'graduate'),
       ('Dominick', 'Carisi', 2.8, 'graduate'),
       ('Elliot', 'Stabler', 3.0, 'graduate'),
       ('Don', 'Cragen', 4.3, 'graduate'),
       ('Maximina', 'Specht', 2.0, 'graduate'),
       ('Laurel', 'Sherrod', 3.3, 'graduate'),
       ('Nada', 'Dillard', 3.6, 'graduate'),
       ('Eliseo', 'Piano', 3.3, 'graduate'),
       ('Mario', 'Speedwagon', 3.3, 'undergraduate'),
       ('Petey', 'Cruiser', 3.3, 'undergraduate'),
       ('Anna', 'Sthesia', 2.3, 'undergraduate'),

       ('Vinny', 'Gret', 3.3, 'graduate'),
       ('Joyce', 'Tick', 3.3, 'graduate'),
       ('Cliff', 'Diver', 3.3, 'graduate'),
       ('Earl', 'Riser', 3.3, 'graduate'),
       ('Cooke', 'Edoh', 3.3, 'graduate'),

       ('Jen', 'Youfelct', 3.3, 'graduate'),
       ('Reanne', 'Carnation', 3.3, 'graduate'),
       ('Paul', 'Misunday', 3.3, 'graduate'),
       ('Chris', 'Cream', 3.3, 'graduate'),
       ('Gio', 'Metric', 3.3, 'graduate'),

       ('Caire', 'Innet', 3.3, 'graduate'),
       ('Marsha', 'Mello', 3.3, 'graduate'),
       ('Manny', 'Petty', 3.3, 'graduate'),
       ('Val', 'Adictorian', 3.3, 'graduate'),
       ('Lucy', 'Tania', 3.3, 'graduate');

-- Student variables
SET @olivia := (SELECT id FROM Student WHERE first_name = 'Olivia');
SET @odafin := (SELECT id FROM Student WHERE first_name = 'Odafin');
SET @amanda := (SELECT id FROM Student WHERE first_name = 'Amanda');
SET @dominick := (SELECT id FROM Student WHERE first_name = 'Dominick');
SET @elliot := (SELECT id FROM Student WHERE first_name = 'Elliot');
SET @don := (SELECT id FROM Student WHERE first_name = 'Don');
SET @maximina := (SELECT id FROM Student WHERE first_name = 'Maximina');
SET @laurel := (SELECT id FROM Student WHERE first_name = 'Laurel');
SET @nada := (SELECT id FROM Student WHERE first_name = 'Nada');
SET @eliseo := (SELECT id FROM Student WHERE first_name = 'Eliseo');
SET @mario := (SELECT id FROM Student WHERE first_name = 'Mario');
SET @petey := (SELECT id FROM Student WHERE first_name = 'Petey');
SET @anna := (SELECT id FROM Student WHERE first_name = 'Anna');
SET @paul := (SELECT id FROM Student WHERE first_name = 'Paul');
SET @Vinny := (SELECT id FROM Student WHERE first_name = 'Vinny');
SET @Joyce := (SELECT id FROM Student WHERE first_name = 'Joyce');
SET @Cliff := (SELECT id FROM Student WHERE first_name = 'Cliff');
SET @Earl := (SELECT id FROM Student WHERE first_name = 'Earl');
SET @Cooke := (SELECT id FROM Student WHERE first_name = 'Cooke');
SET @Jen := (SELECT id FROM Student WHERE first_name = 'Jen');
SET @Reanne := (SELECT id FROM Student WHERE first_name = 'Reanne');
SET @Paul := (SELECT id FROM Student WHERE first_name = 'Paul');
SET @Chris := (SELECT id FROM Student WHERE first_name = 'Chris');
SET @Gio := (SELECT id FROM Student WHERE first_name = 'Gio');
SET @Caire := (SELECT id FROM Student WHERE first_name = 'Caire');
SET @Marsha := (SELECT id FROM Student WHERE first_name = 'Marsha');
SET @Manny := (SELECT id FROM Student WHERE first_name = 'Manny');
SET @Val := (SELECT id FROM Student WHERE first_name = 'Val');
SET @Lucy := (SELECT id FROM Student WHERE first_name = 'Lucy');

INSERT INTO Instructor(first_name, last_name)
VALUES ('Brendan', 'Atreides'),
       ('Leto', 'Atreides'),
       ('Duncan', 'Idaho'),
       ('Vladimir', 'Harkonnen'),
       ('Piter', 'de Vries'),
       ('John', 'Smith'),
       ('Russell', 'Alessi'),
       ('Guillermo', 'Wintheiser'),
       ('Alex', 'Lee'),
       ('Gary', 'Lee');

-- Instructor variables
SET @brendan := (SELECT id FROM Instructor WHERE first_name = 'Brendan');
SET @leto := (SELECT id FROM Instructor WHERE first_name = 'Leto');
SET @duncan := (SELECT id FROM Instructor WHERE first_name = 'Duncan');
SET @vladimir := (SELECT id FROM Instructor WHERE first_name = 'Vladimir');
SET @piter := (SELECT id FROM Instructor WHERE first_name = 'Piter');
SET @john := (SELECT id FROM Instructor WHERE first_name = 'John');
SET @russell := (SELECT id FROM Instructor WHERE first_name = 'Russell');
SET @guillermo := (SELECT id FROM Instructor WHERE first_name = 'Guillermo');
SET @alex := (SELECT id FROM Instructor WHERE first_name = 'Alex');
SET @gary := (SELECT id FROM Instructor WHERE first_name = 'Gary');


INSERT INTO TeachingAssistant(student_id, section_id, num_hours)
VALUES (@don, 1, 50),
       (@don, 2, 50),
       (@don, 3, 50),
       (@nada, 4, 50),
       (@nada, 5, 50),
       (@nada, 6, 50),
       (@eliseo, 7, 50),
       (@eliseo, 8, 50),
       (@eliseo, 9, 50),
       (@amanda, 10, 50);

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

-- Grade variables
SET @aplus := (SELECT id FROM Grade WHERE letter_grade = 'A+');
SET @a := (SELECT id FROM Grade WHERE letter_grade = 'A');
SET @aminus := (SELECT id FROM Grade WHERE letter_grade = 'A-');
SET @bplus := (SELECT id FROM Grade WHERE letter_grade = 'B+');
SET @b := (SELECT id FROM Grade WHERE letter_grade = 'B');
SET @bminus := (SELECT id FROM Grade WHERE letter_grade = 'B-');

INSERT INTO Section(course_id, term_id, instructor_id, classroom, capacity, start_time, end_time)
VALUES (@comp353, @summer2019, @brendan, 'H901', 30, '08:00:00', '10:00:00'),
       (@comp353, @summer2019, @alex, 'H902', 30, '11:00:00', '13:00:00'),
       (@comp353, @summer2019, @guillermo, 'H903', 30, '14:00:00', '16:00:00'),
       (@comp352, @fall2018, @alex, 'H904', 30, '08:00:00', '10:00:00'),
       (@comp352, @fall2018, @alex, 'H905', 30, '11:00:00', '13:00:00'),
       (@comp352, @fall2018, @alex, 'H906', 30, '14:00:00', '16:00:00'),
       (@comp339, @summer2019, @vladimir, 'H907', 30, '08:00:00', '10:00:00'),
       (@comp339, @summer2019, @piter, 'H908', 30, '11:00:00', '13:00:00'),
       (@comp339, @summer2019, @john, 'H909', 30, '14:00:00', '16:00:00'),
       (@chem201, @summer2019, @gary, 'H910', 30, '08:00:00', '10:00:00'),
       (@comp352, @winter2017, @leto, 'H904', 30, '08:00:00', '10:00:00'),
       (@comp352, @winter2017, @leto, 'H905', 30, '11:00:00', '13:00:00'),
       (@comp352, @winter2017, @guillermo, 'H906', 30, '14:00:00', '16:00:00'),
       (@comp352, @fall2017, @duncan, 'H904', 30, '08:00:00', '10:00:00'),
       (@comp352, @fall2017, @russell, 'H905', 30, '11:00:00', '13:00:00');

INSERT INTO Class(student_id, section_id, grade_id)
VALUES (@odafin, (SELECT id FROM Section WHERE course_id = @comp353 AND term_id = @summer2019 AND instructor_id = @brendan), @aplus),
       (@nada, (SELECT id FROM Section WHERE course_id = @comp353 AND term_id = @summer2019 AND instructor_id = @brendan), @aplus),
       (@eliseo, (SELECT id FROM Section WHERE course_id = @comp353 AND term_id = @summer2019 AND instructor_id = @brendan), @aplus),
       (@don, (SELECT id FROM Section WHERE course_id = @comp353 AND term_id = @summer2019 AND instructor_id = @brendan), @a),
       (@dominick, (SELECT id FROM Section WHERE course_id = @comp353 AND term_id = @summer2019 AND instructor_id = @brendan), @a),
       (@amanda, (SELECT id FROM Section WHERE course_id = @comp353 AND term_id = @summer2019 AND instructor_id = @brendan), @aminus),
       (@mario, (SELECT id FROM Section WHERE course_id = @comp353 AND term_id = @summer2019 AND instructor_id = @brendan), @b),
       (@petey, (SELECT id FROM Section WHERE course_id = @comp353 AND term_id = @summer2019 AND instructor_id = @brendan), @bminus),
       (@Lucy, (SELECT id FROM Section WHERE course_id = @comp353 AND term_id = @summer2019 AND instructor_id = @brendan), @aplus),
       (@anna, (SELECT id FROM Section WHERE course_id = @comp353 AND term_id = @summer2019 AND instructor_id = @brendan), @bplus),
       (@paul, (SELECT id FROM Section WHERE course_id = @comp353 AND term_id = @summer2019 AND instructor_id = @brendan), @b);

INSERT INTO StudentProgram(student_id, program_id)
VALUES (@nada, @computer_science_program),
       (@eliseo, @computer_science_program),
       (@don, @computer_science_program),
       (@dominick, @computer_science_program),
       (@amanda, @computer_science_program),
       (@olivia, @human_relations),
       (@odafin, @accountancy),
       (@elliot, @sociology),
       (@maximina, @art_history),
       (@laurel, @childhood_education),
       (@mario, @computer_science_program),
       (@petey, @computer_science_program),
       (@anna, @computer_science_program),
       (@paul, @computer_science_program),
       (@odafin, @computer_science_program),
       (@anna, @human_relations),
       (@odafin, @software_engineering),
       (@anna, @software_engineering);

INSERT INTO ResearchFunding(student_id)
VALUES (@olivia),
       (@odafin),
       (@elliot),
       (@maximina),
       (@laurel),
       (@Caire),
       (@Marsha),
       (@Manny),
       (@Val),
       (@Lucy);

INSERT INTO Prerequisite(course_id, prerequisite_course_id)
VALUES (@comp353, @comp352),
       (@comp353, @comp339),
       (@comp353, @comp248),
       (@comp353, @comp249),
       (@comp353, @comp348),
       (@comp249, @comp248),
       (@comp348, @comp248),
       (@comp348, @comp249),
       (@comp352, @comp248),
       (@comp352, @comp249);

INSERT INTO StudentDepartment(student_id, department_id)
VALUES (@olivia, @humanities),
       (@odafin, @business),
       (@amanda, @computer_science),
       (@dominick, @computer_science),
       (@elliot, @social_sciences),
       (@don, @computer_science),
       (@maximina, @history),
       (@laurel, @education),
       (@nada, @computer_science),
       (@eliseo, @computer_science),
       (@mario, @computer_science),
       (@petey, @computer_science),
       (@anna, @computer_science),
       (@paul, @computer_science);

INSERT INTO InstructorDepartment(instructor_id, department_id)
VALUES (@brendan, @computer_science),
       (@leto, @computer_science),
       (@duncan, @computer_science),
       (@vladimir, @computer_science),
       (@piter, @computer_science),
       (@john, @computer_science),
       (@russell, @computer_science),
       (@guillermo, @computer_science),
       (@alex, @computer_science),
       (@gary, @computer_science);

INSERT INTO Advisor (first_name, last_name)
VALUES ('Vatika', 'Prasad'),
       ('Kareena', 'Kapoor'),
       ('Aamir', 'Khan'),
       ('Tom', 'Cruise'),
       ('Katrina', 'Kaif'),
       ('Mama', 'Bear'),
       ('Buggie', 'Singh'),
       ('Priyanka', 'Chopra'),
       ('Mickey', 'Mouse'),
       ('Mini', 'Xyz');

SET @advisor := (SELECT id FROM Advisor WHERE first_name = 'Vatika');

INSERT INTO StudentAdvisor(student_program_id, advisor_id, term_id)
VALUES ((SELECT id FROM StudentProgram WHERE student_id = @nada AND program_id = @computer_science_program), @advisor, @summer2019),
       ((SELECT id FROM StudentProgram WHERE student_id = @eliseo AND program_id = @computer_science_program), @advisor, @summer2019),
       ((SELECT id FROM StudentProgram WHERE student_id = @dominick AND program_id = @computer_science_program), @advisor, @summer2019),
       ((SELECT id FROM StudentProgram WHERE student_id = @amanda AND program_id = @computer_science_program), @advisor, @summer2019),
       ((SELECT id FROM StudentProgram WHERE student_id = @olivia AND program_id = @human_relations), @advisor, @summer2019),
       ((SELECT id FROM StudentProgram WHERE student_id = @odafin AND program_id = @computer_science_program), @advisor, @summer2019),
       ((SELECT id FROM StudentProgram WHERE student_id = @elliot AND program_id = @sociology), @advisor, @summer2019),
       ((SELECT id FROM StudentProgram WHERE student_id = @maximina AND program_id = @art_history), @advisor, @summer2019),
       ((SELECT id FROM StudentProgram WHERE student_id = @laurel AND program_id = @childhood_education), @advisor, @summer2019),
       ((SELECT id FROM StudentProgram WHERE student_id = @don AND program_id = @computer_science_program), @advisor, @summer2019),
       ((SELECT id FROM StudentProgram WHERE student_id = @anna AND program_id = @software_engineering), @advisor, @summer2019);

INSERT INTO Supervisor(first_name, last_name, department_id, has_research_funding)
VALUES ('Marge', 'Arin', @computer_science, 1),
       ('Hugh', 'Briss', @computer_science, 1),
       ('Gene', 'Poole', @computer_science, 1),
       ('Ty', 'Tanic', @computer_science, 1),
       ('Manuel', 'Labor', @computer_science, 1),
       ('Lynn', 'Guini', @computer_science, 1),
       ('Claire', 'Arin', @computer_science, 1),
       ('Peg', 'Leg', @computer_science, 1),
       ('Marty', 'Graw', @computer_science, 1),
       ('Olive', 'Yu', @computer_science, 1);

SET @marge := (SELECT id FROM Supervisor WHERE first_name = 'Marge');

INSERT INTO StudentSupervisor(student_id, supervisor_id)
VALUES (@olivia, @marge),
       (@odafin, @marge),
       (@elliot, @marge),
       (@maximina, @marge),
       (@laurel, @marge),
       (@Vinny, @marge),
       (@Joyce, @marge),
       (@Cliff, @marge),
       (@Earl, @marge),
       (@Cooke, @marge),
       (@Jen, @marge),
       (@Reanne, @marge),
       (@Paul, @marge),
       (@Chris, @marge),
       (@Gio, @marge),
       (@Caire, @marge),
       (@Marsha, @marge),
       (@Manny, @marge),
       (@Val, @marge),
       (@Lucy, @marge);
