# Sql_PeerReview
---
---

# Ankit Kumar
### Question-1
Created Employee table with columns,Emp_id, Emp_name, Gender, department with the datatypes INT, VARCHAR(25), VARCHAR(25), VARCHAR(25) and the constains PRIMARY KEY AUTO_INCREMENT, NOT NULL, NOT NULL, NOT NULL
**Employee Table creation**
```
CREATE TABLE Employee(
   Emp_id INT PRIMARY KEY AUTO_INCREMENT,
   VARCHAR(25) NOT NULL,
   Gender VARCHAR(25) NOT NULL,
   department VARCHAR(25) NOT NULL
);
```
Inserted values to the Employess table using  **INSERT INTO --- VALUES () --**
**Inserting the values to the Employee Table**
```
INSERT INTO employee(Emp_name,Gender,department)
VALUES('X','Female','Finance'),
      ('Y','Male','IT'),
      ('Z','Male','HR'),
      ('W','Female','IT');
```

***Query***
```
SELECT department AS Department,
       SUM(CASE
               WHEN gender='Male' THEN 1
               ELSE 0
           END) AS 'Count of Male',
       SUM(CASE
               WHEN gender='Female' THEN 1
               ELSE 0
           END) AS 'Count of Female'  
FROM employee
GROUP BY department;
```
Used **SUM** and **CASE** functions to calculate the no of females and males in each department, used **GROUP BY** grouped all the departments and seleted the data from Employee table using **FROM** through **SELECT**

---
### Question-2
Created employee_info table with columns Name, Jan, Feb, Mar with the datatypes of Varchar, INT, INT, INT and the constrains NOT NULL, NOT NULL, NOT NULL respectively.

**employee_info Table creation**
```
CREATE TABLE employee_info(
   Name VARCHAR(25) NOT NULL,
   Jan INT NOT NULL,
   Feb INT NOT NULL,
   Mar INT NOT NULL
);
```
**Inserting the values to the employee_info Table**
```
INSINSERT INTO employee_info(Name, Jan, Feb, Mar)
VALUES('X',5200,9093,3832),
      ('Y',9023,8942,4000),
      ('Z',9834,8197,9903),
      ('W',3244,4321,0293);
```
***Query***
```
SELECT Name,
       CASE
           WHEN Jan>=Feb AND Jan>=Mar THEN Jan
           WHEN Feb>=Jan AND Feb>=Jan THEN Feb
           ELSE Mar
       END AS Value,
       CASE
           WHEN Jan>=Feb AND Jan>=Mar THEN 'Jan'
           WHEN Feb>=Jan AND Feb>=Jan THEN 'Feb'
           ELSE 'Mar'
       END AS Month
 FROM employee_info;
```
This query selects the name, the highest value of three months (Jan, Feb, and Mar), and the corresponding month of the highest value from the "employee_info" table.

The resulting table will have three columns: "Name", "Value", and "Month". The "Name" column contains the name of each employee, the "Value" column contains the highest value among Jan, Feb, and Mar, and the "Month" column contains the month with the highest value.

---
### Question-3
Created Exam Table with the columns  CandidateId, Marks with the datatypes INT, INT and the constrains PRIMARY KEY AUTO_INCREMENT and NOT NULL respectively.

**ExamTable creation**
```
CREATE TABLE Exam(
   CandidateId INT PRIMARY KEY AUTO_INCREMENT,
   Marks INT NOT NULL
);
```
**Inserting the values to the Exam Table**
```
INSERT INTO Exam(Marks)
VALUES(98),(78),(87),(98),(78);
```

***Query***
```
SELECT Marks, 
       RANK() OVER(ORDER BY Marks DESC) 'Rank',
       GROUP_CONCAT(CandidateID) AS CandidateID
FROM EXAM
GROUP BY Marks
ORDER BY Marks DESC;
```
This query selects the "Marks" column from  table "EXAM".The window function **RANK** to rank the marks in descending order, and assigns the rank to each row. The  **GROUP_CONCAT** function is used to concatenate the CandidateIDs of all candidates who scored the same marks.The results are grouped by marks and ordered in descending order by marks.

---
### Question-4

Created Records table with columns CandidateId, Email with the datatypes of INT and VARCHAR and the constrains  PRIMARY KEY respectively.

