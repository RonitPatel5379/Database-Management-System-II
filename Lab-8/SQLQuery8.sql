--Part – A
SELECT * FROM STUDENT
SELECT * FROM ENROLLMENT
SELECT * FROM FACULTY
--1.Handle Divide by Zero Error and Print message like: Error occurs that is - Divide by zero error.
    BEGIN TRY
        DECLARE @A INT = 10
        DECLARE @B INT = 0
        DECLARE @RESULT INT

        SET @RESULT = @A/@B

        PRINT 'RESULT = ' + CAST(@RESULT AS VARCHAR)
    END TRY
    BEGIN CATCH
        PRINT 'Error occurs that is - Divide by zero error.'
    END CATCH
--2.Try to convert string to integer and handle the error using try…catch block.
    BEGIN TRY
        DECLARE @NUM INT
        DECLARE @STR VARCHAR(10) = 'RONIT'

        SET @NUM = CAST(@STR AS INT)
        PRINT 'CONVERTED NUMBER = ' + CAST(@NUM AS VARCHAR)
    END TRY
    BEGIN CATCH
        PRINT 'Error: Cannot convert string to integer.'
        PRINT ERROR_MESSAGE()
    END CATCH
--3.Create a procedure that prints the sum of two numbers: take both numbers as integer & handle exception with all error functions if any one enters string value in numbers otherwise print result.
    CREATE OR ALTER PROC ADDNUMBERS
        @NUM1 VARCHAR(20),
        @NUM2 VARCHAR(20)
    AS
    BEGIN
        BEGIN TRY
            DECLARE @A INT
            DECLARE @B INT
            DECLARE @SUM INT

            SET @A = CAST(@NUM1 AS INT)
            SET @B = CAST(@NUM2 AS INT)

            SET @SUM = @A + @B

            PRINT 'SUM = ' + CAST(@SUM AS VARCHAR)
        END TRY
        BEGIN CATCH
            PRINT 'Error Message: ' + ERROR_MESSAGE()
            PRINT 'Error Number: ' + CAST(ERROR_NUMBER() AS VARCHAR)
            PRINT 'Severity: ' + CAST(ERROR_SEVERITY() AS VARCHAR)
            PRINT 'State: ' + CAST(ERROR_STATE() AS VARCHAR)
        END CATCH
    END
    EXEC ADDNUMBERS 10,'13'
--4.Handle a Primary Key Violation while inserting data into student table and print the error details such as the error message, error number, severity, and state.
    BEGIN TRY
        INSERT INTO STUDENT VALUES (10,'Ronit Bhadania','ronit@gmail.com','2222222222','CSE','2007-06-23',2024,NULL)
    END TRY
    BEGIN CATCH
        PRINT 'Error Message: ' + ERROR_MESSAGE()
        PRINT 'Error Number: ' + CAST(ERROR_NUMBER() AS VARCHAR)
        PRINT 'Severity: ' + CAST(ERROR_SEVERITY() AS VARCHAR)
        PRINT 'State: ' + CAST(ERROR_STATE() AS VARCHAR)
    END CATCH
--5.Throw custom exception using stored procedure which accepts StudentID as input & that throws Error like no StudentID is available in database.
    CREATE OR ALTER PROC CHECKSTUDENT
        @STUDENTID INT
    AS
    BEGIN
        IF NOT EXISTS (SELECT * FROM STUDENT WHERE StudentID = @STUDENTID)
        BEGIN
            THROW 50001,'NO STUDENT IS AVAILABLE IN DATABASE',1
        END
        ELSE
        BEGIN
            PRINT 'STUDENT EXISTS'
        END
    END
    EXEC CHECKSTUDENT 23
--6.Handle a Foreign Key Violation while inserting data into Enrollment table and print appropriate error message.
    BEGIN TRY
        INSERT INTO ENROLLMENT VALUES ('4','CS1','2022-07-01','A','Completed') 
    END TRY
    BEGIN CATCH
        PRINT 'Foreign Key Error Occurred'
        PRINT 'Error Message: ' + ERROR_MESSAGE()
    END CATCH
--Part – B

--7.Handle Invalid Date Format
    BEGIN TRY
        DECLARE @DATE DATE
        SET @DATE = CAST('32-15-2026' AS DATE)
    END TRY
    BEGIN CATCH
        PRINT 'Invalid Date Format'
        PRINT ERROR_MESSAGE()
    END CATCH
--8.Procedure to Update faculty’s Email with Error Handling.
    CREATE OR ALTER PROC UPDATE_FACULTY_EMAIL
        @FACULTYID INT,
        @EMAIL VARCHAR(100)
    AS
    BEGIN
        BEGIN TRY
            UPDATE FACULTY SET FacultyEmail = @EMAIL WHERE FacultyID = @FACULTYID

            IF @@ROWCOUNT=0
            BEGIN
                PRINT 'FACULTY NOT FOUND'
            END
            ELSE
            BEGIN
                PRINT 'EMAIL UPDATED SUCCESSFULLY'
            END
        END TRY
        BEGIN CATCH 
            PRINT 'ERROR MESSAGE: ' + ERROR_MESSAGE()
        END CATCH
    END
    EXEC UPDATE_FACULTY_EMAIL 107,'nair@gmail.com'
--9.Throw custom exception that throws error if the data is invalid.
    CREATE OR ALTER PROC VALIDATEMARKS
        @MARKS INT
    AS
    BEGIN
        IF @MARKS < 0 OR @MARKS > 100
        BEGIN
            THROW 50002,'INVALID MARKS',1
        END
        ELSE
        BEGIN
            PRINT 'VALID MARKS'
        END
    END
    EXEC VALIDATEMARKS 105
--Part – C

--10.Write a script that checks if a faculty’s salary is NULL. If it is, use RAISERROR to show a message with a severity of 16. (Note: Do not use any table)
     DECLARE @SALARY INT
     SET @SALARY = NULL

     IF @SALARY IS NULL
     BEGIN
        RAISERROR('FACULTY SALARY CANNOT BE NULL',16,1)
     END
     ELSE
     BEGIN
        PRINT 'SALARY = ' + CAST(@SALARY AS VARCHAR) 
     END