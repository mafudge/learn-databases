use payroll

exec p_disable_employee_temporal_table
execute p_hire_employee @event_date='2019-12-07 00:00:00', @employee_ssn='964-09-8650', @employee_firstname='Aurora',@employee_lastname='Borealis', @employee_hire_date='2019-12-07 00:00:00', @employee_jobtitle='Sales Associate', @employee_department='Toys', @employee_pay_rate=16.4147 
exec p_enable_employee_temporal_table
