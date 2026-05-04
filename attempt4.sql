Drop Table Department cascade constraints;
Drop Table Major cascade constraints;
Drop Table Student cascade constraints;
Drop Table Course cascade constraints;
Drop Table Enrollment cascade constraints;
Drop Table Grade_Category cascade constraints;
Drop Table Assignment cascade constraints;
Drop Table Student_Grade cascade constraints;

CREATE TABLE Department (
    Department_ID VARCHAR2(5) PRIMARY KEY,
    Department_Name VARCHAR2(30) NOT NULL
);

CREATE TABLE Major (
    Major_ID VARCHAR2(5) PRIMARY KEY,
    Major_Name VARCHAR2(30) NOT NULL
);

CREATE TABLE Student (
    Student_ID VARCHAR2(8) PRIMARY KEY,
    First_Name VARCHAR2(30) NOT NULL,
    Last_Name VARCHAR2(30) NOT NULL,
    Academic_Year VARCHAR2(20),
    GPA NUMBER(3,2),
    Major_ID VARCHAR2(5),
    CONSTRAINT fk_student_major FOREIGN KEY (Major_ID) REFERENCES Major(Major_ID)
);

CREATE TABLE Course (
    Course_ID VARCHAR2(8) PRIMARY KEY,
    Department_ID VARCHAR2(5) NOT NULL,
    Course_Name VARCHAR2(30) NOT NULL,
    Semester VARCHAR2(6) NOT NULL,
    Academic_Year VARCHAR2(4) NOT NULL,
    CONSTRAINT fk_course_dept FOREIGN KEY (Department_ID) REFERENCES Department(Department_ID)
);

CREATE TABLE Enrollment (
    Student_ID VARCHAR2(8),
    Course_ID VARCHAR2(8),
    PRIMARY KEY (Student_ID, Course_ID),
    CONSTRAINT fk_enroll_student FOREIGN KEY (Student_ID) REFERENCES Student(Student_ID),
    CONSTRAINT fk_enroll_course FOREIGN KEY (Course_ID) REFERENCES Course(Course_ID)
);

CREATE TABLE Grade_Category (
    Category_ID VARCHAR2(4) PRIMARY KEY,
    Course_ID VARCHAR2(8) NOT NULL,
    Category_Name VARCHAR2(30) NOT NULL,
    Weight_Percentage NUMBER(5,2),
    CONSTRAINT fk_cat_course FOREIGN KEY (Course_ID) REFERENCES Course(Course_ID)
);

CREATE TABLE Assignment (
    Assignment_ID VARCHAR2(4) PRIMARY KEY,
    Category_ID VARCHAR2(5) NOT NULL,
    Assignment_Name VARCHAR2(50) NOT NULL,
    Max_Points NUMBER(5,2) NOT NULL,
    CONSTRAINT fk_assign_cat FOREIGN KEY (Category_ID) REFERENCES Grade_Category(Category_ID)
);

CREATE TABLE Student_Grade (
    Student_ID VARCHAR2(8),
    Assignment_ID VARCHAR2(4),
    Points_Earned NUMBER(5,2),
    PRIMARY KEY (Student_ID, Assignment_ID),
    CONSTRAINT fk_sg_student FOREIGN KEY (Student_ID) REFERENCES Student(Student_ID),
    CONSTRAINT fk_sg_assign FOREIGN KEY (Assignment_ID) REFERENCES Assignment(Assignment_ID)
);

-- Departments and Majors
INSERT INTO Department (Department_ID, Department_Name) VALUES ('CSC', 'Computer Science');
INSERT INTO Department (Department_ID, Department_Name) VALUES ('MAT', 'Mathematics');

INSERT INTO Major (Major_ID, Major_Name) VALUES ('1', 'Software Engineering');
INSERT INTO Major (Major_ID, Major_Name) VALUES ('2', 'Data Science');

