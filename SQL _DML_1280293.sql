/*
Table of Contents: DML
			=> SECTION 01: INSERT DATA USING INSERT INTO KEYWORD
			=> SECTION 02: INSERT DATA THROUGH STORED PROCEDURE
			=> SECTION 03: INSERT UPDATE DELETE DATA THROUGH VIEW	
			=> SECTION 04: RETREIVE DATA USING FUNCTION(SCALAR, SIMPLE TABLE VALUED, MULTISTATEMENT TABLE VALUED)
			=> SECTION 05: QUERY
				SUB SECTION => 5.01 : SELECT FROM TABLE
				SUB SECTION => 5.02 : SELECT FROM VIEW
				SUB SECTION => 5.03 : SELECT INTO
				SUB SECTION => 5.04 : IMPLICIT JOIN WITH WHERE BY CLAUSE, ORDER BY CLAUSE
				SUB SECTION => 5.05 : INNER JOIN WITH GROUP BY CLAUSE
				SUB SECTION => 5.06 : OUTER JOIN
				SUB SECTION => 5.07 : CROSS JOIN
				SUB SECTION => 5.08 : TOP CLAUSE WITH TIES
				SUB SECTION => 5.09 : DISTINCT
				SUB SECTION => 5.10 : COMPARISON, LOGICAL(AND OR NOT) & BETWEEN OPERATOR
				SUB SECTION => 5.11 : LIKE, IN, NOT IN, OPERATOR & IS NULL CLAUSE
				SUB SECTION => 5.12 : OFFSET FETCH
				SUB SECTION => 5.13 : UNION
				SUB SECTION => 5.14 : EXCEPT INTERSECT
				SUB SECTION => 5.15 : AGGREGATE FUNCTIONS
				SUB SECTION => 5.16 : GROUP BY & HAVING CLAUSE
				SUB SECTION => 5.17 : ROLLUP & CUBE OPERATOR
				SUB SECTION => 5.18 : GROUPING SETS
				SUB SECTION => 5.19 : SUB-QUERIES (INNER, CORRELATED)
				SUB SECTION => 5.20 : EXISTS
				SUB SECTION => 5.21 : CTE
				SUB SECTION => 5.22 : MERGE
				SUB SECTION => 5.23 : BUILT IN FUNCTION
				SUB SECTION => 5.24 : CASE
				SUB SECTION => 5.25 : IIF
				SUB SECTION => 5.26 : COALESCE & ISNULL
				SUB SECTION => 5.27 : WHILE
				SUB SECTION => 5.28 : GROPING FUNCTION
				SUB SECTION => 5.29 : RANKING FUNCTION
				SUB SECTION => 5.30 : IF ELSE & PRINT
				SUB SECTION => 5.31 : TRY CATCH
				SUB SECTION => 5.32 : GOTO
				SUB SECTION => 5.33 : WAITFOR
				SUB SECTION => 5.34 : sp_helptext
				SUB SECTION => 5.35 : TRANSACTION WITH SAVE POINT
*/

use LearningManagementSystemDB
go
/*
==============================  SECTION 01  ==============================
					INSERT DATA USING INSERT INTO KEYWORD
==========================================================================
*/
-- Example of inserting course data with course durations as words
INSERT INTO LMS.Courses (CourseName, CourseLevel, CourseDuration, CourseFee)
VALUES
    ('Spoken English', 'Basic', '3 MONTH', 3000),
	('IELTS Preparation', 'Basic', '3 MONTH',4500),
    ('GMAT Exam Prep', 'Basic', '3 MONTH', 6000),
	('Spoken English', 'Advanced', '6 MONTH', 5000),
    ('IELTS Preparation', 'Advanced', '6 MONTH', 11500),
    ('GMAT Exam Prep', 'Advanced', '6 MONTH', 12000),
    ('Web Development Fundamentals', 'Basic', '3 MONTH', 7000),
    ('Data Science Essentials', 'Advanced', '6 MONTH', 70000),
    ('Graphic Design Basics', 'Basic', '3 MONTH', 5000),
    ('Digital Marketing Essentials', 'Basic', '3 MONTH', 4200),
    ('Python Programming Basics', 'Basic', '3 MONTH', 350.00),
    ('Advanced Web Development', 'Advanced', '12 MONTH', 800.00),
    ('Ethical Hacking Masterclass', 'Diploma', '12 MONTH', 110000),
    ('C++ Programming Fundamentals', 'Basic', '3 MONTH', 8000),
    ('Mobile App Development', 'Advanced', '6 MONTH', 50000),
    ('Machine Learning Fundamentals', 'Advanced', '6 MONTH', 60000),
    ('UI/UX Design Principles', 'Advanced', '6 MONTH', 8500),
    ('Java Programming Basics', 'Basic', '3 MONTH', 5000),
    ('Data Analysis with R', 'Advanced', '6 MONTH', 75000),
    ('Network Security', 'Diploma', '12 MONTH', 100000),
    ('Photography Basics', 'Basic', '3 MONTH', 2500),
    ('Financial Accounting', 'Advanced', '6 MONTH', 13000),
    ('Spanish Language Course', 'Basic', '3 MONTH', 5000);


-- inserting values into the branch table for each course

INSERT INTO LMS.Branches VALUES (CAST(NEWID() AS VARCHAR(50)), 'NVIT','Sholosohor, CTG'),
								(CAST(NEWID() AS VARCHAR(50)),'DIIT','Agrabad, CTG');

-- inserting values into the Batches table for each course

INSERT INTO LMS.Batches (BatchNo, Schedule, StartDate, EndDate, Seat, YEAR, CourseID, BrunchName)
VALUES
    (1, 'Morning', '2023-01-05', '2023-04-05', 20, 2023, 101, 'NVIT'),
    (2, 'Afternoon', '2023-01-05', '2023-04-05', 20, 2023, 101, 'NVIT'),
	(3, 'Morning', '2023-04-06', '2023-08-05', 20, 2023, 101, 'NVIT'),
    (4, 'Afternoon', '2023-04-06', '2023-08-05', 20, 2023, 101, 'NVIT'),
	(5, 'Morning', '2023-08-08', '2023-12-31', 20, 2023, 101, 'NVIT'),
    (6, 'Afternoon', '2023-08-08', '2023-12-31', 20, 2023, 101, 'NVIT');

