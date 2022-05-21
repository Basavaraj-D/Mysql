##### CREATING A USER

CREATE USER alex@127.0.0.1 ; #OR
CREATE USER alex@practice  ;
-- the user can only connect from the computer where mysql is installed

CREATE USER alex@ourdomainname.com ;
-- the user will be able to connect from any computer from this domain but they wont be able to connect from subdomains

CREATE USER alex@ "%.ourdomainname.com" ;
-- the user will be able to connect from all domains and subdomains

CREATE USER alex ;
-- the user can connect from anywhere there is no restrictions

CREATE USER alex IDENTIFIED BY '1234' ;
-- the username is alex and password is 1234

##### VIEWING USER IN OUR SERVER

SELECT *
FROM mysql.user;

-- open Administration - user and privileges

##### DROPPING USERS

CREATE USER john@ourdomain.com IDENTIFIED BY '1234';
DROP USER john@ourdomain.com ;

##### CHANGING PASSWORDS

SET PASSWORD FOR john = "1234";
SET PASSWORD = "1234" ; -- (this changes the password for the currently logged in user)

# we can also change the password in administration tab 

##### GRANTING PRIVILEGES

# There are 2 scenarios

-- 1. web/desktop application 
							# this should have only read and write privileges and not create tables or modify
CREATE USER moon_app IDENTIFIED BY '1234';

GRANT SELECT ,INSERT, UPDATE ,DELETE ,EXECUTE
ON sql_store.* -- means all the tables in sql.store database
--  ON sql.store.customer -- we can also specify a certain tables 
TO moon_app ;-- if the user has any domain name or ip address we should also mention that

-- 2. Admins

GRANT ALL
ON sql_store.*
-- ON *.* (access to all databases and not just sql_store)
TO alex;

##### VIEWING PRIVILEGES

SHOW GRANTS FOR moon_app;
SHOW GRANTS ;
-- we can also make changes in the administration TAB

##### REVOKING PRIVILEGES

GRANT CREATE VIEW
ON sql_store.*
TO moon_app;

REVOKE CREATE VIEW
ON sql_store.*
FROM moon_app ;