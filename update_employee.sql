DROP PROCEDURE IF EXISTS updateEmployee;

DELIMITER //
CREATE PROCEDURE updateEmployee(IN _emp_no INT,
                                IN _birth_date DATE,
                                IN _first_name VARCHAR(14),
                                IN _last_name VARCHAR(16),
                                IN _gender ENUM('M', 'F'),
                                IN _hire_date DATE,
                                IN _salary INT,
                                IN _title VARCHAR(50),
                                IN _dept_no CHAR(4))
BEGIN
    DECLARE exist INT;
    DECLARE errorMessage VARCHAR(255);
    DECLARE oldSalary INT;
    DECLARE oldTitle VARCHAR(50);
    DECLARE oldDeptNo CHAR(4);

    SET exist = (SELECT COUNT(*) FROM employees WHERE employees.emp_no = _emp_no);
    IF exist = 0 THEN
        SET errorMessage = CONCAT('Employee with emp_no = ', _emp_no, ' does not exist.');
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = errorMessage;
    END IF;

    SET exist = (SELECT COUNT(*) FROM salaries WHERE salaries.emp_no = _emp_no AND salaries.to_date = '9999-01-01');
    IF exist = 0 THEN
        SET errorMessage = CONCAT('Employee with emp_no = ', _emp_no, ' is deleted.');
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = errorMessage;
    END IF;

    UPDATE employees
    SET birth_date = _birth_date,
        first_name = _first_name,
        last_name = _last_name,
        gender = _gender,
        hire_date = _hire_date
    WHERE emp_no = _emp_no;

    SELECT salary INTO oldSalary
    FROM salaries
    WHERE emp_no = _emp_no AND to_date = '9999-01-01';
    IF oldSalary != _salary THEN
        UPDATE salaries SET to_date = CURDATE()
        WHERE emp_no = _emp_no AND to_date = '9999-01-01';
        INSERT INTO salaries (emp_no, salary, from_date, to_date)
        VALUE (_emp_no, _salary, CURDATE(), '9999-01-01');
    END IF;

    SELECT title INTO oldTitle
    FROM titles
    WHERE emp_no = _emp_no AND to_date = '9999-01-01';
    IF oldTitle != _title THEN
        UPDATE titles SET to_date = CURDATE()
        WHERE emp_no = _emp_no AND to_date = '9999-01-01';
        INSERT INTO titles (emp_no, title, from_date, to_date)
        VALUE (_emp_no, _title, CURDATE(), '9999-01-01');
    END IF;

    SELECT dept_no INTO oldDeptNo
    FROM dept_emp
    WHERE emp_no = _emp_no AND to_date = '9999-01-01';
    IF oldDeptNo != _dept_no THEN
        UPDATE dept_emp SET to_date = CURDATE()
        WHERE emp_no = _emp_no AND to_date = '9999-01-01';
        INSERT INTO dept_emp (emp_no, dept_no, from_date, to_date)
        VALUE (_emp_no, _dept_no, CURDATE(), '9999-01-01');
    END IF;
END //

DELIMITER ;