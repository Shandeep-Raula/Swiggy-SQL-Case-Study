-- 1. Find the customer who have never orderd.

SELECT name 
FROM users 
WHERE user_id NOT IN(SELECT user_id FROM orders);

----------------------------------------------------------------------------------------------------------------------------------

-- 2. Avarage price of dish

SELECT f.f_name, ROUND(AVG(m.price)) AS Avg_Price
FROM food AS f
JOIN menu AS m
ON f.f_id = m.f_id
GROUP BY f.f_name;

----------------------------------------------------------------------------------------------------------------------------------

-- 3. Whice dish are highest price

SELECT f.f_name, ROUND(AVG(m.price)) AS Avg_Price
FROM food AS f
JOIN menu AS m
ON f.f_id = m.f_id
GROUP BY f.f_name
ORDER BY Avg_Price DESC
LIMIT 1;

----------------------------------------------------------------------------------------------------------------------------------

-- 4. Find the top restaurants in terms of number of orders 

SELECT * FROM orders;

SELECT * FROM restaurants;

SELECT r.r_name , COUNT(o.r_id) AS Total_Orders , SUM(o.amount) AS Revenue
FROM restaurants AS r
JOIN orders AS o
ON o.r_id = r.r_id
GROUP BY r.r_name;

----------------------------------------------------------------------------------------------------------------------------------

-- 5. Find the top restaurants in terms of revenue

SELECT r.r_name , SUM(o.amount) AS Revenue
FROM restaurants AS r
JOIN orders AS o
ON o.r_id = r.r_id
GROUP BY r.r_name;

----------------------------------------------------------------------------------------------------------------------------------

-- 6. Show all orders with order details for a particular customer in a particular date range

SELECT r.r_name , f.f_name

FROM orders AS o
JOIN restaurants AS r
ON o.r_id = r.r_id

JOIN order_details AS od
ON o.order_id = od.order_id

JOIN food AS f 
ON f.f_id = od.f_id

WHERE user_id = (SELECT user_id FROM users WHERE name LIKE 'Ankit')
AND date BETWEEN '2022-06-10' AND  '2022-07-10';

----------------------------------------------------------------------------------------------------------------------------------

-- 7. Find restaurants with max repeated customer

SELECT r.r_name, COUNT(*) AS Loyal_Cutomer FROM 

	(SELECT r_id, user_id, COUNT(*) AS Visits FROM orders 
	GROUP BY r_id, user_id
	HAVING  COUNT(*) > 1) AS t 
	
JOIN restaurants AS r
ON r.r_id = t.r_id
GROUP BY  r.r_name
ORDER BY Loyal_Cutomer DESC
LIMIT 1;

----------------------------------------------------------------------------------------------------------------------------------

-- 8. Month over Month revenue growth
SELECT month , ((Revenue - Previous)/Previous)*100 AS Growth FROM (
	                      WITH sales AS 
	
			   				  (SELECT TO_CHAR(date,'Month') AS month , SUM(amount) AS Revenue
							   FROM orders
							   GROUP BY month , EXTRACT(MONTH FROM date)
							   ORDER BY EXTRACT(MONTH FROM date)
							  )

SELECT month, Revenue, LAG(Revenue,1) OVER(ORDER BY Revenue) AS Previous
FROM sales);

----------------------------------------------------------------------------------------------------------------------------------

-- 9. Customers Favorites Food

WITH cte AS (
		SELECT o.user_id, od.f_id , COUNT(*) AS frequecy
		FROM orders AS o
		JOIN order_details AS od
		ON o.order_id = od.order_id
		GROUP BY o.user_id, od.f_id)
SELECT u.name, f.f_name
FROM cte c1 
JOIN users AS u
ON u.user_id = c1.user_id					
JOIN food AS f					
ON f.f_id = c1.f_id	 				
WHERE c1.frequecy = (
	                 SELECT MAX(frequecy) 
	                 FROM cte c2 
	                WHERE c1.user_id=c2.user_id);






