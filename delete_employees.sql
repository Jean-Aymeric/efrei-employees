DROP PROCEDURE IF EXISTS deleteEmployee;

DELIMITER //

CREATE PROCEDURE deleteEmployee(IN _emp_no INT)
BEGIN
    UPDATE salaries SET to_date = CURDATE()
    WHERE emp_no = _emp_no AND to_date = '9999-01-01';

    UPDATE titles SET to_date = CURDATE()
    WHERE emp_no = _emp_no AND to_date = '9999-01-01';

    UPDATE dept_emp SET to_date = CURDATE()
    WHERE emp_no = _emp_no AND to_date = '9999-01-01';
END //

DELIMITER ;