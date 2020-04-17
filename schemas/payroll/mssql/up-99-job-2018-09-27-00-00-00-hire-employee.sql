use payroll

exec p_disable_employee_temporal_table
execute p_hire_employee @event_date='2018-09-27 00:00:00', @employee_ssn='319-99-8418', @employee_firstname='Dean',@employee_lastname='Ofstudents', @employee_hire_date='2018-09-27 00:00:00', @employee_jobtitle='Sales Associate', @employee_department='Sporting Goods', @employee_pay_rate=15.7380 
exec p_enable_employee_temporal_table
