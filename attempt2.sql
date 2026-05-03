Drop Table Department cascade constraints;
Drop Table Major_Field cascade constraints;
Drop Table Student cascade constraints;
Drop Table Course cascade constraints;
Drop Table Enrollment cascade constraints;
Drop Table Grade_Category cascade constraints;
Drop Table Assignment cascade constraints;
Drop Table Student_Grade cascade constraints;

CREATE TABLE Department (
    Department_ID NUMBER PRIMARY KEY,
    Department_Name VARCHAR2(100) NOT NULL
);

CREATE TABLE Major_Field (
    Field_ID NUMBER PRIMARY KEY,
    Field_Name VARCHAR2(100) NOT NULL
);

CREATE TABLE Student (
    Student_ID NUMBER PRIMARY KEY,
    First_Name VARCHAR2(50) NOT NULL,
    Last_Name VARCHAR2(50) NOT NULL,
    Academic_Year VARCHAR2(20),
    GPA NUMBER(3,2),
    Field_ID NUMBER,
    CONSTRAINT fk_student_field FOREIGN KEY (Field_ID) REFERENCES Major_Field(Field_ID)
);

CREATE TABLE Course (
    Course_ID NUMBER PRIMARY KEY,
    Department_ID NUMBER NOT NULL,
    Course_Number VARCHAR2(20) NOT NULL,
    Course_Name VARCHAR2(100) NOT NULL,
    Semester VARCHAR2(20) NOT NULL,
    Academic_Year NUMBER(4) NOT NULL,
    CONSTRAINT fk_course_dept FOREIGN KEY (Department_ID) REFERENCES Department(Department_ID)
);

CREATE TABLE Enrollment (
    Student_ID NUMBER,
    Course_ID NUMBER,
    PRIMARY KEY (Student_ID, Course_ID),
    CONSTRAINT fk_enroll_student FOREIGN KEY (Student_ID) REFERENCES Student(Student_ID),
    CONSTRAINT fk_enroll_course FOREIGN KEY (Course_ID) REFERENCES Course(Course_ID)
);

CREATE TABLE Grade_Category (
    Category_ID NUMBER PRIMARY KEY,
    Course_ID NUMBER NOT NULL,
    Category_Name VARCHAR2(50) NOT NULL,
    Weight_Percentage NUMBER(5,2) CHECK (Weight_Percentage > 0 AND Weight_Percentage <= 100),
    CONSTRAINT fk_cat_course FOREIGN KEY (Course_ID) REFERENCES Course(Course_ID)
);

CREATE TABLE Assignment (
    Assignment_ID NUMBER PRIMARY KEY,
    Category_ID NUMBER NOT NULL,
    Assignment_Name VARCHAR2(100) NOT NULL,
    Max_Points NUMBER(5,2) NOT NULL CHECK (Max_Points > 0),
    CONSTRAINT fk_assign_cat FOREIGN KEY (Category_ID) REFERENCES Grade_Category(Category_ID)
);

CREATE TABLE Student_Grade (
    Student_ID NUMBER,
    Assignment_ID NUMBER,
    Points_Earned NUMBER(5,2) CHECK (Points_Earned >= 0),
    PRIMARY KEY (Student_ID, Assignment_ID),
    CONSTRAINT fk_sg_student FOREIGN KEY (Student_ID) REFERENCES Student(Student_ID),
    CONSTRAINT fk_sg_assign FOREIGN KEY (Assignment_ID) REFERENCES Assignment(Assignment_ID)
);

-- 1. Parent Tables: Departments and Majors
INSERT INTO Department (Department_ID, Department_Name) VALUES (1, 'Computer Science');
INSERT INTO Department (Department_ID, Department_Name) VALUES (2, 'Mathematics');

INSERT INTO Major_Field (Field_ID, Field_Name) VALUES (1, 'Software Engineering');
INSERT INTO Major_Field (Field_ID, Field_Name) VALUES (2, 'Data Science');

