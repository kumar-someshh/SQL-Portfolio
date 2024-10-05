1. Total Sales by Month

SELECT 
    EXTRACT(MONTH FROM OrderDate) AS Month,
    SUM(TotalAmount) AS TotalSales
FROM Orders
GROUP BY EXTRACT(MONTH FROM OrderDate)
ORDER BY Month;



2. Top 5 Bestselling Products

SELECT 
    P.ProductName, 
    SUM(OD.Quantity) AS TotalSold
FROM OrderDetails OD
JOIN Products P ON OD.ProductID = P.ProductID
GROUP BY P.ProductName
ORDER BY TotalSold DESC
LIMIT 5;



3. Top Customers by Revenue

SELECT 
    C.CustomerID, 
    C.Name, 
    SUM(O.TotalAmount) AS TotalRevenue
FROM Orders O
JOIN Customers C ON O.CustomerID = C.CustomerID
GROUP BY C.CustomerID, C.Name
ORDER BY TotalRevenue DESC
LIMIT 10;



4. Average Delivery Time by Shipper

SELECT 
    S.ShipperName, 
    AVG(S.DeliveryTime) AS AvgDeliveryTime
FROM Orders O
JOIN Shippers S ON O.ShipperID = S.ShipperID
GROUP BY S.ShipperName
ORDER BY AvgDeliveryTime;



5. Revenue from Discounts

SELECT 
    SUM(DiscountApplied) AS TotalDiscountRevenue
FROM Orders;



6. Churn Analysis (Customers Not Ordering in the Last 6 Months)

SELECT 
    C.CustomerID, 
    C.Name, 
    MAX(O.OrderDate) AS LastOrderDate
FROM Orders O
JOIN Customers C ON O.CustomerID = C.CustomerID
GROUP BY C.CustomerID, C.Name
HAVING MAX(O.OrderDate) < DATE_SUB(CURDATE(), INTERVAL 6 MONTH)
ORDER BY LastOrderDate DESC;



7. Low Stock Products

SELECT 
    ProductName, 
    Stock
FROM Products
WHERE Stock < 10
ORDER BY Stock;



8. RFM Analysis (Recency, Frequency, Monetary)

Recency Query (Days Since Last Purchase):

SELECT 
    C.CustomerID, 
    C.Name, 
    DATEDIFF(CURDATE(), MAX(O.OrderDate)) AS DaysSinceLastPurchase
FROM Orders O
JOIN Customers C ON O.CustomerID = C.CustomerID
GROUP BY C.CustomerID, C.Name
ORDER BY DaysSinceLastPurchase;
----------------------------------------------------------------------

Frequency Query (Number of Orders):

SELECT 
    C.CustomerID, 
    C.Name, 
    COUNT(O.OrderID) AS OrderFrequency
FROM Orders O
JOIN Customers C ON O.CustomerID = C.CustomerID
GROUP BY C.CustomerID, C.Name
ORDER BY OrderFrequency DESC;
-----------------------------------------------------------------------
Monetary Query (Total Spending):

SELECT 
    C.CustomerID, 
    C.Name, 
    SUM(O.TotalAmount) AS TotalSpent
FROM Orders O
JOIN Customers C ON O.CustomerID = C.CustomerID
GROUP BY C.CustomerID, C.Name
ORDER BY TotalSpent DESC;

---------------------------------------------------------------------










