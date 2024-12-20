DROP VIEW IF EXISTS b1dev_employees;

CREATE VIEW b1dev_employees AS
SELECT employees.emp_no,
       employees.birth_date,
       employees.first_name,
       employees.last_name,
       employees.gender,
       employees.hire_date,
       salaries.salary,
       titles.title,
       dept_emp.dept_no
FROM employees
INNER JOIN salaries ON employees.emp_no = salaries.emp_no
INNER JOIN titles ON employees.emp_no = titles.emp_no
INNER JOIN dept_emp ON employees.emp_no = dept_emp.emp_no
WHERE salaries.to_date = '9999-01-01'
AND titles.to_date = '9999-01-01'
AND dept_emp.to_date = '9999-01-01';