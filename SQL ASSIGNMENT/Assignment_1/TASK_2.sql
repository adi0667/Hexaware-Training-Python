-- 1. Retrieve the names and emails of all customers
SELECT FirstName, LastName, Email
FROM Customers;

-- 2. List all orders with their order dates and corresponding customer names
SELECT o.OrderID, o.OrderDate, c.FirstName, c.LastName
FROM Orders o
JOIN Customers c ON o.CustomerID = c.CustomerID;

-- 3. Insert a new customer record into the "Customers" table
INSERT INTO Customers (CustomerID, FirstName, LastName, Email, Phone, Address)
VALUES (234,'RIAN', 'MOHITE', 'RRAM@gmail.com', '9876543210', 'Pune, Pune');

-- 4. Update the prices of all electronic gadgets in the "Products" table by increasing them by 10%
UPDATE Products
SET Price = Price * 1.10
WHERE ProductName LIKE '%Gadget%' OR ProductName LIKE '%Electronics%';

-- 5. Delete a specific order and its associated order details from the "Orders" and "OrderDetails" tables
DELETE FROM OrderDetails WHERE OrderID = 1;
DELETE FROM Orders WHERE OrderID = 1;


-- 6. Insert a new order into the "Orders" table
INSERT INTO Orders (OrderID,CustomerID, OrderDate, TotalAmount)
VALUES (34523,105, '2025-03-25', 1000.00);


-- 7. Update the contact information of a specific customer in the "Customers" table
UPDATE Customers
SET Email = 'new.emai@gmail.com', Address = 'New Address, NewCity'
WHERE CustomerID = 1;

-- 8. Recalculate and update the total cost of each order in the "Orders" table
UPDATE o
SET o.TotalAmount = (
    SELECT SUM(od.Quantity * od.UnitPrice)
    FROM OrderDetails od
    WHERE od.OrderID = o.OrderID
)
FROM Orders o;

-- 9. Delete all orders and their associated order details for a specific customer
DELETE FROM OrderDetails WHERE OrderID IN (SELECT OrderID FROM Orders WHERE CustomerID = 1);
DELETE FROM Orders WHERE CustomerID = 1;


-- 10. Insert a new electronic gadget product into the "Products" table
INSERT INTO Products (ProductsID ,ProductName, Description, Price)
VALUES (23454, 'Smartwatch', 'Wearable smartwatch with fitness tracking', 199.99);



