/*__REVISE SQL__*/

/*all databases displaying */
show databases;

/*all tables displaying of selected database*/
show tables;

/*database created*/
create database game;

/*using database*/
use game;

/*database deleted*/
drop database game;

/*table created*/
/*coloumn names are selected with datatype*/
create table bgmi(
id INT primary KEY NOT NULL unique,        
name VARCHAR(255),
level INT,
role VARCHAR(255)
);

create table gun(
gun_id int primary key not null unique,
gun_name VARCHAR(255) default 'SHOTGUN',
bgmi_id INT,
foreign key(bgmi_id) references bgmi(id)  ON DELETE cascade          /*shows relation between two tables*/
);

/*ALL describeption of coloumns(datatype,key,null,default)*/
desc bgmi;

/*table deleted*/
drop table bgmi;
drop table gun;

/*inserting data*/
insert into bgmi(id,name,level,role)values
(1,'JONATHAN',53,'IGL'),
(2,'SCOUTOP',45,'SUPPORT'),
(3,'MORTAL',34,'SNIPER'),
(4,'MAVI',78,'SUPPORT'),
(5,'SNAX',13,'IGL'),
(6,'DYNAMO',78,'IGL');

insert into gun(gun_id,gun_name,bgmi_id)values
(11,'M416',1),
(12,'KAR_98',2),
(13,'AWM',3),
(14,'AKM',4),
(15,'DP',5),
(16,'UZI',6);

/*used to replace values of particular id*/
/*SYNTAX-1*/
replace into gun(gun_id,gun_name,bgmi_id)values
(15,'SHOTGUN2',5);
/*SYNTAX-2*/
replace into gun SET gun_id =16,gun_name ='SHOTGUN',bgmi_id= 6;  

/*used to update a particular id values*/
update  gun SET gun_name ='SHOTGUN3',bgmi_id= 6 where gun_id =16; 

/*used to update all rows values of gun_id by 10*/
update gun SET gun_id =gun_id+10;
update gun SET gun_id =gun_id-10;

/*retriving whole table from database*/
select * from bgmi;
select * from gun;

/*retriving particaular table from database*/
select name from bgmi;

/*Gives current date and time*/
select now();

/*Gives ans=55*/
select 44+11;

/*convert into uppercase letters*/
select ucase('bgmi');

/*convert into lowercase letters*/
select lcase('BgmI');

/*retrive according to condition*/
select * from bgmi where level > 50;

/*retrive according to condition*/
select * from bgmi where level between 0 AND 50;

/*retrive according to condition*/
select * from bgmi where name='SNAX' OR name='MORTAL' OR name='DYNAMO';
/*reduces or*/
select * from bgmi where name IN('SNAX','JONATHAN','DYNAMO');

/*retrive according to condition*/
select * from bgmi where NOT id=3 AND NOT name='MAVI';

/*retrive according to condition*/
select * from bgmi where name NOT IN('SNAX','JONATHAN','DYNAMO');

/*retrive row who is having null value*/
select * from bgmi where name is null;

/*retrive row who is hAving below*/
select * from bgmi where name LIKE 'M%'; /*  %  ->many letters
select * from bgmi where name LIKE '%NA_'; /*  _  ->only one letters

/*order by*/
/*sorting rows by default ascending order*/
select * from bgmi where level order by level;

/*sorting rows descending order*/
select * from bgmi where level order by level desc;

/*distinct -> used for grouping particular coloumn elements*/
/*retrived all types of role here from bgmi table role coloumn*/
select distinct role from bgmi;

/*group -> used for grouping particular coloumn elements*/
select role from bgmi group by role;

/*used to calculate count of particular role*/
select role,count(role) from bgmi group by role;

/*used to calculate minimum level of particular role*/
select role,min(level) from bgmi group by role;

/*used to calculate maximum level of particular role*/
select role,max(level) from bgmi group by role;

/*used to calculate avg of level of particular role*/
select role,avg(level) from bgmi group by role;

/*used to calculate sum of  levels for a particular role*/
select role,sum(level) from bgmi group by role;

/*group by having -> it is used to filtering after grouping*/
/*where  -> it is used to filtering before grouping*/
select *,count(role) from bgmi group by role having count(role)>1;

select * from bgmi;
desc bgmi;

/*ALTER TABLE used to make changes on coloumns in table*/
/*ADD -> used to add new coloumn in table*/
ALTER TABLE bgmi ADD column version float; 

/*MODIFY -> used to modify data-type of particaular coloumn*/
ALTER TABLE bgmi MODIFY column version double; 

/*DROP -> used to delete coloumn*/
ALTER TABLE bgmi DROP column ver; 

/*CHANGE -> used to rename coloumn name*/
ALTER TABLE bgmi CHANGE column version ver float; 

/*RENAME -> used to rename table name*/
ALTER TABLE bgmi RENAME TO PUBG;
show tables;

/*Joining tables*/

