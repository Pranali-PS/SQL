create database zommato;
use zommato;

# 1.Calculate total sales amount per restaurant:

select  r.name,sum(sales_amount) as totalsales
from orders as o
inner join restaurant as r
on o.r_id= r.id
group by r.name;

#2.
select name,rating
from restaurant 
where rating < 4
limit 3;

#3.Analyze sales trends over time:
SELECT YEAR(order_date) AS year, MONTH(order_date) AS month, SUM(sales_amount) AS total_sales_amount
FROM Orders
GROUP BY YEAR(order_date), MONTH(order_date)
ORDER BY year, month;

# Identify the most active users:

SELECT user_id, COUNT(*) AS total_orders
FROM Orders
GROUP BY user_id
ORDER BY total_orders DESC
LIMIT 5;

# 4.Analyze user demographics and preferences:

SELECT Gender, AVG(Age) AS averageage, COUNT(*) AS total_users
FROM Users
GROUP BY Gender;

# 5.Calculate average ratings and ratings distribution for restaurants:

select name,avg(rating)as avgratings ,count(*)total_ratings
from restaurant
group by name;

#6. Identify top-rated restaurants:
select name,city,cuisine,rating
from restaurant
where rating =(select max(rating)
from restaurant);

#7.Analyze pricing strategies:

SELECT AVG(price) AS average_price, MIN(price) AS min_price, MAX(price) AS max_price
FROM Menu;

#8.Set Operators for Menu Price Comparison:
SELECT f.item, m.price
FROM Menu m
JOIN Food f ON m.f_id = f.f_id
WHERE m.price > 10
UNION
SELECT f.item, m.price
FROM Menu m
JOIN Food f ON m.f_id = f.f_id
WHERE m.price <= 10;

#9. Case Statement for User Engagement:

select user_id,count(*)as totalorders,
case
     when count(*)>=10 then "active"
     else "inactive"
end as engagement_status
from orders
group by user_id
order by totalorders desc
limit 10;

# 10.Index for Menu Optimization:
CREATE INDEX idx_menu_price ON Menu(price);

#11. Top-Rated Restaurants
select name,city,cuisine,rating
from restaurant
where rating =(select max (rating)from restaurant);

# 12.Common Table Expression (CTE) for Menu Items with Low Sales

WITH LowSalesMenuItems AS (
    SELECT f.item, SUM(o.sales_qty) AS total_quantity_sold
    FROM Orders o
    JOIN Menu m ON o.r_id = m.r_id 
    JOIN Food f ON m.f_id = f.f_id
    GROUP BY f.item
)
SELECT item, total_quantity_sold
FROM LowSalesMenuItems
ORDER BY total_quantity_sold desc
LIMIT 5;


#13.Set Operators for Menu Price Comparison:
SELECT f.item, m.price
FROM Menu m
JOIN Food f ON m.f_id = f.f_id
WHERE m.price > 10
UNION
SELECT f.item, m.price
FROM Menu m
JOIN Food f ON m.f_id = f.f_id
WHERE m.price <= 10;

#14.Using CASE Statement to Categorize Restaurants by Rating:

select name,rating,
 case
	when rating >=4.5 then "excellent"
	when rating >=4.0 then "very good"
	when rating >=3.0 then "good"
 end as rating_category
from restaurant;

#15.Using Window Function to Rank Restaurants by Sales:
SELECT r.name, SUM(o.sales_amount) AS total_sales,
       RANK() OVER (ORDER BY SUM(o.sales_amount) DESC) AS sales_rank
FROM Orders o
JOIN Restaurant r ON o.r_id = r.id
GROUP BY r.name;
