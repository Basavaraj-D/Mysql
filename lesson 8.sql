##### VIEWS

CREATE VIEW sales_by_client AS
SELECT 
	c.client_id,c.name,
    SUM(invoice_total) AS total_sales
FROM clients c
JOIN invoices i USING (client_id)
GROUP BY client_id,name
;
-- views dont store data they just show that is the reason why they are called as views

CREATE VIEW client_balance AS
SELECT c.client_id,c.name,
	SUM(invoice_total - payment_total) AS balanace
FROM clients c
JOIN invoices i USING (client_id)
GROUP BY client_id,name
;

-- to drop a view and replce a view
DROP VIEW client_balance ;
-- CREATE OR REPLACE VIEW sales_by_client
;
-- if a view does not contain distinct,aggregate functions,group by/having,union then these views are called as updatable view
-- and updatable views ca ve used with insert,delete,update and delete

CREATE OR REPLACE VIEW invoices_with_balance AS
SELECT 
		invoice_id,
        number,
        client_id,
        invoice_total,
        payment_total,
        invoice_total-payment_total AS balance,
        invoice_date,
        due_date,
        payment_date
FROM invoices
WHERE (invoice_total-payment_total) > 0
;
-- In this view we can update,delete and insert data just like a regular table

CREATE OR REPLACE VIEW invoices_with_balance AS
SELECT 
		invoice_id,
        number,
        client_id,
        invoice_total,
        payment_total,
        invoice_total-payment_total AS balance,
        invoice_date,
        due_date,
        payment_date
FROM invoices
WHERE (invoice_total-payment_total) > 0
WITH CHECK OPTION  -- this will make sure no disappearence of rows occur

-- BENEFITS OF VIEW

-- simplify queries
-- reduce the impact of changes
-- restrict access to data


