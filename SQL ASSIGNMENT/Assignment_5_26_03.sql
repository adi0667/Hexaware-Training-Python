Create Table Employees(
EmployeeID Int Primary Key,
Name Varchar(50) Not Null,
Age Int Not Null,
Department Varchar(50),
Salary Decimal(10,2)
);

Insert into Employees(EmployeeID,Name,Age,Department,Salary)
Values
(121,'Akash',27,'Logistics',42000.00),
(231,'Rushi',26,'HR',54240.00),
(432,'Ajay',43,'IT',98000.00);

Update employees
set Salary = Salary + Salary*0.10;

Delete from Employees
where Department = 'IT';

Insert into Employees(EmployeeID,Name,Age,Department,Salary)
Values
(532,'Pranav',32,'IT',
      Case
	  When 25000 < 30000 Then 30000
	  else 25000
	  End
); 

Update Employees
Set Department = 'Senior Staff'
Where Salary < 50000.00;

Delete from Employees
where Age >= 60;

Select * from Employees
Where Department = 'HR' and Salary > 50000.00;

Select * from Employees
Order by Salary desc;

Select * from Employees
Where Age > 30;

Select * from Employees
Where Department in ('HR','Finance');

Select * from Employees
Where Salary between 30000 and 60000;

Select * From Employees
Where Name like ('A%');

Select * from Employees
Where Department not in ('IT');

Select * from Employees
Where Department in ('Sales','Marketing');

SELECT DISTINCT Department, EmployeeID, Name, Salary, Age
FROM Employees;

EXEC sp_rename 'Employees.EmployeeID', 'ID', 'COLUMN';
EXEC sp_rename 'Employees.Salary', 'MonthlyIncome', 'COLUMN';

Select * from Employees
Where Name like 'John' and MonthlyIncome > 40000


