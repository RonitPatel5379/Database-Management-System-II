--Lab-2	Stored Procedure
--Part – A
--1.INSERT Procedures: Create stored procedures to insert records into STUDENT tables (SP_INSERT_STUDENT)
--StuID	Name	Email	Phone	Department	DOB	EnrollmentYear
--10	Harsh Parmar	harsh@univ.edu	9876543219	CSE	2005-09-18	2023
--11	Om Patel	om@univ.edu	9876543220	IT	2002-08-22	2022
    CREATE OR ALTER PROC PR_INSERT_STUDENT
    @StuID INT,
    @Name VARCHAR(20),
    @Email VARCHAR(20),
    @Phone VARCHAR(10),
    @Department VARCHAR(10),
    @DOB DATE,
    @EnrollmentYear INT
    AS
    BEGIN
    INSERT INTO STUDENT(StudentID,StuName,StuEmail,StuPhone,StuDepartment,StuDateOfBirth,StuEnrollmentYear,CGPA)
    VALUES (@StuID,@Name,@Email,@Phone,@Department,@DOB,@EnrollmentYear,NULL)
    END
    EXEC PR_INSERT_STUDENT 10,'Harsh Parmar','harsh@univ.edu','9876543219','CSE','2005-09-18',2023
    EXEC PR_INSERT_STUDENT 11,'Om Patel','om@univ.edu','9876543220','IT','2002-08-22',2022
--2.INSERT Procedures: Create stored procedures to insert records into COURSE tables 
--(SP_INSERT_COURSE)
--CourseID	CourseName	Credits	Dept	Semester
--CS330	Computer Networks	4	CSE	5
--EC120	Electronic Circuits	3	ECE	2
    CREATE OR ALTER PROC PR_INSERT_COURSE
    @CourseID VARCHAR(10),
    @CourseName VARCHAR(100),
    @CourseCredits INT,
    @CourseDepartment VARCHAR(50),
    @CourseSemester INT
    AS
    BEGIN
    INSERT INTO COURSE VALUES (@CourseID,@CourseName,@CourseCredits,@CourseDepartment,@CourseSemester)
    END
    EXEC PR_INSERT_COURSE 'CS330','Computer Networks',4,'CSE',5
    EXEC PR_INSERT_COURSE 'EC120','Electronic Circuits',3,'ECE',2
--3.UPDATE Procedures: Create stored procedure SP_UPDATE_STUDENT to update Email and Phone in STUDENT table. (Update using studentID)
    CREATE OR ALTER PROC PR_UPDATE_STUDENT
    @Email VARCHAR(100),
    @Phone VARCHAR(15),
    @StudentID INT
    AS
    BEGIN
        UPDATE STUDENT
        SET StuEmail = @Email,StuPhone = @Phone
        WHERE StudentID = @StudentID
    END
    EXEC PR_UPDATE_STUDENT 'harsh.parmar@univ.edu','9879999084',10
--4.DELETE Procedures: Create stored procedure SP_DELETE_STUDENT to delete records from STUDENT where Student Name is Om Patel.
    CREATE OR ALTER PROC PR_DELETE_STUDENT
    @StudentName VARCHAR(50)
    AS
    BEGIN
        DELETE FROM STUDENT
        WHERE StuName = @StudentName
    END
    EXEC PR_DELETE_STUDENT 'Om Patel'
--5.SELECT BY PRIMARY KEY: Create stored procedures to select records by primary key (SP_SELECT_STUDENT_BY_ID) from Student table.
    CREATE OR ALTER PROC PR_SELECT_STUDENT_BY_ID
    @StuID INT
    AS
    BEGIN
        SELECT * FROM STUDENT
        WHERE StudentID = @StuID
    END
    EXEC PR_SELECT_STUDENT_BY_ID 5
--6.Create a stored procedure that shows details of the first 5 students ordered by EnrollmentYear.
    CREATE OR ALTER PROC PR_TOP_5_STUDENT
    AS
    BEGIN
        SELECT TOP 5 * FROM STUDENT
        ORDER BY StuEnrollmentYear
    END
    EXEC PR_TOP_5_STUDENT
--Part – B  
--7.Create a stored procedure which displays faculty designation-wise count.
    CREATE OR ALTER PROC PR_DISPLAY_FACULTY
    AS
    BEGIN
        SELECT FacultyDesignation,COUNT(*) AS DESIGNATIONCOUNT FROM FACULTY
        GROUP BY FacultyDesignation
    END
    EXEC PR_DISPLAY_FACULTY
--8.Create a stored procedure that takes department name as input and returns all students in that department.
    CREATE OR ALTER PROC PR_DEPARTMENT_STUDENT
    @DEPTSTU VARCHAR(20)
    AS
    BEGIN
        SELECT StuName FROM STUDENT
        WHERE StuDepartment = @DEPTSTU
    END
    EXEC PR_DEPARTMENT_STUDENT 'CSE'
--Part – C
--9.Create a stored procedure which displays department-wise maximum, minimum, and average credits of courses.
    CREATE OR ALTER PROC PR_COURSECREDIT_DEPARTMENT
    AS
    BEGIN
        SELECT CourseDepartment,
        MAX(CourseCredits) AS MAXCREDITS,
        MIN(CourseCredits) AS MINCREDITS,
        AVG(CourseCredits) AS AVGCREDITS
        FROM COURSE
        GROUP BY CourseDepartment
    END
    EXEC PR_COURSECREDIT_DEPARTMENT
--10.Create a stored procedure that accepts StudentID as parameter and returns all courses the student is enrolled in with their grades.
    CREATE OR ALTER PROC PR_ENROLLED_STUDENT
    @STUID INT
    AS
    BEGIN
        SELECT CourseName,Grade FROM STUDENT
        JOIN ENROLLMENT ON STUDENT.StudentID = ENROLLMENT.StudentID
        JOIN COURSE ON ENROLLMENT.CourseID = COURSE.CourseID
        WHERE STUDENT.StudentID = @STUID
    END
    EXEC PR_ENROLLED_STUDENT 3
