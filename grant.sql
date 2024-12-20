DROP USER IF EXISTS b1dev@'%';
CREATE USER b1dev@'%' IDENTIFIED BY 'b1dev';
GRANT SELECT ON employees.b1dev_employees TO b1dev@'%';
GRANT SELECT ON employees.b1dev_departments TO b1dev@'%';
GRANT EXECUTE ON PROCEDURE employees.deleteEmployee TO b1dev@'%';
GRANT EXECUTE ON PROCEDURE employees.undeleteEmployee TO b1dev@'%';
GRANT EXECUTE ON PROCEDURE employees.createEmployee TO b1dev@'%';
GRANT EXECUTE ON PROCEDURE employees.updateEmployee TO b1dev@'%';