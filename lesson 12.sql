##### STRING DATATYPE

# CHAR(x) - fixed length strings
# VARCHAR(x) -  longer length strings (max is 65,355 characters)
# MEDIUMTEX - for strings longer than 64kb ,and max is 16mb
# LONGTEXT - max is 4gb
# TINYTEXT - 255 bytes max
# TEXT - max is 64kb

-- as for languages english used 1byte,european uses 2bytes and chinese used 3bytes

##### INTEGERS

# TINYINT - 1b - (-128,127)
# UNSIGNED TINYINT -(0,255)
# SMALLINT 	2b - (-32k ,32k)
# MEDIUMINT 3b - (-8M , 8M)
# INT 		4b - (-2B,2B)
# BIGINT 	8b - (-9Z,9Z)

##### FIXED POINT AND FLOATING TYPES

# DECIMAL(4,2) --- 9999.99
# synonyms are DEC NUMERIC AND FIXED
# FLOAT    4b
# DOUBLE   8b

##### BOOLEAN TYPES

# TRUE
# FALSE

#### ENUM AND SET TYPES

# ENUM('small','medium','large')
# SET(...)

##### DATE AND TIME

# DATE
# TIME
# DATETIME   8b
# TIMESTAMP  4b (upto 2038)
# YEAR

##### BLOB TYPES
			 -- generally used to store large files such as images, media files such as video and audio clips in the database.
# TINYBLOB 255B
# BLOB     65KB
# MEDIUMBLOB 16MB
# LONGBLOB	  4GB

##### JSON DATATYPES
					-- json is used to transfering data over the internet.
-- json files starts with  { } with a key value pair in it just like a dictionary,example

-- { "tv": ["samsung","sony","MI" ] }

-- another way to update json files is 
SET -- column name = JSON_OBJECT (
#			"volume",10 ,
#           "dimension", JSON_ARRAY (1,2,3),
#			"manufactures",JSON_OBJECT{"name":"Sony"}   )

-- to extrct individual key-value pair

-- SELECT JSON_EXTRACT("COLUMN NAME", "$.volume" (indicates the current json file)
-- from
-- where

-- SELECT product_id, "column name" -> "$.volume"
-- from
-- where

# if its a list

-- SELECT product_id, "column name" -> "$.dimension[0]"
-- from
-- where

# if its a object

-- SELECT product_id, "column name" -> "$.manufacturer.name"
-- from
-- where
-- if we do not want " " string in output

-- SELECT product_id, "column name" ->> "$.manufacturer.name"
-- from
-- where

# if we want to update the json properties

-- UPDATE COLUMN NAME
-- SET JSON COLUMN NAME = JSON_SET(
--		JSON COLUMN NAME,
--		"$.weight",20,
--		"$.age",10 )








