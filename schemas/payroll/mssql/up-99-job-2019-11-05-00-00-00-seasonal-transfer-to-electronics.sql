use payroll

exec p_disable_employee_temporal_table
execute p_seasonal_transfer @event_date='2019-11-05 00:00:00', @employee_id=54, @from_department='Customer Service',  @to_department='Electronics'
exec p_enable_employee_temporal_table
