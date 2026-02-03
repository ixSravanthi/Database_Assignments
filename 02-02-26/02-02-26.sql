use college_db

create table students (student_id bigint primary Key, 
name VARCHAR(50), 
email VARCHAR(100) UNIQUE,   
age INT,
join_date DATE, 
active_flag bit default 1);

create table courses(course_id int primary key, 
course_name varchar not null, 
fees decimal);

create table enrollments(enroll_id bigint primary key,
student_id bigint,
course_id int,
enroll_timestamp timestamp);


INSERT INTO students (student_id, name, email, age, 
join_date, active_flag)
VALUES (228811661, 'Raj', 'raj@gmail.com', 
18, '2026-02-02', 1);

INSERT into students values(228811662, 'Ram', 
'ram@gmail.com', 19, '2026-02-03',1); 

INSERT into students values(228811663, 'Sita', 
'sita@gmail.com', 20, '2026-01-22',0),
(228811664, 'Shyam', 'shyam@gmail.com', 16, '2026-01-24',0),
(228811665, 'Ramesh', 'ramesh@gmail.com', 21, '2026-02-03',1),
(228811666, 'Alex', 'alex@gmail.com', 18, '2026-02-03',1),
(228811667, 'Joe', 'joe@gmail.com', 19, '2026-01-03',0),
(228811668, 'Tony', 'tony@gmail.com', 22, '2026-02-03',1),
(228811669, 'Peter', 'peter@gmail.com', 20, '2026-01-28',0),
(2288116610, 'mike', 'mike@gmail.com', 21, '2026-02-03',1);


select * from students;
