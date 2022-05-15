# * selects everything present

USE sql_store;
SELECT *       
FROM customers
WHERE customer_id =1;

-- we can also use -- to comment

##### SELECT CLAUSE

-- instead of selecting everything we can also select specific columns/features

SELECT first_name,last_name,points,(points +100) AS add_points
FROM customers;
-- add_points is an alias that we are giving  we can add " add points" if we want space between the alias

SELECT state
FROM customers;
-- we can also select a single feature

SELECT DISTINCT state
FROM customers;
-- selects the distinct elements in a table

##### WHERE CLAUSE

SELECT *
FROM customers
WHERE points>3000;
-- we can also have <,>=,<=,!= / <> 

##### AND/OR/NOT OPERATORS

SELECT *
FROM customers
-- WHERE points>2000 and points<3000
-- WHERE points>3000 OR birth_date ="2019-01-01"
-- WHERE points >2000 OR birth_date ="2019-01-01" AND state="VA"
WHERE NOT(points >2000 OR birth_date ="2019-01-01" AND state="VA");
-- just like in maths where the order takes precedence in Sql AND > OR in order to negate this we can use parenthesis

##### IN OPERATOR

SELECT *
FROM customers
-- WHERE state IN ("VA","FL","GA")
-- using this we can know the customers in that states
WHERE state NOT IN ("VA","FL","GA")
-- we can also use not in 
;

##### BETWEEN OPERATOR

SELECT *
FROM customers
-- WHERE points>2000 and points>3000
WHERE points BETWEEN 2000 and 3000
-- with this we can select the clients with points between 2000 and 3000

