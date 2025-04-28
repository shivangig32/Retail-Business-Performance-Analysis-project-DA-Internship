CREATE DATABASE IF NOT EXISTS superstore_project;
USE superstore_project;
CREATE TABLE IF NOT EXISTS superstore_data (
    Row_ID INT PRIMARY KEY,
    Order_ID VARCHAR(20),
    Order_Date DATE,
    Ship_Date DATE,
    Ship_Mode VARCHAR(50),
    Customer_ID VARCHAR(20),
    Customer_Name VARCHAR(100),
    Segment VARCHAR(50),
    Country VARCHAR(50),
    City VARCHAR(50),
    State VARCHAR(50),
    Postal_Code VARCHAR(20),
    Region VARCHAR(20),
    Product_ID VARCHAR(20),
    Category VARCHAR(50),
    Sub_Category VARCHAR(50),
    Product_Name VARCHAR(200),
    Sales DECIMAL(10,2),
    Quantity INT,
    Discount DECIMAL(5,2),
    Profit DECIMAL(10,2)
);
SELECT * FROM superstore_data
LIMIT 10;
-- Category and Sub-Categorywise profitability
SELECT Category, Sub_Category,
       ROUND(SUM(Sales),2) AS Total_Sales,
       ROUND(SUM(Profit),2) AS Total_Profit,
       ROUND((SUM(Profit) / SUM(Sales)) * 100,2) AS Profit_Margin_Percentage
FROM superstore_data
GROUP BY Category, Sub_Category
ORDER BY Profit_Margin_Percentage ASC;

-- Top 5 Loss- Making Sub-Categories
SELECT Sub_Category,
       ROUND(SUM(Profit),2) AS Total_Profit
FROM superstore_data
GROUP BY Sub_Category
ORDER BY Total_Profit ASC
LIMIT 5;

-- Monthly Sales Trend
SELECT MONTH(Order_Date) AS Order_Month,
       ROUND(SUM(Sales),2) AS Total_Sales,
       ROUND(SUM(Profit),2) AS Total_Profit
FROM superstore_data
GROUP BY Order_Month
ORDER BY Order_Month;

-- Region-Wise Sales and Profit
SELECT Region,
       ROUND(SUM(Sales),2) AS Total_Sales,
       ROUND(SUM(Profit),2) AS Total_Profit
FROM superstore_data
GROUP BY Region
ORDER BY Total_Profit DESC;

-- Products with Heavy Discount But Low Profit
SELECT Product_Name,
       ROUND(AVG(Discount)*100,2) AS Avg_Discount_Percentage,
       ROUND(SUM(Profit),2) AS Total_Profit
FROM superstore_data
WHERE Discount > 0.2
GROUP BY Product_Name
ORDER BY Total_Profit ASC
LIMIT 10;

-- Top Customers by Profit Contribution
SELECT Customer_Name,
       ROUND(SUM(Profit),2) AS Total_Profit
FROM superstore_data
GROUP BY Customer_Name
ORDER BY Total_Profit DESC
LIMIT 10;
