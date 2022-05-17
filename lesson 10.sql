#### TRIGGERS

DELIMITER $$
CREATE TRIGGER payments_after_insert
	AFTER INSERT ON payments
	FOR EACH ROW
BEGIN
	UPDATE invoices
    SET payment_total = payment_total + NEW.payment_amount
	WHERE invoice_id = NEW.invoice_id ;
END $$
DELIMITER ;

INSERT INTO payments
VALUES (default,5,2,"2019-05-12",10,1) ; 

#### VIEWING TRIGGERS

SHOW TRIGGERS ;
SHOW TRIGGERS LIKE "payments%" ;

#### DROPPING TRIGGERS

DELIMITER $$
DROP TRIGGER IF EXISTS payments_after_insert ;

CREATE TRIGGER payments_after_insert
	AFTER INSERT ON payments
	FOR EACH ROW
BEGIN
	UPDATE invoices
    SET payment_total = payment_total + NEW.amount
	WHERE invoice_id = NEW.invoice_id ;
END $$
DELIMITER ;

INSERT INTO payments
VALUES (default,5,2,"2019-05-12",10,1) ;

##### USING TRIGGERS FOR AUDITING

CREATE TABLE payments_audit
(
	client_id		INT,
	date			DATE,
	amount 			DECIMAL (9,2),
    action_type		VARCHAR(50),
    action_date		DATETIME
)

DELIMITER $$
DROP TRIGGER IF EXISTS payments_after_insert ;

CREATE TRIGGER payments_after_insert
	AFTER INSERT ON payments
	FOR EACH ROW
BEGIN
	UPDATE invoices
    SET payment_total = payment_total + NEW.amount
	WHERE invoice_id = NEW.invoice_id ;
    
    INSERT INTO payments_audit
    VALUES (NEW.client_id,NEW.date,NEW.amount,"Insert",NOW()) ;
END $$
DELIMITER ;

-- TRIGGER TO DELETE
DELIMITER $$
DROP TRIGGER IF EXISTS payments_after_delete;

CREATE TRIGGER payments_after_delete
	AFTER DELETE  ON payments
	FOR EACH ROW
BEGIN
	UPDATE invoices
    SET payment_total = payment_total - OLD.amount
	WHERE invoice_id = OLD.invoice_id ;
    
	INSERT INTO payments_audit
    VALUES (OLD.client_id,OLD.date,OLD.amount,"Delete",NOW()) ;
END $$
DELIMITER ;

INSERT INTO payments
VALUES(DEFAULT,5,3,"2019-01-01",100,1)
;
DELeTE FROM payments
WHERE payment_id = 19 ;

##### EVENTS

SHOW VARIABLES LIKE "event%"; -- to turn on events if turned off
SET GLOBAL event_scheduler = ON -- or off 
;

DELIMITER $$
CREATE EVENT yearly_delete_stale_audit_rows
ON SCHEDULE
	EVERY 1 YEAR STARTS "2019-01-01" ENDS "2029-01-01"
DO BEGIN
	DELETE FROM payments_audit
    WHERE action_date < now() - INTERVAL 1 YEAR ;
END $$
DELIMITER ;

#### VIEW/DROP/ALTER EVENT

SHOW EVENTS ;
SHOW EVENTS LIKE "yearly%" ;

DROP EVENT IF EXISTS yearly_delete_stale_audit_rows ;

ALTER EVENT yearly_delete_stale_audit_rows ; -- just like create event we can edit it out
ALTER EVENT yearly_delete_stale_audit_rows ENABLE ; -- temporarily enable or disable event



