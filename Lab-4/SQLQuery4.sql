--Part-A
--1. Write a scalar function to print "Welcome to DBMS Lab".
     CREATE OR ALTER FUNCTION FN_WELCOME()
     RETURNS VARCHAR(50)
     BEGIN
         RETURN 'WELCOME TO DBMS LAB'
     END
     SELECT DBO.FN_WELCOME() AS MESSAGE
--2. Write a scalar function to calculate simple interest.
     CREATE OR ALTER FUNCTION FN_SIMPLEINTEREST
     (
        @P FLOAT,
        @R FLOAT,
        @T FLOAT
     )
     RETURNS FLOAT
     AS
     BEGIN
         RETURN (@P * @R * @T)/100
     END
     SELECT DBO.FN_SIMPLEINTEREST(10000,10,1.5) AS SIMPLEINTEREST
--3. Function to Get Difference in Days Between Two Given Dates
     CREATE OR ALTER FUNCTION FN_DATEDIFFRENCE
     (
         @DATE DATE,
         @NDATE DATE
     )
     RETURNS INT
     AS
     BEGIN
          RETURN DATEDIFF(DAY,@DATE,@NDATE)
     END
     SELECT DBO.FN_DATEDIFFRENCE('2024-05-1','2024-05-15') AS DATEDIFFRENCE
--4. Write a scalar function which returns the sum of Credits for two given CourseIDs.
     CREATE OR ALTER FUNCTION FN_SUMOFCREDITS
     (
        @CourseID1 VARCHAR(10),
        @CourseID2 VARCHAR(10)
     )
     RETURNS INT
     AS
     BEGIN
          DECLARE @Total INT;
          SELECT @Total = (SELECT CourseCredits FROM COURSE WHERE CourseID = @CourseID1) + (SELECT CourseCredits FROM COURSE WHERE CourseID = @CourseID2);
          RETURN @Total;
     END
     SELECT DBO.FN_SUMOFCREDITS('CS101','CS201') AS SUM_CREDIT
--5. Write a function to check whether the given number is ODD or EVEN.
     CREATE OR ALTER FUNCTION FN_ODD_EVEN
     (
        @N INT
     )
     RETURNS VARCHAR(20)
     AS
     BEGIN
        RETURN
            CASE
              WHEN @N%2 = 0 THEN 'EVEN'
              ELSE 'ODD'
            END
     END
     SELECT DBO.FN_ODD_EVEN(20) AS CHECKODDEVEN
--6. Write a function to print number from 1 to N. (Using while loop)
     CREATE OR ALTER FUNCTION FN_PRINTNUM
     (
       @N INT
     )
     RETURNS VARCHAR(MAX)
     AS
     BEGIN
         DECLARE @I INT = 1
         DECLARE @ANS VARCHAR(MAX) = ''
         WHILE @I <= @N
         BEGIN
              SET @ANS = @ANS + CAST(@I AS VARCHAR) + ' '
              SET @I = @I + 1
         END
         RETURN @ANS
     END
     SELECT DBO.FN_PRINTNUM(10) AS NUMS
--7. Write a scalar function to calculate factorial of total credits for a given CourseID.
     CREATE OR ALTER FUNCTION FN_FACTORIAL
     (
        @COURSEID VARCHAR(20)
     )
     RETURNS INT
     AS
     BEGIN
         DECLARE @COURSECREDITS INT;
         DECLARE @FACT INT = 1;
         DECLARE @I INT = 1;
         SELECT @COURSECREDITS = CourseCredits FROM COURSE WHERE CourseID = @COURSEID
         WHILE @I <= @COURSECREDITS
         BEGIN
             SET @FACT = @FACT*@I
             SET @I = @I + 1
         END
         RETURN @FACT
     END
     SELECT DBO.FN_FACTORIAL('CS101') AS FACTORIAL
--8. Write a scalar function to check whether a given EnrollmentYear is in the past, current or future (Case
--statement)
     CREATE OR ALTER FUNCTION FN_ENROLLMENTSTATUS
     (
        @ENROLLMENTYEAR INT
     )
     RETURNS VARCHAR(30)
     AS
     BEGIN
         RETURN
            CASE
              WHEN @ENROLLMENTYEAR < YEAR(GETDATE()) THEN 'PAST'
              WHEN @ENROLLMENTYEAR > YEAR(GETDATE()) THEN 'FUTURE'
              ELSE 'CURRENT'
            END
     END
     SELECT DBO.FN_ENROLLMENTSTATUS(2026) AS ENROLLMENTSTATUS
