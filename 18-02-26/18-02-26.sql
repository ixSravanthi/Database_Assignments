use shipment_db;

create table customers(customer_id int primary key, name varchar(20), 
contact varchar(10) unique, location varchar(20), role varchar(10));

create table shipments(shipment_id varchar(10) primary key, status varchar(20), 
trip_id varchar(10) unique,
package_count int, time timestamp);

create table packages(product_id varchar(10) primary key, product_name varchar(20) not null,
shipment_id varchar(10) foreign key references shipments(shipment_id),
trip_id varchar(10) foreign key references shipments(trip_id),
sender_id int foreign key references customers(customer_id), 
receiver_id int foreign key references customers(customer_id), 
price int, weight int, size varchar(15));

insert into customers values (1,'Jhon',9094958385,'USA','sender'),
(2,'Ramesh',9308467281,'India','sender'),
(3,'Max',8729384766,'canada','receiver'),
(4,'Shyam',9283778192,'India','sender'),
(5,'Karen',7899182733,'USA','receiver'),
(6,'Suresh',9284673381,'India','receiver'),
(7,'Ram',7281947732,'India','sender'),
(8,'Jack',8833928371,'Japan','receiver'),
(9,'Andy',7888273491,'UK','sender'),
(10,'Mona',9388117732,'USA','sender');

insert into shipments(shipment_id, status, trip_id, package_count) values ();

insert into packages values ('p1','Bag','s1','t1',1,3,1000,0.5,'12x22x14');

select * from customers;
select * from shipments;
select * from packages;
