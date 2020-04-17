use payroll

exec p_disable_employee_temporal_table
execute p_hire_employee @event_date='2018-05-22 00:00:00', @employee_ssn='625-23-8336', @employee_firstname='Heath',@employee_lastname='Barr', @employee_hire_date='2018-05-22 00:00:00', @employee_jobtitle='Sales Associate', @employee_department='Electronics', @employee_pay_rate=15.7380 
exec p_enable_employee_temporal_table