-- Batches for IELTS Preparation
INSERT INTO LMS.Batches (BatchNo, Schedule, StartDate, EndDate, Seat, YEAR, CourseID, BrunchName)
VALUES
    (1, 'Morning', '2023-01-05', '2023-04-05', 20, 2023, 102, 'NVIT'),
    (2, 'Afternoon', '2023-01-05', '2023-04-05', 20, 2023, 102, 'NVIT'),
	(3, 'Morning', '2023-04-06', '2023-08-05', 20, 2023, 102, 'NVIT'),
    (4, 'Afternoon', '2023-04-06', '2023-08-05', 20, 2023, 102, 'NVIT'),
	(5, 'Morning', '2023-08-07', '2024-01-02', 20, 2023, 102, 'NVIT'),
    (6, 'Afternoon', '2023-08-07', '2024-01-02', 20, 2023, 102, 'NVIT');

-- Batches for GMAT Exam Prep
INSERT INTO LMS.Batches (BatchNo, Schedule, StartDate, EndDate, Seat, YEAR, CourseID, BrunchName)
VALUES
    (1, 'Morning', '2023-01-05', '2023-04-05', 20, 2023, 103, 'NVIT'),
    (2, 'Afternoon', '2023-01-05', '2023-04-05', 20, 2023, 103, 'NVIT'),
	(3, 'Morning', '2023-04-06', '2023-08-05', 20, 2023, 103, 'NVIT'),
    (4, 'Afternoon', '2023-04-06', '2023-08-05', 20, 2023, 103, 'NVIT'),
	(5, 'Morning', '2023-08-07', '2024-01-02', 20, 2023, 103, 'NVIT'),
    (6, 'Afternoon', '2023-08-07', '2024-01-02', 20, 2023, 103, 'NVIT');

-- Batches for Spoken English (Advanced)
INSERT INTO LMS.Batches (BatchNo, Schedule, StartDate, EndDate, Seat, YEAR, CourseID, BrunchName)
VALUES
    (1, 'Morning', '2023-01-05', '2023-07-05', 20, 2023, 104, 'NVIT'),
    (2, 'Afternoon', '2023-01-05', '2023-07-05', 20, 2023, 104, 'NVIT'),
	(3, 'Morning', '2023-07-06', '2023-12-30', 20, 2023, 104, 'NVIT'),
    (4, 'Afternoon', '2023-07-06', '2023-12-30', 20, 2023, 104, 'NVIT');

	-- Batches for IELTS Preparation (Advanced)
INSERT INTO LMS.Batches (BatchNo, Schedule, StartDate, EndDate, Seat, YEAR, CourseID, BrunchName)
VALUES
    (1, 'Morning', '2023-01-05', '2023-07-05', 20, 2023, 105, 'NVIT'),
    (2, 'Afternoon', '2023-01-05', '2023-07-05', 20, 2023, 105, 'NVIT'),
	(3, 'Morning', '2023-07-06', '2023-12-30', 20, 2023, 105, 'NVIT');

-- Batches for GMAT Exam Prep (Advanced)
INSERT INTO LMS.Batches (BatchNo, Schedule, StartDate, EndDate, Seat, YEAR, CourseID, BrunchName)
VALUES
    (1, 'Morning', '2023-01-05', '2023-07-05', 20, 2023, 106, 'NVIT'),
    (2, 'Afternoon', '2023-01-05', '2024-01-05', 20, 2023, 106, 'NVIT'),
	(3, 'Afternoon', '2023-07-06', '2024-01-05', 20, 2023, 106, 'NVIT');

-- Batches for Web Development Fundamentals
INSERT INTO LMS.Batches (BatchNo, Schedule, StartDate, EndDate, Seat, YEAR, CourseID, BrunchName)
VALUES
    (1, 'Morning', '2023-01-05', '2023-04-05', 20, 2023, 107, 'NVIT'),
    (2, 'Afternoon', '2023-01-05', '2023-04-05', 20, 2023, 107, 'NVIT');

-- Batches for Data Science Essentials
INSERT INTO LMS.Batches (BatchNo, Schedule, StartDate, EndDate, Seat, YEAR, CourseID, BrunchName)
VALUES
    (1, 'Morning', '2023-01-05', '2023-07-05', 20, 2023, 108, 'NVIT'),
    (2, 'Afternoon', '2023-01-05', '2023-07-05', 20, 2023, 108, 'NVIT');

-- Continue inserting batches for other courses following the same pattern-- Batches for Graphic Design Basics
INSERT INTO LMS.Batches (BatchNo, Schedule, StartDate, EndDate, Seat, YEAR, CourseID, BrunchName)
VALUES
    (1, 'Morning', '2023-01-05', '2023-04-05', 15, 2023, 109, 'NVIT'),
    (2, 'Afternoon', '2023-01-05', '2023-04-05', 15, 2023, 109, 'NVIT');

-- Batches for Digital Marketing Essentials
INSERT INTO LMS.Batches (BatchNo, Schedule, StartDate, EndDate, Seat, YEAR, CourseID, BrunchName)
VALUES
    (1, 'Morning', '2023-01-05', '2023-04-05', 18, 2023, 110, 'NVIT'),
    (2, 'Afternoon', '2023-01-05', '2023-04-05', 18, 2023, 110, 'NVIT');

-- Batches for Python Programming Basics
INSERT INTO LMS.Batches (BatchNo, Schedule, StartDate, EndDate, Seat, YEAR, CourseID, BrunchName)
VALUES
    (1, 'Morning', '2023-01-05', '2023-04-02', 15, 2023, 111, 'NVIT'),
    (2, 'Afternoon', '2023-01-05', '2023-04-02', 15, 2023, 111, 'NVIT'),
	(3, 'Morning', '2023-04-05', '2023-08-02', 15, 2023, 111, 'NVIT'),
    (4, 'Afternoon', '2023-04-05', '2023-08-02', 15, 2023, 111, 'NVIT'),
	(5, 'Morning', '2023-08-05', '2023-12-30', 15, 2023, 111, 'NVIT'),
    (6, 'Afternoon', '2023-08-05', '2023-12-30', 15, 2023, 111, 'NVIT');

