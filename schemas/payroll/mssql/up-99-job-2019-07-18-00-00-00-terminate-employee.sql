use payroll

exec p_disable_employee_temporal_table
execute p_employee_terminate @event_date='2019-07-18 00:00:00', @employee_id=49, @termination_date='2019-07-18 00:00:00'
exec p_enable_employee_temporal_table
