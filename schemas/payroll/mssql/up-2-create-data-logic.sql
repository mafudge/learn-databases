use payroll

GO
create view v_active_employees AS
    select employee_id, employee_ssn, employee_firstname, employee_lastname, employee_hire_date, employee_termination_date,
        employee_jobtitle, employee_department, employee_pay_rate, employee_supervisor_employee_id, payroll_type
    from employees e 
        join jobtitle_lookup j on e.employee_jobtitle = j.jobtitle
    where employee_termination_date is null 

GO

create procedure p_disable_employee_temporal_table
as begin
    alter table employees SET (SYSTEM_VERSIONING=OFF); 
    alter table employees DROP PERIOD FOR SYSTEM_TIME
end

GO

create procedure p_enable_employee_temporal_table
as begin
    alter table employees add PERIOD FOR SYSTEM_TIME (valid_from, valid_to);
    alter table employees SET (SYSTEM_VERSIONING=ON (HISTORY_TABLE=dbo.employees_history));
end

GO

exec p_disable_employee_temporal_table

GO

create procedure p_employee_upsert (
    @event_date datetime2,
    @employee_id int,
    @employee_ssn char(11),
    @employee_firstname varchar(100),
    @employee_lastname varchar(100),
    @employee_hire_date datetime,
    @employee_termination_date datetime,
    @employee_jobtitle varchar(100),
    @employee_department varchar(100),
    @employee_pay_rate money,
    @employee_supervisor_employee_id int
)as begin 

    -- is not it there?
    if not exists(select employee_id from employees where employee_id=@employee_id) begin

        -- add it!
        insert into employees 
            (employee_id, employee_ssn, employee_firstname, employee_lastname, employee_hire_date, employee_termination_date, 
            employee_jobtitle, employee_department, employee_pay_rate, employee_supervisor_employee_id, valid_from, valid_to)
        values
            (@employee_id, @employee_ssn, @employee_firstname, @employee_lastname, @employee_hire_date, @employee_termination_date,
            @employee_jobtitle, @employee_department, @employee_pay_rate, @employee_supervisor_employee_id, @event_date, '9999-12-31 23:59:59.9999999')
    end
    else begin 

        -- did any of the attributes change?
        if not exists(select employee_id from employees where employee_id=@employee_id and employee_ssn=@employee_ssn and employee_firstname = @employee_firstname
                and employee_lastname=@employee_lastname and employee_hire_date=@employee_hire_date and  
                ISNULL(employee_termination_date,0)=ISNULL(@employee_termination_date,0)
                and employee_jobtitle=@employee_jobtitle and employee_department=@employee_department and employee_pay_rate=@employee_pay_rate
                and ISNULL(employee_supervisor_employee_id,0)=ISNULL(@employee_supervisor_employee_id,0) ) begin

            -- add current version to history table with @event_date as valid_to
            insert into employees_history 
                (employee_id, employee_ssn, employee_firstname, employee_lastname, employee_hire_date, employee_termination_date, 
                employee_jobtitle, employee_department, employee_pay_rate, employee_supervisor_employee_id, valid_from, valid_to)
            select employee_id, employee_ssn, employee_firstname, employee_lastname, employee_hire_date, employee_termination_date, 
                employee_jobtitle, employee_department, employee_pay_rate, employee_supervisor_employee_id, valid_from, @event_date 
                from employees where employee_id = @employee_id

            update employees set 
                employee_id=@employee_id,
                employee_ssn=@employee_ssn,
                employee_firstname=@employee_firstname,
                employee_lastname=@employee_lastname,
                employee_hire_date=@employee_hire_date ,
                employee_termination_date=@employee_termination_date,
                employee_jobtitle=@employee_jobtitle ,
                employee_department=@employee_department ,
                employee_pay_rate=@employee_pay_rate ,
                employee_supervisor_employee_id=@employee_supervisor_employee_id,
                valid_from = @event_date
                where employee_id=@employee_id;
        end --if
    end -- else
end --procedure

GO 
exec p_enable_employee_temporal_table;

