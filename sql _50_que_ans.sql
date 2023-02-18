CREATE DATABASE ORG;
SHOW DATABASES;
USE ORG;

CREATE TABLE Worker (
	WORKER_ID INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
	FIRST_NAME CHAR(25),
	LAST_NAME CHAR(25),
	SALARY INT(15),
	JOINING_DATE DATETIME,
	DEPARTMENT CHAR(25)
);

INSERT INTO worker
	(WORKER_ID, FIRST_NAME, LAST_NAME, SALARY, JOINING_DATE, DEPARTMENT) VALUES
		(001, 'Monika', 'Arora', 100000, '14-02-20 09.00.00', 'HR'),
		(002, 'Niharika', 'Verma', 80000, '14-06-11 09.00.00', 'Admin'),
		(003, 'Vishal', 'Singhal', 300000, '14-02-20 09.00.00', 'HR'),
		(004, 'Amitabh', 'Singh', 500000, '14-02-20 09.00.00', 'Admin'),
		(005, 'Vivek', 'Bhati', 500000, '14-06-11 09.00.00', 'Admin'),
		(006, 'Vipul', 'Diwan', 200000, '14-06-11 09.00.00', 'Account'),
		(007, 'Satish', 'Kumar', 75000, '14-01-20 09.00.00', 'Account'),
		(008, 'Geetika', 'Chauhan', 90000, '14-04-11 09.00.00', 'Admin');
        
SELECT * FROM Title;

CREATE TABLE Bonus (
	WORKER_REF_ID INT,
	BONUS_AMOUNT INT(10),
	BONUS_DATE DATETIME,
	FOREIGN KEY (WORKER_REF_ID)
		REFERENCES Worker(WORKER_ID)
        ON DELETE CASCADE
);

INSERT INTO Bonus 
	(WORKER_REF_ID, BONUS_AMOUNT, BONUS_DATE) VALUES
		(001, 5000, '16-02-20'),
		(002, 3000, '16-06-11'),
		(003, 4000, '16-02-20'),
		(001, 4500, '16-02-20'),
		(002, 3500, '16-06-11');
        
CREATE TABLE Title (
	WORKER_REF_ID INT,
	WORKER_TITLE CHAR(25),
	AFFECTED_FROM DATETIME,
	FOREIGN KEY (WORKER_REF_ID)
		REFERENCES Worker(WORKER_ID)
        ON DELETE CASCADE
);

INSERT INTO Title 
	(WORKER_REF_ID, WORKER_TITLE, AFFECTED_FROM) VALUES
 (001, 'Manager', '2016-02-20 00:00:00'),
 (002, 'Executive', '2016-06-11 00:00:00'),
 (008, 'Executive', '2016-06-11 00:00:00'),
 (005, 'Manager', '2016-06-11 00:00:00'),
 (004, 'Asst. Manager', '2016-06-11 00:00:00'),
 (007, 'Executive', '2016-06-11 00:00:00'),
 (006, 'Lead', '2016-06-11 00:00:00'),
 (003, 'Lead', '2016-06-11 00:00:00');
 
select * from Worker;
select * from Bonus;
select * from Title;

-- Q.1
select FIRST_NAME as WORKER_NAME from worker;

-- Q.2
select ucase(FIRST_NAME) from worker;

-- Q.3
select DEPARTMENT from worker group by DEPARTMENT;
select distinct DEPARTMENT from worker;

-- Q.4
select substring(FIRST_NAME,1,3) from worker;

-- Q.5
select instr(FIRST_NAME,'b')from worker where FIRST_NAME ='Amitabh';

-- Q.6
select  rtrim(FIRST_NAME) from worker;

-- Q.7
select ltrim(department) from worker;

-- Q.8
select distinct department ,length(department) from worker;
select  department,length(department) from worker group by department;

-- Q.9
select replace( FIRST_NAME,'a','A') from worker;

-- Q.10
select concat(first_name,' ',last_name) as complete_name from worker;

-- Q.11
select * from worker order by FIRST_NAME;

-- Q.12
select * from worker order by FIRST_NAME , DEPARTMENT desc;

-- Q.13
select * from worker where first_name in ('Vipul','Satish');

-- Q.14
select * from worker where first_name NOT in ('Vipul','Satish');

-- Q.15
select * from worker where department = 'Admin';

-- Q.16
select * from worker where first_name like '%a%';

