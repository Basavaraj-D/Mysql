##### DATA MODELLING

-- understand the business requirements
-- build a conceptual model 
-- build a logical model
-- build a physical model

#### CONCEPTUAL MODELS
					-- represents the entities and their relationships
# ER (entity relationships) :

-- ER Model is used to model the logical view of the system from data perspective which consists of these components: 
-- Entity, Entity Type, Entity Set – 
-- An Entity may be an object with a physical existence – a particular person, car, house, or employee – or it may be an object with a
		-- conceptual existence – a company, a job, or a university course. 
-- An Entity is an object of Entity Type and set of all entities is called as entity set. e.g.; E1 is an entity having Entity Type Student and set of all students is called Entity Set. In ER diagram

-- link https://www.geeksforgeeks.org/introduction-of-er-model/

# UML

##### LOGICAL MODELS

-- specifying the data types for the attributes in conceptual models
-- it is always a good idea to split the attributes (eg: Name can be written as first_name and last_name)
-- we have 3 types of relationships

# one to one (assigning an office to a single employee)
# one to many ( each pet has one owner but owner can have many pets )
# many to many ( a student can enroll in many course and a course can have many students)

##### PHYSICAL MODEL

# file-new_model - add diagram - edit table

##### PRIMARY KEY

# Composite primary key : a key which has multiple columns
# we can also have a parent -child relation between tables ( the child table is also called as foreign key table)- diamond symbol represents

#### PRIMARY KEY CONSTRAINTS 

# we can choose what actions must be done to child table if any update happens to the parent table
-- we can set it to cascade(update),restrict(do not update) or null(make it an orphan record)

##### NORMALIZATION

-- suppose if a name is repeated in many places if the name is changed we have to change it in a lot of places
-- that is when normalization comes into place,In here we ensures that it follows a predefined rules such that it prevents data dupliction
-- we have a total of 7 forms of normalization.howver in 99% cases we only apply 3-4

#### 1 NORMAL FORM

# each cell should have a single value and we should not have repeated columns
# so suppose if we had a column called tags it will violate the first rule then we must create a new table which will contains this
# tags and which will have a many to many relationshionship,for which we need to introduce a link table 

#### 2 NORMAL FORM

# every table should describe a single entity,and every column in that table should represent that entity

#### 3 NORMAL FORM

# a column in a table should not be derived from other tables
# suppose we have 3 columns a,b and c if c can be obtained by subtracting a and b then there is no need to have c because if we forget
# to update c at any given point in time it could lead to huge problems

### FORWARD ENGINEERING 

# create a model- database - forward enginner- make changes if needed-next- and finish

#### SYNCHNORISING 

# suppose if we are the only user we can make changes to tablesd directly from tht schema but if there are multiple servers
# open the model and make changes there 
# click database - synchnorize model and save changes
# another thing we can do is that we can also save the changes applied file into git so that in the future also we can apply the same

#### REVERSE ENGINEERING

# suppose we have a database we want to update on if there are multiple servers
# select the table- database- reverse engineer
# this will show us the structure used to construct this table

#### CREATING AND DELETING DATABASES

CREATE DATABASE IF NOT EXISTS sql_store2;
DROP DATABASE IF EXISTS sql_store2;

#### CREATING TABLES

USE sql_store2;
DROP TABLE IF EXISTS customers;
DROP TABLE IF EXISTS orders ;

CREATE TABLE IF NOT EXISTS customers
(
	customer_id 	INT PRIMARY KEY AUTO_INCREMENT,
    first_name 		VARCHAR(50) NOT NULL,
    points 			INT NOT NULL DEFAULT 0,
    email  			VARCHAR(255) NOT NULL UNIQUE,
	city 			VARCHAR(50) NOT NULL
);

#### ALTERING TABLES

ALTER TABLE customers
	ADD last_name VARCHAR(50) NOT NULL AFTER first_name,
    MODIFY COLUMN first_name VARCHAR(55),
    DROP points ;

-- but it is not a good idea to modify the tables like this we should always do it in a testbase to avoid any complications

#### CREATING  RELATIONSHIPS


CREATE TABLE orders
(
	order_id 		INT PRIMARY KEY,
    customer_id 	INT NOT NULL,
    FOREIGN KEY fk_orders_customers (customer_id)
		REFERENCES customers (customer_id)
        ON UPDATE CASCADE
        ON DELETE NO ACTION  
);

-- now if we try to delete customers table we wont be able to since now it is a part of orders
-- we must first delete orders table to delete customers 

#### CREATING RELATIONSHIPS BETWEEN TABLES THAT ALREADY EXISTS

ALTER TABLE  orders
-- we can also add primary key
	ADD PRIMARY KEY (order_id),
    DROP PRIMARY KEY ,
	DROP FOREIGN KEY fk_orders_customers,
    ADD FOREIGN KEY fk_orders_customers (customer_id)
		REFERENCES customers (customer_id)
        ON UPDATE CASCADE
        ON DELETE NO ACTION  ;

##### CHARACTER SETS AND COLLATIONS

SHOW CHARSET 
-- in all most all the cases utf8 is used as a default and it is case insensitive
-- which means whether user enters in cap or small it does not matter at all
-- in utf 8 it reserves a max of 10 bytes which means if CHAR(10) is there then 10 *3 = 30 bytes will be assigned

-- we can also change it either during the creation of the database or after it
;

# either we can set afterwards

CREATE TABLE table1
( 
	first_name 		VARCHAR(50) NOT NULL,
    points 			INT NOT NULL DEFAULT 0
)
CHARACTER SET latin1 ; 

# or we can set it during the creation of columns

CREATE TABLE table1
( 
	first_name 		VARCHAR(50) CHARACTER SET latin1 NOT NULL,
    points 			INT NOT NULL DEFAULT 0
);

# or we can alter the data and set it

ALTER TABLE table1
CHARACTER SET latin1
;
##### STORAGE ENGINES

SHOW ENGINES

-- innodb and myisam is the most preffered ones but innodb takes the cake
;
ALTER TABLE customers
ENGINE = InnoDB

-- but changing the engine can be a taxable process because mysql has to rebuild all the tables and during this our tables
-- will not be accessible.