create table employee(
id INT primary key not null,
fname VARCHAR(255),
lname VARCHAR(255),
age INT,
emailId VARCHAR(255),
PhoneNO INT,
City CHAR(10)
);
insert into employee(id,fname,lname,age,emailId,PhoneNo,City)values
(1,'Aman','Proto',32,'aman@gmail.com',898,'Delhi'),
(2,'Yagya','Narayan',44,'yagya@gmail.com',222,'Palam'),
(3,'Rahul','BD',22,'rahul@gmail.com',444,'Kolkata'),
(4,'Jatin','Hermit',31,'jatin@gmail.com',666,'Raipur'),
(5,'PK','Pandey',21,'pk@gmail.com',555,'Jaipur');

select * from employee;

create table client(
id INT primary key not null,
first_name VARCHAR(255),
last_name VARCHAR(255),
age INT,
emailID VARCHAR(255),
PhoneNO INT,
City CHAR(10),
empID INT,
foreign key (empID) references employee(id)
);

insert into client(id,first_name,last_name,age,emailId,PhoneNo,City,empID)values
(1,'Mac','Rogers',47,'mac@gmail.com',333,'Kolkata',3),
(2,'Max','Poirier',27,'max@gmail.com',222,'Kolkata',3),
(3,'Peter','Jain',24,'peter@gmail.com',111,'Delhi',1),
(4,'Sushant','Aggarwal',23,'sushant@gmail.com',45454,'Hydrabad',5),
(5,'Pratap','Singh',36,'p@gmail.com',77767,'Mumbai',2);

select * from client;

create table project(
id INT primary key not null,
name CHAR(10),
startdate date,
empID INT,
clientID INT,
foreign key (empID) references employee(id),
foreign key (clientID) references client(id)
);

insert into project(id,empID,name,startdate,clientID)values
(1,1,'A','2021-04-21',3),
(2,2,'B','2021-03-12',1),
(3,3,'C','2021-01-16',5),
(4,3,'D','2021-04-27',2),	
(5,5,'E','2021-05-01',4);

select * from employee;
select * from project;
select * from client;

/*INNER JOIN -> intersection only common in both tables will taken*/
select  e.id,e.fname,p.id,p.name from  employee as e INNER JOIN project as p on e.id = p.empID;
select  e.id,e.fname,p.id,p.name from  employee as e INNER JOIN project as p on e.id = p.empID where e.city='JAIPUR';

/*OUTER JOIN*/
/*LEFT JOIN ->all id of left table should contain*/
select  e.id,e.fname,p.id,p.name from  employee as e LEFT JOIN project as p on e.id = p.empID;

/*RIGHT JOIN ->all id of right table should contain*/
select  e.id,e.fname,p.id,p.name from  employee as e RIGHT JOIN project as p on e.id = p.empID;

/*CROSS JOIN ->cartesian product*/
select * from employee as e CROSS JOIN project as p;

/*Without join keyword joning two tables*/
select * from employee as e ,project as p where e.id=p.empID;

/*set operations*/
create table dept1(
empid INT,
name VARCHAR(255),
role VARCHAR(255)
);
insert into dept1(empid,name,role)values
(1,'A','Engineer'),
(2,'B','Salesman'),
(3,'C','Manager'),
(4,'D','Salesman'),
(5,'E','Engineer');

create table dept2(
empid INT,
name VARCHAR(255),
role VARCHAR(255)
);
insert into dept2(empid,name,role)values
(3,'C','Manager'),
(6,'F','Marketting'),
(7,'G','Salesman');

select * from dept1;
select * from dept2;

/*UNION* ->all rows are come excluding the row which are duplicates taken only at one time/
select * from dept1 union select * from dept2;

/*INTERSECTION ->implemented by using inner join ->contains only common rows*/
select dept1.* from dept1 inner join dept2  using(empid);

/*MINUS ->implementation by using LEFT JOIN*/
select dept1.* from dept1 LEFT JOIN dept2 using(empid) where dept2.empid is NULL;

/*SUB QUERIES*/
/*where clause ->*/
/*employees with age >30*/
select * from employee where age in (select age from employee where age >30);

/*emp details working in more than 1 project*/
select * from employee where id IN (select empID from project group by empID having count(empID) > 1); 

/*single value sub query*/
/*emp details having age > avg(age)*/
select * from employee where age >(select avg(age) from employee);

-- from clause
-- select max age person whose first name has 'a'
select max(age) from (select * from employee where fname like '%a%') as temp;

-- Corelated subquery
-- find 2nd oldest employee
select * from employee as e1 where 2 = (select count(e2.age) from employee as e2 where e2.age >= e1.age);

-- view
select * from employee;

-- creating a view
create view customer_view as select fname,age from employee;

-- viewing from view
select * from customer_view; 

-- altering the view
alter view customer_view as select fname,lname,age from employee;

-- drop the view
drop view customer_view;