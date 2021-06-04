create database BANK_DATABASE;
use BANK_DATABASE;
create table Branch(branchname varchar(30),
branchcity varchar(30),
assets int,
primary key(branchname));
desc Branch;
create table BankAccount(
accno int,
branchname varchar(30),
balance int,
primary key(accno),
foreign key(branchname) references Branch(branchname));
desc BankAccount;
create table BankCustomer
(customername varchar(30), 
customer_street varchar(30), 
city varchar(30), 
primary key(customername));
desc BankCustomer;
create table Depositer
(customername varchar(30),
accno int, 
primary key(customername,accno),
foreign key(customername) references BankCustomer(customername),
foreign key(accno) references BankAccount(accno));
desc Depositer; 
create table Loan
(loannumber int,
branchname varchar(30),
amount int, 
primary key(loannumber),
foreign key (branchname) references Branch(branchname));
desc Loan;

insert into Branch values('SBI_Chamrajpet','Bangalore',50000);
insert into Branch values('SBI_ResidencyRoad','Bangalore',10000);
insert into Branch values('SBI_ShivajiRoad','Bombay',20000);
insert into Branch values('SBI_ParlimentRoad','Delhi',10000);
insert into Branch values('SBI_Jantarmantar','Delhi',20000);
select * from Branch;

insert into Loan values(1, 'SBI_Chamrajpet',1000);
insert into Loan values(2, 'SBI_ResidencyRoad',2000);
insert into Loan values(3, 'SBI_ShivajiRoad',3000);
insert into Loan values(4, 'SBI_ParlimentRoad',4000);
insert into Loan values(5, 'SBI_Jantarmantar',5000);
select * from Loan;

insert into BankAccount values(1,'SBI_Chamrajpet',2000);
insert into BankAccount values(2,'SBI_ResidencyRoad',5000);
insert into BankAccount values(3,'SBI_ShivajiRoad',6000);
insert into BankAccount values(4,'SBI_ParlimentRoad',9000);
insert into BankAccount values(5,'SBI_Jantarmantar',8000);
insert into BankAccount values(6,'SBI_ShivajiRoad',4000);
insert into BankAccount values(8,'SBI_ResidencyRoad',4000);
insert into BankAccount values(9,'SBI_ParlimentRoad',3000);
insert into BankAccount values(10,'SBI_ResidencyRoad',5000);
insert into BankAccount values(11,'SBI_Jantarmantar',2000);
select * from BankAccount;

insert into BankCustomer values("Avinash","Bull Temple Road","Bangalore");
insert into BankCustomer values("Dinesh","Bannergatta Road","Bangalore");
insert into BankCustomer values("Mohan","National College Road","Bangalore");
insert into BankCustomer values("Nikil","Akbar Road","Delhi");
insert into BankCustomer values("Ravi","Prithiviraj Road","Delhi");
select * from BankCustomer;

insert into Depositer values("Avinash",1);
insert into Depositer values("Dinesh",2);
insert into Depositer values("Nikil",4);
insert into Depositer values("Ravi",5);
insert into Depositer values("Avinash",8);
insert into Depositer values("Nikil",9);
insert into Depositer values("Dinesh",10);
insert into Depositer values("Nikil",11);
select * from Depositer

select c.customername from BankCustomer c where exists
(select d.customername,count(d.customername) 
           from Depositer d, BankAccount ba 
            where d.accno=ba.accno and c.customername=d.customername and ba.branchname='SBI_ResidencyRoad' 
            group by d.customername having count(d.customername)>=2);
    
select bk.customername from BankCustomer bk where not exists(
 select branchname from Branch where branchcity='Delhi'
and not exists 
(select ba.branchname from Depositer d, BankAccount ba where d.accno=BA.accno and bk.customername=d.customername));
