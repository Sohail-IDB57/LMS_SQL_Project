/*
					SQL Project Name : Learning Management System(LMS)
							      By : Sohail Ahmad   

 --------------------------------------------------------------------------------

Table of Contents: DDL
			=> SECTION 01: Created a Database [LMS]
			=> SECTION 02: Created Appropriate Tables with column definition related to the project
			=> SECTION 03: ALTER, DROP AND MODIFY TABLES & COLUMNS
			=> SECTION 04: CREATE CLUSTERED AND NONCLUSTERED INDEX
			=> SECTION 05: CREATE SEQUENCE & ALTER SEQUENCE
			=> SECTION 06: CREATE A VIEW & ALTER VIEW
			=> SECTION 07: CREATE STORED PROCEDURE 
			=> SECTION 08: CREATE FUNCTION(SCALAR, SIMPLE TABLE VALUED, MULTISTATEMENT TABLE VALUED) 
			=> SECTION 09: CREATE TRIGGER (FOR/AFTER TRIGGER)
			=> SECTION 10: CREATE TRIGGER (INSTEAD OF TRIGGER)
*/

/*
==============================  SECTION 01  ==============================
			CHECK DATABASE EXISTANCE & CREATE COUSTOM DATABASE 
==========================================================================
*/
use master
	if DB_ID('LearningManagementSystemDB') is not null
	drop database LearningManagementSystemDB
	go

declare @data_path nvarchar(256)
	set @data_path= (select substring(physical_name,1, charindex(N'master.mdf', lower(physical_name))-1)
	from master.sys.master_files
	where database_id=1 and file_id=1);
	execute ('create database LearningManagementSystemDB
	on primary(name=LearningManagementSystemDB_data, filename='''+
	@data_path+'LearningManagementSystemDB_data.mdf'',size= 10MB, maxsize=unlimited,filegrowth=2MB)
	log on (name=LearningManagementSystemDB_log, filename='''+
	@data_path+'LearningManagementSystemDB_data.ldf'',size= 10MB, maxsize=100MB,filegrowth=1MB)'
);
go

use LearningManagementSystemDB
go
/*
==============================  SECTION 02  ==============================
		          CREATE TABLES WITH COLUMN DEFINITION 
==========================================================================
*/
--===== Create the SCHEMA =====--

CREATE SCHEMA LMS;
go
--===== Create the Courses table =====--
CREATE TABLE Courses (
    CourseID INT PRIMARY KEY IDENTITY(101, 1),
    CourseName NVARCHAR(100) NOT NULL,
    Category NVARCHAR(50) CHECK (Category IN ('Basic', 'Advanced', 'Diploma')),
    Duration VARCHAR(20) CHECK (Duration IN ('3 MONTH', '6 MONTH', '12 MONTH')),
    CourseFee SMALLMONEY NOT NULL CHECK (CourseFee > 0)   
);
go
--===== Create the Branches table =====--
CREATE TABLE LMS.Branches (
    BranchID INT PRIMARY KEY IDENTITY(101,1),
    BranchNo VARCHAR(50) NOT NULL DEFAULT CAST(NEWID() AS VARCHAR(50)),
    BranchName VARCHAR(50) NOT NULL,
    BranchAddress VARCHAR(100) NOT NULL,
    CONSTRAINT UQ_Branch UNIQUE(BranchName, BranchAddress) -- Ensure unique BranchName and BrunchAddress combinations
);
go
--===== Create the Employees table =====--
CREATE TABLE LMS.Employees (
    EmployeeID INT PRIMARY KEY IDENTITY(101,1),
	EmployeeCode AS ('#' + LEFT(CONVERT(VARCHAR(10), EmployeeID), 7) + '_' + RIGHT(CONVERT(VARCHAR(10), Position ), 10)),
    EmployeeName VARCHAR(25),
    Position VARCHAR(255),
    Salary MONEY NOT NULL,
	Photo VARBINARY(MAX),
    DateOfBirth DATE NOT NULL,
	Address NVARCHAR(255),
    Phone VARCHAR(30) NOT NULL CHECK (LEN(Phone) = 11 AND ISNUMERIC(Phone) = 1 AND Phone LIKE '01%'),
);
go

--===== Create the Trainer table =====--
CREATE TABLE LMS.Trainers (
    TrainerID INT PRIMARY KEY IDENTITY(201,1),
    EmployeeID INT NOT NULL,
    Specialty VARCHAR(50) NOT NULL,
    FOREIGN KEY (EmployeeID) REFERENCES LMS.Employees(EmployeeID),   
);
go
--===== Create the Batches table with show AvailableSeats in batch =====--
CREATE TABLE LMS.Batches (
    BatchID INT PRIMARY KEY IDENTITY(1,1),
	BatchNo INT,  
	BatchName AS (LEFT('0' + CAST(BatchID AS VARCHAR(2)), 4)+'/'+ Right(CAST(BranchID AS VARCHAR(2)), 4)+'/'+Right(CAST(Schedule AS VARCHAR(2)), 1)),
    Schedule VARCHAR(10) NOT NULL CHECK (Schedule IN ('Morning', 'Afternoon')),
	StartDate DATE NOT NULL,
	EndDate DATE NOT NULL,
	Seat INT NOT NULL,
	[YEAR] INT NOT NULL,
	MaxSeats INT NOT NULL,
    AvailableSeats INT,
	CourseID INT NOT NULL,
	BranchId INT REFERENCES LMS.Branches(BranchId),
    FOREIGN KEY (CourseID) REFERENCES Courses(CourseID)  
);
go

--===== Create the Students table =====--
CREATE TABLE LMS.Students (
    StudentID INT PRIMARY KEY IDENTITY (101,1),
    StudentCode AS ('#' + LEFT(CONVERT(VARCHAR(10), StudentID), 4) + '_' + RIGHT(CONVERT(VARCHAR(4), DateOfBirth, 112), 4)),
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50),
    FatherName VARCHAR(30) NOT NULL,
    Photo VARBINARY(100),
    DateOfBirth DATE NOT NULL,
    Email NVARCHAR(100) UNIQUE CONSTRAINT ck_emailCheck CHECK (email LIKE '%@%' ),
	Gender VARCHAR (10) NOT NULL CHECK (Gender IN ('Male', 'Female', 'Other')),
	Region VARCHAR (10) NOT NULL,
    PhoneNo NCHAR(11) NOT NULL CHECK (LEN(PhoneNo) = 11 AND ISNUMERIC(PhoneNo) = 1 AND PhoneNo LIKE '01%'),
    [Address] NVARCHAR(255),
);
go
	
