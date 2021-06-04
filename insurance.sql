create database INSURANCE_DATABASE;
show databases;
use insurance_database;
create table Person(
driver_id char(10) unique not null,
name varchar(100) not null,
address varchar(100) not null,
primary key (driver_id)
);
desc Person;
create table Car(
reg_num char(20) unique not null,
model varchar(20) not null,
year int not null,
primary key (reg_num)
);
desc Car;
create table Accident(
report_num int unique not null,
accident_date date not null,
location varchar(30) not null
);
desc Accident;
create table Owns(
driver_id char(10) unique not null,
reg_num char(20) unique not null,
primary key (driver_id),
foreign key (driver_id) references Person(driver_id),
foreign key (reg_num) references Car(reg_num)
);
desc Owns;
create table participated(
driver_id char(10) unique not null,
reg_num char(20) unique not null,
report_num int unique not null,
damage_amount int not null,
primary key (driver_id),
foreign key (driver_id) references Person(driver_id),
foreign key (reg_num) references Car(reg_num),
foreign key (report_num) references Accident(report_num)
);
desc participated;
insert into Person
values ('A01','Richard','Srinivas Nagar'),('A02','Pradeep','Rajaji Nagar'),('A03','Smith','Ashok Nagar'),('A04','Venu','N R Colony'),('A05','John','Hanumanth Nagar');
insert into Car
values ('KA052250','Indica',1990),('KA031181','Lancer',1957),('KA095477','Toyota',1998),('KA053408','Honda',2008),('KA041702','Audi',2005);
insert into Owns
values ('A01','KA052250'),('A02','KA053408'),('A03','KA031181'),('A04','KA095477'),('A05','KA041702');
insert into Accident
values (11,'2003-01-01','Mysore Road'),(12,'2004-02-02','South end Circle'),(13,'2003-01-21','Bull Temple Road'),(14,'2008-01-17','Mysore Road'),(15,'2005-03-04','Kanakpura Road');
insert into participated
values ('A01','KA052250',11,10000),('A02','KA053408',12,50000),('A03','KA095477',13,25000),('A04','KA031181',14,3000),('A05','KA041702',15,5000);
desc Person;
select * from Person;
select * from Owns;
select * from Accident;
select * from Car;
select * from participated;
