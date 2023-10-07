\connect mydb nichaurasia;
-- Use the 'myschema' schema
SET search_path TO test;

-- Create a schema named 'myschema'
CREATE SCHEMA IF NOT EXISTS test;

insert into student (id, first_name, last_name, gender, cityofbirth, email, university, dob) values (1, 'Anjanette', 'Pietrzyk', 'Female', 'Ugljevik', 'apietrzyk0@wufoo.com', 'Sul Ross State University', '1972-01-30');
insert into student (id, first_name, last_name, gender, cityofbirth, email, university, dob) values (2, 'Rozanne', 'Bulford', 'Female', 'Kuala Lumpur', 'rbulford1@163.com', 'Notre Dame University', '1994-12-21');
insert into student (id, first_name, last_name, gender, cityofbirth, email, university, dob) values (3, 'Padget', 'Ridings', 'Male', 'San Jose', 'pridings2@unicef.org', 'University of Texas at El Paso', '1976-11-28');
insert into student (id, first_name, last_name, gender, cityofbirth, email, university, dob) values (4, 'Kirsteni', 'Coop', 'Female', 'Alua', 'kcoop3@multiply.com', 'Indus Institute of Higher Education', '1981-04-28');
insert into student (id, first_name, last_name, gender, cityofbirth, email, university, dob) values (5, 'Tommy', 'Pollack', 'Female', 'Talca', 'tpollack4@businessweek.com', 'Suzuka International University', '1974-01-09');
commit;