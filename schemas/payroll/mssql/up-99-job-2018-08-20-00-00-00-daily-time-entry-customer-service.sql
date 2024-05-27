use payroll


execute p_add_time_entry @employee_id=57, @entry_date='2018-08-20 00:00:00', @hours_worked=6
execute p_add_time_entry @employee_id=45, @entry_date='2018-08-20 00:00:00', @hours_worked=5
execute p_add_time_entry @employee_id=54, @entry_date='2018-08-20 00:00:00', @hours_worked=6

