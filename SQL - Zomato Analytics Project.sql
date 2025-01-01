-- Create Zomato Database and Use it
CREATE DATABASE zomato;
USE zomato;

-- Loaded Country, Currency, and Main1 Tables from the Table Import Wizard.
-- Cleaned the data using Power Query Editor. Removed irrelevant columns, 
-- added required columns, and formatted the date to 'yyyy-dd-mm'.

-- Query 1: Retrieve all data from country table
SELECT * FROM country;

-- Query 2: Retrieve all data from currency table
SELECT * FROM currency;

-- Query 3: Retrieve all data from main1 table
SELECT * FROM main1;

-- Query 4: Count the number of restaurants by restaurant id
SELECT COUNT(restaurantid) FROM main1;

-- Query 5: Count the number of restaurants by restaurant name
SELECT COUNT(restaurant_name) FROM main1;

-- ------- Number of Restaurants Based on City and Country -------

-- Query 6: Restaurants count per city
SELECT city, COUNT(restaurantid) 
FROM main1
GROUP BY city;

-- Query 7: Restaurants count per country
SELECT countryname, COUNT(restaurantid) 
FROM main1 m
LEFT JOIN country c ON m.countrycode = c.countryid
GROUP BY countryname;

-- Query 8: Restaurants count per city and country
SELECT m.city, COUNT(m.restaurantid) AS city_count, c.countryname
FROM main1 m
LEFT JOIN country c ON m.countrycode = c.countryid
GROUP BY m.city, c.countryname;

-- ------- Number of Restaurants Opening Based on Year, Quarter, Month -------

-- Query 9: Total restaurants opened yearwise
SELECT Year, COUNT(RestaurantID) AS NumberOfRestaurants
FROM main1
GROUP BY Year
ORDER BY Year;

-- Query 10: Total restaurants opened monthwise
SELECT Month, COUNT(RestaurantID) AS NumberOfRestaurants
FROM main1
GROUP BY Month
ORDER BY Month;

-- Query 11: Total restaurants opened quarterly
SELECT Quarter, COUNT(RestaurantID) AS NumberOfRestaurants
FROM main1
GROUP BY Quarter
ORDER BY Quarter;

-- ------- Count of Restaurants Based on Average Ratings -------

-- Query 12: Count of restaurants by average rating
SELECT Rating, COUNT(RestaurantID) AS NumberOfRestaurants
FROM main1
GROUP BY Rating
ORDER BY Rating ASC;

-- ------- Create Buckets Based on Average Price and Count Restaurants in Each Bucket -------

-- Query 13: Create price buckets and count restaurants
SELECT 
    CASE
        WHEN Average_Cost_for_two BETWEEN 0 AND 300 THEN '0-300'
        WHEN Average_Cost_for_two BETWEEN 301 AND 600 THEN '301-600'
        WHEN Average_Cost_for_two BETWEEN 601 AND 1000 THEN '601-1000'
        WHEN Average_Cost_for_two BETWEEN 1001 AND 430000 THEN '1001-430000'
        ELSE 'Other'
    END AS PriceBucket,
    COUNT(RestaurantID) AS NumberOfRestaurants
FROM main1
GROUP BY PriceBucket
ORDER BY PriceBucket;

-- ------- Percentage of Restaurants Based on "Has_Table_booking" -------

-- Query 14: Percentage of restaurants that offer table booking
SELECT 
    Has_Table_booking,
    COUNT(RestaurantID) AS NumberOfRestaurants,
    ROUND((COUNT(RestaurantID) * 100.0 / (SELECT COUNT(*) FROM main1)), 2) AS Percentage
FROM main1
GROUP BY Has_Table_booking;

-- ------- Percentage of Restaurants Based on "Has_Online_delivery" -------

-- Query 15: Percentage of restaurants that offer online delivery
SELECT 
    Has_Online_delivery,
    COUNT(RestaurantID) AS NumberOfRestaurants,
    ROUND((COUNT(RestaurantID) * 100.0 / (SELECT COUNT(*) FROM main1)), 2) AS Percentage
FROM main1
GROUP BY Has_Online_delivery;

-- ------- Total Cuisines -------

-- Query 16: Count of restaurants based on cuisines
SELECT 
    Cuisines, 
    COUNT(RestaurantID) AS NumberOfRestaurants
FROM main1
GROUP BY Cuisines
ORDER BY NumberOfRestaurants DESC;

