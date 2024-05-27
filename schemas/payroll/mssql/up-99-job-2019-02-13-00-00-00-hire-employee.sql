use payroll

exec p_disable_employee_temporal_table
execute p_hire_employee @event_date='2019-02-13 00:00:00', @employee_ssn='909-67-3822', @employee_firstname='Rusty',@employee_lastname='Carz', @employee_hire_date='2019-02-13 00:00:00', @employee_jobtitle='Sales Associate', @employee_department='Hardware', @employee_pay_rate=16.4147 
exec p_enable_employee_temporal_table