-- Batches for Advanced Web Development
INSERT INTO LMS.Batches (BatchNo, Schedule, StartDate, EndDate, Seat, YEAR, CourseID, BrunchName)
VALUES
    (1, 'Morning', '2023-01-05', '2024-01-02', 20, 2023, 112, 'NVIT'),
    (2, 'Afternoon', '2023-01-05', '2024-01-02', 20, 2023, 112, 'NVIT');

-- Batches for Ethical Hacking Masterclass
INSERT INTO LMS.Batches (BatchNo, Schedule, StartDate, EndDate, Seat, YEAR, CourseID, BrunchName)
VALUES
    (1, 'Morning', '2023-01-05', '2023-12-30', 22, 2023, 113, 'NVIT'),
    (2, 'Afternoon', '2023-01-05', '2023-12-30', 22, 2023, 113, 'NVIT');

-- Batches for C++ Programming Fundamentals
INSERT INTO LMS.Batches (BatchNo, Schedule, StartDate, EndDate, Seat, YEAR, CourseID, BrunchName)
VALUES
    (1, 'Morning', '2023-01-05', '2023-04-05', 18, 2023, 114, 'NVIT'),
    (2, 'Afternoon', '2023-01-05', '2023-04-05', 18, 2023, 114, 'NVIT');

-- Batches for Mobile App Development
INSERT INTO LMS.Batches (BatchNo, Schedule, StartDate, EndDate, Seat, YEAR, CourseID, BrunchName)
VALUES
    (1, 'Morning', '2023-01-05', '2023-07-05', 20, 2023, 115, 'NVIT'),
    (2, 'Afternoon', '2023-01-05', '2023-07-05', 20, 2023, 115, 'NVIT');

-- Batches for Machine Learning Fundamentals
INSERT INTO LMS.Batches (BatchNo, Schedule, StartDate, EndDate, Seat, YEAR, CourseID, BrunchName)
VALUES
    (1, 'Morning', '2023-01-05', '2023-07-02', 22, 2023, 116, 'NVIT'),
    (2, 'Afternoon', '2023-01-05', '2023-07-02', 22, 2023, 116, 'NVIT');

-- Batches for UI/UX Design Principles
INSERT INTO LMS.Batches (BatchNo, Schedule, StartDate, EndDate, Seat, YEAR, CourseID, BrunchName)
VALUES
    (1, 'Morning', '2023-01-05', '2023-07-05', 20, 2023, 117, 'NVIT'),
    (2, 'Afternoon', '2023-01-05', '2023-07-05', 20, 2023, 117, 'NVIT');

-- Batches for Java Programming Basics
INSERT INTO LMS.Batches (BatchNo, Schedule, StartDate, EndDate, Seat, YEAR, CourseID, BrunchName)
VALUES
    (1, 'Morning', '2023-01-05', '2023-04-05', 18, 2023, 118, 'NVIT'),
    (2, 'Afternoon', '2023-01-05', '2023-04-05', 18, 2023, 118, 'NVIT');

-- Batches for Data Analysis with R
INSERT INTO LMS.Batches (BatchNo, Schedule, StartDate, EndDate, Seat, YEAR, CourseID, BrunchName)
VALUES
    (1, 'Morning', '2023-01-05', '2023-07-05', 22, 2023, 119, 'NVIT'),
    (2, 'Afternoon', '2023-01-05', '2023-07-05', 22, 2023, 119, 'NVIT');

-- Batches for Network Security
INSERT INTO LMS.Batches (BatchNo, Schedule, StartDate, EndDate, Seat, YEAR, CourseID, BrunchName)
VALUES
    (1, 'Morning', '2023-01-05', '2023-12-30', 25, 2023, 120, 'NVIT'),
    (2, 'Afternoon', '2023-01-05', '2023-12-30', 25, 2023, 120, 'NVIT');

-- Batches for Photography Basics
INSERT INTO LMS.Batches (BatchNo, Schedule, StartDate, EndDate, Seat, YEAR, CourseID, BrunchName)
VALUES
    (1, 'Morning', '2023-01-05', '2023-04-05', 18, 2023, 121, 'NVIT'),
    (2, 'Afternoon', '2023-01-05', '2023-04-05', 18, 2023, 121, 'NVIT');

-- Batches for Financial Accounting
INSERT INTO LMS.Batches (BatchNo, Schedule, StartDate, EndDate, Seat, YEAR, CourseID, BrunchName)
VALUES
    (1, 'Morning', '2023-01-05', '2023-07-05', 20, 2023, 122, 'NVIT'),
    (2, 'Afternoon', '2023-01-05', '2023-07-05', 20, 2023, 122, 'NVIT');

-- Batches for Spanish Language Course
INSERT INTO LMS.Batches (BatchNo, Schedule, StartDate, EndDate, Seat, YEAR, CourseID, BrunchName)
VALUES
    (1, 'Morning', '2023-01-05', '2023-04-05', 18, 2023, 123, 'NVIT'),
    (2, 'Afternoon', '2023-01-05', '2023-04-05', 18, 2023, 123, 'NVIT');


	-- Insert values into Students table 
