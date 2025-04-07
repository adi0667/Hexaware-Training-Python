Declare @monthName NVARCHAR(50);
Declare @sql NVARCHAR(MAX);
Set @monthName  = DateName(month,GetDate());
Set  @sql = 'Select SalesID, SalesAmount as Sales_' + @monthName + ',SalesDate from SalesData;';
Exec sp_executesql @sql;


CREATE TABLE EmployeeSalary (
    EmployeeID INT ,
    EmployeeName VARCHAR(100),
    SalaryMonth VARCHAR(10),  -- Stores month names (e.g., 'January', 'February')
    SalaryAmount DECIMAL(10,2)
);

INSERT INTO EmployeeSalary (EmployeeID, EmployeeName, SalaryMonth, SalaryAmount)
VALUES
(1, 'Alice', 'January', 5000.00),
(1, 'Alice', 'February', 5200.00),
(1, 'Alice', 'March', 5300.00),
(2, 'Bob', 'January', 4800.00),
(2, 'Bob', 'February', 4900.00),
(2, 'Bob', 'March', 4950.00);


SELECT * 
FROM (
    SELECT EmployeeID, EmployeeName, SalaryMonth, SalaryAmount
    FROM EmployeeSalary
) AS SourceTable
PIVOT (
    MAX(SalaryAmount) 
    FOR SalaryMonth IN ([January], [February], [March], [April], [May], [June], 
                        [July], [August], [September], [October], [November], [December])
) AS PivotTable;

CREATE TABLE CustomerTransactions (
    TransactionID INT PRIMARY KEY,
    CustomerID INT, 
    TransactionAmount DECIMAL(10,2),
    TransactionDate DATE
);

INSERT INTO CustomerTransactions (TransactionID, CustomerID, TransactionAmount, TransactionDate)
VALUES
(1, 101, 500.00, '2025-03-01'),
(2, 101, 700.00, '2025-03-05'),
(3, 101, 600.00, '2025-03-03'),
(4, 101, 700.00, '2025-03-06'),
(5, 101, 800.00, '2025-03-07'),
(6, 102, 400.00, '2025-03-02'),
(7, 102, 900.00, '2025-03-10'),
(8, 102, 450.00, '2025-03-08'),
(9, 102, 500.00, '2025-03-12'),
(10, 102, 550.00, '2025-03-15');


WITH RankedTransactions AS (
    SELECT 
        TransactionID,
        CustomerID,
        TransactionAmount,
        TransactionDate,
        ROW_NUMBER() OVER (
            PARTITION BY CustomerID 
            ORDER BY TransactionAmount DESC, TransactionDate DESC
        ) AS Rank
    FROM CustomerTransactions
)
SELECT TransactionID, CustomerID, TransactionAmount, TransactionDate
FROM RankedTransactions
WHERE Rank <= 3
ORDER BY CustomerID, Rank;


CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    CustomerID INT, 
    OrderAmount DECIMAL(10,2),
    OrderDate DATE
);

INSERT INTO Orders (OrderID, CustomerID, OrderAmount, OrderDate)
VALUES
(1, 101, 500.00, '2024-03-10'),
(2, 101, 700.00, '2023-05-15'),
(3, 101, 600.00, '2024-07-20'),
(4, 102, 900.00, '2024-02-10'),
(5, 102, 800.00, '2023-08-25'),
(6, 103, 1000.00, '2023-06-14'),
(7, 103, 1200.00, '2024-01-05');

SELECT 
    CustomerID,
    SUM(OrderAmount) AS TotalOrderAmount,
    SUM(CASE WHEN YEAR(OrderDate) = YEAR(GETDATE()) THEN OrderAmount ELSE 0 END) AS TotalOrdersThisYear,
    SUM(CASE WHEN YEAR(OrderDate) = YEAR(GETDATE()) - 1 THEN OrderAmount ELSE 0 END) AS TotalOrdersLastYear
FROM Orders
GROUP BY CustomerID
ORDER BY CustomerID;


CREATE TABLE StudentScores (
    StudentID INT PRIMARY KEY,
    StudentName VARCHAR(100),
    Subject VARCHAR(50),
    Score INT
);

INSERT INTO StudentScores (StudentID, StudentName, Subject, Score)
VALUES
(1, 'Alice', 'Math', 95),
(2, 'Bob', 'Math', 90),
(3, 'Charlie', 'Math', 95),
(4, 'David', 'Math', 85),
(5, 'Alice', 'Science', 88),
(6, 'Bob', 'Science', 92),
(7, 'Charlie', 'Science', 88),
(8, 'David', 'Science', 80);


SELECT 
    Subject,
    StudentID,
    StudentName,
    Score,
    DENSE_RANK() OVER (
        PARTITION BY Subject 
        ORDER BY Score DESC
    ) AS Rank
FROM StudentScores
ORDER BY Subject, Rank;

