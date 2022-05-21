#### INDEX

-- Indexes are used to retreive the data from the database more quickly than otherwise.However there are some drawbacks
# increase the database size
# they slow the writes

-- indexes should always be based on the queries and not on the tables

#### CREATING INDEX

EXPLAIN
SELECT customer_id
FROM customers
WHERE state in ("CA") ;

CREATE INDEX idx_state ON customers (state);

EXPLAIN
SELECT customer_id
FROM customers
WHERE points>1000 ;

CREATE INDEX idx_points ON customers (points);

#### VIEWING INDEXES

SHOW INDEXES IN customers ;
-- we can also view indexes in table by going to the column on which the index was applied

#### PREFIXING THE INDEXES

CREATE INDEX idx_last_name ON customers (last_name(20)) ;

SELECT 
	COUNT(DISTINCT LEFT(last_name,1)),
    COUNT(DISTINCT LEFT(last_name,2))
FROM customers  
;
#### FULL TEXT INDEX

# suppose user searched for 'react redux' how can we write the query

SELECT *
FROM posts
WHERE title LIKE '%react redux%' OR 
	body LIKE '%react redux%'
;

CREATE FULLTEXT INDEX idx_title_body ON posts (title,body);

SELECT *,MATCH (title,body) AGAINST ('react reduc') -- ( this gives the relevancy score)
FROM posts
WHERE MATCH (title,body) AGAINST ('react redux')
;
SELECT *,MATCH (title,body) AGAINST ('react reduc')
FROM posts
WHERE MATCH (title,body) AGAINST ('react -redux' IN BOOLEAN MODE) -- we are mentioning to search for react and not redux
;
SELECT *,MATCH (title,body) AGAINST ('react reduc')
FROM posts
WHERE MATCH (title,body) AGAINST ('react -redux + form' IN BOOLEAN MODE) -- the sentence must contain react and form in it either 
;																		 -- in title or body
SELECT *,MATCH (title,body) AGAINST ('react reduc')
FROM posts
WHERE MATCH (title,body) AGAINST ('"handling a form' IN BOOLEAN MODE) -- we can also mention sentences
;

##### COMPOSITE INDEXES

USE sql_store;
SHOW INDEXES in customers ;

EXPLAIN SELECT customer_id
FROM customers
WHERE state = "CA" AND points>1000;

-- as we can out of idx_state and idx_points MYSQL selected idx_state,so when sql indexes it does faster for state but points
-- must be read from the table and it may get a bit slow

CREATE INDEX idx_state_points ON customers (state,points) ;

EXPLAIN SELECT customer_id
FROM customers
WHERE state = "CA" AND points>1000;

-- in my sql we can have upto 16 indexes

DROP INDEX idx_state ON customers;
DROP INDEX idx_points ON customers;

##### ORDER OF COLUMNS IN COMPOSITE INDEXES

# put the most frequently used columns first
# put the columns with the higher cardinality(no of unique values) first 
# raking our queries into account

SELECT 
	COUNT(DISTINCT state),
    COUNT(DISTINCT last_name)
FROM customers
;
CREATE INDEX idx_lastname_state ON customers (last_name,state)
;
EXPLAIN SELECT 
	COUNT(DISTINCT state),
    COUNT(DISTINCT last_name)
FROM customers
;
-- we can also specify which index to use

EXPLAIN SELECT customer_id
FROM customers
USE INDEX (idx_lastname_state)
WHERE state ="NY" AND last_name LIKE "A%"
;

#### WHEN INDEXES ARE IGNORED

EXPLAIN SELECT customer_id
FROM customers
WHERE state ="CA" OR points>1000;
-- in here we have to read all the columns

CREATE INDEX idx_points ON customer (points);
EXPLAIN 
	SELECT customer_id
	FROM customers
	WHERE state ="CA" 
    UNION
    SELECT customer_id
	FROM customers
    WHERE  points>1000;

##### USING INDEXES FOR SORTING

EXPLAIN
SELECT customer_id
FROM customers
ORDER BY state;
SHOW STATUS LIKE 'last_query_cost'
;
EXPLAIN
SELECT customer_id
FROM customers
ORDER BY first_name;
SHOW STATUS LIKE 'last_query_cost'
;
-- if we have two columns a and b we can sort either with
# using a
# using b
# using a and b
# using a desc and b desc
-- but we cannot mix a desc and b or viceversa and we cannot mix anothe column a ,c ,b

EXPLAIN
SELECT customer_id
FROM customers
ORDER BY state,points;
SHOW STATUS LIKE 'last_query_cost' ;

EXPLAIN
SELECT customer_id
FROM customers
ORDER BY state DESC ,points DESC;
SHOW STATUS LIKE 'last_query_cost';

-- it is always a good practice to check for existing indexes before creating a new one