-- Students
INSERT INTO Student (Student_ID, First_Name, Last_Name, Academic_Year, GPA, Major_ID) VALUES ('11111111', 'Albert', 'Einstein', 'Senior', 4.00, '1');
INSERT INTO Student (Student_ID, First_Name, Last_Name, Academic_Year, GPA, Major_ID) VALUES ('22222222', 'Serena', 'Williams', 'Junior', 3.80, '1');
INSERT INTO Student (Student_ID, First_Name, Last_Name, Academic_Year, GPA, Major_ID) VALUES ('33333333', 'Grace', 'Hopper', 'Sophomore', 3.90, '1');
INSERT INTO Student (Student_ID, First_Name, Last_Name, Academic_Year, GPA, Major_ID) VALUES ('44444444', 'Marie', 'Curie', 'Senior', 3.95, '2');
INSERT INTO Student (Student_ID, First_Name, Last_Name, Academic_Year, GPA, Major_ID) VALUES ('55555555', 'Steve', 'Jobs', 'Freshman', 4.00, '2');
INSERT INTO Student (Student_ID, First_Name, Last_Name, Academic_Year, GPA, Major_ID) VALUES ('66666666', 'Leonardo', 'da Vinci', 'Junior', 3.75, '1');
INSERT INTO Student (Student_ID, First_Name, Last_Name, Academic_Year, GPA, Major_ID) VALUES ('77777777', 'Lewis', 'Hamilton', 'Senior', 3.60, '1');
INSERT INTO Student (Student_ID, First_Name, Last_Name, Academic_Year, GPA, Major_ID) VALUES ('88888888', 'Alex', 'Albon', 'Sophomore', 3.85, '1');
INSERT INTO Student (Student_ID, First_Name, Last_Name, Academic_Year, GPA, Major_ID) VALUES ('99999999', 'Linus', 'Torvalds', 'Freshman', 3.50, '1');
INSERT INTO Student (Student_ID, First_Name, Last_Name, Academic_Year, GPA, Major_ID) VALUES ('10101010', 'Kimi', 'Antonelli', 'Freshman', 3.92, '2');

-- Courses
INSERT INTO Course (Course_ID, Department_ID, Course_Name, Semester, Academic_Year) VALUES ('CSC101', 'CSC', 'Intro to Programming', 'Fall', '2025');
INSERT INTO Course (Course_ID, Department_ID, Course_Name, Semester, Academic_Year) VALUES ('CSC102', 'CSC', 'Databases', 'Spring', '2026');
INSERT INTO Course (Course_ID, Department_ID, Course_Name, Semester, Academic_Year) VALUES ('MAT101', 'MAT', 'Discrete Mathematics', 'Fall', '2025');

-- CS101: 5 Students
INSERT INTO Enrollment (Student_ID, Course_ID) VALUES ('11111111', 'CSC101');
INSERT INTO Enrollment (Student_ID, Course_ID) VALUES ('22222222', 'CSC101');
INSERT INTO Enrollment (Student_ID, Course_ID) VALUES ('33333333', 'CSC101');
INSERT INTO Enrollment (Student_ID, Course_ID) VALUES ('44444444', 'CSC101');
INSERT INTO Enrollment (Student_ID, Course_ID) VALUES ('55555555', 'CSC101');

-- CS201: 4 Students
INSERT INTO Enrollment (Student_ID, Course_ID) VALUES ('66666666', 'CSC102');
INSERT INTO Enrollment (Student_ID, Course_ID) VALUES ('77777777', 'CSC102');
INSERT INTO Enrollment (Student_ID, Course_ID) VALUES ('88888888', 'CSC102');
INSERT INTO Enrollment (Student_ID, Course_ID) VALUES ('99999999', 'CSC102');

-- MATH101: 4 Students
INSERT INTO Enrollment (Student_ID, Course_ID) VALUES ('11111111', 'MAT101');
INSERT INTO Enrollment (Student_ID, Course_ID) VALUES ('10101010', 'MAT101');
INSERT INTO Enrollment (Student_ID, Course_ID) VALUES ('55555555', 'MAT101');
INSERT INTO Enrollment (Student_ID, Course_ID) VALUES ('88888888', 'MAT101');

-- Grade Categories
-- CS101: 40% HW, 60% Exams
INSERT INTO Grade_Category (Category_ID, Course_ID, Category_Name, Weight_Percentage) VALUES ('1', 'CSC101', 'Homework', 40);
INSERT INTO Grade_Category (Category_ID, Course_ID, Category_Name, Weight_Percentage) VALUES ('2', 'CSC101', 'Exams', 60);