INSERT INTO LMS.Students (FirstName, LastName, FatherName, DateOfBirth, Email,Gender,Region, Phone, Address, BatchID)
VALUES
    ('Abul', 'Hasan', 'Abdul Karim', '1990-01-15', 'abulhasan@email.com','Male','Islam', '01711234567', 'Dhaka, Bangladesh', 1),
    ('Tahmid', 'Ahmed', 'Mohammad Ali', '1995-12-02', 'tahmidahmed@email.com','Male','Islam', '01822345678', 'Chattogram, Bangladesh', 2),
    ('Sabina', 'Islam', 'Mohammad Ikram', '2000-03-20', 'sabinaislam@email.com','Female','Islam', '01933456789', 'Rajshahi, Bangladesh', 1),
    ('Rahim', 'Khan', 'Abdur Rahim', '1998-04-04', 'rahimkhan@gmail.com', 'Male','Islam','01644567890', 'Khulna, Bangladesh', 2),
    ('Afrin', 'Tasnim', 'Mohammad Abu Tasnim', '2005-05-05', 'afrintasnim@gmail.com','Male','Islam', '01555678901', 'Sylhet, Bangladesh', 1),
    ('Emily', 'taposhi', 'Monir Washim', '1992-06-18', NULL,'Female','Hindu', '01456789012', 'Dhaka, Bangladesh', 1),
    ('Asif', 'Fazle', 'Enamul Hoque', '1997-10-27', 'asif@email.com', 'Male','Islam','01678901234', 'Chattogram, Bangladesh', 2),
    ('Jobaida', 'khanom', 'Johir Uddin', '1991-12-03', NULL,'Female','Islam', '01789012345', 'Rajshahi, Bangladesh', 1),
    ('Danish', 'Chowdury', 'Somrat Chowdury', '1993-03-14', NULL,'Male','Hindu', '01890123456', 'Khulna, Bangladesh', 2),
    ('Liton', 'Das', 'Choton Das', '1995-04-25', 'litondas@email.com','Male','Hindu', '01901234567', 'Sylhet, Bangladesh', 6),
    ('Elias', 'Korim', 'Minhaz Abedin', '1998-11-06', 'elias@email.com','Male','Islam', '01512345678', 'Dhaka, Bangladesh', 5),
    ('Ema', 'khanom', 'Abdul Bashar ', '1992-12-17', 'emma@gmail.com','Female','Islam', '01623456789', 'Chattogram, Bangladesh', 4),
    ('Masud', 'Korim', 'Abdul Korim', '1995-09-28', 'mason.taylor@email.com', 'Male','Islam','01734567890', 'Rajshahi, Bangladesh', 3),
    ('Ajmol', 'Ahmed', 'Josim Ahmed', '1997-11-09', 'ajmol@gmail.com','Male','Islam', '01845678901', 'Khulna, Bangladesh', 5),
    ('Noah', 'Nova', 'Akram Hossain', '1990-04-20', 'noah@email.com','Female','Islam', '01956789012', 'Sylhet, Bangladesh', 6),
    ('Rakib', 'Islam', 'Mohammad Akram', '1996-07-15', 'rakib.islam@email.com', 'Male', 'Islam', '01767890123', 'Dhaka, Bangladesh', 2),
    ('Farida', 'Begum', 'Abdul Khalek', '1994-08-22', 'farida@email.com', 'Female', 'Islam', '01878901234', 'Chattogram, Bangladesh', 3),
    ('Mamun', 'Rahman', 'Mosharraf Hossain', '1999-01-10', 'mamun.rahman@email.com', 'Male', 'Islam', '01989012345', 'Rajshahi, Bangladesh', 4),
    ('Ayesha', 'Khatun', 'Mozammel Haque', '1993-02-27', 'ayesha@email.com', 'Female', 'Islam', '01690123456', 'Khulna, Bangladesh', 5),
    ('Kamrul', 'Hasan', 'Azizul Haque', '1996-05-14', 'kamrul.hasan@email.com', 'Male', 'Islam', '01701234567', 'Sylhet, Bangladesh', 6),
    ('Sabrina', 'Akter', 'Rahim Uddin', '1991-08-07', 'sabrina.akter@email.com', 'Female', 'Islam', '01812345678', 'Dhaka, Bangladesh', 7),
    ('Imran', 'Hossain', 'Nurul Islam', '1997-09-18', 'imran.hossain@email.com', 'Male', 'Islam', '01923456789', 'Chattogram, Bangladesh', 8),
    ('Nadia', 'Chowdhury', 'Fazlul Haque', '1994-12-25', 'nadia.chowdhury@email.com', 'Female', 'Islam', '01634567890', 'Rajshahi, Bangladesh', 9),
    ('Sohel', 'Kabir', 'Iqbal Kabir', '1998-03-30', 'sohel.kabir@email.com', 'Male', 'Islam', '01745678901', 'Khulna, Bangladesh', 10),
    ('Jannatul', 'Ferdous', 'Alamgir Hossain', '2000-06-10', 'jannatul.ferdous@email.com', 'Female', 'Islam', '01856789012', 'Sylhet, Bangladesh', 11),
    ('Arif', 'Alam', 'Md. Shah Alam', '1995-11-01', 'arif.alam@email.com', 'Male', 'Islam', '01967890123', 'Dhaka, Bangladesh', 12),
    ('Nishat', 'Jahan', 'Abdul Kader', '1992-02-14', 'nishat.jahan@email.com', 'Female', 'Islam', '01678901234', 'Chattogram, Bangladesh', 13),
    ('Faisal', 'Ahmed', 'Nazrul Islam', '1999-05-27', 'faisal.ahmed@email.com', 'Male', 'Islam', '01789012345', 'Rajshahi, Bangladesh', 14),
    ('Sharmin', 'Akter', 'Kamal Hossain', '1997-10-09', 'sharmin.akter@email.com', 'Female', 'Islam', '01890123456', 'Khulna, Bangladesh', 15),
    ('Rahat', 'Hossain', 'Ashraf Ali', '1993-01-22', 'rahat.hossain@email.com', 'Male', 'Islam', '01901234567', 'Sylhet, Bangladesh', 16),
    ('Sadia', 'Islam', 'Mohammad Ali', '1996-04-05', 'sadia.islam@email.com', 'Female', 'Islam', '01767890123', 'Dhaka, Bangladesh', 17),
    ('Rashed', 'Khan', 'Abdul Bari', '1994-08-18', 'rashed.khan@email.com', 'Male', 'Islam', '01878901234', 'Chattogram, Bangladesh', 18),
    ('Mousumi', 'Akter', 'Alauddin Ahmed', '1999-02-02', 'mousumi.akter@email.com', 'Female', 'Islam', '01989012345', 'Rajshahi, Bangladesh', 19),
    ('Imran', 'Ahmed', 'Nurul Islam', '1993-03-17', 'imran.ahmed@email.com', 'Male', 'Islam', '01690123456', 'Khulna, Bangladesh', 20),
    ('Farzana', 'Akter', 'Abdul Bari', '1996-06-04', 'farzana.akter@email.com', 'Female', 'Islam', '01701234567', 'Sylhet, Bangladesh', 21),
    ('Sohel', 'Rana', 'Iqbal Rana', '1991-09-27', 'sohel.rana@email.com', 'Male', 'Islam', '01812345678', 'Dhaka, Bangladesh', 22),
    ('Shahnaz', 'Hossain', 'Nurul Islam', '1997-11-10', 'shahnaz.hossain@email.com', 'Female', 'Islam', '01923456789', 'Chattogram, Bangladesh', 23),
    ('Imran', 'Khan', 'Fazlul Haque', '1994-12-25', 'imran.khan@email.com', 'Male', 'Islam', '01634567890', 'Rajshahi, Bangladesh', 24),
    ('Tania', 'Akter', 'Iqbal Hossain', '1998-03-30', 'tania.akter@email.com', 'Female', 'Islam', '01745678901', 'Khulna, Bangladesh', 25),
    ('Jahangir', 'Alam', 'Md. Shah Alam', '2000-06-10', 'jahangir.alam@email.com', 'Male', 'Islam', '01856789012', 'Sylhet, Bangladesh', 26),
    ('Taslima', 'Jahan', 'Abdul Kader', '1995-11-01', 'taslima.jahan@email.com', 'Female', 'Islam', '01967890123', 'Dhaka, Bangladesh', 27),
    ('Mamun', 'Ahmed', 'Nazrul Islam', '1992-02-14', 'mamun.ahmed@email.com', 'Male', 'Islam', '01678901234', 'Chattogram, Bangladesh', 28),
    ('Shabnam', 'Akter', 'Kamal Hossain', '1999-05-27', 'shabnam.akter@email.com', 'Female', 'Islam', '01789012345', 'Rajshahi, Bangladesh', 29),
    ('Rahim', 'Hossain', 'Ashraf Ali', '1997-10-09', 'rahim.hossain@email.com', 'Male', 'Islam', '01890123456', 'Khulna, Bangladesh', 30),
    ('Tamanna', 'Akter', 'Sultan Ahmed', '1993-01-22', 'tamanna.akter@email.com', 'Female', 'Islam', '01901234567', 'Sylhet, Bangladesh', 31);

