##### INNER JOINS
					-- when we join tables in the same schema we call it an inner join

SELECT o.order_id,o.customer_id,c.first_name,c.last_name
FROM orders o -- (o acts as an alias)
JOIN customers c
	ON o.customer_id = c.customer_id ;
    
##### JOINING ACROSS DATABASES
								-- when we are joing tables in different schemas.

SELECT *
FROM order_items oi
JOIN sql_inventory.products p
	ON oi.product_id = p.product_id ; 
    
##### SELF JOINS
				-- joining data in the same table with itself
USE sql_hr;
SELECT e.employee_id,e.first_name,m.first_name AS "reports to"
FROM employees E
JOIN employees m
	ON e.reports_to = m.employee_id ; 

#### JOINING MULTIPLE TABLES

SELECT o.order_id,o.order_date,c.first_name,c.last_name,os.name as status
FROM orders o
JOIN customers c
	ON o.customer_id = c.customer_id
JOIN order_statuses os
	ON o.status = os.order_status_id ; 
    
##### COMPOUND JOIN CONDITIONS
							-- generally most data contains a single primary key but there could be instances where we have 
-- multiple primary keys

SELECT *
FROM order_items oi
JOIN order_item_notes oin
	ON oi.product_id = oin.product_id
    AND oi.order_id = oin.order_id ; 

##### IMPLICIT JOIN

SELECT *
FROM orders o ,customers c
WHERE o.customer_id = c.customer_id ;

#### OUTER JOINS
				
SELECT c.customer_id,c.first_name,o.order_id
FROM customers c

# LEFT JOIN orders o
#  	ON c.customer_id = o.customer_id
# ORDER BY c.customer_id

RIGHT JOIN orders o
	ON c.customer_id  = o.customer_id
ORDER BY c.customer_id ; 

-- INNER JOIN: returns rows when there is a match in both tables. 
-- LEFT JOIN: returns all rows from the left table, even if there are no matches in the right table. 
-- RIGHT JOIN: returns all rows from the right table, even if there are no matches in the left table

##### SELF OUTER JOINS

USE sql_hr;
SELECT e.employee_id,e.first_name,m.first_name AS manager
FROM employees e
LEFT JOIN employees m
	ON e.reports_to = m.employee_id ; 
    
##### USING CLAUSE

SELECT o.order_id,c.first_name,sh.name as shipper
FROM orders o
JOIN customers c
	USING (customer_id)
LEFT JOIN shippers sh
	USING (shipper_id) ; 
    
-- if we have many primary keys we can use

SELECT *
FROM order_items oi
JOIN order_item_notes oin
	USING (order_id,product_id) ; 
    
#### NATURAL JOINS
				-- in natural join we allow the system to decide but we are not in control of the database

SELECT *
FROM orders o
NATURAL JOIN customers c ; 

##### CROSS JOINS
				-- when we want to combine every record from the first table with every record from the second table
SELECT 
	c.first_name AS customer,
    p.name AS product
FROM customers c
CROSS JOIN products p
ORDER BY c.first_name ;

##### UNIONS

SELECT order_id,customer_id,'ACTIVE' AS status
FROM orders
WHERE order_date >= "2019-01-01"
UNION
SELECT order_id,customer_id,'ARCHIVED' AS status
FROM orders
WHERE order_date < "2019-01-01" ; 
	


			