**Records Table creation**
```
CREATE TABLE Records(
   CandidateId INT PRIMARY KEY,
   Email VARCHAR(70)
);
```
**Inserting the values to the Records Table**
```
INSERT INTO Records(CandidateId, Email)
VALUES(45,'abc@gmail.com'),
      (23,'def@gmail.com'),
      (34,'abc@gmail.com'),
      (21,'bcf@gmail.com'),
      (94,'def@gmail.com');
```
***Query***
```
create view Help_info as SELECT MIN(CandidateId) AS Candidate_ID
FROM Records
GROUP BY Email
ORDER BY Candidate_ID DESC ;

select * from Help_info;
--deleting
DELETE from records where candidateId not in
(select candidate_Id from Help_info);
--Printing
SELECT * FROM Records
```

Ankit creates a view  "Help_info" and then performs a delete operation on a table called "Records" based on the results of the view.


The view "Help_info" selects the minimum value of "CandidateId" for each unique "Email" in the "Records" table. The results are grouped by "Email" and ordered in descending order by "Candidate_ID".

Deleting all rows from the "Records" table where the "CandidateId" is not found in the "Candidate_ID" column of the "Help_info" view.


# Arin's Approach:
### Question-1:
**Creating employees Table **
```
CREATE TABLE employees(
	EmpID INT PRIMARY KEY,
    Name VARCHAR(20) NOT NULL,
    Gender VARCHAR(20) NOT NULL,
    Department VARCHAR(20) NOT NULL
);
```
Created employees table with columns EmpID,  Name, Gender, Department with the datatypes INT, VARCHAR(20), VARCHAR(20) and VARCHAR(20) with the constrains PRIMARY KEY, NOT NULL, NOT NULL, NOT NULL
**Inserting the values in to the employees table**
```
INSERT INTO employees VALUES(1,'X', 'Female', 'Finance');
INSERT INTO employees VALUES(2,'Y', 'Male', 'IT');
INSERT INTO employees VALUES(3,'Z', 'Male', 'HR');
INSERT INTO employees VALUES(4,'W', 'Female', 'IT');
```
***Query***
```
SELECT Department, 
    SUM(CASE WHEN Gender='Male' THEN 1  ELSE 0 END) as 'Num of males',
    SUM(CASE WHEN Gender='Female' THEN 1 ELSE 0 END) as 'Num of females' 
FROM employees 
GROUP BY Department
ORDER BY Department;
```


Used **SUM** and **CASE** functions to calculate the no of females and males in each department, used **GROUP BY** grouped all the departments  and seleted the data from Employee table using **FROM** through **SELECT** finally **ORDER BY** Department


### Question-2:
**Creating employees Table **
```
SELECT Name, 
(SELECT MAX(maxSal) maxSal FROM 
	(SELECT salaries.Jan AS maxSal 
		UNION 
        SELECT salaries.Feb 
        UNION 
        SELECT salaries.Mar
	) AS a
) as Value,
(SELECT(
		CASE 
			WHEN Value=salaries.Jan THEN 'Jan' 
			WHEN Value=salaries.Feb THEN 'Feb' 
			WHEN Value=salaries.Mar THEN 'Mar' 
	    	END
		)
) as Month

FROM salaries;
```




###### Question-3:


```
SET @rank_num=0;

SELECT 

	Marks, 

	@rank_num := @rank_num+1 as 'Rank', 

	GROUP_CONCAT(Candidate_ID) as Candidate_ID 

FROM marks 

GROUP BY Marks 

ORDER BY Marks DESC;

```
Uses Rank() function to rank the marks, GROUP_CONCAT(Candidate_ID) which concatenates values for each group of marks
The GROUP BY clause groups the data by marks. This means that all rows with the same value of Marks will be grouped together.
The ORDER BY clause sorts the data by marks in descending order, in which we get the rows with the highest marks first.


### Question-4:
```
SELECT MIN(Candidate_id) as Candidate_id, Email FROM emails GROUP BY Email ORDER BY Candidate_id DESC;  
```
The GROUP BY, groups the data by Email. This means that all rows with the same email address will be grouped together.
The ORDER BY clause sorts the data by Candidate_id in descending order