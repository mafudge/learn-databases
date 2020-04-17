use payroll;
/*
+-----------+         +---------+
| Employees |--------<|Paychecks|
+-----------+         +---------+
     |                    \|/
     |                     | 
    /|\                    |
+----------------+     +-----------+
|Timecard_Entries|>----|Pay_Periods|
+----------------+     +-----------+

*/ 


create table jobtitle_lookup
(
    jobtitle varchar(100) not null,
    payroll_type varchar(10) not null,
    constraint pk_jobtitle_lookup_jobtitle primary key (jobtitle)
);

create table department_lookup
(
    department varchar(100) not null,
    constraint pk_department_lookup_department primary key(department)
);

create table employees
(
    employee_id int not null,
    employee_ssn char(11) not null,
    employee_firstname varchar(100) not null,
    employee_lastname varchar(100) not null,
    employee_hire_date datetime not null,
    employee_termination_date datetime null,
    employee_jobtitle varchar(100) not null,
    employee_department varchar(100) not null,
    employee_pay_rate money default(0) not null,
    employee_supervisor_employee_id int null,
    constraint u_employees_employee_ssn 
        unique (employee_ssn),
    constraint ck_employees_employee_pay_rate_ge_0 
        check (employee_pay_rate>=0),
    constraint pk_employees_employee_id 
        primary key (employee_id)
);

-- hourly employees get paid each friday.
-- salaried employees get paid the last friday of every month.
create table pay_periods
(
    payperiod_id int not null,
    payperiod_date datetime not null,
    constraint pk_pay_periods_payperiod_id primary key(payperiod_id)
);

-- stored procedure to add payperiods

create table timecard_entries
(
    entry_id int identity not null,
    entry_employee_id int not null,
    entry_payperiod_id int not null,
    entry_date datetime not null,
    entry_hours_worked decimal (6,1) not null,
    constraint ck_timecard_entries_valid_entry_date check 
        (cast(format(entry_date,'yyyyMMdd') as int) between entry_payperiod_id-7 and entry_payperiod_id),
    constraint pk_timecard_entries_entry_id primary key (entry_id)
);

create table paychecks
(
    paycheck_id int identity not null,
    paycheck_employee_id int not null,
    paycheck_payperiod_id int not null,
    paycheck_total_hours_worked decimal (6,1) not null,
    paycheck_employee_payroll_type  varchar(10) not null,
    paycheck_employee_pay_rate money not null,
    paycheck_gross_pay money not null,
    constraint u_paychecks_employee_id_and_payperiod_id unique (paycheck_payperiod_id, paycheck_employee_id),
    constraint pk_paychecks_paycheck_id primary key (paycheck_id)
);

GO

create table temp_seasonal_transfers
(
    employee_id int not null,
    home_department varchar(100) not null,
    seasonal_department varchar(100) not null,
    constraint pk_temp_seasons_transfers primary key (employee_id)
)

GO

alter table employees add
    constraint fk_employees_employee_jobtitle foreign key (employee_jobtitle)
        references jobtitle_lookup (jobtitle),
    constraint fk_employees_employee_department foreign key (employee_department)
        references department_lookup(department), 
    constraint fk_employees_employee_supervisor_employee_id foreign key (employee_supervisor_employee_id)
        references employees(employee_id);

alter table timecard_entries add
    constraint fk_timecard_entries_entry_employee_id foreign key (entry_employee_id)
        references employees(employee_id),
    constraint fk_timecard_entries_entry_payperiod_id foreign key (entry_payperiod_id)
        references pay_periods (payperiod_id);

alter table paychecks add   
    constraint fk_paychecks_paycheck_employee_id foreign key (paycheck_employee_id)
        references employees(employee_id),
    constraint fk_paychecks_paycheck_payperiod_id foreign key (paycheck_payperiod_id)
        references pay_periods (payperiod_id)

GO

-- temporal table
alter table employees add 
    valid_from DATETIME2 GENERATED ALWAYS AS ROW START NOT NULL,
    valid_to DATETIME2 GENERATED ALWAYS AS ROW END NOT NULL,
    PERIOD FOR SYSTEM_TIME (valid_from, valid_to);

alter table employees SET (SYSTEM_VERSIONING=ON (HISTORY_TABLE=dbo.employees_history));

