CREATE SCHEMA IF NOT EXISTS `SqlassignmentDB`;
USE `SqlassignmentDB`;


/*Creating Employee table */
CREATE TABLE IF NOT EXISTS Employees (
	empid integer(4) not null unique,
	emp_name varchar(40),
	Gender varchar(10),
	department varchar(25),
	check(Gender in ("Male","Female")));


/*Inserting values to the Employee table*/
Insert into Employees 
values	(1,'X','Female','Finance'),
		(2,'Y','Male','IT'),
        (3,'Z','Male','HR'),
        (4,'W','Female','IT');
        
-- Checking the constrains of the Employees table
Insert into employees values(5,'Mohan','DE','SQL');
Insert into employees values(6,'Logan','Male',null);



-- Question -1

-- Method-1:
SELECT IFNULL(Department,'Not Assigned') as Department,
   COUNT(CASE WHEN LOWER(Gender)='male' THEN 1 END) AS 'Num of Male',
   COUNT(CASE WHEN LOWER(Gender)='female' THEN 1 END) AS 'Num of Female'
FROM Employees 
GROUP BY Department;


-- Method-2:
SELECT IFNULL(Department,'Not Assigned'), 
   SUM(IF(gender="male",1,0)) AS 'Num of male', 
   SUM(IF(lower(Gender) = 'female', 1, 0)) AS 'Num of Female'
FROM EmployeeS
GROUP BY Department
ORDER BY Department;


-- Creating Employee_salary table
CREATE TABLE Employee_salary (
	emp_name varchar(30) not null,
	Jan Float(15,2) Not null default 0,
	Feb Float(15,2) Not null default 0,
	March Float(15,2) Not null default 0,
	check(Jan>=0 and Feb >=0 and March >=0));


-- Inseting values to the Employee_salary table
INSERT INTO Employee_salary
 VALUES('X',5200,9093,3832),
	   ('Y',9023,8942,4000),
       ('Z',9834,8197,9903),
       ('W',3244,4321,0293);
-- Checking the constrains of the Employee_salary table
-- INSERT INTO Employee_salary VALUES('V',100,100,null);
-- INSERT INTO Employee_salary VALUES('V',100,-100,null);



-- Question-2:
-- Method-1:
SELECT emp_name AS 'Name',
  VALUE,
   CASE WHEN idx=1 THEN 'Jan'
		WHEN idx=2 THEN 'Feb'
		WHEN idx=3 THEN 'Mar'
   END AS 'Month'
FROM (SELECT
		emp_name,
		GREATEST(Jan, Feb, March) AS VALUE,
		FIELD(greatest(Jan, Feb, March), Jan, Feb, March) AS  idx
	FROM Employee_salary ) AS emps;


--  Method-2:
SELECT emp_name AS 'Name',
		(SELECT (CASE WHEN (Jan>Feb AND Jan>March) THEN Jan  WHEN (Feb > Jan AND Feb >March) THEN feb ELSE March END)) AS VAL,
		(SELECT (CASE WHEN VAL = Jan  THEN  "Jan" WHEN VAL = Feb  THEN  'Feb' WHEN VAL = March THEN 'Mar' END)) AS "Month"
FROM Employee_salary;



-- Creating Test table
CREATE TABLE IF NOT EXISTS Test (
	candidate_id integer(4) not null unique,	
	marks float(10,2) default 0);

-- Inseting values into the Test
INSERT INTO Test 
VALUES (1,98),
	  (2,78),
	  (3,87),
	  (4,98),
	  (5,78); 



-- Question-3:
SELECT Marks, dense_rank() OVER (ORDER BY marks DESC ) AS 'rank',GROUP_CONCAT(Candidate_id) AS Candidate_id
FROM test
GROUP BY marks;

-- Creating mail_ids table
CREATE TABLE IF NOT EXISTS Mail_ids (
	candidate_id integer(4) not null,
	mail varchar(30) not null
);  

-- inserting values to the mail_ids table
INSERT INTO mail_ids 
VALUES (45,'abc@gmail.com'),
	  (23,'def@yahoo.com'),
	  (34,'abc@gmail.com'),
	  (21,'bcf@gmail.com'),
	  (94,'def@yahoo.com'); 
      



-- Question-4:
-- Method -1:

CREATE TEMPORARY TABLE tmp AS
	SELECT MIN(candidate_id ) AS candidate_id,
    mail
FROM mail_ids 
GROUP BY mail;

DELETE FROM mail_ids 
WHERE Candidate_id NOT IN (SELECT Candidate_id FROM tmp);

DROP TEMPORARY TABLE tmp;



-- Method-2:
DELETE FROM Mail_ids 
WHERE candidate_id IN (SELECT tempcandidate_id FROM (SELECT DISTINCT a.candidate_id as tempcandidate_id 
FROM Mail_ids AS a 
INNER JOIN mail_ids AS b 
WHERE a.mail=b.mail AND a.candidate_id>b.candidate_id) AS c) 
ORDER BY candidate_id;