-- 2. Students (10 total)
INSERT INTO Student (Student_ID, First_Name, Last_Name, Academic_Year, GPA, Field_ID) VALUES (1, 'Ada', 'Lovelace', 'Senior', 4.00, 1);
INSERT INTO Student (Student_ID, First_Name, Last_Name, Academic_Year, GPA, Field_ID) VALUES (2, 'Alan', 'Turing', 'Junior', 3.80, 1);
INSERT INTO Student (Student_ID, First_Name, Last_Name, Academic_Year, GPA, Field_ID) VALUES (3, 'Grace', 'Hopper', 'Sophomore', 3.90, 1);
INSERT INTO Student (Student_ID, First_Name, Last_Name, Academic_Year, GPA, Field_ID) VALUES (4, 'John', 'von Neumann', 'Senior', 3.95, 2);
INSERT INTO Student (Student_ID, First_Name, Last_Name, Academic_Year, GPA, Field_ID) VALUES (5, 'Katherine', 'Johnson', 'Freshman', 4.00, 2);
INSERT INTO Student (Student_ID, First_Name, Last_Name, Academic_Year, GPA, Field_ID) VALUES (6, 'Margaret', 'Hamilton', 'Junior', 3.75, 1);
INSERT INTO Student (Student_ID, First_Name, Last_Name, Academic_Year, GPA, Field_ID) VALUES (7, 'Tim', 'Berners-Lee', 'Senior', 3.60, 1);
INSERT INTO Student (Student_ID, First_Name, Last_Name, Academic_Year, GPA, Field_ID) VALUES (8, 'Donald', 'Knuth', 'Sophomore', 3.85, 1);
INSERT INTO Student (Student_ID, First_Name, Last_Name, Academic_Year, GPA, Field_ID) VALUES (9, 'Linus', 'Torvalds', 'Freshman', 3.50, 1);
INSERT INTO Student (Student_ID, First_Name, Last_Name, Academic_Year, GPA, Field_ID) VALUES (10, 'Claude', 'Shannon', 'Junior', 3.92, 2);

-- 3. Courses (3 total)
INSERT INTO Course (Course_ID, Department_ID, Course_Number, Course_Name, Semester, Academic_Year) VALUES (101, 1, 'CS101', 'Intro to Programming', 'Fall', 2023);
INSERT INTO Course (Course_ID, Department_ID, Course_Number, Course_Name, Semester, Academic_Year) VALUES (102, 1, 'CS201', 'Databases', 'Spring', 2024);
INSERT INTO Course (Course_ID, Department_ID, Course_Number, Course_Name, Semester, Academic_Year) VALUES (103, 2, 'MATH101', 'Discrete Mathematics', 'Fall', 2023);

-- 4. Enrollments (Up to 5 per course)
-- CS101: 5 Students
INSERT INTO Enrollment (Student_ID, Course_ID) VALUES (1, 101);
INSERT INTO Enrollment (Student_ID, Course_ID) VALUES (2, 101);
INSERT INTO Enrollment (Student_ID, Course_ID) VALUES (3, 101);
INSERT INTO Enrollment (Student_ID, Course_ID) VALUES (4, 101);
INSERT INTO Enrollment (Student_ID, Course_ID) VALUES (5, 101);

-- CS201: 4 Students
INSERT INTO Enrollment (Student_ID, Course_ID) VALUES (6, 102);
INSERT INTO Enrollment (Student_ID, Course_ID) VALUES (7, 102);
INSERT INTO Enrollment (Student_ID, Course_ID) VALUES (8, 102);
INSERT INTO Enrollment (Student_ID, Course_ID) VALUES (9, 102);

-- MATH101: 4 Students
INSERT INTO Enrollment (Student_ID, Course_ID) VALUES (1, 103);
INSERT INTO Enrollment (Student_ID, Course_ID) VALUES (10, 103);
INSERT INTO Enrollment (Student_ID, Course_ID) VALUES (5, 103);
INSERT INTO Enrollment (Student_ID, Course_ID) VALUES (8, 103);

