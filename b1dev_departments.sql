DROP VIEW IF EXISTS b1dev_departments;
CREATE VIEW b1dev_departments AS
SELECT departments.dept_no,
       departments.dept_name,
       dept_manager.emp_no
FROM departments
INNER JOIN dept_manager ON departments.dept_no = dept_manager.dept_no
WHERE dept_manager.to_date = '9999-01-01';