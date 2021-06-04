show databases;
create database studentfaculty;
use studentfaculty;


CREATE TABLE student(
snum INT,
sname VARCHAR(10),
 major VARCHAR(2),
lvl VARCHAR(2),
age INT, primary key(snum));
desc student;

CREATE TABLE faculty(
fid INT,fname VARCHAR(20),
deptid INT,
PRIMARY KEY(fid));
desc faculty;

CREATE TABLE class(
cname VARCHAR(20),
 metts_at TIMESTAMP,
 room VARCHAR(10),
 fid INT,
 PRIMARY KEY(cname),
 FOREIGN KEY(fid) REFERENCES faculty(fid));
 desc class;

CREATE TABLE enrolled(
 snum INT,
 cname VARCHAR(20),
 PRIMARY KEY(snum,cname),
 FOREIGN KEY(snum) REFERENCES student(snum),
 FOREIGN KEY(cname) REFERENCES class(cname));
 desc enrolled;



Insert into student values(1,'john','CS','SR',19);
Insert into student values(2,'smith','CS','JR',20);
Insert into student values(3,'jacob','CV','SR',20);
Insert into student values(4,'tom','CS','JR',20);
Insert into student values(5,'rahul','CS','JR',20);
Insert into student values(6,'rita','CS','SR',21);
select * from student;

insert into class values('class1','12/11/15 10:15:16','r1',14);
insert into class values('class10','12/11/15 10:15:16','r128',14);
insert into class values('class2','12/11/15 10:15:20','r2',12);
insert into class values('class3','12/11/15 10:15:25','r3',11);
insert into class values('class4','12/11/15 20:15:20','r4',14);
insert into class values('class5','12/11/15 20:15:20','r3',15);
insert into class values('class6','12/11/15 13:20:20','r2',14);
insert into class values('class7','12/11/15 10:10:10','r3',14);

insert into faculty values(11,'Harish',1000);
insert into faculty values(12,'MV',1000);
insert into faculty values(13,'Meera',1001);
insert into faculty values(14,'Shiva',1002);
insert into faculty values(15,'Nupur',1000);
select * from faculty;
		
insert into enrolled values(1,'class1');
insert into enrolled values(2,'class1');
insert into enrolled values(3,'class3');
insert into enrolled values(4,'class3');
insert into enrolled values(5,'class4');
insert into enrolled values(1,'class5');
insert into enrolled values(2,'class5');
insert into enrolled values(3,'class5');
insert into enrolled values(4,'class5');
insert into enrolled values(5,'class5');

-- i..Find the names of all Juniors (level(lvl) = Jr) who are enrolled in a class taught by Harish.

select distinct S.Sname from Student s, Class c, Enrolled e, Faculty f where s.snum = e.snum and e.cname = c.cname and c.fid = f.fid and
f.fname = 'Harish' and s.lvl = 'JR';


-- ii.Find the names of all classes that either meet in room R128 or have five or more Students enrolled.
select c.cname from class c where c.room='R128' union select e.cname from enrolled e group by e.cname having count(e.snum)>=5;



-- iii.  Find the names of all students who are enrolled in two classes that meet at the same time.
select distinct S.sname from Student S where S.snum in (select E1.snum from Enrolled E1, Enrolled E2, Class C1, Class C2
where E1.snum = E2.snum and E1.cname <> E2.cname and E1.cname = C1.cname
and E2.cname = C2.cname and C1.metts_at = C2.metts_at);
 


-- iv. Find the names of faculty members who teach in every room in which some class is taught.
select distinct(c.fid) from class c where not exists (select c1.room from class c1 where c1.room not in (select c2.room from class c2 where c2.fid=c.fid));

-- v.Find the names of faculty members for whom the combined enrollment of the courses that they teach is less than five. 
select f.fname from faculty f where (select count(e.snum) from enrolled e where e.cname in (select c.cname from class c where c.fid=f.fid))<5;


-- vi.Find the names of students who are not enrolled in any class.
select s.sname from student s where s.snum not in (select distinct(e.snum) from enrolled e);

-- vii. For each age value that appears in Students, find the level value that appears most often. For example, if there are more FR level students aged 18 than SR, JR, or SO students aged 18, you should print the pair (18, FR).
select distinct(st.age),st.lvl from student st where st.lvl = (select s.lvl from student s  where s.age=st.age  group by s.lvl 
order by count(s.lvl) desc limit 1);