-- 5. Grade Categories
-- CS101: 40% HW, 60% Exams
INSERT INTO Grade_Category (Category_ID, Course_ID, Category_Name, Weight_Percentage) VALUES (1, 101, 'Homework', 40);
INSERT INTO Grade_Category (Category_ID, Course_ID, Category_Name, Weight_Percentage) VALUES (2, 101, 'Exams', 60);

-- CS201: 50% Projects, 50% Exams
INSERT INTO Grade_Category (Category_ID, Course_ID, Category_Name, Weight_Percentage) VALUES (3, 102, 'Projects', 50);
INSERT INTO Grade_Category (Category_ID, Course_ID, Category_Name, Weight_Percentage) VALUES (4, 102, 'Exams', 50);

-- MATH101: 20% Participation, 80% Exams
INSERT INTO Grade_Category (Category_ID, Course_ID, Category_Name, Weight_Percentage) VALUES (5, 103, 'Participation', 20);
INSERT INTO Grade_Category (Category_ID, Course_ID, Category_Name, Weight_Percentage) VALUES (6, 103, 'Exams', 80);

-- 6. Assignments
-- CS101 Assignments
INSERT INTO Assignment (Assignment_ID, Category_ID, Assignment_Name, Max_Points) VALUES (1, 1, 'HW 1', 100);
INSERT INTO Assignment (Assignment_ID, Category_ID, Assignment_Name, Max_Points) VALUES (2, 1, 'HW 2', 50);
INSERT INTO Assignment (Assignment_ID, Category_ID, Assignment_Name, Max_Points) VALUES (3, 2, 'Midterm', 100);

-- CS201 Assignments
INSERT INTO Assignment (Assignment_ID, Category_ID, Assignment_Name, Max_Points) VALUES (4, 3, 'SQL Project', 200);
INSERT INTO Assignment (Assignment_ID, Category_ID, Assignment_Name, Max_Points) VALUES (5, 4, 'Final Exam', 100);

-- MATH101 Assignments
INSERT INTO Assignment (Assignment_ID, Category_ID, Assignment_Name, Max_Points) VALUES (6, 5, 'Attendance', 10);
INSERT INTO Assignment (Assignment_ID, Category_ID, Assignment_Name, Max_Points) VALUES (7, 6, 'Final Exam', 100);

-- 7. Student Grades
-- Grading CS101 (Students 1-5)
-- HW 1 (Max 100)
INSERT INTO Student_Grade (Student_ID, Assignment_ID, Points_Earned) VALUES (1, 1, 100);
INSERT INTO Student_Grade (Student_ID, Assignment_ID, Points_Earned) VALUES (2, 1, 90);
INSERT INTO Student_Grade (Student_ID, Assignment_ID, Points_Earned) VALUES (3, 1, 85);
INSERT INTO Student_Grade (Student_ID, Assignment_ID, Points_Earned) VALUES (4, 1, 70);
INSERT INTO Student_Grade (Student_ID, Assignment_ID, Points_Earned) VALUES (5, 1, 100);
-- HW 2 (Max 50)
INSERT INTO Student_Grade (Student_ID, Assignment_ID, Points_Earned) VALUES (1, 2, 50);
INSERT INTO Student_Grade (Student_ID, Assignment_ID, Points_Earned) VALUES (2, 2, 45);
INSERT INTO Student_Grade (Student_ID, Assignment_ID, Points_Earned) VALUES (3, 2, 40);
INSERT INTO Student_Grade (Student_ID, Assignment_ID, Points_Earned) VALUES (4, 2, 30);
INSERT INTO Student_Grade (Student_ID, Assignment_ID, Points_Earned) VALUES (5, 2, 50);
-- Midterm (Max 100)
INSERT INTO Student_Grade (Student_ID, Assignment_ID, Points_Earned) VALUES (1, 3, 95);
INSERT INTO Student_Grade (Student_ID, Assignment_ID, Points_Earned) VALUES (2, 3, 88);
INSERT INTO Student_Grade (Student_ID, Assignment_ID, Points_Earned) VALUES (3, 3, 92);
INSERT INTO Student_Grade (Student_ID, Assignment_ID, Points_Earned) VALUES (4, 3, 75);
INSERT INTO Student_Grade (Student_ID, Assignment_ID, Points_Earned) VALUES (5, 3, 100);

