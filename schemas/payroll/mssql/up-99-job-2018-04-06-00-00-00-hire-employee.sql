use payroll

exec p_disable_employee_temporal_table
execute p_hire_employee @event_date='2018-04-06 00:00:00', @employee_ssn='662-00-8712', @employee_firstname='Yolanda',@employee_lastname='Smyland', @employee_hire_date='2018-04-06 00:00:00', @employee_jobtitle='Sales Associate', @employee_department='Clothing', @employee_pay_rate=15.7380 
exec p_enable_employee_temporal_table