--9. Write a table-valued function that returns details of students whose names start with a given letter.
     CREATE OR ALTER FUNCTION FN_STUDENTNAME
     (
        @STUDENTLETTER CHAR(1)
     )
     RETURNS TABLE
     AS
     RETURN (SELECT * FROM STUDENT WHERE StuName LIKE @STUDENTLETTER + '%')
     SELECT * FROM FN_STUDENTNAME('R')
--10. Write a table-valued function that returns unique department names from the STUDENT table.
     CREATE OR ALTER FUNCTION FN_UNIQUEDEPARTMENT()
     RETURNS TABLE
     AS
     RETURN (SELECT DISTINCT StuDepartment FROM STUDENT)
     SELECT * FROM FN_UNIQUEDEPARTMENT()
--Part-B
--11. Write a scalar function that calculates age in years given a DateOfBirth.
      CREATE OR ALTER FUNCTION FN_CALCULATEAGE
      (
         @DATEOFBIRTH VARCHAR(20)
      )
      RETURNS INT
      AS
      BEGIN
          RETURN DATEDIFF(YEAR,@DATEOFBIRTH,GETDATE())
      END
      SELECT DBO.FN_CALCULATEAGE('2007-01-13') AS DATEOFBIRTH
--12. Write a scalar function to check whether given number is palindrome or not.
      CREATE OR ALTER FUNCTION FN_PALINDROME
      (
         @N INT
      )
      RETURNS VARCHAR(20)
      AS
      BEGIN
           DECLARE @REM INT
           DECLARE @REV INT = 0
           DECLARE @NUM INT = @N
           WHILE @NUM != 0
           BEGIN
               SET @REM = @NUM%10
               SET @REV = @REV*10 + @REM
               SET @NUM=@NUM/10
           END
           RETURN 
             CASE
               WHEN @REV=@N THEN 'PALINDROME'
               ELSE 'NOT PALINDROME'
             END
      END
      SELECT DBO.FN_PALINDROME(121) AS CHECKPALINDROME
--13. Write a scalar function to calculate the sum of Credits for all courses in the 'CSE' department.
      CREATE OR ALTER FUNCTION FN_DEP_SUMOFCREDITS()
      RETURNS INT
      AS
      BEGIN
          RETURN (SELECT SUM(CourseCredits) FROM COURSE WHERE CourseDepartment='CSE')
      END
      SELECT DBO.FN_DEP_SUMOFCREDITS() AS SUMOFCREDITS
--14. Write a table-valued function that returns all courses taught by faculty with a specific designation.
      CREATE OR ALTER FUNCTION FN_COURSEDESIGNATION
      (
        @DESIGNATION VARCHAR(20)
      )
      RETURNS TABLE
      AS
      RETURN (SELECT CourseName,FacultyDesignation FROM COURSE JOIN COURSE_ASSIGNMENT ON COURSE.CourseID = COURSE_ASSIGNMENT.CourseID
           JOIN FACULTY ON COURSE_ASSIGNMENT.FacultyID = FACULTY.FacultyID WHERE FacultyDesignation = @DESIGNATION)
      SELECT * FROM FN_COURSEDESIGNATION('Professor') AS COURSENAME_DESIGNATION
--Part - C
--15. Write a scalar function that accepts StudentID and returns their total enrolled credits (sum of credits
--from all active enrollments).
      CREATE OR ALTER FUNCTION FN_ACTIVE_SUMOFCREDITS
      (
        @STUDENTID INT
      )
      RETURNS INT
      AS
      BEGIN
          RETURN (SELECT SUM(CourseCredits) FROM COURSE JOIN ENROLLMENT 
          ON COURSE.CourseID = ENROLLMENT.CourseID 
          WHERE StudentID = @STUDENTID AND EnrollmentStatus = 'Active')
      END
      SELECT DBO.FN_ACTIVE_SUMOFCREDITS(1) AS SUMOFCREDITS
--16. Write a scalar function that accepts two dates (joining date range) and returns the count of faculty who
--joined in that period.
      CREATE OR ALTER FUNCTION FN_COUNTFACULTY
      (
        @DATE1 DATE,
        @DATE2 DATE
      )
      RETURNS INT
      AS
      BEGIN
         RETURN (SELECT COUNT(*) FROM FACULTY
                 WHERE FacutyJoiningDate >= @DATE1 AND FacutyJoiningDate <= @DATE2)
      END
      SELECT DBO.FN_COUNTFACULTY('2012-1-1','2019-12-31') AS FACULTYCOUNT