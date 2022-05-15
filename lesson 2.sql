#### LIKE OPERATOR

SELECT *
FROM customers
-- WHERE last_name LIKE 'b%'
-- WHERE last_name LIKE '%b%'
-- WHERE last_name LIKE '%y'
-- % indicates the beginning or ending of a certain character in a string

-- WHERE last_name LIKE '__y' -- contains two letters before y at the end
WHERE last_name LIKE '_____y' -- contains 5 letter before y at the end
;
##### REGEXP 

SELECT *
FROM customers
-- WHERE last_name REGEXP '^B' -- name begins with letter B
-- WHERE last_name REGEXP 'field$' -- name ends with field

-- | can be used as an or to tell 2 or more strings

-- WHERE LAST_NAME REGEXP 'field|mac|rose' -- last name contains mac,brush or field in it
-- WHERE LAST_NAME REGEXP 'field$|^mac|rose'

-- WHERE last_name REGEXP '[gim]e' -- contains g,i or m before letter e
-- WHERE last_name REGEXP 'e[fmq]' -- contains fmq before letter e
-- WHERE last_name REGEXP '[a-h]e' -- there can be a range from a-h before e
;

##### ISNULL OPERATOR

SELECT *
FROM customers
WHERE phone IS NULL ;
-- selects if any row contains a null value similarly we can also use NOT NULL

##### ORDER BY CLAUSE

SELECT *
FROM customers
-- ORDER BY first_name DESC -- (descending order)
ORDER BY state,first_name ;

##### LIMIT CLAUSE

SELECT *
FROM customers
-- LIMIT 2 -- selects the first 2 elements
LIMIT 6,3 -- skip the first 6 elements and select the next 3