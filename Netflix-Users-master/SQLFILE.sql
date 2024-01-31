
SELECT 
    *
FROM
    netflix;

-- Check for Null Values

SELECT 
    *
FROM
    netflix
WHERE
    'subscriotion Type' IS NULL
        OR `Monthly Revenue` IS NULL
        OR `Join Date` IS NULL
        OR `Last Payment Date` IS NULL
        OR Device IS NULL;

-- Check for Duplicate Rows

SELECT DISTINCT
    COUNT(*)
FROM
    netflix;


SELECT 
    `User ID`,
    `Subscription Type`,
    `Join Date`,
    Country,
    Age,
    Gender,
    Device,
    COUNT(*) AS Count
FROM
    netflix
GROUP BY `User ID` , `Subscription Type` , `Join Date` , Country , Age , Gender , Device
HAVING Count > 1;


-- Drop Unused Column

Alter Table netflix
Drop Column Column1 ;


-- Create Age Distribution Column

Alter table netflix
Add Column Age_Distribution varchar(10) ;

SELECT 
    MIN(Age) AS MIN, MAX(Age) AS MAX
FROM
    netflix;
    
    
UPDATE netflix 
SET 
    Age_Distribution = CASE
        WHEN age BETWEEN 25 AND 30 THEN '25-30'
        WHEN age BETWEEN 31 AND 35 THEN '31-35'
        WHEN age BETWEEN 36 AND 40 THEN '36-40'
        WHEN age BETWEEN 41 AND 45 THEN '41-45'
        WHEN age BETWEEN 46 AND 50 THEN '46-50'
        ELSE '>50'
    END;



-- Create Year Columns

SELECT 
    MID(`Join Date`, 4, 2) AS Month,
    RIGHT(`Join Date`, 4) AS Year
FROM
    netflix;

Alter Table netflix
Add Column Year int ;

UPDATE netflix 
SET 
    Year = RIGHT(`Join Date`, 4);


-- Create Month Column

Alter Table netflix
Add Column Month varchar(10) ;

UPDATE netflix 
SET 
    Month = MID(`Join Date`, 4, 2);

           
UPDATE netflix 
SET 
    Month = CASE
        WHEN Month = 01 THEN 'January'
        WHEN Month = 02 THEN 'February'
        WHEN Month = 03 THEN 'March'
        WHEN Month = 04 THEN 'April'
        WHEN Month = 05 THEN 'May'
        WHEN Month = 06 THEN 'June'
        WHEN Month = 07 THEN 'July'
        WHEN Month = 08 THEN 'August'
        WHEN Month = 09 THEN 'September'
        WHEN Month = 10 THEN 'October'
        WHEN Month = 11 THEN 'November'
        WHEN Month = 12 THEN 'December'
        ELSE 'unknown'
    END;
    
    
-- Total Revenue by (Subscription Type)

SELECT 
    `Subscription Type`,
    Gender,
    Year,
    ROUND(AVG(`Monthly Revenue`), 2) AS Average_Revenue,
    ROUND(SUM(`Monthly Revenue`), 2) AS Total_Revenue,
    COUNT('User ID') AS Users
FROM
    netflix
GROUP BY `Subscription Type`, Gender,Year
ORDER BY Average_Revenue DESC;
		
                   
-- Count of Users Yearly Joined

SELECT 
    Year,
    COUNT(`User ID`) AS Users,
    ROUND(SUM(`Monthly Revenue`), 2) AS Total_Revenue
FROM
    netflix
GROUP BY Year
ORDER BY Users DESC;

-- Count of Users Monthly Joined

SELECT 
    Month,
    COUNT(`User ID`) AS Users,
    ROUND(SUM(`Monthly Revenue`), 2) AS Total_Revenue
FROM
    netflix
GROUP BY Month
ORDER BY Users DESC;


-- Which Gender have more Users  

SELECT 
    gender,
    COUNT(`User ID`) AS Users,
    SUM(`Monthly Revenue`) AS Total_Revenue
FROM
    netflix
GROUP BY gender
ORDER BY Users DESC;

-- Top 5 Countries have Users

SELECT 
    Country,
    COUNT(`User ID`) AS Users,
    SUM(`Monthly Revenue`) AS Total_Revenue
FROM
    netflix
GROUP BY Country
ORDER BY Country DESC
LIMIT 5;


-- The most Type of Device have more Users and Revenue

SELECT 
    Device,
    COUNT(`User ID`) AS Users,
    SUM(`Monthly Revenue`) AS 'Total Revenue'
FROM
    netflix
GROUP BY Device
ORDER BY Users DESC;

-- Which Age Group has more Users and Revenue

SELECT 
    Age_Distribution,
    COUNT(`User ID`) AS Users,
    SUM(`Monthly Revenue`) AS 'Total Revenue'
FROM
    netflix
GROUP BY Age_Distribution
ORDER BY Users DESC;


