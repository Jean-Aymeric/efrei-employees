DROP PROCEDURE IF EXISTS deleteEmployee;

DELIMITER //

CREATE PROCEDURE deleteEmployee(IN _emp_no INT)
BEGIN
    DECLARE exist INT;
    DECLARE errorMessage VARCHAR(255);

    SET exist = (SELECT COUNT(*) FROM employees WHERE employees.emp_no = _emp_no);
    IF exist = 0 THEN
        SET errorMessage = CONCAT('Employee with emp_no = ', _emp_no, ' does not exist.');
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = errorMessage;
    END IF;

    SET exist = (SELECT COUNT(*) FROM salaries WHERE salaries.emp_no = _emp_no AND salaries.to_date = '9999-01-01');
    IF exist = 0 THEN
        SET errorMessage = CONCAT('Employee with emp_no = ', _emp_no, ' is already deleted.');
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = errorMessage;
    END IF;

    UPDATE salaries SET to_date = CURDATE()
    WHERE emp_no = _emp_no AND to_date = '9999-01-01';

    UPDATE titles SET to_date = CURDATE()
    WHERE emp_no = _emp_no AND to_date = '9999-01-01';

    UPDATE dept_emp SET to_date = CURDATE()
    WHERE emp_no = _emp_no AND to_date = '9999-01-01';
END //

DELIMITER ;