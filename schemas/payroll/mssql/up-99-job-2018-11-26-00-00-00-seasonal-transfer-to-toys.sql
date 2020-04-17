use payroll

exec p_disable_employee_temporal_table
execute p_seasonal_transfer @event_date='2018-11-26 00:00:00', @employee_id=27, @from_department='Customer Service',  @to_department='Toys'
exec p_enable_employee_temporal_table
