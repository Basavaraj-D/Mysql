##### NUMBER OPERATIONS IN SQL

SELECT ROUND(5.78)		;
SELECT ROUND(6.2323,2)	;
SELECT CEILING(5.2)		;
SELECT FLOOR(5.8) 		;
SELECT ABS(-5.6) 		;
SELECT RAND()			;

##### STRING FUNCTIONS

SELECT LENGTH("APPLE")	;
SELECT UPPER("apple")	;
SELECT LOWER("APPLE")	;
SELECT LTRIM("	APPLE")	;
SELECT RTRIM("APPLE  ") ;
SELECT TRIM("	APPLE") ;
SELECT LEFT("APPLEJUICE",4) ;
SELECT RIGHT("APPLEJUICE",4) ;
SELECT SUBSTRING("APPLEJUICE",3,5) ;
SELECT SUBSTRING("APPLEJUICE",3)	;
SELECT LOCATE ("E","APPLEJUICE")	;
SELECT LOCATE("M","APPLEJUICE")		;
SELECT LOCATE("JUICE","APPLEJUICE") ;
SELECT REPLACE("APPLEJUICE","JUICE","PIE") ;
SELECT CONCAT("APPLE","SALAD") ;
SELECT CONCAT("APPLE"," ","SALAD") ;

##### DATE FUNCTIONS

SELECT NOW()		;
SELECT CURDATE()	;
SELECT CURTIME()	;
SELECT YEAR(NOW())	;
SELECT DAY(NOW())	;
SELECT MONTH(NOW())	;
SELECT DAYNAME(NOW()) ;
SELECT MONTHNAME(NOW()) ;
SELECT EXTRACT(MONTH FROM NOW()) ;

SELECT *
FROM orders
WHERE YEAR(order_date) <= YEAR(NOW()) ;

##### FORMATTING DATE AND TIME

SELECT DATE_FORMAT(NOW(), '%d -%m-%y') ;
SELECT DATE_FORMAT(NOW() , "%D-%M-%Y") ;
SELECT TIME_FORMAT(NOW(),"%H-%I-%P")   ;

##### CALCULATING DATE AND TIME

SELECT DATE_ADD(NOW() ,interval 1 day)  ;
SELECT DATE_ADD(NOW(),interval 1 year)	;
SELECT DATE_ADD(NOW(),interval -1 year) ;
SELECT DATE_SUB(NOW(),interval 1 year)	;

SELECT DATEDIFF("2022-01-05","2021-04-02") ; -- datediff does not mean diff in time
SELECT TIME_TO_SEC("09:00") - TIME_TO_SEC("09:02") ;

##### IFNULL AND COALESCE

SELECT order_id,shipper_id,
	IFNULL(shipper_id ,"NOT ASSIGNED") AS shipper
FROM orders ;

SELECT order_id,COALESCE(shipper_id,comments,"NOT assigned") AS shipper
FROM orders  ;

#### IF FUNCTION

SELECT order_id,order_date,
	IF(year(order_date) = year(now()) ,"Active","Archived")
FROM orders
;
##### CASE OPERATOR

SELECT order_id,
		CASE
        WHEN year(order_date) = year(now()) THEN "Active"
        WHEN year(order_date) > year(now()) THEN "last_year"
        WHEN year(order_date) < year(now()) THEN "Archived"
		ELSE "Future"
	END as category
FROM orders