-- Insert values into Employees table 
INSERT INTO LMS.Employees (EmployeeName, Position, Salary, Photo, DateOfBirth, Address, Phone)
VALUES
    ('Abdul Rahman', 'Trainer', 20000, NULL, '1982-12-10', '24/A School Road, Dhaka', '01711223344'),
    ('Farida Begum', 'Computer Operator', 25000, NULL, '1990-05-22', '56/B IT Park, Chattogram', '01822334455'),
    ('Kamal Hossain', 'Trainer', 20000, NULL, '1975-10-08', '101 Corporate Avenue, Dhaka', '01933445566'),
    ('Tasnim Ahmed', 'Course Counselor', 25000, NULL, '1989-12-15', '12/C Education Street, Rajshahi', '01644556677'),
    ('Fariha Khan', 'Administrative Assistant', 18000, NULL, '1998-04-02', '78/D Administration Lane, Khulna', '01555667788'),
    ('Nadia Khan', 'IT Specialist', 22000, NULL, '1986-02-18', '45/E Software Lane, Dhaka', '01711223311'),
    ('Imran Ahmed', 'Marketing Executive', 30000, NULL, '1983-01-25', '78/G Marketing Street, Chattogram', '01822334422'),
    ('Sultana Akhtar', 'Finance Officer', 35000, NULL, '1979-04-15', '23/F Finance Road, Dhaka', '01933445533'),
    ('Rahat Islam', 'Trainer', 25000, NULL, '1980-10-30', '34/B Network Avenue, Rajshahi', '01644556644'),
    ('Salma Begum', 'Customer Service Representative', 18000, NULL, '1985-11-22', '67/I Customer Street, Khulna', '01555667755'),
    ('Rafiul Alam', 'Human Resources Specialist', 28000, NULL, '1973-01-12', '89/H HR Lane, Dhaka', '01711223300'),
    ('Tania Islam', 'Project Coordinator', 30000, NULL, '1987-07-07', '56/K QA Street, Chattogram', '01822334499'),
    ('Kabir Hossain', 'Trainer', 25000, NULL, '1972-10-05', '45/D Project Road, Dhaka', '01933445588'),
    ('Nishat Rahman', 'Operations Manager', 30000, NULL, '1980-04-20', '34/A Operations Lane, Rajshahi', '01644556677'),
    ('Jahanara Begum', 'Trainer', 25000, NULL, '1989-12-31', '23/B Web Avenue, Khulna', '01555667766'),
    ('Ayesha Begum', 'Trainer', 25000, NULL, '1988-04-15', '56/F Education Lane, Dhaka', '01711223355'),
    ('Zahid Islam', 'Trainer', 25000, NULL, '1991-07-22', '78/A Maintenance Street, Chattogram', '01822334466'),
    ('Nasrin Akter', 'Trainer', 20000, NULL, '1985-12-30', '34/G School Road, Dhaka', '01933445577'),
    ('Akash Rahman', '4th Class Employee', 10000, NULL, '1992-10-12', '12/D Facility Lane, Rajshahi', '01644556688'),
    ('Tahmina Khan', 'Trainer', 28000, NULL, '1983-07-18', '67/E Academic Street, Dhaka', '01555667799'),
    ('Mohammed Ali', 'Trainer', 24000, NULL, '1995-12-05', '23/I Grounds Road, Khulna', '01711223366'),
    ('Fariha Rahman', 'Trainer', 22000, NULL, '1980-02-29', '45/H Classroom Avenue, Dhaka', '01822334477'),
    ('Rahim Hossain', '4th Class Employee', 7000, NULL, '1990-09-20', '56/J Utility Street, Chattogram', '01933445588'),
    ('Akash Khan', 'Trainer', 17000, NULL, '1987-06-11', '34/F Education Road, Dhaka', '01644556699'),
    ('Abdul Malek', 'Trainer', 28000, NULL, '1993-11-15', '67/D Maintenance Lane, Rajshahi', '01555667700');


