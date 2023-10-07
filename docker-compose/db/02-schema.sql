-- Connect to the new database
\connect mydb nichaurasia;
-- Use the 'myschema' schema
SET search_path TO test;

-- Create a schema named 'myschema'
CREATE SCHEMA IF NOT EXISTS test;

DROP TABLE IF EXISTS student;

CREATE TABLE IF NOT EXISTS student (
	id INT PRIMARY KEY,-- multiple entries in not PK
	first_name VARCHAR(50),
	last_name VARCHAR(50),
	gender VARCHAR(50),
	cityOfBirth VARCHAR(50),
	email VARCHAR(50),
	university VARCHAR(200),
	dob DATE
);

DROP SEQUENCE IF EXISTS student_seq;

CREATE SEQUENCE IF NOT EXISTS student_seq
     AS INT
    INCREMENT BY 2 --Increment by 2
     MAXVALUE 10000
    START WITH 1005
     NO CYCLE
    OWNED BY student.id