##### STORED PROCEDURES

-- stored procedures helps us to store and organize SQL databases
-- it can be used for faster execution
-- stored procedures have a higher data security

DELIMITER $$
CREATE PROCEDURE get_clients()
BEGIN
	SELECT *
    FROM clients ;
END $$
DELIMITER ;

-- create a store procedure for invoices > 0

DELIMITER $$
CREATE PROCEDURE get_invoices_with_balance ()
BEGIN
	SELECT *,invoice_total -payment_total AS balance
    FROM invoices
    WHERE (invoice_total -payment_total) >0
    ORDER BY balance DESC;
END $$
DELIMITER ;

##### DROPPING STORED PROCEDURE

DROP PROCEDURE get_invoices_with_balance ;

DROP PROCEDURE IF EXISTS get_clients ;
DELIMITER $$
CREATE PROCEDURE get_clients()
	SELECT * FROM clients ;
BEGIN
END $$
DELIMITER ;

##### PARAMETERS

DROP PROCEDURE IF EXISTS get_clients_by_state ;
DELIMITER $$
CREATE PROCEDURE get_clients_by_state (state char(2))
BEGIN
	SELECT * 
    FROM clients c
    WHERE c.state = state;
END $$
DELIMITER ;

##### PARAMETERS WITH DEFAULT

DELIMITER $$
CREATE PROCEDURE get_clients_by_state( state char(2))
BEGIN
	IF state IS NULL THEN
		SET state = "CA";
	END IF;
		SELECT * 
        FROM clients c
        WHERE c.state = state ;
END $$
DELIMITER ;

-- CALL get_clients_by_state(NULL)
-- now instead of returning the clients in 'CA" we want to return all the values

DELIMITER $$
CREATE PROCEDURE get_clients_by_state( state char(2))
BEGIN
	IF state IS NULL THEN
		SELECT * FROM clients ;
	ELSE
		SELECT * 
        FROM clients c
        WHERE c.state = state ;
	END IF;
END $$
DELIMITER ;

-- we can write the above code also as

DELIMITER $$
CREATE PROCEDURE get_clients_by_state( state char(2))
BEGIN
		SELECT * 
        FROM clients c
        WHERE c.state = IFNULL(state, c.state) ;
END $$
DELIMITER ;

##### PARAMETER VALIDATION

DELIMITER $$
CREATE PROCEDURE make_payments(
	invoice_id INT ,
    payment_amount DECIMAL (9,2),
    payment_date DATE )
BEGIN
	IF payment_amount <=0 THEN
		SIGNAL SQLSTATE '22003'  
			SET MESSAGE_TEXT = "invalid payment amount" ;
	END IF;
-- the above statement will be used for validation if payment_total is  a -ve value
	UPDATE invoices i
    SET
		i.payment_total = payment_amount,
        i.payment_date = payment_date
	WHERE i.invoice_id = invoice_id ;
END ;

##### OUTPUT PARAMETERS

DELIMITER $$
CREATE PROCEDURE get_unpaid_invoices_for_clients
(
	client_id INT,
    OUT invoices_count INT,
    OUT invoices_total DECIMAL(9,2)
)
BEGIN
	SELECT COUNT(*) ,SUM(invoice_total)
    INTO invoices_count,invoices_total
    FROM invoices
    WHERE i.client_id = client_id AND payment_total =0 ;
END ;

##### VARIABLES

-- user or session variable
SET @invoice_total = 0

-- local variables

CREATE PROCEDURE get_risk_factor()
BEGIN
	DECLARE risk_factor DECIMAL(9,2) DEFAULT 0;
    DECLARE invoices_total DECIMAL (9,2) ;
    DECLARE invoices_count INT ;
    
    SELECT COUNT(*), SUM(invoice_total)
    INTO invoices_count ,invoices_total
    FROM invoices ;
    
    SET risk_factor = invoice_total / invoices_count *5;
    SELECT risk_factor ;
END


##### FUNCTIONS

CREATE FUNCTION get_risk_factor_for_client
(
	client_id INT
)
RETURNS INTEGER

-- DETERMINISTIC, READS SQL DATA,MODIFIES SQL DATA ARE SOME OF THE PROPERTIES
READS SQL DATA
BEGIN
	DECLARE risk_factor DECIMAL(9,2) DEFAULT 0;
    DECLARE invoices_total DECIMAL (9,2) ;
    DECLARE invoices_count INT ;
    
    SELECT COUNT(*), SUM(invoice_total)
    INTO invoices_count ,invoices_total
    FROM invoices i
    WHERE i.client_id = client_id;
    
    SET risk_factor = invoice_total / invoices_count *5 ;
    RETURN IFNULL(risk_factor,0) ; 
END
-- to access
 
SELECT client_id,name,get_risk_factor (clinet_id)
FROM clients