-- Insert values into Trainer table
INSERT INTO LMS.Trainers (EmployeeID, Specialty )
VALUES
    (101, 'Web Development'),
    (103, 'Spoken English'),
	(103, 'IELTS'),
    (109, 'Graphic Design'),
    (113, 'Digital Marketing'),
    (113, 'Financial Accounting'),
    (116, 'Machine Learning'),
	(116,'Data Science'), 
    (119, 'Data Analysis'),
    (121, 'Graphic Design'),
    (123, 'Spanish Language'),
	(124, 'GMAT'),
	(125, 'Ethical Hacking');
go
-- Insert data into the TrainerBatches table
INSERT INTO LMS.TrainerBatches (TrainerID, BatchID)
VALUES (201, 1),
       (202, 2);
go
-- Insert data into the Payments table
INSERT INTO LMS.Payments (StudentID, BatchID, Amount, PaymentDate)
VALUES (1, 1, 800, '2023-02-01'),
       (2, 2, 1200, '2023-03-01');

-- Insert data into the Attendance table
INSERT INTO LMS.Attendance (StudentID, BatchID, AttendanceDate, IsPresent)
VALUES (1, 1, '2023-01-20', 1),
       (2, 2, '2023-02-25', 0);

-- Insert data into the Exams table
INSERT INTO LMS.Exams (BatchID, ExamDate, Score)
VALUES (1, '2023-04-05', 90),
       (2, '2023-05-10', 85);

-- Insert data into the Certificates table
INSERT INTO LMS.[Certificates] (StudentID, CourseID, CertificateName, IssueDate)
VALUES (1, 1, 'Basic Spoken English Certificate', '2023-04-15'),
       (2, 2, 'Basic IELTS Preparation Certificate', '2023-04-20');

-- Insert data into the Expenses table
INSERT INTO LMS.Expenses (ExpenseType, Amount, ExpenseDate)
VALUES ('Office Supplies', 500, '2023-01-05'),
       ('Training Material', 1000, '2023-02-10');

-- Insert data into the Materials table
INSERT INTO LMS.Materials (MaterialName, Quantity)
VALUES ('Monitor', 10),
       ('Whiteboard', 5);

-- Insert data into the MaterialPurchases table
INSERT INTO MaterialPurchases (MaterialID, PurchaseDate, PurchaseQuantity, UnitPrice)
VALUES (1, '2023-01-10', 15, 800),
       (2, '2023-02-15', 12, 200);

/*
==============================  SECTION 02  ==============================
					INSERT DATA THROUGH STORED PROCEDURE
==========================================================================
*/
-- Call the sp_ManageStudent stored procedure to insert a new student
EXEC sp_ManageStudent 'INSERT', NULL, 'Rakibul ', 'Islam', 'Habibul Islam', '1995-11-20', 'rakibul@gmail.com', 'Male', 'Islam', '01234567894', '789 Trainee Lane';

-- Call the sp_EnrollStudent stored procedure to enroll a student in a batch
EXEC sp_EnrollStudent 1, 1, 1, '2023-01-15';

-- Call the sp_updateenrollment stored procedure to update an enrollment
EXEC sp_updateenrollment 1, 1, 1, 1, '2023-01-20';

-- Call the sp_deleteenrollment stored procedure to delete an enrollment
EXEC sp_deleteenrollment 1;
/*
==============================  SECTION 03  ==============================
					INSERT UPDATE DELETE DATA THROUGH VIEW
==========================================================================
*/
-- Insert data through the view for Student Enrollment
INSERT INTO vw_studentenrollmentview
    (StudentName, DateOfBirth, PhoneNo, EnrollmentDate, CourseName, BatchNo, Schedule)
VALUES
    ('Sakibul Hasan', '1990-05-15', '01234567890', '2023-01-01', 'Basic English', '01/Morning', 'Morning');

-- Update data through the view for Student Enrollment
UPDATE vw_studentenrollmentview
SET
    StudentName = 'Abul Hasan',
    DateOfBirth = '1992-08-20',
    PhoneNo = '01876543210'
WHERE StudentID = 1;

-- Delete data through the view for Student Enrollment
DELETE FROM vw_studentenrollmentview
WHERE StudentID = 1;

/*
==============================  SECTION 04  ==============================
					  RETREIVE DATA USING FUNCTION
==========================================================================
*/
-- Retrieve the next batch number for a given course using the scalar function
DECLARE @NextBatchNumber INT;

SET @NextBatchNumber = dbo.fn_GetNextBatchNumber(1); -- Provide the CourseID

SELECT @NextBatchNumber AS NextBatchNumber;

-- Example of using the table-valued function
DECLARE @trainerID INT = 201; -- Provide the TrainerID

SELECT *
FROM dbo.fn_GetTrainerBatches(@trainerID);

-- Retrieve enrolled students for a given batch using the simple table-valued function
SELECT *
FROM dbo.fn_GetAvailableSeats(1); -- Provide the BatchID

-- Retrieve total expenses using the multi-statement table-valued function
SELECT *
FROM dbo.fn_GetTotalExpenses();

-- Retrieve total income using the multi-statement table-valued function
SELECT *
FROM dbo.fn_GetTotalPayment();

/*
==============================  SECTION 05  ==============================
								  QUERY
==========================================================================
*/
--====== SUB SECTION => 5.01 : SELECT FROM TABLE
-- Select data from the Courses table
SELECT * FROM Courses;

-- Select data from the Branches table
SELECT * FROM LMS.Branches;

-- Select data from the Employees table
SELECT * FROM LMS.Employees;

-- Select data from the Trainers table
SELECT * FROM LMS.Trainers;

-- Select data from the Batches table
SELECT * FROM LMS.Batches;

-- Select data from the Students table
SELECT * FROM LMS.Students;

-- Select data from the TrainerBatches table
SELECT * FROM LMS.TrainerBatches;

-- Select data from the Enrollments table
SELECT * FROM LMS.Enrollments;

-- Select data from the Payments table
SELECT * FROM LMS.Payments;

