-- Exported from QuickDBD: https://www.quickdatatabasediagrams.com/
-- Link to schema: https://app.quickdatabasediagrams.com/#/d/AGZVvw
-- NOTE! If you have used non-SQL datatypes in your design, you will have to change these here.


CREATE TABLE "departments" (
    "dept_no" VARCHAR(10)   NOT NULL,
    "dept_name" VARCHAR(30)   NOT NULL,
    CONSTRAINT "pk_departments" PRIMARY KEY (
        "dept_no"
     )
);

CREATE TABLE "department_employees" (
    "emp_no" INTEGER   NOT NULL,
    "dept_no" VARCHAR(10)   NOT NULL,
    "from_date" DATE   NOT NULL,
    "to_date" DATE   NOT NULL
);

CREATE TABLE "department_manager" (
    "dept_no" VARCHAR(10)   NOT NULL,
    "emp_no" INTEGER   NOT NULL,
    "from_date" DATE   NOT NULL,
    "to_date" DATE   NOT NULL
);

CREATE TABLE "employees" (
    "emp_no" INTEGER   NOT NULL,
    "birth_date" DATE   NOT NULL,
    "first_name" VARCHAR(20)   NOT NULL,
    "last_name" VARCHAR(20)   NOT NULL,
    "gender" VARCHAR(1)   NOT NULL,
    "hire_date" DATE   NOT NULL,
    CONSTRAINT "pk_employees" PRIMARY KEY (
        "emp_no"
     )
);

CREATE TABLE "salaries" (
    "emp_no" INTEGER   NOT NULL,
    "salary" INTEGER   NOT NULL,
    "from_date" DATE   NOT NULL,
    "to_date" DATE   NOT NULL
);

CREATE TABLE "titles" (
    "emp_no" INTEGER   NOT NULL,
    "title" VARCHAR(30)   NOT NULL,
    "from_date" DATE   NOT NULL,
    "to_date" DATE   NOT NULL
);

ALTER TABLE "department_employees" ADD CONSTRAINT "fk_department_employees_emp_no" FOREIGN KEY("emp_no")
REFERENCES "employees" ("emp_no");

ALTER TABLE "department_employees" ADD CONSTRAINT "fk_department_employees_dept_no" FOREIGN KEY("dept_no")
REFERENCES "departments" ("dept_no");

ALTER TABLE "department_manager" ADD CONSTRAINT "fk_department_manager_dept_no" FOREIGN KEY("dept_no")
REFERENCES "departments" ("dept_no");

ALTER TABLE "department_manager" ADD CONSTRAINT "fk_department_manager_emp_no" FOREIGN KEY("emp_no")
REFERENCES "employees" ("emp_no");

ALTER TABLE "salaries" ADD CONSTRAINT "fk_salaries_emp_no" FOREIGN KEY("emp_no")
REFERENCES "employees" ("emp_no");

ALTER TABLE "titles" ADD CONSTRAINT "fk_titles_emp_no" FOREIGN KEY("emp_no")
REFERENCES "employees" ("emp_no");

-- CHECK TABLES

SELECT * FROM employees;
SELECT * FROM departments;
SELECT * FROM department_employees;
SELECT * FROM department_manager;
SELECT * FROM salaries;
SELECT * FROM titles;

-- CHECK AMOUNT OF ROWS IN EVERY TABLE TO MAKE SURE EVERYTHING IMPORTED RIGHT

SELECT COUNT(*) FROM employees;
SELECT COUNT(*) FROM departments;
SELECT COUNT(*) FROM department_employees;
SELECT COUNT(*) FROM department_manager; 
SELECT COUNT(*) FROM salaries;
SELECT COUNT(*) FROM titles;






-- 1. List the following details of each employee: employee number, last name, first name, gender, and salary.

SELECT * FROM employees;
SELECT * FROM salaries;

