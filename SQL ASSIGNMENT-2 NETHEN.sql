-- 1. Select all employees in department 10 whose salary is greater than 3000.
USE ASSIGNMENT;
SELECT * FROM EMPLOYEE WHERE SALARY > 3000 AND DEPTNO = 10;

-- 2. The grading of students based on the marks they have obtained is done as follows:
-- 40 to 50 -> Second Class
-- 50 to 60 -> First Class
-- 60 to 80 -> First Class
-- 80 to 100 -> Distinctions
SET SQL_SAFE_UPDATES=0;
SELECT * FROM STUDENTS;
ALTER TABLE STUDENTS ADD COLUMN Grade VARCHAR(20) AFTER MARKS;
UPDATE STUDENTS SET Grade = CASE 
WHEN MARKS BETWEEN 40 AND 49.9 THEN 'Third class'
WHEN MARKS BETWEEN 50 AND 59.9 THEN 'Second class'
WHEN MARKS BETWEEN 60 AND 79.9 THEN 'First class'
WHEN MARKS BETWEEN 80 AND 100 THEN 'Distinction'
ELSE 'Fail'
END;

-- a. How many students have graduated with first class?
SELECT count(*) AS 'FIRST CLASS STUDENTS' FROM STUDENTS WHERE MARKS BETWEEN 60 AND 79.9;

-- b. How many students have graduated with distinction class?
SELECT COUNT(*) AS 'DISTINCTION STUDENTS' FROM STUDENTS WHERE MARKS BETWEEN 80 AND 100;

-- 3. Get a list of city names from station with even ID numbers only. Exclude duplicates from your answer.
SELECT * FROM STATION;
SELECT DISTINCT CITY,ID FROM STATION WHERE ID%2=0;

-- 4.Find the difference between the total number of city entries in the table and the number of distinct city entries in the table. In other words, if N is the number of city entries in station, and N1 is the number of distinct city names in station, 
-- write a query to find the value of N-N1 from station.
SELECT (COUNT(CITY)-COUNT(DISTINCT CITY)) AS DIFFERENCE FROM STATION;

-- 5. Answer the following
-- a. Query the list of CITY names starting with vowels (i.e., a, e, i, o, or u) from STATION. 
SELECT DISTINCT CITY FROM STATION WHERE CITY REGEXP '^[AEIOU]';

-- b. Query the list of CITY names from STATION which have vowels (i.e., a, e, i, o, and u) as both their first and last characters. Your result cannot contain duplicates.
SELECT DISTINCT CITY FROM STATION WHERE LEFT(CITY,1) IN ('A','E','I','O','U') AND RIGHT(CITY,1) IN ('A','E','I','O','U');
-- OR
select DISTINCT CITY FROM STATION WHERE CITY REGEXP '^[AEIOU]' AND CITY REGEXP '[AEIOU]$';

-- c. Query the list of CITY names from STATION that do not start with vowels. Your result cannot contain duplicates.
SELECT DISTINCT CITY FROM STATION WHERE CITY NOT REGEXP '^[AEIOU]';

-- d. Query the list of CITY names from STATION that either do not start with vowels or do not end with vowels. Your result cannot contain duplicates.
SELECT DISTINCT CITY FROM STATION WHERE CITY NOT REGEXP '^[AEIOU]|[AEIOU]$';

-- 6. Write a query that prints a list of employee names having a salary greater than $2000 per month who have been employed for less than 36 months. Sort your result by descending order of salary.
SELECT CONCAT(FIRST_NAME, ' ', LAST_NAME) AS EMPLOYEE_NAME,HIRE_DATE,SALARY,TIMESTAMPDIFF(MONTH, HIRE_DATE, CURRENT_DATE()) AS 'TOTAL_MONTHS_JOINED' FROM EMP WHERE SALARY>2000 HAVING TOTAL_MONTHS_JOINED < 3 ORDER BY SALARY DESC;

-- 7. How much money does the company spend every month on salaries for each department? [table: employee]
-- Expected Result
-- +--------+--------------+
-- | deptno | total_salary |
-- +--------+--------------+
-- |     10 |     20700.00 |
-- |     20 |     12300.00 |
-- |     30 |      1675.00 |
-- +--------+--------------+
-- 3 rows in set (0.002 sec)
SELECT * FROM EMPLOYEE;
SELECT DEPTNO, SUM(SALARY) AS 'TOTAL SALARY' FROM EMPLOYEE GROUP BY DEPTNO;

-- 8. How many cities in the CITY table have a Population larger than 100000. [table: city]
SELECT * FROM CITY;
SELECT NAME AS CITY, POPULATION FROM CITY WHERE POPULATION >100000 ORDER BY POPULATION DESC;

-- 9. What is the total population of California? [table: city]
SELECT * FROM CITY;
SELECT DISTRICT, SUM(POPULATION) AS 'TOTAL_CALIFORNIA_POPULATION' FROM CITY WHERE DISTRICT REGEXP 'CALIFORNIA' GROUP BY DISTRICT;

-- 10. What is the average population of the districts in each country? [table: city]
SELECT DISTRICT, AVG(POPULATION) AS AVERAGE_POPULATION FROM CITY GROUP BY DISTRICT;

-- 11.Find the ordernumber, status, customernumber, customername and comments for all orders that are ‘Disputed=  [table: orders, customers]
SELECT * FROM ORDERS;
SELECT * FROM CUSTOMERS;
SELECT O.ORDERNUMBER,O.STATUS,O.CUSTOMERNUMBER,C.CUSTOMERNAME,O.COMMENTS FROM CUSTOMERS C JOIN ORDERS O USING(CUSTOMERNUMBER) WHERE O.STATUS='DISPUTED';