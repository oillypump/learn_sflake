---> set the Role
USE ROLE accountadmin;

---> set the Warehouse
USE WAREHOUSE compute_wh;


CREATE OR REPLACE FILE FORMAT tasty_bytes.public.csv_ff 
type = 'csv';

CREATE OR REPLACE STAGE tasty_bytes.public.s3load
url = 's3://sfquickstarts/tasty-bytes-builder-education/'
file_format = tasty_bytes.public.csv_ff;

CREATE OR REPLACE DATABASE tasty_bytes;

create or replace schema tasty_bytes.raw_pos;

CREATE OR REPLACE STAGE tasty_bytes.raw_pos.blob_stage
url = 's3://sfquickstarts/tastybytes/'
file_format = (type = csv);

LIST @tasty_bytes.raw_pos.blob_stage/raw_pos/franchise/;


ls @tasty_bytes.raw_pos.blob_stage;




-- truck table build
CREATE OR REPLACE TABLE tasty_bytes.raw_pos.truck
(
    truck_id NUMBER(38,0),
    menu_type_id NUMBER(38,0),
    primary_city VARCHAR(16777216),
    region VARCHAR(16777216),
    iso_region VARCHAR(16777216),
    country VARCHAR(16777216),
    iso_country_code VARCHAR(16777216),
    franchise_flag NUMBER(38,0),
    year NUMBER(38,0),
    make VARCHAR(16777216),
    model VARCHAR(16777216),
    ev_flag NUMBER(38,0),
    franchise_id NUMBER(38,0),
    truck_opening_date DATE
);

CREATE OR REPLACE TABLE tasty_bytes.raw_pos.franchise 
(
    franchise_id NUMBER(38,0),
    first_name VARCHAR(16777216),
    last_name VARCHAR(16777216),
    city VARCHAR(16777216),
    country VARCHAR(16777216),
    e_mail VARCHAR(16777216),
    phone_number VARCHAR(16777216) 
);


copy into tasty_bytes.raw_pos.truck
from @tasty_bytes.raw_pos.blob_stage/raw_pos/truck;

select * from tasty_bytes.raw_pos.truck;


copy into tasty_bytes.raw_pos.franchise
from @tasty_bytes.raw_post.blob_stage/raw_pos/franchise;

select * from tasty_bytes.raw_pos.franchise;


show databases;


CREATE view tasty_bytes.raw_pos.truck_franchise
as
SELECT
    t.*,
    f.first_name AS franchisee_first_name,
    f.last_name AS franchisee_last_name
FROM tasty_bytes.raw_pos.truck t
JOIN tasty_bytes.raw_pos.franchise f
    ON t.franchise_id = f.franchise_id;

describe view tasty_bytes.raw_pos.truck_franchise;

drop view tasty_bytes.raw_pos.truck_franchise;


CREATE MATERIALIZED VIEW tasty_bytes.raw_pos.truck_franchise_materialized
as
SELECT
    t.*,
    f.first_name AS franchisee_first_name,
    f.last_name AS franchisee_last_name
FROM tasty_bytes.raw_pos.truck t
JOIN tasty_bytes.raw_pos.franchise f
    ON t.franchise_id = f.franchise_id;

show views;

CREATE MATERIALIZED VIEW tasty_bytes.raw_pos.nissan_view
as
SELECT
    t.*
FROM tasty_bytes.raw_pos.truck t
WHERE make = 'Nissan';