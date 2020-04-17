use payroll

exec p_disable_employee_temporal_table
execute p_hire_employee @event_date='2020-01-05 00:00:00', @employee_ssn='887-72-7874', @employee_firstname='Wilma',@employee_lastname='Trainbelate', @employee_hire_date='2020-01-05 00:00:00', @employee_jobtitle='Sales Associate', @employee_department='Customer Service', @employee_pay_rate=16.4147 
exec p_enable_employee_temporal_table
