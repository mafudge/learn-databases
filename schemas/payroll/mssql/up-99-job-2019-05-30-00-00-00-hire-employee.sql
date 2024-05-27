use payroll

exec p_disable_employee_temporal_table
execute p_hire_employee @event_date='2019-05-30 00:00:00', @employee_ssn='111-56-7793', @employee_firstname='Cook',@employee_lastname='Myefoud', @employee_hire_date='2019-05-30 00:00:00', @employee_jobtitle='Sales Associate', @employee_department='Housewares', @employee_pay_rate=16.4147 
exec p_enable_employee_temporal_table
