create database supplier;
show databases;
use supplier;
create table suppliers(
	sid int primary key,
    sname varchar(30),
    address varchar(30)
);
desc suppliers;

create table parts(
	pid int primary key,
    pname varchar(30),
    color varchar(30)
);
desc parts;

create table catalog(
sid int, 
pid int, 
foreign key(sid) references suppliers(sid), 
foreign key(pid) references parts(pid), 
cost float,
primary key(sid, pid));
desc catalog;

insert into suppliers values(10001,'Acme Widget','bangalore') ;
insert into suppliers values(10002,'Johns','kolkata') ;
insert into suppliers values(10003,'Vimal','Mumbai') ;
insert into suppliers values(10004,'Reliance','delhi') ;

insert into parts values(20001,'book','red') ;
insert into parts values(20002,'pen','red') ;
insert into parts values(20003,'pencil','green') ;
insert into parts values(20004,'mobile','green');
insert into parts values(20005,'charger','black');

insert into catalog values(10001,20001,10);
insert into catalog values(10001,20002,10);
insert into catalog values(10001,20003,30);
insert into catalog values(10001,20004,10);
insert into catalog values(10001,20005,10);
insert into catalog values(10002,20001,10);
insert into catalog values(10002,20002,20);
insert into catalog values(10003,20003,30);
insert into catalog values(10004,20003,40);

select * from suppliers;
select * from catalog;
select * from parts;

-- i.Find the pnames of parts for which there is some supplier.
select p.pname 
from parts p 
where p.pid in (
select pid 
from catalog c 
group by c.pid having count(c.sid)>0);

-- ii.Find the snames of suppliers who supply every part.
select s.sname 
from suppliers s 
where s.sid in(
select c.sid from catalog c group by c.sid 
 having count(distinct (c.pid))=(select count(p.pid) from parts p));

-- iii.Find the snames of suppliers who supply every red part.
select s.sname 
from suppliers s 
where s.sid in (
select ca.sid  
from catalog ca,parts p 
where ca.pid=p.pid and p.color='red' 
group by ca.sid
 having count(ca.pid)=(
 select count(*) 
 from parts p 
 where p.color='red'));
 
 -- iv.Find the pnames of parts supplied by Acme Widget Suppliers and by no one else.
 
select ca.pid 
from catalog ca  
where ca.sid=(
select s.sid 
from suppliers s 
where s.sname ='Acme Widget') 
having (
select count(c.pid) 
from catalog c 
where c.pid=ca.pid)=1;

-- v.Find the sids of suppliers who charge more for some part than the average cost of that part (averaged over all the suppliers who supply that part).

select distinct c.sid,c.pid 
from catalog c 
where c.cost > (
select avg(ca.cost) 
from catalog ca 
where ca.pid=c.pid);

-- vi.For each part, find the sname of the supplier who charges the most for that part
select p.pid, s.sname 
from parts p, suppliers s, catalog C 
where c.pid = p.pid and c.sid = s.sid and c.cost = (
SELECT max(c1.cost)
from catalog c1 
where c1.pid = p.pid);
