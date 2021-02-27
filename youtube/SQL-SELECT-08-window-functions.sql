use tinyu
go
-- list of names, year, gpa, column with avg gpa for that year
-- first CTE list of names, year and gpa
with table1 as (
    select 
        student_firstname, student_lastname,  student_year_name, student_gpa
    from students
),
-- second CTE grouping of year_name and avg by year
table2 as (
select student_year_name, avg(student_gpa) as avg_student_gpa_by_year
    from students
    group by student_year_name
)
-- final query joins them together!
select t1.*, t2.avg_student_gpa_by_year
from table1 as t1 join table2 as t2 
    on t1.student_year_name = t2.student_year_name

-- aggregate window functions
select student_firstname, student_lastname,  student_year_name, student_gpa,
    avg(student_gpa)  over (partition by student_year_name) as avg_student_gpa_year
from students

-- avg by year and by major
select student_firstname, student_lastname,  student_year_name, student_major_id, student_gpa,
    avg(student_gpa)  over (partition by student_year_name) as avg_student_gpa_year,
    avg(student_gpa) over (partition by student_major_id ) as avg_student_gpa_by_major,
    avg(student_gpa) over () as overall_avg_gpa
from students

-- example with join
select student_firstname, student_lastname, major_name,
    count(*) over (partition by major_name ) as count_in_major
from students 
    join majors on student_major_id = major_id

-- Value lag(), lead(), first_value(), last_value()
select *,
    lag(student_gpa) over (partition by student_year_name order by student_gpa) as prev_student_gpa,
    lag(student_lastname) over (partition by student_year_name order by student_gpa) as prev_student_name
from students
order by student_id --student_year_name, student_gpa

-- guilty report student names by major and the name of the highest gpa in that major
select student_firstname, student_lastname, major_name, student_gpa,
    first_value(student_firstname) 
        over (partition by major_name order by student_gpa desc) as best_student_first_name,
    first_value(student_lastname) 
        over (partition by major_name order by student_gpa desc) as best_student_last_name
from students 
    join majors on student_major_id = major_id


-- ranking window functions ntile(), row_number(), rank()
select student_firstname, student_lastname, student_gpa,
    ntile(10) over ( order by student_gpa desc) as gpa_quartile
    from students


--row numbers
select 
    row_number() over (order by student_year_name) as row_num, * 
from students

-- ntile with a parition
select student_firstname, student_lastname, student_year_name, student_gpa,
    ntile(4) over ( partition by student_year_name order by student_gpa desc) as gpa_quartile_by_year
    from students

-- student report of GPA's by year name but show class rank e.g. highest gpa = 1, next highest =2 
select student_firstname, student_lastname, student_year_name, student_gpa,
    rank() over (PARTITION by student_year_name order by student_gpa desc)
    from students