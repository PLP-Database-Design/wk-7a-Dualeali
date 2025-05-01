-- Question 1: Achieving 1NF (First Normal Form)
SELECT OrderID, CustomerName, TRIM(SUBSTRING_INDEX(SUBSTRING_INDEX(Products, ',', n.n), ',', -1)) AS Product
FROM ProductDetail
JOIN (SELECT 1 AS n UNION ALL SELECT 2 UNION ALL SELECT 3 UNION ALL SELECT 4 UNION ALL SELECT 5) n
    ON CHAR_LENGTH(Products) - CHAR_LENGTH(REPLACE(Products, ',', '')) >= n.n - 1;


-- Question 2: Achieving 2NF (Second Normal Form)
CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY AUTO_INCREMENT,
    CustomerName VARCHAR(255) NOT NULL
);

INSERT INTO Customers (CustomerName)
SELECT DISTINCT CustomerName FROM OrderDetails;

ALTER TABLE OrderDetails ADD COLUMN CustomerID INT;

UPDATE OrderDetails od
JOIN Customers c ON od.CustomerName = c.CustomerName
SET od.CustomerID = c.CustomerID;

ALTER TABLE OrderDetails DROP COLUMN CustomerName;
