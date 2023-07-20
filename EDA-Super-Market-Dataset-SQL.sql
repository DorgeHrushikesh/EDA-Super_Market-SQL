create database eda_super_market;

select * from supermarket

-- 1. Display the first 5 rows from the dataset.

SELECT Top 5 * FROM supermarket


-- 2. Display the last 5 rows from the dataset.

SELECT *
FROM (
    SELECT TOP 5 *
    FROM supermarket
    ORDER BY Invoice_ID DESC
) AS LastFiveRows
ORDER BY Invoice_ID ASC;


-- 3. Display random 5 rows from the dataset.

SELECT TOP 5 *
FROM supermarket
ORDER BY rand();


-- 4. Display count, min, max, avg, and std values for a column in the dataset.

SELECT 
    COUNT(gross_income) AS Count,
    MIN(gross_income) AS MinValue,
    MAX(gross_income) AS MaxValue,
    AVG(gross_income) AS AverageValue,
    STDEV(gross_income) AS StandardDeviation
FROM supermarket;


-- 5. Find the number of missing values.

SELECT COUNT(*) AS MissingValuesCount
FROM supermarket
WHERE Branch is NULL;


-- 6. Count the number of occurrences of each city.

SELECT City, COUNT(*) AS OccurrenceCount
FROM supermarket
GROUP BY City;


-- 7. Find the most frequently used payment method.

SELECT TOP 1 Payment, COUNT(*) AS PaymentCount
FROM supermarket
GROUP BY Payment
ORDER BY COUNT(*) DESC;


-- 8. Does The Cost of Goods Sold Affect The Ratings That The Customers Provide? 

select Rating,cogs from supermarket;


-- 9. Find the most profitable branch as per gross income.

SELECT * FROM supermarket;

SELECT TOP 1 Branch, gross_income
FROM supermarket
ORDER BY gross_income DESC;


-- 10.  Find the most used payment method city-wise.

SELECT * FROM supermarket;

SELECT City, Payment, COUNT(*) AS PaymentCount
FROM supermarket
GROUP BY City, Payment
HAVING COUNT(*) = (
    SELECT MAX(PaymentCount)
    FROM (
        SELECT City, COUNT(*) AS PaymentCount
        FROM supermarket
        GROUP BY City, Payment
    ) AS CityPaymentCounts
    WHERE CityPaymentCounts.City = supermarket.City
)
ORDER BY City;


-- 11. Find the product line purchased in the highest quantity.

SELECT * FROM supermarket;

SELECT TOP 1 Product_Line, SUM(Quantity) AS TotalQuantity
FROM supermarket
GROUP BY Product_Line
ORDER BY SUM(Quantity) DESC;


-- 12. Display the daily sales by day of the week.

SELECT * FROM supermarket;

UPDATE supermarket
SET date = CONVERT(date, [Date], 101);

SELECT * FROM supermarket;

SELECT 
    DATENAME(WEEKDAY, date) AS DayName,
    DATEPART(WEEKDAY, date) AS DayOfWeek,
    SUM(Total) AS TotalSum
FROM supermarket
GROUP BY DATENAME(WEEKDAY, date), DATEPART(WEEKDAY, date);


-- 13. Find the month with the highest sales.

SELECT 
    DATENAME(MONTH, Date) AS [Name],
    MONTH(Date) AS [Month],
    SUM(Total) AS [Total]
FROM supermarket
GROUP BY DATENAME(MONTH, Date), MONTH(Date)
ORDER BY SUM(Total) DESC;


-- 14. Find the time at which sales are highest.

SELECT * FROM supermarket;

SELECT 
    DATEPART(HOUR, [Time]) AS [Hour],
    SUM(Total) AS [Total]
FROM supermarket
GROUP BY DATEPART(HOUR, [Time])
ORDER BY SUM(Total) DESC;


-- 15. Which gender spends more on average?

SELECT 
    Gender,
    AVG([gross_income]) AS AverageGrossIncome
FROM supermarket
GROUP BY Gender;


--16. How does sales revenue vary across different product categories?

SELECT 
    Product_line,
    SUM(SaleAmount) AS TotalSales
FROM supermarket
GROUP BY Product_line
ORDER BY TotalSales DESC;



