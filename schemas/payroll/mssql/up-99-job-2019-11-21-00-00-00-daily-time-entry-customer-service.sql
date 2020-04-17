use payroll


execute p_add_time_entry @employee_id=45, @entry_date='2019-11-21 00:00:00', @hours_worked=6
execute p_add_time_entry @employee_id=14, @entry_date='2019-11-21 00:00:00', @hours_worked=5
execute p_add_time_entry @employee_id=25, @entry_date='2019-11-21 00:00:00', @hours_worked=5