--===== Create the TrainerBatches table =====--
CREATE TABLE LMS.TrainerBatches (
    TrainerBatchID INT PRIMARY KEY IDENTITY(1,1),
    TrainerID INT,
    BatchID INT,
    CONSTRAINT FK_TrainerBatch_TrainerID FOREIGN KEY (TrainerID) REFERENCES LMS.Trainers(TrainerID),
    CONSTRAINT FK_TrainerBatch_BatchID FOREIGN KEY (BatchID) REFERENCES LMS.Batches(BatchID)
);
go
--===== Create Enrollment Table with CONSTRAINT =====--
CREATE TABLE LMS.Enrollments (
    EnrollmentID INT IDENTITY(1,1),
    StudentID INT NOT NULL,
    BatchID INT NOT NULL,
	CourseID INT NOT NULL,
    EnrollmentDate DATE NOT NULL,
	TotalCourseFee DECIMAL(10, 0) NOT NULL,
	Scholarship DECIMAL(10, 0) NULL DEFAULT 0,
	NetTotalFee AS (TotalCourseFee - COALESCE(Scholarship, 0)),
    CONSTRAINT FK_Student_Enrollment FOREIGN KEY (StudentID) REFERENCES LMS.Students(StudentID),
    CONSTRAINT FK_Batch_Enrollment FOREIGN KEY (BatchID) REFERENCES LMS.Batches(BatchID),
    CONSTRAINT FK_Course_Enrollment FOREIGN KEY (CourseID) REFERENCES Courses(CourseID),
    CONSTRAINT CHK_EnrollmentDate CHECK (EnrollmentDate >= (SELECT MIN(StartDate) FROM LMS.Batches)), -- Enrollment date after batch start
    CONSTRAINT CHK_NoDuplicateEnrollment UNIQUE (StudentID, BatchID), -- No duplicate enrollment for a student in a batch
);
go
--===== CREATE TABLE Payment =====--
CREATE TABLE LMS.Payments (
    PaymentID INT PRIMARY KEY IDENTITY(601, 1),
    StudentID INT NOT NULL,
    BatchID INT NOT NULL,
    Amount DECIMAL(10, 0) NOT NULL,
	PaymentDate Date NOT NULL,
    CONSTRAINT FK_Student_Income FOREIGN KEY (StudentID) REFERENCES LMS.Students(StudentID),
    CONSTRAINT FK_Batch_Income FOREIGN KEY (BatchID) REFERENCES LMS.Batches(BatchID)
);
--===== Attendance Table =====--
CREATE TABLE LMS.Attendance (
    AttendanceID INT PRIMARY KEY IDENTITY(401, 1),
    StudentID INT NOT NULL,
    BatchID INT NOT NULL,
    AttendanceDate DATE NOT NULL,
    IsPresent BIT NOT NULL,
    CONSTRAINT FK_AttendanceStudent FOREIGN KEY (StudentID) REFERENCES LMS.Students(StudentID),
    CONSTRAINT FK_AttendanceBatch FOREIGN KEY (BatchID) REFERENCES LMS.Batches(BatchID)
);
go
--===== Exams Table =====--
CREATE TABLE LMS.Exams (
    ExamID INT PRIMARY KEY IDENTITY(501, 1),
    BatchID INT NOT NULL,
    ExamDate DATE NOT NULL,
    Score INT NOT NULL,
    CONSTRAINT FK_ExamBatch FOREIGN KEY (BatchID) REFERENCES LMS.Batches(BatchID)
);
go
--===== Create the Certificates table =====--
CREATE TABLE LMS.[Certificates] (
    CertificateID INT PRIMARY KEY,
    StudentID INT NOT NULL,
    CourseID INT NOT NULL,
    CertificateName VARCHAR(100) NOT NULL,
    IssueDate DATE NOT NULL,
    FOREIGN KEY (StudentID) REFERENCES LMS.Students(StudentID),
    FOREIGN KEY (CourseID) REFERENCES Courses(CourseID)
);
go

