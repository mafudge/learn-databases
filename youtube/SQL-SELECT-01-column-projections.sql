use tinyu
go 
select * from students

-- selecting individual columns
select student_firstname, student_lastname,  student_gpa 
    from students 

-- column aliases
select student_firstname as FirstName, student_lastname as [Last Name], student_gpa as GPA
    from students

-- derived columns
select student_firstname + ' ' + student_lastname as "student_fullname",
    student_gpa,
    4.0 - student_gpa as student_points_to_40
    from students

-- columns and aliases and derived columns
select *, 4.0 as max_gpa, 4.0 - student_gpa as points_to_4
from students

-- type conversion with cast()
select cast( 10 as varchar)  -- not a good example!
select cast( 10.5 as int) as int_value

-- real world example
select 
    student_firstname + ' ' + student_lastname + ' has a ' + cast(student_gpa as varchar) + ' GPA' as message
from students