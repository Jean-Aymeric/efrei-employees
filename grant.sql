DROP USER IF EXISTS b1dev@'%';
CREATE USER b1dev@'%' IDENTIFIED BY 'b1dev';
GRANT SELECT ON employees.b1dev_employees TO b1dev@'%';
GRANT SELECT ON employees.b1dev_departments TO b1dev@'%';