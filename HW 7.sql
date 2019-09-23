-- Exported from QuickDBD: https://www.quickdatabasediagrams.com/
-- NOTE! If you have used non-SQL datatypes in your design, you will have to change these here.


SET XACT_ABORT ON

BEGIN TRANSACTION QUICKDBD

CREATE TABLE [departments] (
    [dept_no] VARCHAR  NOT NULL ,
    [dept_name] VARCHAR  NOT NULL ,
    CONSTRAINT [PK_departments] PRIMARY KEY CLUSTERED (
        [dept_no] ASC
    )
)

CREATE TABLE dept_emp (
    [emp_no] INT  NOT NULL ,
    [dept_no] VARCHAR  NOT NULL ,
    [from_date] DATE  NOT NULL ,
    [to_date] DATE  NOT NULL ,
    CONSTRAINT [PK_dept_emp] PRIMARY KEY CLUSTERED (
        [emp_no] ASC
    )
)

CREATE TABLE [dept_manager] (
    [dept_no] VARCHAR  NOT NULL ,
    [emp_no] INT  NOT NULL ,
    [from_date] DATE  NOT NULL ,
    [to_date] DATE  NOT NULL 
)

CREATE TABLE [employees] (
    [emp_no] INT  NOT NULL ,
    [birth_date] DATE  NOT NULL ,
    [first_name] VARCHAR  NOT NULL ,
    [last_name] VARCHAR  NOT NULL ,
    [gender] VARCHAR  NOT NULL ,
    [hire_date] DATE  NOT NULL 
)

CREATE TABLE [salaries] (
    [emp_no] INT  NOT NULL ,
    [salary] INT  NOT NULL ,
    [from_date] DATE  NOT NULL ,
    [to_date] DATE  NOT NULL 
)

CREATE TABLE [title] (
    [emp_no] INT  NOT NULL ,
    [titles] VARCHAR  NOT NULL ,
    [from_date] DATE  NOT NULL ,
    [to_date] DATE  NOT NULL 
)

ALTER TABLE [dept_emp] WITH CHECK ADD CONSTRAINT [FK_dept_emp_dept_no] FOREIGN KEY([dept_no])
REFERENCES [departments] ([dept_no])

ALTER TABLE [dept_emp] CHECK CONSTRAINT [FK_dept_emp_dept_no]

ALTER TABLE [dept_manager] WITH CHECK ADD CONSTRAINT [FK_dept_manager_dept_no] FOREIGN KEY([dept_no])
REFERENCES [departments] ([dept_no])

ALTER TABLE [dept_manager] CHECK CONSTRAINT [FK_dept_manager_dept_no]

ALTER TABLE [dept_manager] WITH CHECK ADD CONSTRAINT [FK_dept_manager_emp_no] FOREIGN KEY([emp_no])
REFERENCES [employees] ([emp_no])

ALTER TABLE [dept_manager] CHECK CONSTRAINT [FK_dept_manager_emp_no]

ALTER TABLE [employees] WITH CHECK ADD CONSTRAINT [FK_employees_emp_no] FOREIGN KEY([emp_no])
REFERENCES [employees] ([emp_no])

ALTER TABLE [employees] CHECK CONSTRAINT [FK_employees_emp_no]

ALTER TABLE [salaries] WITH CHECK ADD CONSTRAINT [FK_salaries_emp_no] FOREIGN KEY([emp_no])
REFERENCES [employees] ([emp_no])

ALTER TABLE [salaries] CHECK CONSTRAINT [FK_salaries_emp_no]

ALTER TABLE [title] WITH CHECK ADD CONSTRAINT [FK_title_emp_no] FOREIGN KEY([emp_no])
REFERENCES [employees] ([emp_no])

ALTER TABLE [title] CHECK CONSTRAINT [FK_title_emp_no]

COMMIT TRANSACTION QUICKDBD
);

SELECT * FROM dept_emp


1. List the following details of each employee: employee number, last name, first name, gender, and salary

SELECT employees.emp_no, employees.last_name, employees.first_name, employees.gender, salaries.salary
FROM employees 
JOIN salaries ON
salaries.emp_no=employees.emp_no
ORDER BY emp_no;

SELECT * FROM salaries
2. List employees who were hired in 1986

SELECT first_name, last_name
FROM employees
WHERE hire_date BETWEEN '1986-01-01'
		AND '1986-12-31';


3. List the manager of each department with the following information: department number, department name, the manager's employee number, last name, first name, and start and end employment dates

SELECT departments.dept_no, departments.dept_name, employees.emp_no, employees.last_name, employees.first_name, dm.from_date, dm.to_date
FROM dept_manager AS dm
INNER JOIN departments ON
dm.dept_no=departments.dept_no
INNER JOIN employees ON
dm.emp_no=employees.emp_no;


4. List the department of each employee with the folowing information: employee number, last name, first name, and department name
--missing employees
SELECT employees.emp_no, employees.last_name, employees.first_name, departments.dept_name
FROM employees
INNER JOIN dept_emp ON
employees.emp_no=dept_emp.emp_no
INNER JOIN departments ON
dept_emp.dept_no=departments.dept_no;


5. List all employees whose first name is "Hercules" and last names begin with "B."

SELECT * FROM employees
WHERE first_name = 'Hercules'
AND last_name 
LIKE 'B%';


6. List all employees in the Sales department, including their employee number, last name, first name, and department name

SELECT employees.emp_no, employees.last_name, employees.first_name, departments.dept_name
FROM employees
INNER JOIN dept_emp ON
dept_emp.emp_no=employees.emp_no
INNER JOIN departments ON
departments.dept_no=dept_emp.dept_no
WHERE dept_name = 'Sales';


7. List all employees in the Sales and Development departments, including their employee number, last name, first name, and department name

SELECT employees.emp_no, employees.last_name, employees.first_name, departments.dept_name
FROM employees
INNER JOIN dept_emp ON
dept_emp.emp_no=employees.emp_no
INNER JOIN departments ON
departments.dept_no=dept_emp.dept_no
WHERE dept_name = 'Sales'
OR dept_name = 'Development';

8.In descending order, list the frequency count of employee last names, i.e., how many employees share each last name

SELECT last_name, COUNT(last_name) AS "last name count"
FROM employees
GROUP BY last_name
ORDER BY "last name count" DESC;
