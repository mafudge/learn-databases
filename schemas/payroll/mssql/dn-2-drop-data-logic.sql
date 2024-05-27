use payroll

drop view if exists v_active_employees 

drop procedure if exists p_enable_employee_temporal_table
drop procedure if exists p_disable_employee_temporal_table
drop procedure if exists  p_add_time_entry
drop procedure if exists  p_issue_paycheck

drop procedure if exists p_employee_change_department
drop procedure if exists p_employee_terminate 
drop procedure if exists p_employee_give_raise
drop procedure if exists p_employee_upsert
drop procedure if exists p_hire_employee

drop procedure if exists p_seasonal_transfer
drop procedure if exists p_return_seasonal_transfer