SELECT  e.emp_no AS employee_number, 
		e.last_name, 
		e.first_name, 
		e.gender, 
		s.salary	
FROM employees AS e
JOIN salaries AS s ON
e.emp_no = s.emp_no
ORDER BY employee_number;


-- 2. List employees who were hired in 1986.

SELECT * FROM employees;

SELECT  e.emp_no AS employee_number, 
		e.last_name, 
		e.first_name, 
		e.hire_date 
FROM employees AS e
WHERE e.hire_date >= '1986-01-01' and e.hire_date <= '1986-12-31';


-- 3. List the manager of each department with the following information: 
-- department number, department name, the manager's employee number, last name, first name, and start and end employment dates.

SELECT * FROM employees; -- last name and first name
SELECT * FROM departments; -- department number and department name
SELECT * FROM department_manager; -- manager's employee number, start and end employments dates


SELECT  d.dept_no AS department_number,
		d.dept_name AS department_name,
		e.emp_no AS employee_number,
		e.first_name, 
		e.last_name, 
		dm.from_date AS start_date,
		dm.to_date AS end_date
FROM departments d
JOIN department_manager dm ON
d.dept_no = dm.dept_no
JOIN employees e ON
dm.emp_no = e.emp_no
WHERE dm.to_date = '9999-01-01';


-- 4. List the department of each employee with the following information: employee number, last name, first name, and department name.

SELECT * FROM employees;
SELECT * FROM departments;
SELECT * FROM department_emplyees;

SELECT  e.emp_no AS employee_number,
		e.last_name,
		e.first_name,
		d.dept_name AS department_name
FROM departments d
JOIN department_employees de ON
d.dept_no = de.dept_no
JOIN employees e ON
de.emp_no = e.emp_no
ORDER BY employee_number;
		

-- 5. List all employees whose first name is "Hercules" and last names begin with "B."

SELECT * FROM employees;

SELECT  e.first_name, 
		e.last_name
FROM employees e
WHERE e.first_name = 'Hercules' AND e.last_name LIKE 'B%'
ORDER BY e.last_name;


-- 6. List all employees in the Sales department, including their employee number, last name, first name, and department name.

SELECT * FROM employees;
SELECT * FROM departments;
SELECT * FROM department_emplyees;

SELECT  e.emp_no AS employer_number,
		e.last_name,
		e.first_name,
		d.dept_name AS department_name
FROM departments d
JOIN department_employees de ON
d.dept_no = de.dept_no
JOIN employees e ON
de.emp_no = e.emp_no
WHERE d.dept_name = 'Sales';


-- 7. List all employees in the Sales and Development departments
-- including their employee number, last name, first name, and department name

SELECT * FROM employees;
SELECT * FROM departments;
SELECT * FROM department_emplyees;

SELECT  e.emp_no AS employer_number,
		e.last_name,
		e.first_name,
		d.dept_name AS department_name
FROM departments d
JOIN department_employees de ON
d.dept_no = de.dept_no
JOIN employees e ON
de.emp_no = e.emp_no
WHERE d.dept_name = 'Sales' OR d.dept_name = 'Development'
ORDER BY e.emp_no;


-- 8. In descending order, list the frequency count of employee last names, i.e., how many employees share each last name.

SELECT * FROM employees;

SELECT  e.last_name, 
		COUNT(e.last_name) AS frequency_count
FROM employees e
GROUP BY e.last_name
ORDER BY frequency_count DESC;


-- BONUS

-- Average salary by title.

SELECT * FROM salaries;
SELECT * FROM titles;

SELECT  t.title,
		ROUND(AVG(s.salary),2) AS average_salary
FROM titles t
LEFT JOIN salaries s
ON t.emp_no = s.emp_no
WHERE t.to_date = '1/1/9999'
GROUP BY t.title
ORDER BY average_salary DESC;


-- EPILOGUE

SELECT * FROM employees;

SELECT * 
FROM employees e
WHERE e.emp_no = 499942;





