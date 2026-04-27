--Part – A 
--1. Create a stored procedure that accepts a date and returns all faculty members who joined on that date.
     CREATE OR ALTER PROC PR_FACULTY
     @DATE DATE
     AS
     BEGIN
          SELECT FacultyName FROM FACULTY
          WHERE FacutyJoiningDate = @DATE
     END
     EXEC PR_FACULTY '2015-06-10'
--2. Create a stored procedure for ENROLLMENT table where user enters either StudentID or CourseID returns EnrollmentID, EnrollmentDate, Grade, and Status.
     CREATE OR ALTER PROC PR_ENROLLMENT
     @STUDENTID INT = NULL,
     @COURSEID VARCHAR(20) = NULL
     AS
     BEGIN
         SELECT EnrollmentID,EnrollmentDate,Grade,EnrollmentStatus 
         FROM ENROLLMENT
         WHERE StudentID = @STUDENTID OR CourseID = @COURSEID
     END
     EXEC PR_ENROLLMENT 3
--3. Create a stored procedure that accepts two integers (min and max credits) and returns all courses whose credits fall between these values.
     CREATE OR ALTER PROC PR_COURSE
     @CREDIT_MIN INT = NULL,
     @CREDIT_MAX INT = NULL
     AS
     BEGIN
         SELECT  DISTINCT CourseName FROM COURSE
         WHERE CourseCredits>@CREDIT_MIN AND CourseCredits<@CREDIT_MAX
     END
     EXEC PR_COURSE 1,4
--4. Create a stored procedure that accepts Course Name and returns the list of students enrolled in that course.
     CREATE OR ALTER PROC PR_STUDENT_LIST
     @COURSENAME VARCHAR(50) = NULL
     AS
     BEGIN
         SELECT StuName FROM STUDENT
         JOIN ENROLLMENT
         ON STUDENT.StudentID = ENROLLMENT.StudentID
         JOIN COURSE 
         ON ENROLLMENT.CourseID = COURSE.CourseID
         WHERE CourseName = @COURSENAME
     END
     EXEC PR_STUDENT_LIST 'Database Management Systems'
--5. Create a stored procedure that accepts Faculty Name and returns all course assignments.
     CREATE OR ALTER PROC PR_COURSE_ASSIGNMENT
     @FACULTYNAME VARCHAR(50) = NULL
     AS
     BEGIN
         SELECT CourseName FROM COURSE
         JOIN COURSE_ASSIGNMENT
         ON COURSE.CourseID = COURSE_ASSIGNMENT.CourseID
         JOIN FACULTY
         ON FACULTY.FacultyID = COURSE_ASSIGNMENT.FacultyID
         WHERE FacultyName = @FACULTYNAME
     END
     EXEC PR_COURSE_ASSIGNMENT 'DR. SHETH'
--6. Create a stored procedure that accepts Semester number and Year, and returns all course assignments with faculty and classroom details.
     CREATE OR ALTER PROC PR_SEMESTER_YEAR
     @SEMESTER INT = NULL,
     @YEAR INT = NULL
     AS
     BEGIN
         SELECT CourseName,FacultyName,ClassRoom FROM COURSE
         JOIN COURSE_ASSIGNMENT
         ON COURSE.CourseID = COURSE_ASSIGNMENT.CourseID
         JOIN FACULTY
         ON FACULTY.FacultyID = COURSE_ASSIGNMENT.FacultyID
         WHERE Semester = @SEMESTER AND Year = @YEAR
     END
     EXEC PR_SEMESTER_YEAR 3,2024
--Part – B 
--7. Create a stored procedure that accepts the first letter of Status ('A', 'C', 'D') and returns enrollment details.
     CREATE OR ALTER PROC PR_FIRST_LETTER
     @LETTER CHAR(1) = NULL
     AS
     BEGIN
         SELECT * FROM ENROLLMENT
         WHERE EnrollmentStatus LIKE @LETTER + '%'
     END
     EXEC PR_FIRST_LETTER 'C'
--8. Create a stored procedure that accepts either Student Name OR Department Name and returns student data accordingly.
     CREATE OR ALTER PROC PR_STUDENT_DETAILS
     @STUDENTNAME VARCHAR(50) = NULL,
     @STUDENTDEPARTMENT VARCHAR(50) = NULL
     AS
     BEGIN
         SELECT * FROM STUDENT
         WHERE StuName = @STUDENTNAME OR StuDepartment = @STUDENTDEPARTMENT
     END
     EXEC PR_STUDENT_DETAILS NULL,'CSE'
--9. Create a stored procedure that accepts CourseID and returns all students enrolled grouped by enrollment status with counts.
     CREATE OR ALTER PROC PR_ENROLLED_STUDENT
     @COURSEID VARCHAR(20) = NULL
     AS
     BEGIN
         SELECT StuName FROM STUDENT
         JOIN ENROLLMENT
         ON STUDENT.StudentID = ENROLLMENT.StudentID
         GROUP BY EnrollmentStatus
     END
     EXEC PR_ENROLLED_STUDENT 'CS101'
--Part – C 
--10.Create a stored procedure that accepts a year as input and returns all courses assigned to faculty in that year with classroom details.
     CREATE OR ALTER PROC PR_COURSEASSIGNED_FACULTY
     @YEAR INT
     AS
     BEGIN
        SELECT CourseName,FacultyName,Year,ClassRoom FROM COURSE_ASSIGNMENT
        JOIN COURSE
        ON COURSE_ASSIGNMENT.CourseID = COURSE.CourseID
        JOIN FACULTY
        ON COURSE_ASSIGNMENT.FacultyID = FACULTY.FacultyID
     END
     EXEC PR_COURSEASSIGNED_FACULTY 2024
--11.Create a stored procedure that accepts From Date and To Date and returns all enrollments within that range with student and course details.
     CREATE OR ALTER PROC PR_ENROLLMENT_RANGE
     @STARTDATE DATE,
     @ENDDATE DATE
     AS
     BEGIN
         SELECT StuName,CourseName,EnrollmentDate,EnrollmentStatus FROM STUDENT
         JOIN ENROLLMENT
         ON STUDENT.StudentID = ENROLLMENT.StudentID
         JOIN COURSE
         ON ENROLLMENT.CourseID = COURSE.CourseID
         WHERE EnrollmentDate BETWEEN @STARTDATE AND @ENDDATE
     END
     EXEC PR_ENROLLMENT_RANGE '2021-01-01','2022-12-31'
--12.Create a stored procedure that accepts FacultyID and calculates their total teaching load (sum of credits of all courses assigned).
     CREATE OR ALTER PROCEDURE PR_FACULTY_TEACHINGLOAD
     @FID INT
     AS
     BEGIN
	     SELECT FacultyName,SUM(CourseCredits) AS [TOTAL TEACHING LOAD]
	     FROM COURSE_ASSIGNMENT  JOIN COURSE 
	     ON COURSE_ASSIGNMENT.CourseID = COURSE.CourseID
	     JOIN FACULTY
	     ON COURSE_ASSIGNMENT.FacultyID = FACULTY.FacultyID
	     WHERE FACULTY.FacultyID = @FID
	     GROUP BY FacultyName
     END
     EXEC PR_FACULTY_TEACHINGLOAD 102
