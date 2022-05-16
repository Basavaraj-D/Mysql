##### WRITING SUBQUERIES

SELECT *
FROM products
WHERE unit_price > ( SELECT unit_price
					 FROM products
                     WHERE product_id =3) ;

SELECT employee_id,first_name,salary
FROM employees
WHERE salary > (SELECT AVG(salary)
				FROM employees) ;
                
##### IN AND NOT IN

SELECT *
FROM products
WHERE product_id NOT IN (SELECT DISTINCT product_id
						  FROM order_items )
;
##### SUBQUERIES VS JOINS

SELECT *
FROM clients
WHERE client_id NOT IN( SELECT DISTINCT client_id
						FROM invoices ) ;

SELECT *
FROM clients
LEFT JOIN invoices USING (client_id)
WHERE invoice_id IS NULL ;

##### ANY KEYWORD

SELECT *
FROM clients
WHERE client_id IN ( SELECT client_id
					 FROM invoices
                     GROUP BY client_id
                     HAVING COUNT(*) >2)
;
SELECT *
FROM clients
WHERE client_id = ANY( SELECT client_id
					 FROM invoices
                     GROUP BY client_id
                     HAVING COUNT(*) >2) ;
                     
##### CORRELATED SUBQUERIES

SELECT *
FROM employees e
WHERE salary > ( SELECT AVG(salary)
				 FROM employees
                 WHERE office_id = e.office_id) ;
                 
##### EXISTS OPERATOR

SELECT *
FROM clients
WHERE client_id NOT IN (SELECT client_id
						FROM invoices ) ;
                        
SELECT *
FROM clients c
WHERE EXISTS (SELECT client_id
				FROM invoices
                WHERE client_id = c.client_id)
-- main difference between exists and in is that it doesnt return a subquery which can be very useful
;
##### SUBQUERIES IN SELECT CLAUSE

SELECT invoice_id,invoice_total,(SELECT AVG(invoice_total) FROM invoices) AS average,
		invoice_total - (SELECT average)  AS difference
FROM invoices ;

SELECT client_id, name,
	SUM(invoice_total) AS total_sales,
    (SELECT AVG(invoice_total) FROM invoices ) AS average_invoices,
    (SELECT SUM(invoice_total))-(SELECT average_invoices) AS difference
FROM invoices
RIGHT JOIN clients c USING (client_id)
GROUP BY client_id ;

##### SUBQUERIES IN FROM CLAUSE

SELECT *
FROM (
	SELECT 
		client_id,
        name,
		(SELECT SUM(invoice_total)
			FROM invoices
			WHERE client_id = c.client_id ) AS total_sales,
		(SELECT AVG(invoice_total) FROM invoices ) AS average,
		(SELECT total_sales - average) AS difference
	FROM  clients c
) AS sales_summary -- alias is mandatory when subquer in from
WHERE total_sales IS NOT NULL