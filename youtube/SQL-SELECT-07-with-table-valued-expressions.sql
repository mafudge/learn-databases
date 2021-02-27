use tinyu
go
select student_year_name, avg(student_gpa) as avg_gpa_by_year
from students 
group by student_year_name
having avg(student_gpa) < 3


with student_year_gpa as (
    select student_year_name, avg(student_gpa) as avg_gpa_by_year
    from students
    group by student_year_name
)
select * 
from student_year_gpa
where avg_gpa_by_year < 3

-- list of students name, gpa where the student_gpa > average overall gpa
select student_firstname, student_lastname, student_gpa, 
    (select avg(student_gpa) from students) as overall_avg_gpa
from students
where student_gpa > (select avg(student_gpa) from students)

with avg_gpa as (
    select avg(student_gpa) as overall_avg_gpa
    from students
)
select student_firstname, student_lastname, student_gpa, 
    (select * from avg_gpa)
    from students 
    where student_gpa > (select * from avg_gpa)


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