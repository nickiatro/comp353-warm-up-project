-- only run this after you have initialised the database.

INSERT INTO Department(name) VALUES ("Mathematics"), ("Computer Science and Engineering"), ("Biology"), ("Physics"), ("Chemistry"), ("Humanities");

INSERT INTO Term(season, year) VALUES ("Fall", 2019), ("Winter", 2019), ("Summer", 2019), ("Fall", 2020), ("Winter", 2020), ("Summer", 2020);


INSERT INTO Instructor(first_name, last_name) VALUES ("Paul", "Atreides"), ("Leto", "Atreides"), ("Duncan", "Idaho"), ("Vladimir", "Harkonnen"), ("Piter", "de Vries");

INSERT INTO Student(first_name, last_name, gpa, degree) VALUES ("Olivia", "Benson", 3.0, "undergraduate"), ("Odafin", "Tutuola", 2.2, "undergraduate"), ("Amanda", "Rollins", 3.0, "graduate"), ("Dominick", "Carisi", 2.8, "graduate"), ("Elliot", "Stabler", 3.0, "undergraduate"), ("Don", "Cragen", 4.3, "graduate");

INSERT INTO Course(name, number, department_id) VALUES ("Combinatorics", 339, 2), ("Number Theory", 200, 1), ("Electromagnetism", 200, 4), ("Thermodynamics", 201, 4), ("Classical Mechanics", 202, 4), ("Relativity", 300, 4);

INSERT INTO Prerequisite() VALUES (6, 3), (6, 4), (6, 5);

INSERT INTO StudentProgram(student_id, program_id) VALUES(1, 4); -- olivia benson is a physics student
INSERT INTO Section(course_id, term_id, instructor_id, classroom, capacity, start_time, end_time) VALUES (3, 1, 1, "H907", 30, "08:00:00", "10:00:00"), (4, 1, 1, "H907", 30, "11:00:00", "13:00:00"), (5, 1, 1, "H907", 30, "14:00:00", "16:00:00"), (6, 2, 1, "H907", 30, "08:00:00", "10:00:00");

INSERT INTO Grade(letter_grade, gpa) VALUES ("A", 4.0), ("A", 5.0), ("F", 0.0);
INSERT INTO Class(student_id, section_id, grade_id, gpa) VALUES (1, 1, 1, 4.0), (1, 2, 2, 4.0), (1, 3, 3, 0.0);