GO 
create procedure p_employee_give_raise ( 
    @event_date datetime2,
    @employee_id int,
    @percent_increase decimal (6,5)
) as begin 
    declare @employee_ssn char(11)
    declare @employee_firstname varchar(100)
    declare @employee_lastname varchar(100)
    declare @employee_hire_date datetime
    declare @employee_termination_date datetime
    declare @employee_jobtitle varchar(100)
    declare @employee_department varchar(100)
    declare @employee_pay_rate money
    declare @employee_supervisor_employee_id int
    -- fill in existing values
    select @employee_ssn=employee_ssn, @employee_firstname=employee_firstname, @employee_lastname=employee_lastname, @employee_hire_date=employee_hire_date,
        @employee_termination_date=employee_termination_date, @employee_jobtitle=employee_jobtitle, @employee_department=employee_department, 
        @employee_pay_rate=employee_pay_rate, @employee_supervisor_employee_id=employee_supervisor_employee_id
        from employees where employee_id = @employee_id

    declare @new_employee_pay_rate money = (1 + @percent_increase) * @employee_pay_rate

    execute p_employee_upsert
        @event_date = @event_date, @employee_id=@employee_id, @employee_ssn=@employee_ssn, @employee_firstname=@employee_firstname, 
        @employee_lastname=@employee_lastname, @employee_hire_date=@employee_hire_date, @employee_termination_date=@employee_termination_date, @employee_jobtitle=@employee_jobtitle, 
        @employee_department=@employee_department, @employee_pay_rate=@new_employee_pay_rate, @employee_supervisor_employee_id=@employee_supervisor_employee_id
end 

GO
create procedure p_employee_terminate ( 
    @event_date datetime2,
    @employee_id int,
    @termination_date datetime
) as begin 
    declare @employee_ssn char(11)
    declare @employee_firstname varchar(100)
    declare @employee_lastname varchar(100)
    declare @employee_hire_date datetime
    declare @employee_termination_date datetime
    declare @employee_jobtitle varchar(100)
    declare @employee_department varchar(100)
    declare @employee_pay_rate money
    declare @employee_supervisor_employee_id int
    -- fill in existing values
    select @employee_ssn=employee_ssn, @employee_firstname=employee_firstname, @employee_lastname=employee_lastname, @employee_hire_date=employee_hire_date,
        @employee_termination_date=employee_termination_date, @employee_jobtitle=employee_jobtitle, @employee_department=employee_department, 
        @employee_pay_rate=employee_pay_rate, @employee_supervisor_employee_id=employee_supervisor_employee_id
        from employees where employee_id = @employee_id

    execute p_employee_upsert
        @event_date = @event_date, @employee_id=@employee_id, @employee_ssn=@employee_ssn, @employee_firstname=@employee_firstname, 
        @employee_lastname=@employee_lastname, @employee_hire_date=@employee_hire_date, @employee_termination_date=@termination_date, @employee_jobtitle=@employee_jobtitle, 
        @employee_department=@employee_department, @employee_pay_rate=@employee_pay_rate, @employee_supervisor_employee_id=@employee_supervisor_employee_id
end 

GO

create procedure p_hire_employee(
    @event_date datetime2,
    @employee_ssn char(11),
    @employee_firstname varchar(100),
    @employee_lastname varchar(100),
    @employee_hire_date datetime,
    @employee_jobtitle varchar(100),
    @employee_department varchar(100),
    @employee_pay_rate money
) as begin
    declare @employee_id int
    declare @employee_supervisor_employee_id int
    declare @employee_termination_date datetime = NULL
    
    -- get new supervisor_id
    select @employee_supervisor_employee_id=employee_id from employees where employee_jobtitle='Department Manager' and employee_department=@employee_department
    select @employee_id = max(employee_id) + 1 from employees

    -- upsert the data!
    execute p_employee_upsert
        @event_date = @event_date, @employee_id=@employee_id, @employee_ssn=@employee_ssn, @employee_firstname=@employee_firstname, @employee_lastname=@employee_lastname, 
        @employee_hire_date=@employee_hire_date, @employee_termination_date=@employee_termination_date, @employee_jobtitle=@employee_jobtitle, 
        @employee_department=@employee_department, @employee_pay_rate=@employee_pay_rate, @employee_supervisor_employee_id=@employee_supervisor_employee_id

end

