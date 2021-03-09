use demo
GO
-- motivation
select count(*) as survey_count, Education, Marital_Status
    from surveys 
    group by Education, Marital_Status
go 
-- let's put marital status in columns
with pivot_source as (
    select Education, Marital_Status from surveys 
)
select * from pivot_source PIVOT (
    count(Marital_Status) for Marital_Status in ("Married", "Single", "Prefer not to Answer")
) as pivot_table 
GO
-- avg household income by home ownership and marital status
with pivot_source as (
    select Own_Home, Marital_Status, cast(Household_Income as decimal) as Income 
    from surveys
    where Household_Income != 'Prefer not to Answer'
    and Own_Home != 'Prefer not to Answer'
)
select * from pivot_source pivot (
    avg(Income) for Marital_Status in ("Single", "Married", "Prefer not to Answer")
) as pivot_table

go
drop view if exists v_home_avg_by_marital_status
GO
create view v_home_avg_by_marital_status  AS
with pivot_source as (
    select Own_Home, Marital_Status, cast(Household_Income as decimal) as Income 
    from surveys
    where Household_Income != 'Prefer not to Answer'
    and Own_Home != 'Prefer not to Answer'
)
select * from pivot_source pivot (
    avg(Income) for Marital_Status in ("Single", "Married", "Prefer not to Answer")
) as pivot_table
go

-- unpivots columns into rows
select Own_Home, avg_income, marital_status 
    from v_home_avg_by_marital_status UNPIVOT (
    avg_income for marital_status in ("Single", "Married", "Prefer not to Answer")
) as unpivot_table

-- handle data that is not queryable
select * from contacts
    where home_phone like '315-%'
    or mobile_phone like '315-%'

-- fix this with unpivot !!!!
with source as (
    select * from contacts unpivot (
        phone_number for phone_type in ("home_phone", "mobile_phone", "work_phone","other_phone")
    ) as unpivot_table
)
select * from source where phone_number like '315-%'
