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
