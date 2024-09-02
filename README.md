# LMS SQL Project

## Overview

The LMS SQL Project is a comprehensive SQL-based solution for managing a Learning Management System (LMS). This project includes scripts for creating and managing a database schema, inserting and updating data, and performing various operations related to courses, students, trainers, and materials. It also includes advanced features like triggers, stored procedures, views, and functions to handle complex data interactions and maintain data integrity.

## Project Structure

1. **Database Creation Scripts**
   - **Schema Creation**: Scripts to create the database schema and initial tables.
   - **Alterations and Modifications**: Scripts for schema changes, including adding or dropping columns and tables.

2. **Indexes**
   - Scripts to create and manage clustered and non-clustered indexes for performance optimization.

3. **Sequences**
   - Scripts for managing sequences used for generating unique IDs.

4. **Views**
   - **Student Enrollment View**: Combines student and enrollment data.
   - **Trainer Info View**: Provides encrypted and schema-bound trainer information.

5. **Stored Procedures**
   - **sp_ManageStudent**: Manages student data.
   - **sp_EnrollStudent**: Handles student enrollment.
   - **sp_updateenrollment**: Updates enrollment information.
   - **sp_deleteenrollment**: Deletes enrollment records.

6. **Functions**
   - **Scalar Functions**: Calculates batch numbers, available seats, etc.
   - **Table-Valued Functions**: Provides detailed data retrieval and reporting.

7. **Triggers**
   - **EnrollmentFinancialsTrigger**: Automatically creates payment records.
   - **MaterialAvailabilityTrigger**: Updates material status.

8. **Instead of Triggers**
   - **InsteadOfInsertTrigger**: Handles insert operations for payments with validations.

9. **Data Insertion**
   - **Direct Insertions**: Using `INSERT INTO` statements for inserting course, branch, batch, student, and employee data.
   - **Stored Procedure Insertion**: Using stored procedures for managing data insertion.

10. **Query Examples**
    - **SELECT Queries**: Demonstrates basic and advanced querying techniques.
    - **Joins, Aggregates, and Functions**: Includes examples of implicit joins, UNION, OFFSET FETCH, ROLLUP, and CUBE operations.

## Getting Started

### Prerequisites

- SQL Server or a compatible SQL database system.
- Basic understanding of SQL and database management.

### Installation

1. Clone the repository:
  
   git clone https://github.com/Sohail-IDB57/LMS_SQL_Project.git
   

2. Navigate to the project directory:
  
   cd LMS_SQL_Project
  

3. Run the database creation scripts in your SQL database management tool.

### Usage

1. **Run the Database Creation Scripts**: Execute the scripts in the provided order to set up the database schema.

2. **Insert Data**:
   - Use the `INSERT INTO` statements or stored procedures to add initial data.

3. **Perform Operations**:
   - Utilize the stored procedures, functions, and triggers to manage and query the data.

4. **Query Data**:
   - Use the provided query examples to retrieve and analyze data.

### Advanced Features

- **Triggers**: Automatically manage data consistency and integrity.
- **Views**: Simplify data retrieval and enhance security with encrypted views.
- **Stored Procedures and Functions**: Automate complex operations and calculations.

## Contribution

Contributions to the project are welcome. Please fork the repository and submit pull requests with your improvements.

## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.