go
--===== CREATE TABLE Expenses =====--
CREATE TABLE LMS.Expenses (
    ExpenseID INT PRIMARY KEY IDENTITY(701, 1),
    ExpenseType VARCHAR(100) NOT NULL,
    Amount DECIMAL(10, 0),
    ExpenseDate DATE NOT NULL
    CONSTRAINT CK_ExpenseAmount CHECK (Amount >= 0)
);
go
--===== CREATE TABLE Materials =====--
CREATE TABLE LMS.Materials (
    MaterialID INT PRIMARY KEY IDENTITY(101,1),
    MaterialName VARCHAR(100) NOT NULL,
	Quantity int NOT NULL CHECK (Quantity > 0)
);
go
--===== CREATE TABLE MaterialPurchases =====--
CREATE TABLE MaterialPurchases (
    MaterialPurchaseID INT PRIMARY KEY IDENTITY(201,1),
    MaterialID INT REFERENCES LMS.Materials(MaterialID),
    PurchaseDate DATE NOT NULL,
    PurchaseQuantity INT NOT NULL,
    UnitPrice DECIMAL(10, 2) NOT NULL,
    TotalPrice AS (PurchaseQuantity * UnitPrice), -- Computed column for total price
    CONSTRAINT CHK_Quantity CHECK (PurchaseQuantity > 0),
    CONSTRAINT CHK_UnitPrice CHECK (UnitPrice >= 0),
    CONSTRAINT CHK_TotalPrice CHECK (TotalPrice >= 0)
);
go
--===== CREATE TABLE MaterialStatus =====--
CREATE TABLE LMS.MaterialStatus (
    StatusID INT PRIMARY KEY IDENTITY(1,1),
    StatusName VARCHAR(20) NOT NULL CHECK (StatusName IN ('Use', 'Repiar', 'Damage')),
    Description NVARCHAR(255),
	StatusQuantity int NOT NULL CHECK (StatusQuantity > 0),
	MaterialID INT REFERENCES LMS.Materials(MaterialID) 
);
go
--===== Feedback/Ratings Table =====--
CREATE TABLE LMS.FeedbackRatings (
    FeedbackID INT PRIMARY KEY IDENTITY(801, 1),
    StudentID INT NOT NULL,
    CourseID INT NOT NULL,
    TrainerID INT NOT NULL,
    Rating INT CHECK (Rating >= 1 AND Rating <= 5),
    FeedbackText NVARCHAR(MAX),
    FeedbackDate DATE,
    CONSTRAINT FK_Student_FeedbackRatings FOREIGN KEY (StudentID) REFERENCES LMS.Students(StudentID),
    CONSTRAINT FK_Course_FeedbackRatings FOREIGN KEY (CourseID) REFERENCES Courses(CourseID),
    CONSTRAINT FK_Trainer_FeedbackRatings FOREIGN KEY (TrainerID) REFERENCES LMS.Trainers(TrainerID)
);
go
--===== Project Submissions Table =====--
CREATE TABLE LMS.ProjectSubmissions (
    SubmissionID INT PRIMARY KEY IDENTITY(901, 1),
    StudentID INT NOT NULL,
    BatchID INT NOT NULL,
    ProjectTitle NVARCHAR(100) NOT NULL,
    SubmissionDate DATE,
    SubmissionFile VARBINARY(MAX),
    CONSTRAINT FK_Student_ProjectSubmissions FOREIGN KEY (StudentID) REFERENCES LMS.Students(StudentID),
    CONSTRAINT FK_Batch_ProjectSubmissions FOREIGN KEY (BatchID) REFERENCES LMS.Batches(BatchID)
);
go
--===== Resources Inventory Table =====--
CREATE TABLE ResourcesInventory (
    ResourceID INT PRIMARY KEY IDENTITY(1201, 1),
    ResourceName VARCHAR(100) NOT NULL,
    Quantity INT,
    Location VARCHAR(50),
    ResourceType VARCHAR(50),
    CONSTRAINT UQ_ResourceName UNIQUE(ResourceName)
);
go
/*
==============================  SECTION 03  ==============================
		          ALTER, DROP AND MODIFY TABLES & COLUMNS
==========================================================================
*/
--============== ALTER DATABASE ============--
	ALTER DATABASE LearningManagementSystemDB modify file(name='LearningManagementSystemDB_data',size=20MB,maxsize=unlimited,filegrowth=5%);
	go