-- Grading CS201 (Students 6-9)
-- SQL Project (Max 200)
INSERT INTO Student_Grade (Student_ID, Assignment_ID, Points_Earned) VALUES (6, 4, 190);
INSERT INTO Student_Grade (Student_ID, Assignment_ID, Points_Earned) VALUES (7, 4, 150);
INSERT INTO Student_Grade (Student_ID, Assignment_ID, Points_Earned) VALUES (8, 4, 200);
INSERT INTO Student_Grade (Student_ID, Assignment_ID, Points_Earned) VALUES (9, 4, 170);
-- Final Exam (Max 100)
INSERT INTO Student_Grade (Student_ID, Assignment_ID, Points_Earned) VALUES (6, 5, 85);
INSERT INTO Student_Grade (Student_ID, Assignment_ID, Points_Earned) VALUES (7, 5, 70);
INSERT INTO Student_Grade (Student_ID, Assignment_ID, Points_Earned) VALUES (8, 5, 95);
INSERT INTO Student_Grade (Student_ID, Assignment_ID, Points_Earned) VALUES (9, 5, 80);

-- Grading MATH101 (Students 1, 5, 8, 10)
-- Attendance (Max 10)
INSERT INTO Student_Grade (Student_ID, Assignment_ID, Points_Earned) VALUES (1, 6, 10);
INSERT INTO Student_Grade (Student_ID, Assignment_ID, Points_Earned) VALUES (5, 6, 10);
INSERT INTO Student_Grade (Student_ID, Assignment_ID, Points_Earned) VALUES (8, 6, 8);
INSERT INTO Student_Grade (Student_ID, Assignment_ID, Points_Earned) VALUES (10, 6, 9);
-- Final Exam (Max 100)
INSERT INTO Student_Grade (Student_ID, Assignment_ID, Points_Earned) VALUES (1, 7, 98);
INSERT INTO Student_Grade (Student_ID, Assignment_ID, Points_Earned) VALUES (5, 7, 100);
INSERT INTO Student_Grade (Student_ID, Assignment_ID, Points_Earned) VALUES (8, 7, 85);
INSERT INTO Student_Grade (Student_ID, Assignment_ID, Points_Earned) VALUES (10, 7, 92);

-- Logic Portion
SELECT 
    s.First_Name,
    s.Last_Name,
    c.Course_Name,
    ROUND(SUM(cw.Weighted_Score), 2) AS Final_Grade_Out_Of_100
FROM (
    SELECT 
        ct.Student_ID,
        gc.Course_ID,
        (ct.Total_Earned / ct.Total_Max) * gc.Weight_Percentage AS Weighted_Score
    FROM (
        SELECT 
            sg.Student_ID,
            a.Category_ID,
            SUM(sg.Points_Earned) AS Total_Earned,
            SUM(a.Max_Points) AS Total_Max
        FROM 
            Student_Grade sg
        JOIN 
            Assignment a ON sg.Assignment_ID = a.Assignment_ID
        GROUP BY 
            sg.Student_ID,
            a.Category_ID
    ) ct 
    JOIN 
        Grade_Category gc ON ct.Category_ID = gc.Category_ID
) cw 
JOIN 
    Student s ON cw.Student_ID = s.Student_ID
JOIN 
    Course c ON cw.Course_ID = c.Course_ID
GROUP BY 
    s.Student_ID,
    s.First_Name,
    s.Last_Name,
    c.Course_ID,
    c.Course_Name
ORDER BY 
    c.Course_Name, 
    s.Last_Name;
    
