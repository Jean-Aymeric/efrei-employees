DROP PROCEDURE IF EXISTS createEmployee;

DELIMITER //
CREATE PROCEDURE createEmployee(IN _birth_date DATE,
                                IN _first_name VARCHAR(14),
                                IN _last_name VARCHAR(16),
                                IN _gender ENUM('M', 'F'),
                                IN _hire_date DATE,
                                IN _salary INT,
                                IN _title VARCHAR(50),
                                IN _dept_no CHAR(4))
BEGIN
    DECLARE nextEmpNo INT;

    SELECT (MAX(emp_no) + 1) INTO nextEmpNo FROM employees;
    INSERT INTO employees (emp_no, birth_date, first_name, last_name, gender, hire_date)
        VALUE (nextEmpNo, _birth_date, _first_name, _last_name, _gender, _hire_date);

    INSERT INTO salaries (emp_no, salary, from_date, to_date)
        VALUE (nextEmpNo, _salary, _hire_date, '9999-01-01');

    INSERT INTO titles (emp_no, title, from_date, to_date)
        VALUE (nextEmpNo, _title, _hire_date, '9999-01-01');

    INSERT INTO dept_emp (emp_no, dept_no, from_date, to_date)
        VALUE (nextEmpNo, _dept_no, _hire_date, '9999-01-01');
END //

DELIMITER ;