--============== ALTER SCHEMA ============--
	ALTER SCHEMA LMS TRANSFER dbo.Courses;
	go
--============== ALTER TABLE ============--
	ALTER TABLE Courses
	ADD Description NVARCHAR(MAX);

	ALTER TABLE LMS.Employees
	ADD IsActive BIT NOT NULL DEFAULT 1;

	ALTER TABLE LMS.Batches
	ADD Status NVARCHAR(20) NOT NULL DEFAULT 'Upcoming';

	ALTER TABLE LMS.ProjectSubmissions
	ADD SubmissionStatus NVARCHAR(20) NOT NULL DEFAULT 'Pending';

	ALTER TABLE LMS.Materials
	ADD PurchaseDate DATE;
	go

--============== ALTER CONSTRAINT ============--
	ALTER TABLE LMS.TrainerBatches
	ADD CONSTRAINT PK_TrainerBatches PRIMARY KEY (TrainerID, BatchID);

	ALTER TABLE LMS.Enrollments
	ADD CONSTRAINT CHK_SameBatchSchedule CHECK (
        NOT EXISTS (
            SELECT 1
            FROM LMS.Enrollments e
            INNER JOIN LMS.Batches b ON e.BatchID = b.BatchID
            WHERE e.StudentID = StudentID
            AND e.EnrollmentID <> COALESCE(INSERTED.EnrollmentID, 0)
            AND b.Schedule = (SELECT Schedule FROM LMS.Batches WHERE BatchID = e.BatchID)
        )
    ) -- No enrollment in other batches with the same schedule
	go