-- CS201: 50% Projects, 50% Exams
INSERT INTO Grade_Category (Category_ID, Course_ID, Category_Name, Weight_Percentage) VALUES ('3', 'CSC102', 'Projects', 50);
INSERT INTO Grade_Category (Category_ID, Course_ID, Category_Name, Weight_Percentage) VALUES ('4', 'CSC102', 'Exams', 50);

-- MATH101: 20% Participation, 80% Exams
INSERT INTO Grade_Category (Category_ID, Course_ID, Category_Name, Weight_Percentage) VALUES ('5', 'MAT101', 'Participation', 20);
INSERT INTO Grade_Category (Category_ID, Course_ID, Category_Name, Weight_Percentage) VALUES ('6', 'MAT101', 'Exams', 80);

-- Assignments
-- CS101 Assignments
INSERT INTO Assignment (Assignment_ID, Category_ID, Assignment_Name, Max_Points) VALUES ('1', '1', 'HW 1', 100);
INSERT INTO Assignment (Assignment_ID, Category_ID, Assignment_Name, Max_Points) VALUES ('2', '1', 'HW 2', 50);
INSERT INTO Assignment (Assignment_ID, Category_ID, Assignment_Name, Max_Points) VALUES ('3', '2', 'Midterm', 100);

-- CS201 Assignments
INSERT INTO Assignment (Assignment_ID, Category_ID, Assignment_Name, Max_Points) VALUES ('4', '3', 'SQL Project', 200);
INSERT INTO Assignment (Assignment_ID, Category_ID, Assignment_Name, Max_Points) VALUES ('5', '4', 'Final Exam', 100);

-- MATH101 Assignments
INSERT INTO Assignment (Assignment_ID, Category_ID, Assignment_Name, Max_Points) VALUES ('6', '5', 'Attendance', 10);
INSERT INTO Assignment (Assignment_ID, Category_ID, Assignment_Name, Max_Points) VALUES ('7', '6', 'Final Exam', 100);

-- Student Grades
-- Grading CS101
-- HW 1 (Max 100)
INSERT INTO Student_Grade (Student_ID, Assignment_ID, Points_Earned) VALUES ('11111111', '1', 100);
INSERT INTO Student_Grade (Student_ID, Assignment_ID, Points_Earned) VALUES ('22222222', '1', 90);
INSERT INTO Student_Grade (Student_ID, Assignment_ID, Points_Earned) VALUES ('33333333', '1', 85);
INSERT INTO Student_Grade (Student_ID, Assignment_ID, Points_Earned) VALUES ('44444444', '1', 70);
INSERT INTO Student_Grade (Student_ID, Assignment_ID, Points_Earned) VALUES ('55555555', '1', 100);
-- HW 2 (Max 50)
INSERT INTO Student_Grade (Student_ID, Assignment_ID, Points_Earned) VALUES ('11111111', '2', 50);
INSERT INTO Student_Grade (Student_ID, Assignment_ID, Points_Earned) VALUES ('22222222', '2', 45);
INSERT INTO Student_Grade (Student_ID, Assignment_ID, Points_Earned) VALUES ('33333333', '2', 40);
INSERT INTO Student_Grade (Student_ID, Assignment_ID, Points_Earned) VALUES ('44444444', '2', 30);
INSERT INTO Student_Grade (Student_ID, Assignment_ID, Points_Earned) VALUES ('55555555', '2', 50);
-- Midterm (Max 100)
INSERT INTO Student_Grade (Student_ID, Assignment_ID, Points_Earned) VALUES ('11111111', '3', 95);
INSERT INTO Student_Grade (Student_ID, Assignment_ID, Points_Earned) VALUES ('22222222', '3', 88);
INSERT INTO Student_Grade (Student_ID, Assignment_ID, Points_Earned) VALUES ('33333333', '3', 92);
INSERT INTO Student_Grade (Student_ID, Assignment_ID, Points_Earned) VALUES ('44444444', '3', 75);
INSERT INTO Student_Grade (Student_ID, Assignment_ID, Points_Earned) VALUES ('55555555', '3', 100);

