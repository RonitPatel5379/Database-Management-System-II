--Table : Log(LogMessage varchar(100), logDate Datetime)
CREATE TABLE LOG(
	LOGMESSAGE VARCHAR(100),
	LOGDATE DATETIME
)
SELECT * FROM STUDENT
SELECT * FROM FACULTY
--Part – A
--1.Create trigger for printing appropriate message after student registration.
    GO
	CREATE OR ALTER TRIGGER TRIG_STU_REGISTRATION 
	ON STUDENT
	AFTER INSERT
	AS
	BEGIN
		PRINT 'STUDENT REGISTERED'
	END
	INSERT INTO STUDENT VALUES(11,'RONIT BHADANIA','ronit@univ.edu','8190256374','CSE','2006-05-7',2024,NULL)
--2.Create trigger for printing appropriate message after faculty deletion.
    GO
	CREATE OR ALTER TRIGGER TRIG_FACULTY_DELETE
	ON FACULTY
	AFTER DELETE
	AS
	BEGIN
		PRINT 'FACULTY DELETED'
	END
	INSERT INTO FACULTY VALUES(108,'DR.PUJ','puj@univ.edu','CSE','Professor','2008-07-01')
	DELETE FROM FACULTY WHERE FacultyID=108
--3.Create trigger for monitoring all events on course table. (print only appropriate message)
	GO
	CREATE OR ALTER TRIGGER TRIG_COURSE_EVENT
	ON COURSE
	AFTER INSERT,UPDATE,DELETE
	AS
	BEGIN
		PRINT 'COURSE MODIFIED'
	END
	INSERT INTO COURSE VALUES('CS401','DATABASE MANAGEMENT SYSTEM-II',4,'CSE',4)
	UPDATE COURSE SET CourseName='DBMS-II' WHERE CourseID='CS401'
	DELETE FROM COURSE WHERE CourseID='CS401'
--4.Create trigger for logging data on new student registration in Log table.
	GO
	CREATE OR ALTER TRIGGER TRIG_STU_REGS_LOG
	ON STUDENT
	AFTER INSERT
	AS
	BEGIN
		INSERT INTO LOG VALUES ('NEW STUDENT REGISTERED',GETDATE())
	END
--5.Create trigger for auto-uppercasing faculty names.
	GO
	CREATE OR ALTER TRIGGER TRIG_FAC_NAME_UPPER
	ON FACULTY
	AFTER INSERT
	AS
	BEGIN
		UPDATE FACULTY SET FacultyName=UPPER(FacultyName)
		WHERE FacultyID IN (SELECT FacultyID FROM inserted)
	END
	
--6.Create trigger for calculating faculty experience (Note: Add required column in faculty table)
	ALTER TABLE Faculty ADD Experience INT
    GO
	CREATE OR ALTER TRIGGER TRIG_FAC_EXP
	ON FACULTY
	AFTER INSERT
	AS
	BEGIN
		UPDATE FACULTY SET Experience = DATEDIFF(YEAR,FacutyJoiningDate,GETDATE())
		WHERE FacultyID IN (SELECT FacultyID FROM inserted)
	END
--Part – B
--7.Create trigger for auto-stamping enrollment dates.
	GO
	CREATE OR ALTER TRIGGER TRIG_ENROLLMENT_DATE
	ON ENROLLMENT
	AFTER INSERT
	AS
	BEGIN
		UPDATE ENROLLMENT SET EnrollmentDate = GETDATE()
		WHERE EnrollmentID IN (SELECT EnrollmentID FROM inserted)
	END
--8.Create trigger for logging data After course assignment - log course and faculty detail.
	GO
	CREATE OR ALTER TRIGGER TRIG_COURSE_ASSIGNMENT_LOG
	ON COURSE_ASSIGNMENT
	AFTER INSERT
	AS
	BEGIN
		INSERT INTO LOG VALUES ('COURSE ASSIGNED TO FACULTY',GETDATE())
	END
--Part - C
--9.Create trigger for updating student phone and print the old and new phone number.
	GO
	CREATE OR ALTER TRIGGER TRIG_STU_PHONE_UPDATE
	ON STUDENT
	AFTER UPDATE
	AS
	BEGIN
		DECLARE @OLDPHONE VARCHAR(15),@NEWPHONE VARCHAR(15)
		SELECT @OLDPHONE = StuPhone FROM deleted
		SELECT @NEWPHONE = StuPhone FROM inserted
		PRINT 'PHONE CHANGED FROM ' + @OLDPHONE + ' TO ' + @NEWPHONE
	END
--10.Create trigger for updating course credit log old and new credits in log table.
	GO
	CREATE OR ALTER TRIGGER TRIG_COURSE_CREDITS
	ON COURSE
	AFTER UPDATE
	AS
	BEGIN
		INSERT INTO LOG VALUES ('COURSE CREDIT UPDATED',GETDATE())
	END