--============== Update column definition ============--
	ALTER TABLE LMS.MaterialPurchases
	ALTER COLUMN PurchaseDescription NVARCHAR(255) NULL;
	go

--============== DROP SCHEMA ============--
	--DROP SCHEMA LMS;

--============== DROP TABLE ============--
	IF OBJECT_ID('ResourcesInventory') IS NOT NULL
	DROP TABLE ResourcesInventory
	GO
--============== DROP TABLE ============--
--	DROP TABLE ResourcesInventory

--============== DROP COLUMN ============--
	ALTER TABLE LMS.Materials
	DROP COLUMN PurchaseDate;
	go
--============== DROP CONSTRAINT ============--
	ALTER TABLE LMS.TrainerBatches
	DROP CONSTRAINT PK_TrainerBatches;
	go
/*
==============================  SECTION 04  ==============================
		          CREATE CLUSTERED AND NONCLUSTERED INDEX
==========================================================================
*/
--============== CLUSTERED INDEX ============--

	CREATE CLUSTERED INDEX idx_Enrollments_EnrollmentID ON LMS.Enrollments(EnrollmentID);
	CREATE INDEX idx_CourseID ON Courses (CourseID);
	CREATE INDEX idx_StudentID ON LMS.Students (StudentID);
	go
--============== Non-Clustered Index ============--
	CREATE NONCLUSTERED INDEX IX_TrainerBatches_TrainerID ON LMS.TrainerBatches(TrainerID);
	go

	/*
==============================  SECTION 05  ==============================
							 CREATE SEQUENCE
==========================================================================
*/

--============== CREATE SEQUENCE ============--
	CREATE SEQUENCE EmployeeIDSeq
	START WITH 1
	INCREMENT BY 1;
	go
--============== Alter Sequence ============--
	ALTER SEQUENCE EmployeeIDSeq
	RESTART WITH 100;
	go
/*
==============================  SECTION 06  ==============================
							  CREATE A VIEW
==========================================================================
*/
--============== Create a view to display student information along with enrollment details ============--

CREATE VIEW vw_studentenrollmentview AS
SELECT
    S.StudentID,
    CONCAT(S.FirstName, ' ', S.LastName) AS StudentName,
    S.DateOfBirth,
    S.PhoneNo,
    E.EnrollmentID,
    E.EnrollmentDate,
    C.CourseName,
	C.Category,
    B.StartDate,
    B.EndDate,
    B.BatchNo,
    B.Schedule   
FROM
    LMS.Students AS S
    JOIN LMS.Enrollments AS E ON S.StudentID = E.StudentID
    JOIN LMS.Batches AS B ON E.BatchID = B.BatchID
    JOIN Courses AS C ON E.CourseID = C.CourseID;
go

--============== VIEW WITH ENCRYPTION, SCHEMABINDING & WITH CHECK OPTION  FOR TRAINER INFORMATION ============--
CREATE VIEW vw_TrainerInfoView
WITH ENCRYPTION, SCHEMABINDING
AS
SELECT
    T.TrainerID,
	E.EmployeeName as TrainerName,
    T.EmployeeID,
    T.Specialty,
    TB.BatchID,
    B.BatchNo,
    B.Schedule,
    B.StartDate,
    B.EndDate,
    C.CourseName,
	C.Category
FROM
    LMS.Trainers AS T
    JOIN LMS.TrainerBatches AS TB ON T.TrainerID = TB.TrainerID
    JOIN LMS.Batches AS B ON TB.BatchID = B.BatchID
    JOIN LMS.Courses AS C ON B.CourseID = C.CourseID
	join LMS.Employees AS E ON T.TrainerID = E.EmployeeID
