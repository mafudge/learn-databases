use tinyu
go
-- DDL (Data Definition)
-- CREATE / ALTER / DROP
-- creates the view
create view v_ugrad_students as
    select * from students
    where student_year_name != 'Graduate'
go 
-- query the view with INFO SCHEMA
select * from INFORMATION_SCHEMA.VIEWS

-- views are like tables
select student_year_name, student_firstname, student_lastname, major_name, student_gpa
from v_ugrad_students
    join majors on student_major_id = major_id
    join year_names on year_name = student_year_name
order by sort_order

/*
undergraduate academic concerns report
- year, names, major, gpa 
- undergrads only
- sort by year
- ranking in quartiles (window function)
- bottom 2 quartiles
*/
with ugrad_quartile as (
    select sort_order,student_year_name, student_firstname, 
        student_lastname, major_name, student_gpa,
        ntile(4) over 
            (partition by student_year_name order by student_gpa desc) as gpa_quartile_by_year
    from v_ugrad_students
        join majors on student_major_id = major_id
        join year_names on year_name = student_year_name
)
select student_year_name, student_firstname, student_lastname, 
    major_name, student_gpa, gpa_quartile_by_year
from ugrad_quartile where gpa_quartile_by_year in (3,4)
    order by sort_order

go
-- create it as a view
drop view v_ugrad_academic_concern_report
go 
create view v_ugrad_academic_concern_report AS
    with ugrad_quartile as (
        select sort_order,student_year_name, student_firstname, 
            student_lastname, major_name, student_gpa,
            ntile(4) over 
                (partition by student_year_name order by student_gpa desc) as gpa_quartile_by_year
        from v_ugrad_students
            join majors on student_major_id = major_id
            join year_names on year_name = student_year_name
    )
    select sort_order, student_year_name, student_firstname, student_lastname, 
        major_name, student_gpa, gpa_quartile_by_year
    from ugrad_quartile where gpa_quartile_by_year in (3,4)
GO


select * from v_ugrad_academic_concern_report
go 
update v_ugrad_academic_concern_report set student_gpa = 1.8
    where student_firstname = 'Lilly' AND
    student_lastname = 'Padz'
