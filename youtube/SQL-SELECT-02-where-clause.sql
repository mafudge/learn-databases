use tinyu
go 
select * from students
    where student_year_name = 'Freshman'  --selection

-- names of all freshman
select student_firstname, student_lastname, student_year_name
    from students
    where student_year_name ='Freshman'

--- students who are not freshmen
select * from students where student_year_name <> 'Freshman'

-- students with gpa below 2.0
select * from students where student_gpa < 2.0


-- students who are freshman and have a gpa > 3
-- and or not
select * 
from students 
where student_gpa > 3 
    and student_year_name = 'Freshman'

select * from students
where student_gpa > 3 
    or student_year_name = 'Freshman'

-- students with gpa between 2 and 3
select * from students  
    where student_gpa between 2 and 3 

-- find one student
select * 
from students 
where student_id = 17

select * from students
where student_id = 9 or student_id = 10 or student_id = 17

-- set operator "in"
select * from students
where student_id in (9,10,17,99,100)

-- null check
-- students without a major
select * from students 
    where student_major_id is null

-- students with a major
select * from students 
    where student_major_id is not null

select * 
from students
where len(cast(student_notes as varchar)) > 0 

-- like  pattern matching
-- students with first name begings with L
select * from students where student_firstname like 'l%'

-- students with second letter an "i" Mike for example
select * from students 
where student_firstname like '_i%'

select * from students 
where student_firstname like '_i%' 
    or student_firstname  like '_a%'


-- where before project error!!!!
select student_firstname, student_lastname, student_gpa, 4.0-student_gpa as diff_to_4 -- # 3
from students -- #1
where diff_to_4 between 0 and 1.5  -- # 2

-- correct
select student_firstname, student_lastname, student_gpa, 4.0-student_gpa as diff_to_4 
from students
where 4.0-student_gpa between 0 and 1.5  
