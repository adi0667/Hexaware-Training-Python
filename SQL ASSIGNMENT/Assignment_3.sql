SELECT name FROM sys.databases WHERE database_id <= 4;

SELECT name, physical_name FROM sys.master_files WHERE database_id = DB_ID('CompanyDB');

CREATE DATABASE HRDB
ON PRIMARY 
(
    NAME = 'HRDB_Data',
    FILENAME = 'C:\Program Files\Microsoft SQL Server\MSSQL16.SQLEXPRESS\MSSQL\DATA\HRDB.mdf',
    SIZE = 10MB,
    MAXSIZE = UNLIMITED,
    FILEGROWTH = 2MB
)
LOG ON 
(
    NAME = 'HRDB_Log',
    FILENAME = 'C:\Program Files\Microsoft SQL Server\MSSQL16.SQLEXPRESS\MSSQL\DATA\HRDB.ldf',
    SIZE = 5MB,
    MAXSIZE = UNLIMITED,
    FILEGROWTH = 1MB
);

ALTER DATABASE HRDB MODIFY NAME = EmployeeDB;

DROP DATABASE EmployeeDB;

SELECT name AS DataType FROM sys.types;

CREATE TABLE Employees (
    EmpID INT PRIMARY KEY,
    EmpName VARCHAR(100) NOT NULL,
    JoinDate DATE NOT NULL,
    Salary DECIMAL(10,2) DEFAULT 30000.00
);

ALTER TABLE Employees ADD Department VARCHAR(50);

EXEC sp_rename 'Employees', 'Staff';

DROP TABLE Staff;