WITH CHECK OPTION;
go

/*
==============================  SECTION 07  ==============================
							 STORED PROCEDURE
==========================================================================
*/
--============== STORED PROCEDURE FOR 'INSERT', 'UPDATE', 'DELETE' ============--
CREATE PROCEDURE sp_ManageStudent
    @operation VARCHAR(10), 
    @studentID INT ,
    @firstName VARCHAR(50) ,
    @lastName VARCHAR(50) ,
    @fatherName VARCHAR(30) ,
    @dateOfBirth DATE ,
    @email NVARCHAR(100) = NULL,
    @gender VARCHAR(10) ,
    @region VARCHAR(10) ,
    @phoneNo NCHAR(11) ,
    @address NVARCHAR(255) = NULL
AS
BEGIN
    IF @operation = 'INSERT'
    BEGIN
        -- Insert logic here
        INSERT INTO LMS.Students (FirstName, LastName, FatherName, DateOfBirth, Email, Gender, Region, PhoneNo, Address)
        VALUES (@FirstName, @LastName, @FatherName, @DateOfBirth, @Email, @Gender, @Region, @PhoneNo, @Address);
    END
    ELSE IF @operation = 'UPDATE'
    BEGIN
        -- Update logic here
        UPDATE LMS.Students
        SET
            FirstName = @firstName,
            LastName = @lastName,
            FatherName = @fatherName,
            DateOfBirth = @dateOfBirth,
            Email = @email,
            Gender = @gender,
            Region = @region,
            PhoneNo = @phoneNo,
            Address = @address
        WHERE
            StudentID = @studentID;
    END
    ELSE IF @operation = 'DELETE'
    BEGIN
        -- Delete logic here
        DELETE FROM LMS.Students
        WHERE
            StudentID = @studentID;
    END
END;
go
--============== STORED PROCEDURE FOR INSERT ( enroll a student in a batch) ============--
CREATE PROCEDURE sp_EnrollStudent
    @studentid INT,
    @batchid INT,
    @courseid INT,
    @enrollmentdate DATE
AS
BEGIN
    DECLARE @totalcoursefee DECIMAL(10, 0);
    DECLARE @scholarship DECIMAL(10, 0);

    -- Retrieve the CourseFee based on the provided CourseID
    SELECT @totalcoursefee = CourseFee
    FROM LMS.Courses
    WHERE CourseID = @courseid;

    -- Calculate scholarship based on the number of courses enrolled
    SELECT @scholarship = CASE
                            WHEN COUNT(*) > 0 THEN 0.1 * @TotalCourseFee -- 10% scholarship for each additional course
                            ELSE 0
                          END
    FROM LMS.Enrollments
    WHERE StudentID = @studentid;

    -- Insert the enrollment record
    INSERT INTO LMS.Enrollments (StudentID, BatchID, CourseID, EnrollmentDate, TotalCourseFee, Scholarship)
    VALUES (@studentid, @batchid, @courseid, @enrollmentdate, @totalcoursefee, @scholarship);

    PRINT 'Student enrolled successfully with scholarship: ' + CAST(@scholarship AS NVARCHAR(20));
END;

go
--============== STORED PROCEDURE FOR UPDATE ============--
go
CREATE PROCEDURE sp_updateenrollment
    @enrollmentid INT,
    @studentid INT,
    @batchid INT,
    @courseid INT,
    @enrollmentdate DATE
AS
BEGIN
    DECLARE @totalcoursefee DECIMAL(10, 0);
    DECLARE @scholarship DECIMAL(10, 0);

    -- Automatically set TotalCourseFee based on CourseID
    SELECT @totalCourseFee = CourseFee
    FROM Courses
    WHERE CourseID = @courseid;

    -- Check if the student is enrolling in more than one course to provide scholarship
    IF EXISTS (
        SELECT 1
        FROM LMS.Enrollments
        WHERE StudentID = @studentid
          AND EnrollmentID <> @enrollmentid -- Exclude the current enrollment for the same student
    )
    BEGIN
        SET @scholarship = 0.1 * @totalcoursefee; -- 10% scholarship for additional courses
    END
    ELSE
    BEGIN
        SET @scholarship = 0; -- No scholarship for the first course
    END

    -- Update the Enrollments table
    UPDATE LMS.Enrollments
    SET
        StudentID = @studentid,
        BatchID = @batchid,
        CourseID = @courseid,
        EnrollmentDate = @enrollmentdate,
        TotalCourseFee = @totalcoursefee,
        Scholarship = @scholarship
    WHERE EnrollmentID = @enrollmentid;

    PRINT 'Enrollment updated successfully with automatic scholarship calculation.';
