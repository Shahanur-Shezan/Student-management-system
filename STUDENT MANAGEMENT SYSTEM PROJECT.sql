-- STUDENT MANAGEMENT SYSTEM PROJECT

-- Drop tables if they already exist
DROP TABLE IF EXISTS results;
DROP TABLE IF EXISTS enrollments;
DROP TABLE IF EXISTS students;
DROP TABLE IF EXISTS courses;
DROP TABLE IF EXISTS teachers;

-- Create students table
CREATE TABLE students (
    student_id INT PRIMARY KEY,
    name VARCHAR(100),
    gender VARCHAR(10),
    date_of_birth DATE,
    department VARCHAR(50)
);

-- Create teachers table
CREATE TABLE teachers (
    teacher_id INT PRIMARY KEY,
    name VARCHAR(100),
    email VARCHAR(100),
    department VARCHAR(50)
);

-- Create courses table
CREATE TABLE courses (
    course_id INT PRIMARY KEY,
    course_name VARCHAR(100),
    credit INT,
    teacher_id INT,
    FOREIGN KEY (teacher_id) REFERENCES teachers(teacher_id)
);

-- Create enrollments table
CREATE TABLE enrollments (
    enrollment_id INT PRIMARY KEY,
    student_id INT,
    course_id INT,
    enrollment_date DATE,
    FOREIGN KEY (student_id) REFERENCES students(student_id),
    FOREIGN KEY (course_id) REFERENCES courses(course_id)
);

-- Create results table
CREATE TABLE results (
    result_id INT PRIMARY KEY,
    student_id INT,
    course_id INT,
    grade VARCHAR(2),
    FOREIGN KEY (student_id) REFERENCES students(student_id),
    FOREIGN KEY (course_id) REFERENCES courses(course_id)
);

-- Insert sample data into students
INSERT INTO students VALUES 
(1, 'Rahim Uddin', 'Male', '2002-04-12', 'Statistics'),
(2, 'Karima Khatun', 'Female', '2001-08-23', 'Mathematics'),
(3, 'Nayeem Islam', 'Male', '2003-01-17', 'Physics');

-- Insert sample data into teachers
INSERT INTO teachers VALUES 
(101, 'Dr. Selina Haque', 'selina@university.edu', 'Statistics'),
(102, 'Mr. Tanvir Hasan', 'tanvir@university.edu', 'Mathematics');

-- Insert sample data into courses
INSERT INTO courses VALUES 
(201, 'Probability Theory', 3, 101),
(202, 'Linear Algebra', 3, 102);

-- Insert sample data into enrollments
INSERT INTO enrollments VALUES 
(301, 1, 201, '2025-01-10'),
(302, 2, 202, '2025-01-12'),
(303, 3, 201, '2025-01-15');

-- Insert sample data into results
INSERT INTO results VALUES 
(401, 1, 201, 'A'),
(402, 2, 202, 'B+'),
(403, 3, 201, 'A-');

-- Sample Queries

-- 1. List all students
SELECT * FROM students;

-- 2. List all courses with their assigned teacher
SELECT c.course_name, c.credit, t.name AS teacher_name
FROM courses c
JOIN teachers t ON c.teacher_id = t.teacher_id;

-- 3. Show enrollment details with student and course name
SELECT s.name AS student_name, c.course_name, e.enrollment_date
FROM enrollments e
JOIN students s ON e.student_id = s.student_id
JOIN courses c ON e.course_id = c.course_id;

-- 4. Show each student's result with course
SELECT s.name, c.course_name, r.grade
FROM results r
JOIN students s ON r.student_id = s.student_id
JOIN courses c ON r.course_id = c.course_id;

-- 5. Count how many students are in each department
SELECT department, COUNT(*) AS total_students
FROM students
GROUP BY department;