-- Q.17
select * from worker where first_name like '%a';

-- Q.18
select * from worker where first_name like '%h' and length(first_name)=6;

-- Q.19
select * from worker where salary between 100000 AND 500000;

-- Q.20
select * from worker where joining_date ='2014-02-20 09:00:00';
select * from worker where year(joining_date) = 2014 AND month(joining_date) =02;

-- Q.21
select department,count(department) from worker group by department having department = 'Admin';
select department,count(department) from worker where department = 'Admin';

-- Q.22
select concat(first_name,' ',last_name) from worker where salary between 50000 AND 100000;
select concat(first_name,' ',last_name) from worker where salary >=50000 and salary <= 100000;

-- Q.23
select department,count(department)  from worker group by department order by count(department) desc;

-- Q.24
select * from worker where worker_id in (select worker_ref_id from title where worker_title = 'Manager');
select w.* from worker as w inner join title as t on w.worker_id = t.worker_ref_id where t.worker_title = 'Manager';  

-- Q.25
select worker_title,count(worker_title) from title group by worker_title having count(worker_title) > 1;

-- Q.26
select * from worker where mod(worker_id,2) != 0;

-- Q.27
select * from worker where mod(worker_id,2) = 0;

-- Q.28
create table worker_clone like worker;
insert into worker_clone select * from worker;
select * from worker_clone;

-- Q.29
select w.* from worker as w inner join worker_clone as c using(worker_id); 

-- Q.30
select w.* from worker as w left join worker_clone as c using(worker_id) where c.worker_id is null; 

-- Q.31
select now();
select curdate();
select current_time();
select current_timestamp();

-- Q.32
select * from worker order by salary desc limit 5;

-- Q.33
select * from worker order by salary desc limit 4,1;

-- Q.34
select salary from worker as w1 where 4 = (select count(distinct (w2.salary)) from worker as w2 where w2.salary >= w1.salary);

-- Q.35
select * from worker as w1,worker as w2 where w1.salary = w2.salary AND w1.worker_id !=w2.worker_id;

-- Q.36
select distinct salary from worker as w1 where 2 = (select count(distinct (w2.salary)) from worker as w2 where w2.salary >= w1.salary);
select distinct salary from worker order by salary desc limit 1,1;
select max(salary) from worker where salary not in (select max(salary) from worker);

-- Q.37
select * from worker union all select * from worker order by worker_id;

-- Q.38
select worker_id from worker where worker_id not in(select worker_ref_id from bonus);

-- Q.39
select * from worker where worker_id <= (select count(worker_id)/2 from worker);

-- Q.40
select department from worker group by department having count(department) < 4;

-- Q.41
select department,count(department) from worker group by department;

-- Q.42
select * from worker where worker_id in(select max(worker_id) from worker);

-- Q.43
select * from worker where worker_id in(select min(worker_id) from worker);

-- Q.44
(select * from worker order by worker_id desc limit 5) order by worker_id;

-- Q.45
select * from worker where salary in(select max(salary) from worker group by department);
select w.department,w.first_name,w.salary from (select department,max(salary) as maxsal from worker group by department) as temp inner join worker as w 
on temp.department = w.department AND temp.maxsal =w.salary;

-- Q.46
select distinct salary from worker as w1 where 3 >= (select count(distinct (w2.salary)) from worker as w2 where w2.salary >= w1.salary) order by salary desc;
select distinct salary from worker order by salary desc limit 3;

-- Q.47
select distinct salary from worker as w1 where  5 <= (select count(distinct (w2.salary)) from worker as w2 where w2.salary >= w1.salary) order by salary;
select distinct salary from worker as w1 where  3 >= (select count(distinct (w2.salary)) from worker as w2 where w2.salary <= w1.salary) order by salary;
select distinct salary from worker group by salary limit 3;

-- Q.48
select distinct salary from worker as w1 where 2 = (select count(distinct (w2.salary)) from worker as w2 where w2.salary >= w1.salary);
select distinct salary from worker order by salary desc limit 1,1;

-- Q.49
select department,sum(salary)  from worker group by department;

-- Q.50
select * from worker where salary = (select  max(salary) from worker);
select * from worker as w1 where 1 = (select count( distinct(w2.salary)) from worker as w2 where w2.salary >=w1.salary);
select * from worker where salary = (select distinct salary from worker order by salary desc limit 1);
