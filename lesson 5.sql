##### AGGREGATE FUNCTIONS

SELECT 
	-- MAX(invoice_total) AS highest
    -- MAX(payment_date) AS highest
    -- MIN(invoice_total) AS lowest
    -- AVG(invoice_total) AS average
    -- SUM(invoice_total) AS total
    -- COUNT(invoice_total) AS total_count
    -- COUNT(payment_date) AS count_of_payments
    -- COUNT(*) AS total_rewards    -- * takes into account even the null values
    COUNT(DISTINCT client_id) AS total_records
FROM invoices
WHERE invoice_date >"2019-01-01" ;

##### GROUPBY CLAUSE

SELECT 
	client_id,
    SUM(invoice_total) AS total_sales
FROM invoices
WHERE invoice_date >"2019-01-01"
GROUP BY client_id
ORDER BY total_sales DESC ;
-- coming to order of operation groupby> orderby

##### HAVING CLAUSE

SELECT 
	client_id,
    SUM(invoice_total) AS total_sales
FROM invoices
GROUP BY client_id
HAVING total_sales >500 ;
-- where can be used before group by and having can be used after grouping the data

##### ROLLUP OPERATOR

SELECT client_id,SUM(invoice_total) AS total_sales
FROM invoices
GROUP BY client_id WITH ROLLUP ;

SELECT state,city,SUM(invoice_total) AS total_sales
FROM invoices i
JOIN clients c USING (client_id)
GROUP BY state,city WITH ROLLUP

