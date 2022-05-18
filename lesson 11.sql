##### TRANSACTIONS

-- transaction is a group of SQL statement that represent a single unit of work
-- A transaction has the following properties 
-- A- ATOMICITY (just like atoms they are unbreakable )
-- C -CONSISTENCY 
-- I -ISOLATION (isolated to prevent multiple chages)
-- D - DURABILITY (changes made by the transaction are permanent )

START TRANSACTION ;

INSERT INTO orders(customer_id,order_date,status)
VALUES(1,"2019-01-01",1);

INSERT INTO order_items
VALUES(LAST_INSERT_ID(),1,1,1) ;

COMMIT;

#### CONCURRENCY AND LOCKING

START TRANSACTION;
UPDATE customers
SET points =points+10
WHERE customer_id =1 ;
COMMIT;

-- suppose another user tries to update the same query if the first query is not yet committed then
-- it will be locked without the first one getting executed the second will not be updates

#### TRANSACTION ISOLATION LEVELS

# LOST UPDATES:
			-- imagine 2 queries that are being updated,query 1 updates the state and query 2
-- updates the points,now the queries to be last updated will override the other this is called
-- LOST UPDATES
# DIRTY READS
# NON-REPEATING READS
# PHANTOM READS

SHOW VARIABLES LIKE 'transaction_isolation'; -- default is repeatable read
SET GLOBAL TRANSACTION ISOLATION LEVEL SERIALIZABLE;

#### READ UNCOMMITTED

SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;
SELECT points
FROM customers
WHERE customer_id =1 ;

-- suppose anoter user updates 
START TRANSACTION;
UPDATE customers
SET points =20
WHERE customer_id =1;
ROLLBACK ;
-- but for some reason without commit it gets rollback now we are dealing with the data 
-- that never existed.

##### READ COMMITTED

SET TRANSACTION ISOLATION LEVEL READ COMMITTED;
START TRANSACTION;
SELECT points FROM customers WHERE customer_id =1 ;
SELECT points FROM customers WHERE customer_id =1 ;
COMMIT;

-- second user might do 

START TRANSACTION;
UPDATE customers
SET points =2393
WHERE customer_id =1 ;
COMMIT ; -- without commit it will not reflect in the first query

#### REPEATABLE READ

SET TRANSACTION ISOLATION LEVEL REPEATABLE READ;
START TRANSACTION;
SELECT points FROM customers WHERE customer_id =1 ;
SELECT points FROM customers WHERE customer_id =1 ;
COMMIT; -- even if a data is committed the value which will be seen is consistent

-- second user may write 

SET TRANSACTION ISOLATION LEVEL READ COMMITTED;
START TRANSACTION;
SELECT points FROM customers WHERE customer_id =1 ;
SELECT points FROM customers WHERE customer_id =1 ;
COMMIT;

##### SERIALIZABLE ISOLATION

SET TRANSACTION ISOLATION LEVEL SERIALIZABLE;
START TRANSACTION;
SELECT * FROM customers WHERE state ="VA" ;
COMMIT;

##### DEADLOCKS
				-- when different transactions locks the data waiting for the other transaction to finish
                

START TRANSACTION;
UPDATE customers SET state = "VA" WHERE customer_id =1 ;
UPDATE orders SET state = 1 WHERE order_id =1 ;
COMMIT;

-- suppose another user tries to update 

START TRANSACTION;
UPDATE orders SET state = 1 WHERE order_id =1 ;
UPDATE customers SET state = "VA" WHERE customer_id =1 ;
COMMIT;
