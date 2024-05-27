use payroll;

alter table employees SET (SYSTEM_VERSIONING=OFF); 
alter table employees DROP PERIOD FOR SYSTEM_TIME

GO

drop table if exists timecard_entries;
drop table if exists paychecks;
drop table if exists employees;
drop table if exists pay_periods;
drop table if exists jobtitle_lookup;
drop table if exists department_lookup;
drop table if exists payroll_type_lookup;
drop table if exists employees_history;
drop table if exists temp_seasonal_transfers

