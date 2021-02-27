use tinyu
go
select * from students

-- count of students in this table
select count(*) as count_of_students 
    from students

select 
    min(student_gpa) as lowest_gpa,
    max(student_gpa) as highest_gpa,
    avg(student_gpa) as mean_gpa
    from students

-- different ways to count things
select count(*) as count_of_students,
    count(student_major_id) as count_of_student_with_majors,
    count(distinct student_major_id) as count_of_different_student_majors
    from students

-- verification that there are 4 different majors
select distinct student_major_id from students

-- count of majors, but only among freshmen
select count(distinct student_major_id) as studnet_major_count_of_freshman from students  
    where student_year_name = 'Freshman'

-- group by clause
select student_year_name,  avg(student_gpa) as student_average_by_year
    from students
    group by student_year_name

-- count of students in major with avg gpa
select student_year_name,  
    count(*) as student_count,
    avg(student_gpa) as student_average_by_year,
    max(student_gpa) as student_max_by_year
from students
group by student_year_name


-- group by more than one column
select  student_year_name, major_name, 
    avg(student_gpa) as avg_gpa_by_year_and_major,
    count(*) as count_of_by_year_and_major
from students
    join majors on student_major_id = major_id
group by student_year_name, major_name
order by student_year_name, major_name 

-- avg gpa by major for only freshman
select student_year_name, major_name, 
    avg(student_gpa) as avg_gpa_by_major,
    count(*) as student_count_in_major
from students left join majors 
    on student_major_id = major_id
where student_year_name = 'Freshman'
group by major_name,student_year_name

--
-- avg gpa by major 
select major_name, 
    avg(student_gpa) as avg_gpa_by_major,
    count(*) as student_count_in_major
from students left join majors 
    on student_major_id = major_id
group by major_name
having avg(student_gpa) > 3