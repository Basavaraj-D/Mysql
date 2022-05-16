#### INSERTING INTO A ROW

INSERT INTO customers
VALUES (default,'Alex','gates','1998-01-01',default,'wall street,New york','New york','VA',default) ;

#### INSERTING MULTIPLE ROWS

INSERT INTO shippers(name)
VALUES ('shipper1' ),
	   ('shipper2' ),
	   ('shipper3' ) ;
       
##### INSERTING HIERARCHICAL ROWS

INSERT INTO orders (customer_id,order_date,status)
VALUES (2,"2019-02-01",1);
INSERT INTO order_items
VALUES (last_insert_id(),1,1,2.95),
	   (last_insert_id(),2,2,3.95) ;
       
#### CREATING A COPY OF THE TABLE

CREATE table orders_archived AS
SELECT *
FROM orders ; 
-- downside  is that the newly created table will not have any primary key in it
-- we can also insert into the newly created table

INSERT INTO orders_archived
SELECT *
FROM orders 
WHERE order_date <"2019-01-01" ;

##### UPDATING A SINGLE ROW

UPDATE invoices
SET payment_total =10,payment_date = "2019-04-21"
WHERE invoice_id = 1;

UPDATE invoices
SET payment_total=default,payment_date =default
WHERE invoice_id =1 ; 

##### UPDATING MULTIPLE ROWS

UPDATE invoices
SET payment_total = invoice_total * 0.5,payment_date = due_date
WHERE client_id IN (3,4) ; 

##### USING SUBQUERIES IN UPDATES

UPDATE invoices
SET payment_total = invoice_total *0.5,
	payment_date = due_date
WHERE invoice_id = (
				SELECT client_id
				FROM invoices
                WHERE name=  "myworks" );
                
##### DELETING ROWS

DELETE FROM invoices
WHERE client_id = 1 ;

DELETE FROM invoices
WHERE client_id = ( SELECT *
					FROM clients
                    WHERE name ="myworks") ;
