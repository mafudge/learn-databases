use tinyu
go 
select * from students

-- understanding case
select case when 2=1 then 'Yes' else 'No' end as something
/*
 when gpa is >= 3.6 Chancellor's list
 when gpa is >= 3.2 Dean's list
 when gpa is < 2.0 Academic Warning List
*/
select student_firstname, student_lastname, student_gpa, 
    case 
        when student_gpa >= 3.6 then 'Chancellor''s List' 
        when student_gpa >= 3.2 then 'Dean''s List'
        when student_gpa < 2.0 then 'Academic Warning'
        else 'No List'
    end
    as student_list
from students

--- example masking a gpa
select student_firstname, student_lastname,
    case when student_gpa < 3 then 'X.XXX'
    else cast(student_gpa as varchar) end masked_gpa
from students 