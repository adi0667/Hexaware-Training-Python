CREATE DATABASE TechShop;
USE TechShop;

CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    Email VARCHAR(100),
    Phone VARCHAR(15),
    Address VARCHAR(255)
);


CREATE TABLE Products (
    ProductID INT PRIMARY KEY,
    ProductName VARCHAR(100) NOT NULL,
    Description TEXT,
    Price DECIMAL(10, 2) NOT NULL
);


CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    CustomerID INT,
    OrderDate DATE NOT NULL,
    TotalAmount DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);


CREATE TABLE OrderDetails (
    OrderDetailID INT PRIMARY KEY,
    OrderID INT,
    ProductID INT,
    Quantity INT NOT NULL,
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID),
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);


CREATE TABLE Inventory (
    InventoryID INT PRIMARY KEY,
    ProductID INT,
    QuantityInStock INT NOT NULL,
    LastStockUpdate DATE,
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);


INSERT INTO Customers (CustomerID, FirstName, LastName, Email, Phone, Address) VALUES
(1, 'Amit', 'Sharma', 'amit.sharma@example.com', '987-654-3210', '123 MG Road, Bangalore, Karnataka'),
(2, 'Priya', 'Patel', 'priya.patel@example.com', '987-654-3211', '456 Andheri East, Mumbai, Maharashtra'),
(3, 'Rajesh', 'Singh', 'rajesh.singh@example.com', '987-654-3212', '789 Park Street, Kolkata, West Bengal'),
(4, 'Neha', 'Iyer', 'neha.iyer@example.com', '987-654-3213', '101 Vasant Vihar, New Delhi'),
(5, 'Ravi', 'Verma', 'ravi.verma@example.com', '987-654-3214', '202 Banjara Hills, Hyderabad, Telangana'),
(6, 'Sita', 'Gupta', 'sita.gupta@example.com', '987-654-3215', '303 Rameshwar Road, Lucknow, Uttar Pradesh'),
(7, 'Vikram', 'Reddy', 'vikram.reddy@example.com', '987-654-3216', '404 Bannerghatta Road, Bangalore, Karnataka'),
(8, 'Sonal', 'Kumar', 'sonal.kumar@example.com', '987-654-3217', '505 DLF Phase-1, Gurgaon, Haryana'),
(9, 'Karan', 'Yadav', 'karan.yadav@example.com', '987-654-3218', '606 Greater Kailash, New Delhi'),
(10, 'Meena', 'Nair', 'meena.nair@example.com', '987-654-3219', '707 Ernakulam, Kerala');


INSERT INTO Products (ProductID, ProductName, Description, Price) VALUES
(1, 'Laptop', 'High-performance laptop with 16GB RAM', 999.99),
(2, 'Smartphone', 'Latest model smartphone with 5G support', 599.99),
(3, 'Tablet', '10-inch tablet with high resolution display', 399.99),
(4, 'Headphones', 'Noise-cancelling over-ear headphones', 199.99),
(5, 'Smartwatch', 'Waterproof smartwatch with fitness tracking', 149.99),
(6, 'Camera', 'Digital SLR camera with 24MP resolution', 799.99),
(7, 'Speaker', 'Portable Bluetooth speaker with stereo sound', 129.99),
(8, 'Mouse', 'Ergonomic wireless mouse for comfortable use', 29.99),
(9, 'Keyboard', 'Mechanical keyboard with RGB backlighting', 89.99),
(10, 'Monitor', '27-inch Full HD monitor with slim bezels', 199.99);


INSERT INTO Orders (OrderID, CustomerID, OrderDate, TotalAmount) VALUES
(1, 1, '2025-03-01', 1299.98),
(2, 2, '2025-03-02', 799.99),
(3, 3, '2025-03-03', 399.99),
(4, 4, '2025-03-04', 699.98),
(5, 5, '2025-03-05', 149.99),
(6, 6, '2025-03-06', 999.99),
(7, 7, '2025-03-07', 599.99),
(8, 8, '2025-03-08', 229.98),
(9, 9, '2025-03-09', 1199.98),
(10, 10, '2025-03-10', 89.99);


INSERT INTO OrderDetails (OrderDetailID, OrderID, ProductID, Quantity) VALUES
(1, 1, 1, 1),
(2, 1, 4, 1),
(3, 2, 2, 1),
(4, 3, 3, 1),
(5, 4, 4, 2),
(6, 5, 5, 1),
(7, 6, 6, 1),
(8, 7, 7, 1),
(9, 8, 8, 1),
(10, 9, 9, 1);


INSERT INTO Inventory (InventoryID, ProductID, QuantityInStock, LastStockUpdate) VALUES
(1, 1, 50, '2025-03-01'),
(2, 2, 30, '2025-03-02'),
(3, 3, 40, '2025-03-03'),
(4, 4, 20, '2025-03-04'),
(5, 5, 100, '2025-03-05'),
(6, 6, 25, '2025-03-06'),
(7, 7, 60, '2025-03-07'),
(8, 8, 75, '2025-03-08'),
(9, 9, 15, '2025-03-09'),
(10, 10, 10, '2025-03-10');
