select * from surveys
select * from customers 

-- add a survey not by a customer to make it interesting
delete from surveys where Email = 'mafudge@gmail.com'
insert into surveys (Email,Twitter_Username, Marital_Status, Household_Income, Own_Home, Education, Favorite_Department)
    values ('mafudge@gmail.com', 'mafudge', 'Prefer Not To Answer','Prefer Not To Answer', 'Prefer Not To Answer','Prefer Not To Answer', 'Electronics' )
-- SET UNION -- distinct set of rows entity integrity
select email from surveys
    UNION
select email from customers 

select email from surveys
    INTERSECT
select email from customers 

select email from customers 
    except 
select email from surveys
go
-- count of each of the different set outputs
with customer_surveys as (
    select email from surveys
        INTERSECT
    select email from customers 
),
customer_no_survey as (
    select email from customers 
        except 
    select email from surveys
),
survey_no_customer as (
    select email from surveys
        EXCEPT
    select email from customers 
)
select 'customers' as source,  count(*) as row_count  from customers
    UNION
select 'surveys' as source, count(*)  from surveys
    UNION
select 'customer_surveys' , count(*) from customer_surveys
    UNION
select 'customer_no_survey', count(*) from customer_no_survey
    UNION 
SELECT 'survey_no_customer', count(*) from survey_no_customer

-- UNION ALL concatenates two sets together duplicates are ok and thus Entity integrity

-- regular union 30 customers + 1 extra survey taker who was not a customer
select email from surveys --(26)
    union
select email from customers  --(30)

-- union all appends 26 surveys + 30 customers
select email from surveys --(26)
    union ALL
select email from customers --(30)
order by email 

