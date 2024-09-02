# SQL Project: Learning Management System (LMS) Database

## Project Overview

This SQL project involves the creation and management of a Learning Management System (LMS) database. The database encompasses various aspects of an educational institute, including courses, batches, students, employees, payments, and more. The project includes Data Manipulation Language (DML) operations, stored procedures, views, functions, and queries to manage and analyze the data effectively.

## Table of Contents

1. [Database Schema](#database-schema)
2. [DML Operations](#dml-operations)
   - [Insert Data Using `INSERT INTO` Keyword](#section-01-insert-data-using-insert-into-keyword)
   - [Insert Data Through Stored Procedures](#section-02-insert-data-through-stored-procedure)
   - [Insert, Update, Delete Data Through Views](#section-03-insert-update-delete-data-through-view)
   - [Retrieve Data Using Functions](#section-04-retrieve-data-using-function)
   - [Queries](#section-05-query)
3. [Running the Project](#running-the-project)
4. [Additional Information](#additional-information)

## Database Schema

The LMS database includes the following tables:

- Courses
- Branches
- Batches
- Students
- Employees
- Trainers
- TrainerBatches
- Payments
- Attendance
- Exams
- Certificates
- Expenses
- Materials
- MaterialPurchases
- MaterialStatus
- FeedbackRatings
- ProjectSubmissions

## DML Operations

### Section 01: Insert Data Using `INSERT INTO` Keyword

In this section, data is inserted into various tables such as `Courses`, `Branches`, `Batches`, `Students`, `Employees`, `Trainers`, and more. Examples include:

- Adding course details.
- Inserting batch information for each course.
- Adding student records.
- Inserting employee and trainer details.

### Section 02: Insert Data Through Stored Procedures

Stored procedures are used for managing data with specific operations:

- `sp_ManageStudent`: Insert a new student.
- `sp_EnrollStudent`: Enroll a student in a batch.
- `sp_updateenrollment`: Update an existing enrollment.
- `sp_deleteenrollment`: Delete an enrollment.

### Section 03: Insert, Update, Delete Data Through Views

Data manipulation through views includes:

- Inserting student enrollment data through the view `vw_studentenrollmentview`.
- Updating student information.
- Deleting student records.

### Section 04: Retrieve Data Using Functions

Functions are used for various data retrieval operations:

- `fn_GetNextBatchNumber`: Retrieve the next batch number for a given course.
- `fn_GetTrainerBatches`: Get batches assigned to a trainer.
- `fn_GetAvailableSeats`: Retrieve enrolled students for a given batch.
- `fn_GetTotalExpenses`: Get total expenses.
- `fn_GetTotalPayment`: Get total income.

### Section 05: Query

Various queries demonstrate SQL capabilities:

- **Select Queries:** Retrieve data from different tables.
- **Joins:** Use implicit joins, inner joins, outer joins, and cross joins.
- **Aggregations:** Calculate averages, counts, and totals.
- **Subsections:** Includes `TOP`, `DISTINCT`, `UNION`, `GROUP BY`, `ROLLUP`, `CUBE`, `GROUPING SETS`, and more.

## Running the Project

To run this project:

1. **Create the Database:**
   - Execute the database creation script to set up the `LearningManagementSystemDB` database.

2. **Execute the SQL Scripts:**
   - Run the provided SQL scripts to insert data, create stored procedures, views, and functions.

3. **Perform Queries:**
   - Execute the queries to retrieve and analyze data as needed.

## Additional Information

- Ensure that all necessary permissions are granted for creating tables, views, and stored procedures.
- Modify any database-specific settings or values as needed before executing the scripts.
- Review the results of the queries to ensure that the data is being manipulated and retrieved correctly.

