use payroll;
GO
-- turn off temporal tables
alter table employees SET (SYSTEM_VERSIONING=OFF); 
alter table employees DROP PERIOD FOR SYSTEM_TIME
GO

delete from paychecks;
delete from timecard_entries;
delete from pay_periods;
delete from employees;
delete from  jobtitle_lookup;;
delete from  department_lookup;


