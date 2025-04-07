select name 
from sys.databases;

USE master;
GO
SELECT name AS [Logical Name], physical_name AS [File Path]
FROM sys.master_files
WHERE database_id = DB_ID('SalesDB');

Create database InventoryDB;

Alter Database InventoryDB
Modify Name = StockSB;

ALTER DATABASE StockSB
SET SINGLE_USER
WITH ROLLBACK IMMEDIATE;
Drop Database StockSB;

select name as datatype
from sys.types
where is_user_defined = 0;

Create table Products(
ProductID INT Primary Key,
ProductName Varchar(50)Not Null,
Price Decimal(10,2) Not Null,
StockQuantity INT Default 0
);

Alter Table Products
Add Category Varchar(30) Not Null;

EXEC sp_rename 'Products','Inventory';

Drop Table Inventory;

Select name
from sys.databases
where name in('master','model','msdb','tempdb');

USE master;
GO
SELECT name AS [Logical Name], physical_name AS [File Path], type_desc AS [File Type]
FROM sys.master_files
WHERE database_id = DB_ID('master'); 


CREATE DATABASE SalesDB

ALter database SalesDB
modify name = RetailDB;

ALTER DATABASE RetailDB
SET SINGLE_USER
WITH ROLLBACK IMMEDIATE;
Drop Database RetailDB;

select name
from sys.databases;

Create Database CompanyDB;
select name as[Logical Name], physical_name as [File Path]
from sys.master_files
where database_id = DB_ID('ST');

create database HRDB;

EXEC sp_renamedb HRDB,EmployeeDB;

ALTER DATABASE EmployeeDB
SET SINGLE_USER
WITH ROLLBACK IMMEDIATE;
Drop Database EmployeeDB;


select name as datatype
from sys.types;

Create table Employees(
EmpID INT Primary Key,
EmpName Varchar(100) Not Null,
JoinDate Date Not Null,
Salary Decimal(10,2) Default 30000.00
);

Alter table Employees
Add Department Varchar(50) Not Null;

Exec sp_rename Employees,Staff;


Use Master
Alter database Staff
Set Single_User
With Rollback Immediate
Drop Database Staff;


CREATE DATABASE InventoryDB  
ON  
(  
    NAME = InventoryDB_Data,  
    FILENAME = 'C:\Program Files\Microsoft SQL Server\MSSQL16.SQLEXPRESS\MSSQL\DATA\\InventoryDB.mdf',  
    SIZE = 5MB,  
    MAXSIZE = 50MB,  
    FILEGROWTH = 5MB  
)  
LOG ON  
(  
    NAME = InventoryDB_Log,  
    FILENAME = 'C:\Program Files\Microsoft SQL Server\MSSQL16.SQLEXPRESS\MSSQL\DATA\\InventoryDB.ldf',  
    SIZE = 2MB,  
    MAXSIZE = 20MB,  
    FILEGROWTH = 2MB  
);

select serverproperty('InstanceDefaultDataPath') AS DefaultDataPath;
 

 Create table SalesData(
 SalesID INT Primary Key,
 Product_Name Varchar(50),
 SalesAmount Decimal(10,2),
 SalesDate Datetime
 );

DECLARE @sql NVARCHAR(MAX);
DECLARE @monthName NVARCHAR(20);
SET @monthName = DATENAME(MONTH, GETDATE());
SET @sql = N'SELECT SalesAmount AS Sales_' + @monthName + ' FROM dbo.SalesData';
EXEC sp_executesql @sql;


