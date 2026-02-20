/*Shipment Booking Module 
Core Idea 
Stores booking details of shipments including packages, sender, receiver, and tracking status. 
Constraint 
One shipment can have many packages. 
Each package has its own weight and size. 
Shipment status changes must be stored (not just updated). 
Sender and receiver may or may not be existing customers. 
Shipment price must be saved even if rate changes later. 
One shipment can travel in multiple trips. 
Cancelling a shipment should not delete its history.*/

use shipment_db;

create table customers(customer_id int primary key, name varchar(20), 
contact varchar(10) unique, location varchar(20));

create table trips(trip_id varchar(10) primary key, vehicle_no varchar(20), 
origin varchar(20), destination varchar(20), depature_date date, arrival_date date);

create table shipments(shipment_id varchar(10) primary key, 
booking_date DATETIME2 DEFAULT SYSDATETIME(), 
trip_id varchar(10) foreign key references trips(trip_id),
package_count int);

create table packages(package_id varchar(10) primary key, package_name varchar(20) not null, 
shipment_id varchar(10) foreign key references shipments(shipment_id), 
trip_id varchar(10) foreign key references trips(trip_id), 
sender_id int foreign key references customers(customer_id), sender_name varchar(20), 
receiver_id int foreign key references customers(customer_id), receiver_name varchar(20), 
price int, weight int, size varchar(15), booking_date date);

create table shipment_status(status_id varchar(10) primary key, 
shipment_id varchar(10) foreign key references shipments(shipment_id), 
status varchar(20), time DATETIME2 DEFAULT SYSDATETIME());

insert into customers values (1,'Jhon',9094958385,'USA'),
(2,'Ramesh',9308467281,'India'),
(3,'Max',8729384766,'canada'),
(4,'Shyam',9283778192,'India'),
(5,'Karen',7899182733,'USA'),
(6,'Suresh',9284673381,'India'),
(7,'Ram',7281947732,'India'),
(8,'Jack',8833928371,'Japan'),
(9,'Andy',7888273491,'UK'),
(10,'Mona',9388117732,'USA');

insert into trips values ('t1','AP09AB1234','India','Dubai','2026-02-01','2026-02-02'),
('t2','KA01XY5678','Dubai','USA','2026-02-03','2026-02-05'),
('t3','TN10ZZ9999','India','Japan','2026-02-04','2026-02-06');

insert into shipments(shipment_id, trip_id, package_count) values ('s1','t1',2),
('s2','t1',1),
('s3','t2',2),
('s4','t3',1),
('s5','t2',1);

insert into  packages values ('p1','Electronics','s1','t1',1,'Jhon',3,'Max',5000,20,'Medium','2026-02-01'),
('p2','Furniture','s1','t1',1,'Jhon',3,'Max',7000,55,'Large','2026-02-01'),
('p3','Books','s2','t1',2,'Ramesh',6,'Suresh',2000,10,'Small','2026-02-02'),
('p4','Clothes','s3','t2',4,'Shyam',NULL,'Alex',3000,15,'Medium','2026-02-03'),
('p5','Machinery','s3','t2',4,'Shyam',NULL,'Alex',9000,65,'Large','2026-02-03'),
('p6','Mobile','s4','t3',NULL,'Robert',8,'Jack',4500,12,'Small','2026-02-04'),
('p7','Gift Box','s5','t2',7,'Ram',5,'Karen',2500,18,'Medium','2026-02-05');

insert into shipment_status(status_id, shipment_id, status) values ('st1','s1','Booked'),
('st2','s1','In Transit'),
('st3','s1','Delivered'),
('st4','s2','Booked'),
('st5','s2','In Transit'),
('st6','s3','Booked'),
('st7','s4','Booked'),
('st8','s5','Booked'),
('st9','s5','Cancelled');

--List all shipments along with their package details.
select * from shipments s right join packages p on s.shipment_id=p.shipment_id;

--Retrieve shipments with their sender and receiver information (name, contact). 
SELECT DISTINCT p.shipment_id, p.sender_name, sc.contact AS sender_contact,
p.receiver_name, rc.contact AS receiver_contact
FROM packages p
LEFT JOIN customers sc ON p.sender_id = sc.customer_id
LEFT JOIN customers rc ON p.receiver_id = rc.customer_id;

--List shipments along with price snapshot and package count. 
select shipment_id, sum(price) as price, count(shipment_id) as package_count from packages group by shipment_id;

--Retrieve cancelled shipments along with all their packages 
select * from packages p left join shipment_status st on p.shipment_id=st.shipment_id where st.status='Cancelled';

--Find shipments where any package weight exceeds 50 kg. 
select * from packages where weight>50;


