-- Create a database
CREATE DATABASE mycompanydb;

-- Create table Employees
CREATE TABLE Employees (
 	employee_id INT PRIMARY KEY,
    first_name VARCHAR(64),
    last_name VARCHAR(64),
    department_id INT,
    CONSTRAINT fk_employee_department FOREIGN KEY (department_id) REFERENCES Department (department_id)
);

-- Create table Department
CREATE TABLE Department (
    department_id INT PRIMARY KEY,
    department_name VARCHAR(255)
);

-- Create table Salary
CREATE TABLE Salary (
    salary_id INT PRIMARY KEY,
    employee_id INT,
    gross_pay INT,
    CONSTRAINT fk_salary_employee FOREIGN KEY (salary_id) REFERENCES employees (employee_id) ON DELETE CASCADE
);


-- sample data
INSERT INTO Department (department_id, department_name) 
VALUES 
(1, 'Administration'),
(2, 'Finance'),
(3, 'Production'),
(4, 'Processing'),
(5, 'Procurement');


-- sample data
INSERT INTO Salary (salary_id, employee_id, gross_pay) 
VALUES 
(1, 1, 90000),
(2, 2, 98000),
(3, 3, 80000),
(4, 4, 105000),
(5, 5, 110000),
(6, 6, 120000),
(7, 7, 150000),
(8, 8, 120000);

-- sample data
UPDATE Employees SET department_id=1 WHERE employee_id=1; 
UPDATE Employees SET department_id=2 WHERE employee_id=2;
UPDATE Employees SET department_id=3 WHERE employee_id=3;
UPDATE Employees SET department_id=4 WHERE employee_id=4;
UPDATE Employees SET department_id=5 WHERE employee_id=5;
UPDATE Employees SET department_id=1 WHERE employee_id=6;
UPDATE Employees SET department_id=2 WHERE employee_id=7;




-- ===========================================================================
-- Retrieving employees and their corresponding departments

SELECT 
    first_name AS 'FIRST NAME', 
    last_name AS 'LAST NAME', 
    department_name AS DEPARTMENT 
FROM 
    Employees e, Department d 
WHERE 
    e.department_id=d.department_id 
ORDER BY 
department_name;

-- +------------+-----------+----------------+
-- | FIRST NAME | LAST NAME | DEPARTMENT     |
-- +------------+-----------+----------------+
-- | Adam       | Kimutai   | Administration |
-- | Mark       | Otieno    | Administration |
-- | Anthony    | Kamau     | Finance        |
-- | Paul       | Phillip   | Finance        |
-- | James      | Lesser    | Processing     |
-- | John       | Mark      | Procurement    |
-- | Peter      | Rock      | Production     |
-- +------------+-----------+----------------+
-- 7 rows in set (0.00 sec)



-- ===========================================================================
-- Retrieving NUMBER OF EMPLOYEES, TOTAL PAY and AVERAGE PAY per department

SELECT 
    department_name AS DEPARTMENT,
    COUNT(e.department_id) AS 'No OF EMPLOYEES', 
    SUM(gross_pay) AS 'TOTAL PAY', 
    AVG(gross_pay) AS 'AVERAGE PAY' 
FROM 
    Employees e, Department d, Salary s 
WHERE 
    e.employee_id=s.employee_id AND e.department_id=d.department_id 
GROUP BY 
    department_name;

-- +----------------+-----------------+-----------+-------------+
-- | DEPARTMENT     | No OF EMPLOYEES | TOTAL PAY | AVERAGE PAY |
-- +----------------+-----------------+-----------+-------------+
-- | Administration |               2 |    210000 | 105000.0000 |
-- | Finance        |               2 |    248000 | 124000.0000 |
-- | Production     |               1 |     80000 |  80000.0000 |
-- | Processing     |               1 |    105000 | 105000.0000 |
-- | Procurement    |               1 |    110000 | 110000.0000 |
-- +----------------+-----------------+-----------+-------------+


-- ===========================================================================
-- RETRIEVING average pay per department

SELECT 
    department_name AS DEPARTMENT, 
    AVG(gross_pay) AS 'AVERAGE PAY' 
FROM 
    Employees e, Department d, Salary s 
WHERE 
    e.employee_id=s.employee_id AND e.department_id=d.department_id 
GROUP BY department_name;

-- +----------------+-------------+
-- | DEPARTMENT     | AVERAGE PAY |
-- +----------------+-------------+
-- | Administration | 105000.0000 |
-- | Finance        | 124000.0000 |
-- | Production     |  80000.0000 |
-- | Processing     | 105000.0000 |
-- | Procurement    | 110000.0000 |
-- +----------------+-------------+
-- 5 rows in set (0.00 sec)



-- ===============================================================
-- RETRIVING employees ho do not belong to any department

SELECT * FROM employees WHERE department_id<=>NULL;

-- +-------------+------------+-----------+---------------+
-- | employee_id | first_name | last_name | department_id |
-- +-------------+------------+-----------+---------------+
-- |           8 | Mary       | Jane      |          NULL |
-- |           9 | Twin       | Thomas    |          NULL |
-- +-------------+------------+-----------+---------------+

