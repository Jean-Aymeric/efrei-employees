DROP PROCEDURE IF EXISTS undeleteEmployee;

DELIMITER //
CREATE PROCEDURE undeleteEmployee(IN _emp_no INT)
BEGIN
    DECLARE maxToDate DATE;
    DECLARE errorMessage VARCHAR(255);
    DECLARE exist int;

    SET exist = (SELECT COUNT(*) FROM employees WHERE employees.emp_no = _emp_no);
    IF exist = 0 THEN
        SET errorMessage = CONCAT('Employee with emp_no = ', _emp_no, ' does not exist.');
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = errorMessage;
    END IF;

    SET exist = (SELECT COUNT(*) FROM salaries WHERE salaries.emp_no = _emp_no AND salaries.to_date = '9999-01-01');
    IF exist = 1 THEN
        SET errorMessage = CONCAT('Employee with emp_no = ', _emp_no, ' is not deleted.');
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = errorMessage;
    END IF;

    SET maxToDate = (SELECT MAX(to_date) FROM salaries WHERE salaries.emp_no = _emp_no);
    UPDATE salaries SET to_date = '9999-01-01'
    WHERE emp_no = _emp_no AND to_date = maxToDate;

    UPDATE titles SET to_date = '9999-01-01'
    WHERE emp_no = _emp_no AND to_date = maxToDate;

    UPDATE dept_emp SET to_date = '9999-01-01'
    WHERE emp_no = _emp_no AND to_date = maxToDate;

END //

DELIMITER ;