GO
create procedure p_employee_change_department( 
    @event_date datetime2,
    @employee_id int,
    @new_employee_department varchar(100)
) as begin 
    declare @employee_ssn char(11)
    declare @employee_firstname varchar(100)
    declare @employee_lastname varchar(100)
    declare @employee_hire_date datetime
    declare @employee_termination_date datetime
    declare @employee_jobtitle varchar(100)
    declare @employee_department varchar(100)
    declare @employee_pay_rate money
    declare @employee_supervisor_employee_id int
    -- fill in existing values
    select @employee_ssn=employee_ssn, @employee_firstname=employee_firstname, @employee_lastname=employee_lastname, @employee_hire_date=employee_hire_date,
        @employee_termination_date=employee_termination_date, @employee_jobtitle=employee_jobtitle, @employee_department=employee_department, 
        @employee_pay_rate=employee_pay_rate, @employee_supervisor_employee_id=employee_supervisor_employee_id
        from employees where employee_id = @employee_id

    -- get new supervisor_id
    select @employee_supervisor_employee_id=employee_id from employees where employee_jobtitle='Department Manager' and employee_department=@new_employee_department

    -- upsert the data!
    execute p_employee_upsert
        @event_date = @event_date, @employee_id=@employee_id, @employee_ssn=@employee_ssn, @employee_firstname=@employee_firstname, @employee_lastname=@employee_lastname, 
        @employee_hire_date=@employee_hire_date, @employee_termination_date=@employee_termination_date, @employee_jobtitle=@employee_jobtitle, 
        @employee_department=@new_employee_department, @employee_pay_rate=@employee_pay_rate, @employee_supervisor_employee_id=@employee_supervisor_employee_id
end
GO
create procedure p_seasonal_transfer (
    @event_date datetime2,
    @employee_id int,
    @from_department varchar(100),
    @to_department varchar(100)
)
as begin
    begin try    
        begin transaction 
            insert into temp_seasonal_transfers (employee_id, home_department, seasonal_department) 
                values (@employee_id, @from_department, @to_department)
            exec p_employee_change_department @event_date=@event_date,@employee_id=@employee_id, @new_employee_department=@to_department
        commit transaction 
    end try
    begin catch
        rollback
    end catch
end

GO

create procedure p_return_seasonal_transfer (
    @event_date datetime2,
    @employee_id int
)
as begin
    begin try    
        begin transaction 
            declare @to_department varchar(100) = NULL
            select @to_department = home_department from temp_seasonal_transfers where employee_id=@employee_id
            if @to_department = NULL RAISERROR ('employee_id not found',1,1)
            exec p_employee_change_department @event_date=@event_date,@employee_id=@employee_id, @new_employee_department=@to_department
            delete from  temp_seasonal_transfers where employee_id=@employee_id
        commit transaction 
    end try
    begin catch
        rollback
    end catch;
end


GO

create procedure p_issue_paycheck (
    @employee_id int, 
    @payperiod_id int
) as begin
    declare @payrate money;
    declare @totalhours int = 40
    declare @grosspay money = 0
    declare @payrolltype varchar(10);
    select @payrolltype= payroll_type, @payrate=employee_pay_rate 
        from employees join jobtitle_lookup on employee_jobtitle=jobtitle where employee_id=@employee_id

    if @payrolltype = 'Hourly' begin
        select @totalhours = isnull(sum(entry_hours_worked),0)
            from timecard_entries 
                where entry_employee_id=@employee_id and entry_payperiod_id = @payperiod_id
        set @grosspay =  @totalhours * @payrate
    end
    else begin
        set @grosspay = @payrate
    end
    insert into paychecks 
        (paycheck_employee_id, paycheck_payperiod_id, paycheck_total_hours_worked, paycheck_employee_payroll_type, paycheck_employee_pay_rate,  paycheck_gross_pay)
    values ( @employee_id, @payperiod_id, @totalhours, @payrolltype, @payrate, @grosspay)
end

GO

create procedure p_add_time_entry ( 
    @employee_id int, 
    @entry_date datetime, 
    @hours_worked decimal(6,1)
) as begin
    declare @payrolltype varchar(10);
    declare @payperiod_id int 
    select @payrolltype= payroll_type 
        from employees join jobtitle_lookup on employee_jobtitle=jobtitle where employee_id=@employee_id
    select top 1  @payperiod_id= payperiod_id from pay_periods where @entry_date < payperiod_date order by payperiod_id asc 

    if @payrolltype = 'Hourly' begin
        insert into timecard_entries ( entry_employee_id, entry_payperiod_id, entry_date, entry_hours_worked)
            values(@employee_id, @payperiod_id, @entry_date, @hours_worked)
    end
end


