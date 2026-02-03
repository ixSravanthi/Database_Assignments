use college_db

--TASK-1

create table students (student_id bigint primary Key, 
name VARCHAR(50), 
email VARCHAR(100) UNIQUE,   
age INT,
join_date DATE, 
active_flag bit default 1);

create table courses(course_id int primary key, 
course_name varchar(50) not null, 
fees decimal);

create table enrollments(enroll_id bigint primary key,
student_id bigint,
course_id int,
enroll_timestamp timestamp);

--TASK-2

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

insert into courses values(101,'Python Programming',5000),
(102,'Database Management System',6500),
(103,'Java',45000),
(104,'Ethical Hacking',2000),
(105,'Data Structures',3000);

ALTER TABLE enrollments drop column enroll_timestamp;

ALTER TABLE enrollments
ADD enroll_timestamp DATETIME2 DEFAULT SYSDATETIME();

insert into enrollments(enroll_id,student_id,course_id) values(661101,228811661,101);

insert into enrollments(enroll_id,student_id,course_id) values(662102,228811662,102);

insert into enrollments(enroll_id,student_id,course_id) values(663103,228811663,103),
(664104,228811664,104),
(665105,228811665,105),
(666101,228811666,101),
(667102,228811667,102),
(668103,228811668,103),
(669104,228811669,104),
(6610105,2288116610,105),
(669101,228811669,101),
(668102,228811668,102),
(667103,228811667,103),
(666104,228811666,104),
(665101,228811665,101);

--TASK-3

INSERT into students values(2288116611, 'Max', 
'max@gmail.com', 18, '2026-02-03',1),
(2288116612, 'Dustin', 'dustin@gmail.com', 17, '2026-02-03',1),
(2288116613, 'Steve', 'steve@gmail.com', 21, '2026-01-25',0);

insert into courses values(106,'Machine Learning',8500);

insert into enrollments(enroll_id,student_id,course_id) 
values(6612106,2288116612,106);

select * from students;

select name,email from students;

select * from students order by age desc;

select top 5 * from students order by join_date desc;

select distinct age from students;

select DISTINCT course_name from courses;

update students set age=19 where student_id=2288116611;

update students set active_flag=0 where student_id in (2288116611,2288116612);

update courses set fees+=fees*(0.1);

delete from students where student_id=2288116613;

delete from courses where fees<1000;

delete from enrollments where enroll_timestamp<'2026-02-02 16:57:49.471';

alter table students alter COLUMN name varchar(60);

EXEC sp_rename 
    'students.join_date',
    'registration_date',
    'COLUMN';

alter table students add phone_number VARCHAR(15);

--TASK-4

select * from students where age>21;

select * from students where active_flag=1;

select * from courses where fees BETWEEN 1000 and 5000;

select * from students where age in (20,22,25);

select * from students where age>20 AND active_flag=1;

select * from students where age<20 OR active_flag=0;

select * from courses where fees>2000 AND course_name LIKE '%Data%'; 

select * from students where email like '%gmail.com'; 

select * from courses where course_name like 'Data%';

insert into students values (2288116613,'Steve','steve@gmail.com',null,'2026-01-19',1,null);

select * from students where age is null;

select * from students where age is not null;

--TASK-5

select count(*) from students;

select count(*) from students where active_flag=1;

select sum(fees) from courses;

select avg(fees) from courses;

select sum(fees) from courses where fees>2000; 

select min(age) from students;

select max(fees) from courses;

select max(registration_date) from students;

select min(registration_date) from students;

select count(*), active_flag from students GROUP by active_flag;

select count(*), age from students group by age;

select course_id from enrollments group by course_id having count(course_id)>3;

select age,count(age) from students group by age having avg(age)>21;

select course_id from enrollments group by course_id having count(course_id)>2;

--TASK-6

select * from students where age>20 order by age;

select count(*) from students where name LIKE '%a%';

select course_name, fees from courses where fees between 3000 and 9000 order by fees;

select * from students where active_flag=0 and age is not null;

select student_id from enrollments group by student_id having count(student_id)>1;