END;

go
--============== STORED PROCEDURE FOR DELETE ============--
CREATE PROCEDURE sp_deleteenrollment
    @enrollmentid INT
AS
BEGIN
    DECLARE @message NVARCHAR(255);

    DELETE FROM LMS.Enrollments
    WHERE
        EnrollmentID = @enrollmentid;

    IF @@ROWCOUNT > 0
        SET @message = 'Enrollment deleted successfully.';
    ELSE
        SET @message = 'Enrollment not found.';

    PRINT @message;
END;
/*
==============================  SECTION 08  ==============================
								 FUNCTION
==========================================================================
*/
--============== A SCALAR FUNCTION ============--
-- Create a function to get the next batch number for a given course ID
go
CREATE FUNCTION fn_GetNextBatchNumber(@courseid INT)
RETURNS INT
AS 
BEGIN
    DECLARE @nextbatchnumber INT;

    -- Calculate the next batch number based on the maximum batch number for the given course
    SELECT @nextbatchnumber = ISNULL(MAX(BatchNo), 0) + 1
    FROM LMS.Batches
    WHERE CourseID = @courseid;

    RETURN @nextbatchnumber;
END;

-- Create a function to get available seats
go
CREATE FUNCTION fn_GetAvailableSeats(@batchid INT)
RETURNS INT
AS
BEGIN
    DECLARE @availableseats INT;

    SELECT @availableseats = MaxSeats - ISNULL(EnrollmentCount, 0)
    FROM LMS.Batches B
    LEFT JOIN (
        SELECT BatchID, COUNT(*) AS EnrollmentCount
        FROM LMS.Enrollments
        GROUP BY BatchID
    ) E ON B.BatchID = E.BatchID
    WHERE B.BatchID = @batchid;

    RETURN @availableseats;
END;
GO

--============== Alter the table to use the function in the computed column ============--
ALTER TABLE LMS.Batches
ADD AvailableSeats AS fn_GetAvailableSeats(BatchID);
GO

--============== A SIMPLE TABLE VALUED FUNCTION ============--

-- Create a table-valued function to get all enrolled students for a given batch
CREATE FUNCTION tvf_GetEnrolledStudents(@batchid INT)
RETURNS TABLE
AS
RETURN
(
    SELECT E.StudentID, S.FirstName + ' ' + S.LastName AS StudentName, S.DateOfBirth, S.PhoneNo, E.EnrollmentID, E.EnrollmentDate,
           C.CourseName, B.StartDate, B.EndDate, B.BatchNo, B.Schedule
    FROM LMS.Enrollments E
    JOIN LMS.Students S ON E.StudentID = S.StudentID
    JOIN LMS.Batches B ON E.BatchID = B.BatchID
    JOIN Courses C ON E.CourseID = C.CourseID
    WHERE E.BatchID = @batchid
);
go

-- Function to retrieve batches trained by a specific trainer
go
CREATE FUNCTION fn_GetTrainerBatches
(
    @trainerid INT
)
RETURNS TABLE
AS
RETURN
(
    SELECT B.BatchID, B.BatchName, C.CourseName
    FROM LMS.TrainerBatches TB
    INNER JOIN LMS.Batches B ON TB.BatchID = B.BatchID
    INNER JOIN Courses C ON B.CourseID = C.CourseID
    WHERE TB.TrainerID = @trainerid
);
go
--============== A MULTISTATEMENT TABLE VALUED FUNCTION ============-

