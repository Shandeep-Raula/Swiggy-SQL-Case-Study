CREATE TABLE orders(
    order_id INT,
	user_id INT,
	r_id INT,
	amount INT,
	date DATE,
	partner_id INT,
	delivery_time INT,
	delivery_rating INT,
	restaurant_rating INT
);

CREATE TABLE users(
	user_id INT,
    name VARCHAR,
	email VARCHAR,
	password VARCHAR
);

CREATE TABLE menu(
	menu_id INT,
    r_id INT,
	f_id INT,
	price INT
);

CREATE TABLE order_details(
	id INT,
    order_id INT,
	f_id INT
);

CREATE TABLE delivery_partner(
	partner_id INT,
    partner_name VARCHAR
);

CREATE TABLE food(
	f_id INT,
    f_name VARCHAR,
	type VARCHAR
);

CREATE TABLE restaurants(
	r_id INT,
    r_name VARCHAR,
	cuisine VARCHAR
);

SELECT * FROM restaurants;

SELECT * FROM food;

SELECT * FROM delivery_partner;

SELECT * FROM order_details;

SELECT * FROM users;

SELECT * FROM orders;

SELECT * FROM menu;


