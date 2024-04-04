-- Connect to the new database
--\c mydb;
-- Check if the database 'mydb' exists, and create it if it doesn't
SELECT 'CREATE DATABASE mydb'
WHERE NOT EXISTS (SELECT FROM pg_database WHERE datname = 'mydb');

-- Create a schema named 'test' and set it as the default search path
CREATE SCHEMA IF NOT EXISTS test;
SET search_path TO test;

-- Create the 'student' table
DROP TABLE IF EXISTS student;
CREATE TABLE IF NOT EXISTS student (
    id SERIAL PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    gender VARCHAR(50),
    city_of_birth VARCHAR(50),
    email VARCHAR(50),
    university VARCHAR(200),
    dob DATE
);

-- Create the 'student_seq' sequence
DROP SEQUENCE IF EXISTS student_seq;
CREATE SEQUENCE IF NOT EXISTS student_seq
    INCREMENT BY 2
    MAXVALUE 10000
    START WITH 1005
    NO CYCLE
    OWNED BY student.id;