-- Select data from the Attendance table
SELECT * FROM LMS.Attendance;

-- Select data from the Exams table
SELECT * FROM LMS.Exams;

-- Select data from the Certificates table
SELECT * FROM LMS.Certificates;

-- Select data from the Expenses table
SELECT * FROM LMS.Expenses;

-- Select data from the Materials table
SELECT * FROM LMS.Materials;

-- Select data from the MaterialPurchases table
SELECT * FROM LMS.MaterialPurchases;

-- Select data from the MaterialStatus table
SELECT * FROM LMS.MaterialStatus;

-- Select data from the FeedbackRatings table
SELECT * FROM LMS.FeedbackRatings;

-- Select data from the ProjectSubmissions table
SELECT * FROM LMS.ProjectSubmissions;


--====== SUB SECTION => 5.02 : SELECT FROM VIEW--
-- Example query to select data from the view
SELECT * FROM vw_studentenrollmentview;
go
--============== SUB SECTION 5.03: SELECT INTO ============--
-- Create a copy of the Students table
SELECT *
INTO LMS.StudentsCopy
FROM LMS.Students;

--============== SUB SECTION 5.04: IMPLICIT JOIN WITH WHERE BY CLAUSE, ORDER BY CLAUSE ============--
-- Select student information along with enrollment details for a specific batch
SELECT
    S.StudentID,
    CONCAT(S.FirstName, ' ', S.LastName) AS StudentName,
    S.DateOfBirth,
    S.PhoneNo,
    E.EnrollmentID,
    E.EnrollmentDate,
    C.CourseName,
    B.StartDate,
    B.EndDate,
    B.BatchNo,
    B.Schedule
FROM
    LMS.Students AS S,
    LMS.Enrollments AS E,
    LMS.Batches AS B,
    Courses AS C
WHERE
    S.StudentID = E.StudentID
    AND E.BatchID = B.BatchID
    AND E.CourseID = C.CourseID
    AND B.BatchID = 1 -- Replace with the desired BatchID
ORDER BY
    S.StudentID;

--============== SUB SECTION 5.05: INNER JOIN WITH GROUP BY CLAUSE ============--
-- Count the number of enrollments for each student
SELECT
    S.StudentID,
    CONCAT(S.FirstName, ' ', S.LastName) AS StudentName,
    COUNT(E.EnrollmentID) AS EnrollmentCount
FROM
    LMS.Students AS S
    INNER JOIN LMS.Enrollments AS E ON S.StudentID = E.StudentID
GROUP BY
    S.StudentID,
    S.FirstName,
    S.LastName
ORDER BY
    EnrollmentCount DESC;

--============== SUB SECTION 5.06: OUTER JOIN ============--
-- Select students along with their enrollments, including those with no enrollments
SELECT
    S.StudentID,
    CONCAT(S.FirstName, ' ', S.LastName) AS StudentName,
    E.EnrollmentID
FROM
    LMS.Students AS S
    LEFT OUTER JOIN LMS.Enrollments AS E ON S.StudentID = E.StudentID;

--============== SUB SECTION 5.07: CROSS JOIN ============--
-- Create all possible combinations of students and courses
SELECT
    S.StudentID,
    CONCAT(S.FirstName, ' ', S.LastName) AS StudentName,
    C.CourseID,
    C.CourseName
FROM
    LMS.Students AS S
    CROSS JOIN Courses AS C;

--============== SUB SECTION 5.08: TOP CLAUSE WITH TIES ============--
-- Select the top 3 students based on their enrollment count
SELECT TOP 3 WITH TIES
    S.StudentID,
    CONCAT(S.FirstName, ' ', S.LastName) AS StudentName,
    COUNT(E.EnrollmentID) AS EnrollmentCount
FROM
    LMS.Students AS S
    INNER JOIN LMS.Enrollments AS E ON S.StudentID = E.StudentID
GROUP BY
    S.StudentID,
    S.FirstName,
    S.LastName
ORDER BY
    EnrollmentCount DESC;

--============== SUB SECTION 5.09: DISTINCT ============--
-- Select unique courses from the Enrollments table
SELECT DISTINCT
    C.CourseID,
    C.CourseName
FROM
    LMS.Enrollments AS E
    INNER JOIN Courses AS C ON E.CourseID = C.CourseID;

--============== SUB SECTION 5.10: COMPARISON, LOGICAL(AND OR NOT) & BETWEEN OPERATOR ============--
-- Select Tariner with a salary greater than 50000 and not in the 'Basic' category
SELECT
    *
FROM
    LMS.Employees
WHERE
    Salary > 50000
    AND NOT Position IN ('Trainer');

--============== SUB SECTION 5.11: LIKE, IN, NOT IN, OPERATOR & IS NULL CLAUSE ============--
-- Select Trainer with a position containing 'Manager' or 'Supervisor'
SELECT
    *
FROM
    LMS.Employees
WHERE
    Position LIKE '%Manager%'
    OR Position LIKE '%Tainer%';

--============== SUB SECTION 5.12: OFFSET FETCH ============--
-- Select 5 students with an offset of 3 (Skip the first 3 rows)
SELECT
    *
FROM
    LMS.Students
ORDER BY
    StudentID
OFFSET 3 ROWS
FETCH NEXT 5 ROWS ONLY;

--============== SUB SECTION 5.13: UNION ============--
-- Combine results from Students and Employees tables
SELECT
    StudentID AS ID,
    FirstName,
    LastName,
    NULL AS Position
FROM
    LMS.Students
UNION
SELECT
    EmployeeID AS ID,
    NULL,
    NULL,
    Position
FROM
    LMS.Employees;

--============== SUB SECTION 5.15: AGGREGATE FUNCTIONS ============--
-- Calculate the average salary of employees
SELECT
    AVG(Salary) AS AverageSalary
FROM
    LMS.Employees;

--============== SUB SECTION 5.16: GROUP BY & HAVING CLAUSE ============--
-- Find courses with more than 10 enrollments
SELECT
    C.CourseID,
    C.CourseName,
    COUNT(E.EnrollmentID) AS EnrollmentCount
