/* 
A Stored Procedure is a collection of SQL statements stored in the MySQL database and executed as a single unit whenever needed.



Why Use Stored Procedures?
1. Reusability
Write once, use many times.

2. Faster Execution
Procedure is compiled and stored in the database.

3. Reduces Repeated Code
Instead of writing the same query repeatedly, call the procedure.



Syntax
DELIMITER //
CREATE PROCEDURE procedure_name()
BEGIN
    SQL Statements;
END //
DELIMITER ;


Employee Table
CREATE TABLE employee(
    emp_id INT PRIMARY KEY,
    emp_name VARCHAR(50),
    gender VARCHAR(10),
    age INT,
    department VARCHAR(30),
    designation VARCHAR(30),
    city VARCHAR(30),
    hire_date DATE,
    salary DECIMAL(10,2),
    bonus DECIMAL(10,2)
);
Insert 20 Records
INSERT INTO employee VALUES
(101,'Arun','Male',25,'IT','Developer','Chennai','2022-01-15',35000,2000),
(102,'Bala','Male',28,'HR','Executive','Madurai','2021-03-10',30000,1500),
(103,'Charan','Male',30,'Sales','Manager','Coimbatore','2020-05-12',50000,5000),
(104,'Deepak','Male',27,'IT','Tester','Trichy','2023-02-18',32000,1800),
(105,'Eshwar','Male',35,'Finance','Analyst','Salem','2019-07-22',55000,6000),
(106,'Farooq','Male',29,'IT','Developer','Madurai','2021-08-14',40000,2500),
(107,'Ganesh','Male',31,'HR','Manager','Chennai','2018-11-11',60000,7000),
(108,'Hari','Male',26,'Sales','Executive','Erode','2022-04-20',28000,1200),
(109,'Irfan','Male',33,'Finance','Manager','Madurai','2017-09-15',65000,8000),
(110,'Jagan','Male',24,'IT','Support','Chennai','2024-01-05',25000,1000),
(111,'Karthik','Male',29,'Sales','Executive','Trichy','2021-06-18',34000,1800),
(112,'Lokesh','Male',32,'HR','Executive','Salem','2020-08-21',38000,2200),
(113,'Manoj','Male',27,'Finance','Analyst','Madurai','2022-10-10',42000,2500),
(114,'Naveen','Male',36,'IT','Manager','Chennai','2016-12-12',75000,10000),
(115,'Omprakash','Male',28,'Sales','Executive','Coimbatore','2023-01-17',31000,1500),
(116,'Praveen','Male',34,'Finance','Manager','Erode','2018-02-25',70000,9000),
(117,'Qadir','Male',26,'HR','Executive','Madurai','2022-06-14',29000,1300),
(118,'Ramesh','Male',30,'IT','Developer','Trichy','2020-04-11',45000,3000),
(119,'Suresh','Male',27,'Sales','Executive','Salem','2023-07-07',33000,1700),
(120,'Tamil','Male',35,'Finance','Manager','Chennai','2017-05-30',68000,8500);



Employee Table
CREATE TABLE employee(
    emp_id INT,
    emp_name VARCHAR(50),
    salary DECIMAL(10,2)
);

Simple Procedure
Example 1: 
Create Procedure
DELIMITER //
CREATE PROCEDURE show_employees()
BEGIN
    SELECT * FROM employee;
END //
DELIMITER ;

Execute Procedure
CALL show_employees();


Example 2: 
DELIMITER //
CREATE PROCEDURE it_employees()
BEGIN
    SELECT * FROM employee where department='it';
END //
DELIMITER ;

Execute Procedure
CALL IT_employees();


Example 3: 
DELIMITER //
CREATE PROCEDURE madurai_employees()
BEGIN
    SELECT * FROM employee where city=madurai;
END //
DELIMITER ;

Execute Procedure
CALL madurai_employees();



Types of Parameters
Type	Purpose
IN		Input value
OUT		Output value
INOUT	Input and Output



IN Parameter Examples (3)
Example 1: Employee by ID
DELIMITER //
CREATE PROCEDURE emp_by_id(IN pid INT)
BEGIN
    SELECT * FROM employee
    WHERE emp_id = pid;
END //
DELIMITER ;
CALL emp_by_id(101);


Example 2: Employees by Department
DELIMITER //
CREATE PROCEDURE emp_by_dept(IN pdept VARCHAR(30))
BEGIN
    SELECT * FROM employee
    WHERE department = pdept;
END //
DELIMITER ;
CALL emp_by_dept('IT');


Example 3: Employees by City
DELIMITER //
CREATE PROCEDURE emp_by_city(IN pcity VARCHAR(30))
BEGIN
    SELECT * FROM employee
    WHERE city = pcity;
END //
DELIMITER ;
CALL emp_by_city('Madurai');



OUT Parameter Examples (3)
Example 1: Employee Count
DELIMITER //
CREATE PROCEDURE total_employees(OUT total INT)
BEGIN
    SELECT COUNT(*) INTO total
    FROM employee;
END //
DELIMITER ;
CALL total_employees(@t);
SELECT @t;


Example 2: Maximum Salary
DELIMITER //
CREATE PROCEDURE max_salary(OUT msal DECIMAL(10,2))
BEGIN
    SELECT MAX(salary) INTO msal
    FROM employee;
END //
DELIMITER ;
CALL max_salary(@s);
select @s;


Example 3: Average Salary
DELIMITER //
CREATE PROCEDURE avg_salary(OUT asal DECIMAL(10,2))
BEGIN
    SELECT AVG(salary) INTO asal
    FROM employee;
END //
DELIMITER ;
CALL avg_salary(@as);
selecet @as;



INOUT Parameter Examples (3)
Example 1
DELIMITER //
CREATE PROCEDURE add_bonus_amt(INOUT amt INT)
BEGIN
    SET amt = amt + 1000;
END //
DELIMITER ;

Execute
SET @amt = 5000;
CALL add_bonus(@amt);
SELECT @amt;
Output:6000


Example 2
DELIMITER //
CREATE PROCEDURE double_salary(INOUT sal INT)
BEGIN
    SET sal = sal * 2;
END //
DELIMITER ;
Execute:
SET @salary = 30000;
CALL double_salary(@salary);
SELECT @salary;
Output:60000


Example 3
DELIMITER //
CREATE PROCEDURE tax_deduction(INOUT sal INT)
BEGIN
    SET sal = sal - 2000;
END //
DELIMITER ;
Execute:
SET @salary = 50000;
CALL tax_deduction(@salary);
SELECT @salary;
Output:48000



IF Examples
-- syntax --
if condition then
	statements;
elseif conditon then
	statements;
else
	statements;
end if;

i) IF  must end with end if;
ii)IF function in query
select if(80>=35,'pass','fail');

Example 1: Salary Status
USING IF WITH TABLE
DELIMITER //
CREATE PROCEDURE salary_status(
    IN eid INT
)
BEGIN
    DECLARE sal DECIMAL(10,2);

    SELECT salary INTO sal
    FROM employee
    WHERE emp_id = eid;
    
    IF sal >= 50000 THEN
        SELECT 'High Salary' as status;
    ELSE
        SELECT 'Low Salary' as status;
    END IF;
END //
DELIMITER ;
Execute:
CALL salary_status(107);


Example 2: Bonus Check
Delimiter //
Create procedure bonus_check(in bonus int)
Begin
IF bonus >= 5000 THEN
    SELECT 'Excellent Bonus';
ELSE
    SELECT 'Normal Bonus';
END IF;
end //

ASSIGNMENT:
CREATE PROCEDURE FOR GRADE CALCULATION USING IN PARAMETER WITHOUT USING TABLE
>=90	A GRADE
>=75	B GRADE
>=50	C GRADE
<50		FAIL



CASE Examples 
-- syntax --
CASE expression
	WHEN value1 THEN
		statements;
	WHEN value2 THEN
		statements;
	ELSE
		statements;
END CASE;


Example 1: 
Using CASE in table
DELIMITER //
CREATE PROCEDURE department_type(IN pid INT)
BEGIN
    DECLARE dept VARCHAR(30);
    SELECT department INTO dept FROM employee WHERE emp_id = pid;
    CASE dept
        WHEN 'IT' THEN
            SELECT 'Technology Department';
        WHEN 'HR' THEN
            SELECT 'Human Resource Department';
        WHEN 'Finance' THEN
            SELECT 'Finance Department';
        ELSE
            SELECT 'Sales Department';
    END CASE;
END //
DELIMITER ;
Execute
CALL department_type(101);

Example 2:
CREATE PROCEDURE check_marks(IN marks INT)
BEGIN
    CASE
        WHEN marks >= 90 THEN
            SELECT 'A Grade';
        WHEN marks >= 75 THEN
            SELECT 'B Grade';
        WHEN marks >= 50 THEN
            SELECT 'C Grade';
        ELSE
            SELECT 'Fail';
    END CASE;
END //
DELIMITER ;
Execute:
CALL check_marks(82);



Variables in Procedure
DELIMITER //
CREATE PROCEDURE demo()
BEGIN
    DECLARE bonus INT;
    SET bonus = 5000;
    SELECT bonus;
END //
DELIMITER ;

Output:
5000



INSERT Procedure 
Example 1:
DELIMITER //
CREATE PROCEDURE add_employee(
    IN pid INT,
    IN pname VARCHAR(50),
    IN pgender VARCHAR(10),
    IN page INT,
    IN pdept VARCHAR(30),
    IN pdesig VARCHAR(30),
    IN pcity VARCHAR(30),
    IN phiredate DATE,
    IN psalary DECIMAL(10,2),
    IN pbonus DECIMAL(10,2)
)
BEGIN
    INSERT INTO employee
    VALUES(pid,pname,pgender,page,pdept,
           pdesig,pcity,phiredate,psalary,pbonus);
END //
DELIMITER ;
Execute
CALL add_employee(121,'Vijay','Male',26,'IT','Developer','Chennai','2024-05-10',45000,2500);



DELETE Procedure 
Example 1:
DELIMITER //
CREATE PROCEDURE delete_employee(IN pid INT)
BEGIN
    DELETE FROM employee WHERE emp_id = pid;
END //
DELIMITER ;
Execute
CALL delete_employee(121);

Check:
SELECT *
FROM employee
WHERE emp_id = 121;



UPDATE Procedure
Example 1:
DELIMITER //
CREATE PROCEDURE update_emp_salary(
    IN pid INT,
    IN newsalary DECIMAL(10,2)
)
BEGIN
    UPDATE employee
    SET salary = newsalary
    WHERE emp_id = pid;
END //
DELIMITER ;
Execute
CALL update_emp_salary(101,50000);

Check:
SELECT * FROM employee
WHERE emp_id = 101;


LOOP IN MYSQL:
MySQL supports three loops in stored programs:
1)WHILE
2)REPEAT
3)LOOP(with LEAVE to exit)


WHILE LOOP
A WHILE loop repeatedly executes a block of code as long as the condition is true.

-- Syntax --
WHILE condition DO
    statements;
END WHILE;


Example 1: Print Numbers 1 to 5
DELIMITER //
CREATE PROCEDURE print_numbers()
BEGIN
    DECLARE i INT DEFAULT 1;
    WHILE i <= 5 DO
        SELECT i;
        SET i = i + 1;
    END WHILE;
END //
DELIMITER ;
Execute:
CALL print_numbers();

Example 2: 
Multiplication Table of 5
DELIMITER //
CREATE PROCEDURE table_of_5()
BEGIN
    DECLARE i INT DEFAULT 1;
    WHILE i <= 10 DO
        SELECT CONCAT('5 x ', i, ' = ', 5 * i) AS Result;
        SET i = i + 1;
    END WHILE;
END //
DELIMITER ;
Execute:
CALL table_of_5();


Example 3: Sum of Numbers 1 to N
DELIMITER //
CREATE PROCEDURE sum_n(IN n INT)
BEGIN
    DECLARE i INT DEFAULT 1;
    DECLARE total INT DEFAULT 0;
    WHILE i <= n DO
        SET total = total + i;
        SET i = i + 1;
    END WHILE;
    SELECT total AS Sum_Result;
END //
DELIMITER ;
Execute:
CALL sum_n(5);

