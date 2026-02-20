use customers_db;

--RELATIONSHIPS

create table customers(id int primary key, 
name varchar(20) not null, country varchar(20), 
phone_no bigint unique);

create table orders(order_id int primary key,
customer_id int foreign key references customers(id),
product_name varchar(20), amount int, order_date date);

create table products(p_id int PRIMARY key, p_namee varchar(20));

insert into customers values (1,'Jhon', 'USA', 9038746287),
(2,'Karen', 'India', 9877368227), 
(3,'Joe', 'Japan', 8927368491),
(4,'Komal', 'USA', 9039740871), 
(5,'Chang', 'India', 9028637811);

insert into customers values (6,'Pooja','Hong Kong',8930298572);

insert into orders values (101,2,'Bag',2500,'2026-01-15'),
(102,1,'Bottle',500,'2026-02-10'),
(103,4,'Ring',3000,'2025-05-15'),
(104,3,'Phone',75000,'2026-01-05'),
(105,5,'Laptop',90000,'2026-02-03'),
(106,3,'Pen',50,'2026-01-28'),
(107,4,'Book',500,'2025-08-25');

insert into orders values (108,10,'Bag',2500,'2026-01-15');

insert into orders values(108,1,'Pen',50,'2026-03-01'),
(109,2,'Pen',50,'2026-03-01'), 
(110,5,'Pen',50,'2026-03-01'),
(111,4,'Pen',50,'2026-03-01');

insert into products values(10,'Bag'),
(11,'Phone'),
(12,'Pen'),
(13,'Book');

insert into products values(14,'Laptop'),
(15,'Bottle'), (16,'Ring'), (17,'Chair');

alter table products add category varchar(20);

update products set category='item1' where p_id in (10,13,17,14);
update products set category='item2' where p_id in (11,15);
update products set category='item3' where p_id in (12,16);

CREATE table employee(e_id int primary key, e_name varchar(20), 
d_id int, role varchar(10), manager int);

alter table employee add salary int;

CREATE table department(dept_id int primary key, 
dept_name varchar(20), loc varchar(20));

insert into employee values (1110,'kamala',222,'manager',null),
(1111,'cherry',222,'analyst',1110),
(1112,'jack',333,'developer',1113),
(1113,'leo',444,'manager',null);

insert into employee values
(1114,'Haika',222,'QA',1113);

update employee set salary=100000 where e_id=1110;
update employee set salary=90000 where e_id=1111;
update employee set salary=90000 where e_id=1112;
update employee set salary=100000 where e_id=1113;
update employee set salary=85000 where e_id=1114;

update employee set manager=1110 where e_id=1113;

insert into department values(111,'CSE','block A'),
(222,'MBA','block B'),
(333,'CSM','block C'),
(444,'IT','block D');

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
student_id bigint foreign key references students(student_id),
course_id int foreign key references courses(course_id),
enroll_timestamp timestamp);

--INNER JOIN

select c.name,o.product_name from customers c 
join orders o on c.id=o.customer_id ;

select o.order_id, o.product_name, c.name, c.country from 
customers c join orders o on c.id=o.customer_id ;

select e.e_name, d.dept_name from employee e 
join department d on e.d_id=d.dept_id ; 

select o.order_id, c.name, p.p_namee from customers c 
join orders o on c.id=o.customer_id 
join products p on o.product_name=p.p_namee;

select * from employee e join department d on e.d_id=d.dept_id ;

select c.name, o.product_name, o.amount from customers c 
join orders o on c.id =o.customer_id where o.amount>2000;

select * from customers c join orders o on c.id=o.customer_id 
where o.product_name like 'B%' and c.name like 'j%';

--LEFT JOIN

select * from customers c left join 
orders o on c.id =o.customer_id ;

select * from customers c left join orders o on
c.id=o.customer_id where o.customer_id is null;

select * from department d left join employee e on 
d.dept_id=e.d_id where e.e_id is not null; 

select * from department d left join employee e on 
d.dept_id=e.d_id where e.e_id is null; 

select * from products p left join 
orders o on p.p_namee=o.product_name where o.order_id is null ; 

select * from products p left join orders o 
on p.p_namee=o.product_name where p.p_namee like 'B%';

--RIGHT JOIN

select * from customers c 
right join orders o on c.id=o.customer_id ;

select * from customers c right join orders o on c.id!=o.customer_id;

select * from employee e right join 
department d on e.d_id=d.dept_id where e.e_id is null;

select d.dept_name,count(e.e_id) from employee e right join 
department d on e.d_id=d.dept_id group by d.dept_name ;

--FULL OUTER JOIN

select * from customers c left join orders o on 
c.id=o.customer_id UNION 
select * from customers c right join orders o on 
c.id=o.customer_id ;

select * from customers c left join orders o on 
c.id!=o.customer_id UNION 
select * from customers c right join orders o on 
c.id!=o.customer_id ;

select * from employee e left join department d on
e.d_id=d.dept_id UNION 
select * from employee e right join department d on 
e.d_id=d.dept_id ;

--SELF JOIN

select e.e_name as manager, m.e_name as employee from employee e 
join employee m on e.e_id=m.manager;