-- Create a multi-statement table-valued function for Expenses
CREATE FUNCTION fn_GetTotalExpenses()
RETURNS @totalexpenses TABLE
(
    ExpenseType VARCHAR(100),
    TotalAmount DECIMAL(10, 2)
)
AS
BEGIN
    INSERT INTO @totalexpenses (ExpenseType, TotalAmount)
    SELECT ExpenseType, SUM(Amount) AS TotalAmount
    FROM LMS.Expenses
    GROUP BY ExpenseType;

    RETURN;
END;
go
-- Create a multi-statement table-valued function for Income
CREATE FUNCTION fn_GetTotalPayment()
RETURNS @totalincome TABLE
(
    StudentID INT,
    TotalAmount DECIMAL(10, 2)
)
AS
BEGIN
    INSERT INTO @totalincome (StudentID, TotalAmount)
    SELECT StudentID, SUM(Amount) AS TotalAmount
    FROM LMS.Payments
    GROUP BY StudentID;

    RETURN;
END;
go
/*
==============================  SECTION 09  ==============================
							FOR/AFTER TRIGGER
==========================================================================
*/
--===== CREATE TRIGGER EnrollmentFinancialsTrigger =====--
CREATE TRIGGER EnrollmentFinancialsTrigger
ON LMS.Enrollments
AFTER INSERT
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @StudentID INT, @BatchID INT, @NetTotalFee DECIMAL(10, 0);

    SELECT
        @StudentID = StudentID,
        @BatchID = BatchID,
        @NetTotalFee = NetTotalFee
    FROM
        INSERTED;

    INSERT INTO LMS.Payments (StudentID, BatchID, Amount, PaymentDate)
    VALUES (@StudentID, @BatchID, @NetTotalFee, GETDATE());
END;
go

--===== CREATE TRIGGER MaterialAvailabilityTrigger =====--
CREATE TRIGGER MaterialAvailabilityTrigger
ON LMS.Materials
AFTER INSERT, UPDATE, DELETE
AS
BEGIN
    SET NOCOUNT ON;

    -- Handle INSERT and UPDATE
    IF EXISTS (SELECT * FROM INSERTED)
    BEGIN
        MERGE INTO LMS.MaterialStatus AS target
        USING (
            SELECT
                m.MaterialID,
                CASE
                    WHEN m.Quantity > 0 THEN 'Available'
                    ELSE 'Not Available'
                END AS StatusName,
                m.Quantity AS StatusQuantity
            FROM
                LMS.Materials m
                INNER JOIN INSERTED i ON m.MaterialID = i.MaterialID
        ) AS source ON target.MaterialID = source.MaterialID AND target.StatusName = source.StatusName
        WHEN MATCHED THEN
            UPDATE SET StatusQuantity = source.StatusQuantity
        WHEN NOT MATCHED THEN
            INSERT (MaterialID, StatusName, StatusQuantity)
            VALUES (source.MaterialID, source.StatusName, source.StatusQuantity);
    END

    -- Handle DELETE
    IF EXISTS (SELECT * FROM DELETED)
    BEGIN
        DELETE FROM LMS.MaterialStatus
        WHERE MaterialID IN (SELECT MaterialID FROM DELETED);
    END
END;
go
/*
==============================  SECTION 10  ==============================
							INSTEAD OF TRIGGER
==========================================================================
*/

--===== CREATE TRIGGER InsteadOfInsertTrigger =====--
CREATE TRIGGER InsteadOfInsertTrigger
ON LMS.Payments
INSTEAD OF INSERT
AS
BEGIN
    SET NOCOUNT ON;

    INSERT INTO LMS.Payments (StudentID, BatchID, Amount, PaymentDate)
    SELECT
        i.StudentID,
        i.BatchID,
        CASE WHEN e.NetTotalFee > i.Amount THEN e.NetTotalFee ELSE i.Amount END AS Amount,
        i.PaymentDate
    FROM
        INSERTED i
    JOIN
        LMS.Enrollments e ON i.StudentID = e.StudentID AND i.BatchID = e.BatchID;
  
END;
go



