use payroll

exec p_disable_employee_temporal_table
execute p_return_seasonal_transfer @event_date='2019-01-04 00:00:00', @employee_id=27
execute p_return_seasonal_transfer @event_date='2019-01-04 00:00:00', @employee_id=46
execute p_return_seasonal_transfer @event_date='2019-01-04 00:00:00', @employee_id=54
exec p_enable_employee_temporal_table