FROM
    LMS.Courses AS C
    LEFT OUTER JOIN LMS.Enrollments AS E ON C.CourseID = E.CourseID
GROUP BY
    C.CourseID,
    C.CourseName
HAVING
    COUNT(E.EnrollmentID) > 10;

--============== SUB SECTION 5.17: ROLLUP & CUBE OPERATOR ============--
-- Find the total enrollment count for each course and category, including overall totals
SELECT
    C.Category,
    C.CourseName,
    COUNT(E.EnrollmentID) AS EnrollmentCount
FROM
    LMS.Courses AS C
    LEFT OUTER JOIN LMS.Enrollments AS E ON C.CourseID = E.CourseID
GROUP BY
    ROLLUP (C.Category, C.CourseName);

	SELECT
    C.Category,
    C.CourseName,
    COUNT(E.EnrollmentID) AS EnrollmentCount
FROM
    LMS.Courses AS C
    LEFT OUTER JOIN LMS.Enrollments AS E ON C.CourseID = E.CourseID
GROUP BY
    CUBE (C.Category, C.CourseName);

--============== SUB SECTION 5.18: GROUPING SETS ============--
-- Find the total enrollment count for each course and category, including overall totals
SELECT
    C.Category,
    C.CourseName,
    COUNT(E.EnrollmentID) AS EnrollmentCount
FROM
    LMS.Courses AS C
    LEFT OUTER JOIN LMS.Enrollments AS E ON C.CourseID = E.CourseID
GROUP BY
    GROUPING SETS (
        (C.Category, C.CourseName),
        (C.Category),
        ()
    );

--============== SUB SECTION 5.19: SUB-QUERIES (INNER, CORRELATED) ============--

-- 5.19.01: INNER JOIN Subquery
-- Retrieve students and their enrolled courses using an INNER JOIN subquery
SELECT
    S.StudentID,
    S.FirstName,
    S.LastName,
    E.EnrollmentID,
    C.CourseName
FROM
    LMS.Students AS S
INNER JOIN
    LMS.Enrollments AS E ON S.StudentID = E.StudentID
INNER JOIN
    LMS.Courses AS C ON E.CourseID = C.CourseID;

-- 5.19.02: Correlated Subquery
-- Retrieve students with the count of their enrollments
SELECT
    StudentID,
    FirstName,
    LastName,
    (
        SELECT COUNT(EnrollmentID)
        FROM LMS.Enrollments
        WHERE StudentID = S.StudentID
    ) AS EnrollmentCount
FROM
    LMS.Students AS S;

--============== SUB SECTION 5.20: EXISTS ============--
-- Check if there are students enrolled in any course
IF EXISTS (SELECT 1 FROM LMS.Enrollments)
    PRINT 'There are enrolled students.'
ELSE
    PRINT 'No students are currently enrolled.';

--============== SUB SECTION 5.21: CTE ============--
-- Common Table Expression (CTE) example
WITH CTE_StudentNames AS (
    SELECT
        StudentID,
        CONCAT(FirstName, ' ', LastName) AS FullName
    FROM
        LMS.Students
)
SELECT * FROM CTE_StudentNames;

--============== SUB SECTION 5.22: MERGE ============--
-- MERGE statement example (upsert)
MERGE INTO LMS.Students AS Target
USING (
    VALUES
        (1, 'Sakib', 'Alom'),
        (2, 'Rakim', 'Ahmad')
) AS Source (StudentID, FirstName, LastName)
ON Target.StudentID = Source.StudentID
WHEN MATCHED THEN
    UPDATE SET
        Target.FirstName = Source.FirstName,
        Target.LastName = Source.LastName
WHEN NOT MATCHED THEN
    INSERT (StudentID, FirstName, LastName)
    VALUES (Source.StudentID, Source.FirstName, Source.LastName);

--============== SUB SECTION 5.23: BUILT-IN FUNCTIONS ============--
-- Example of a built-in function (LEN)
SELECT
    FirstName,
    LEN(FirstName) AS FirstNameLength
FROM
    LMS.Students;

--============== SUB SECTION 5.24: CASE ============--
-- Example of a CASE statement
SELECT
    StudentID,
    FirstName,
    LastName,
    CASE
        WHEN LEN(FirstName) > LEN(LastName) THEN 'First name is longer'
        WHEN LEN(FirstName) < LEN(LastName) THEN 'Last name is longer'
        ELSE 'First and last names are of equal length'
    END AS NameComparison
FROM
    LMS.Students;

--============== SUB SECTION 5.25: IIF ============--
-- Example of IIF function
SELECT
    StudentID,
    FirstName,
    LastName,
    IIF(LEN(FirstName) > LEN(LastName), 'First name is longer', 'Last name is longer') AS NameComparison
FROM
    LMS.Students;

--============== SUB SECTION 5.26: COALESCE & ISNULL ============--
-- Example of COALESCE and ISNULL functions
SELECT
    StudentID,
    FirstName,
    ISNULL(MiddleName, 'N/A') AS MiddleName,
    COALESCE(Email, 'No email provided') AS Email
FROM
    LMS.Students;


--============== SUB SECTION 5.28: GROUPING FUNCTION ============--
-- Example of GROUPING function with GROUP BY
SELECT
    CASE
        WHEN GROUPING(FirstName) = 1 THEN 'All Students'
        ELSE FirstName
    END AS GroupedFirstName,
    COUNT(*) AS StudentCount
FROM
    LMS.Students
GROUP BY
    FirstName WITH ROLLUP;

--============== SUB SECTION 5.29: RANKING FUNCTION ============--
-- Example of RANK() window function
SELECT
    StudentID,
    FirstName,
    LastName,
    CourseID,
    Marks,
    RANK() OVER (PARTITION BY CourseID ORDER BY Marks DESC) AS RankInCourse
FROM
    LMS.Enrollments;

--============== SUB SECTION 5.33: WAITFOR ============--
-- Example of WAITFOR DELAY
WAITFOR DELAY '00:00:03'; -- Wait for 3 seconds

--============== SUB SECTION 5.34: sp_helptext ============--
-- Example of sp_helptext to view the definition of a stored procedure
EXEC sp_helptext 'sp_updateenrollment';