select m.e_name as employee,e.e_name as manager from employee e 
join employee m on e.e_id=m.manager 
where m.e_name is not null and e.e_name='leo';

select e_name from employee where role='manager';

select e.e_name as manager, m.e_name as employee from employee e 
join employee m on e.e_id=m.manager order by manager; --*

--CROSS JOIN

select * from customers cross join products;

select e1.e_name, e2.role from employee e1 cross join employee e2;


--MULTI-TABLE JOIN

select c.id, c.name, p.p_id, o.order_id, p.p_namee, o.amount from customers c join orders o on c.id=o.customer_id 
join products p on o.product_name=p.p_namee;

select * from orders o join products p on o.product_name=p.p_namee;

select * from employee e join department d on e.d_id=d.dept_id;

--JOIN + GROUP BY

select o.customer_id,count(o.customer_id) from customers c 
join orders o on c.id=o.customer_id group by o.customer_id; 

select c.id,sum(o.amount) from customers c 
join orders o on c.id=o.customer_id group by c.id; 

select d.dept_id,count(d.dept_id) from employee e 
join department d on e.d_id=d.dept_id group by d.dept_id;

select o.product_name,count(o.product_name) from orders o 
join products p on o.product_name=p.p_namee group by o.product_name ;

select e.d_id,sum(salary) from employee e join department d on e.d_id=d.dept_id group by e.d_id;

--JOIN + HAVING

select o.customer_id,count(o.customer_id ) from customers c join orders o on c.id=o.customer_id 
group by o.customer_id having count(o.customer_id)>3;

select e.d_id,count(e.d_id) from employee e 
join department d on e.d_id=d.dept_id group by e.d_id having count(e.d_id)>5;

select o.product_name,count(o.product_name) from products p join orders o on p.p_namee=o.product_name 
group by o.product_name having count(o.product_name)>10;

select o.customer_id,sum(amount) from customers c join orders o on c.id=o.customer_id 
group by o.customer_id having sum(amount)>5000;

--JOIN + COUNT

select o.customer_id,count(o.customer_id ) from customers c join orders o on c.id=o.customer_id 
group by o.customer_id;

select e.d_id,count(e.e_id) from employee e join department d on e.d_id=d.dept_id group by e.d_id; 

select category,count(p_namee) from products group by category; 

select count(o.order_id) from customers c join orders o on c.id=o.customer_id group by c.country   

--JOIN + WHERE

select * from customers c join orders o on 
c.id=o.customer_id where o.order_date>'2026-02-01';

select * from employee e join department d on e.d_id=d.dept_id where d.dept_id=222;

select * from customers c join orders o on c.id=o.customer_id where c.country='India';

select * from orders o join products p on o.product_name=p.p_namee where o.amount>5000;

--JOIN + LIKE

select * from customers c join orders o on 
c.id=o.customer_id where c.name like 'J%';

select * from employee e join department d on 
e.d_id=d.dept_id where e.e_name like 'K%' and e.d_id=222;

select * from orders o join products p 
on o.product_name=p.p_namee where o.product_name='pen';

--JOIN + SUBQUERY

select * from customers where id in (select customer_id from orders);

select * from customers where id not in (select customer_id from orders)

select p_namee from products where p_namee not in (select product_name from orders);

select dept_id, dept_name from department where dept_id not in 
(select d_id from employee);

select * from orders where amount>(select avg(amount) from orders);

select * from customers where id in 
(select customer_id from orders where amount>(select avg(amount) from orders));

select * from employee join 
(select d_id,avg(salary) as dept_salary from employee e 
join department d on e.d_id=d.dept_id group by d_id ) as dept_avg
on dept_avg.d_id=employee.d_id where employee.salary>dept_avg.dept_salary  ;

select * from customers where exists(select c.id from orders o join customers c on o.customer_id=c.id);--*

select * from customers where not exists(select customer_id from orders);--*

--MULTI-SELECT JOIN

select c.name, o.order_id, o.amount,(select count(*) from orders o1 where o1.customer_id=c.id) as tot_orders,
(select avg(amount) from orders) as avg_amount from customers c join orders o on c.id=o.customer_id;
 
select c.name, o.order_id, o.amount, 
(select max(amount) from orders) from customers c join orders o on c.id=o.customer_id; 

select c.name, o.order_id, o.amount*2.5, 
(select max(amount) from orders) from customers c join orders o on c.id=o.customer_id;

select c.name, o.order_id, o.amount, CASE when o.amount>(2500) then 'Average' end
from customers c join orders o on c.id=o.customer_id;


select * from customers;

select * from orders;

select * from products;

select * from department;

select * from employee;

<<<<<<< HEAD
=======
select o.product_name,case 
	when o.amount>5000
	then 'Avereage'
	when o.amount>10000
	then 'Important'
	when o.amount>50000
	then 'premium'
end as order_type from customers c join orders o on c.id=o.customer_id join products p on o.product_name=p.p_namee 
group by o.product_name,o.amount;  

select * from customers where id not in (select customer_id from orders) 

alter table employee drop 


























>>>>>>> 1810e00 (DB Design)