-- Grading CS201
-- SQL Project (Max 200)
INSERT INTO Student_Grade (Student_ID, Assignment_ID, Points_Earned) VALUES ('66666666', '4', 190);
INSERT INTO Student_Grade (Student_ID, Assignment_ID, Points_Earned) VALUES ('77777777', '4', 150);
INSERT INTO Student_Grade (Student_ID, Assignment_ID, Points_Earned) VALUES ('88888888', '4', 200);
INSERT INTO Student_Grade (Student_ID, Assignment_ID, Points_Earned) VALUES ('99999999', '4', 170);
-- Final Exam (Max 100)
INSERT INTO Student_Grade (Student_ID, Assignment_ID, Points_Earned) VALUES ('66666666', '5', 85);
INSERT INTO Student_Grade (Student_ID, Assignment_ID, Points_Earned) VALUES ('77777777', '5', 70);
INSERT INTO Student_Grade (Student_ID, Assignment_ID, Points_Earned) VALUES ('88888888', '5', 95);
INSERT INTO Student_Grade (Student_ID, Assignment_ID, Points_Earned) VALUES ('99999999', '5', 80);

-- Grading MATH101
-- Attendance (Max 10)
INSERT INTO Student_Grade (Student_ID, Assignment_ID, Points_Earned) VALUES ('11111111', '6', 10);
INSERT INTO Student_Grade (Student_ID, Assignment_ID, Points_Earned) VALUES ('55555555', '6', 10);
INSERT INTO Student_Grade (Student_ID, Assignment_ID, Points_Earned) VALUES ('88888888', '6', 8);
INSERT INTO Student_Grade (Student_ID, Assignment_ID, Points_Earned) VALUES ('10101010', '6', 9);
-- Final Exam (Max 100)
INSERT INTO Student_Grade (Student_ID, Assignment_ID, Points_Earned) VALUES ('11111111', '7', 98);
INSERT INTO Student_Grade (Student_ID, Assignment_ID, Points_Earned) VALUES ('55555555', '7', 100);
INSERT INTO Student_Grade (Student_ID, Assignment_ID, Points_Earned) VALUES ('88888888', '7', 85);
INSERT INTO Student_Grade (Student_ID, Assignment_ID, Points_Earned) VALUES ('10101010', '7', 92);

-- Helper Table Creation
DROP TABLE Category_Calculation cascade constraints;
CREATE TABLE Category_Calculation (
    Student_ID VARCHAR2(8),
    Course_ID VARCHAR2(8),
    Weighted_Score NUMBER(5,2)
);

INSERT INTO Category_Calculation (Student_ID, Course_ID, Weighted_Score)
SELECT 
    sg.Student_ID,
    gc.Course_ID,
    (SUM(sg.Points_Earned) / SUM(a.Max_Points)) * gc.Weight_Percentage
FROM 
    Student_Grade sg
JOIN 
    Assignment a ON sg.Assignment_ID = a.Assignment_ID
JOIN 
    Grade_Category gc ON a.Category_ID = gc.Category_ID
GROUP BY 
    sg.Student_ID,
    gc.Course_ID,
    a.Category_ID,
    gc.Weight_Percentage;
    
-- Final Output Query
SELECT 
    s.First_Name,
    s.Last_Name,
    c.Course_Name,
    ROUND(SUM(cc.Weighted_Score), 2) AS Final_Grade_Out_Of_100
FROM 
    Category_Calculation cc
JOIN 
    Student s ON cc.Student_ID = s.Student_ID
JOIN 
    Course c ON cc.Course_ID = c.Course_ID
GROUP BY 
    s.Student_ID,
    s.First_Name,
    s.Last_Name,
    c.Course_ID,
    c.Course_Name
ORDER BY 
    c.Course_Name, 
    s.Last_Name;
    
Select * From Department;
Select * from Major;
Select * from Course;
Select * from Student;
Select * from Enrollment;
Select * from Grade_Category;
Select * From Assignment;
Select * From Student_Grade;
