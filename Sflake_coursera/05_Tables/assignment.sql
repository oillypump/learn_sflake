USE SCHEMA test_database.test_schema;

CREATE TABLE TEST_TABLE (
	TEST_NUMBER NUMBER,
	TEST_VARCHAR VARCHAR,
	TEST_BOOLEAN BOOLEAN,
	TEST_DATE DATE,
	TEST_VARIANT VARIANT,
	TEST_GEOGRAPHY GEOGRAPHY
);
INSERT INTO TEST_DATABASE.TEST_SCHEMA.TEST_TABLE
  VALUES
  (28, 'ha!', True, '2024-01-01', NULL, NULL);


CREATE DATABASE test_database;
CREATE SCHEMA test_schema;

show databases;
select * from test_database.test_schema.test_table;


truncate table test_database.test_schema.test_table;


show tables;

CREATE TABLE TEST_TABLE2 (
	TEST_NUMBER NUMBER
);

insert into test_database.test_schema.test_table2
values (42); 

show tables;

drop table test_database.test_schema.test_table;

undrop table test_database.test_schema.test_table;