use tinyu
go 

-- simple equjoin
select  student_lastname + ' ' + student_firstname as student_name, student_year_name, 
    student_major_id, major_id, major_name
from students
    join majors on student_major_id = major_id

-- add in gpa and sort by year then gpa
-- multi-table join
select  student_firstname + ' ' + student_lastname as student_name, student_year_name, 
   student_gpa, major_name
from students
    join majors on student_major_id = major_id
    join year_names on student_year_name = year_name 
order by sort_order, student_gpa desc 

-- table aliasing 
select  s.student_firstname + ' ' + s.student_lastname as student_name, s.student_year_name, 
   s.student_gpa, m.major_name
from students as s
    join majors as m on s.student_major_id = m.major_id
    join year_names as y on s.student_year_name = y.year_name 
order by y.sort_order, s.student_gpa desc 

-- all majors even those without students
-- outer join
select m.*, s.student_firstname, s.student_lastname
    from majors as m left join students as s 
        on s.student_major_id = m.major_id
order by m.major_id 


-- only majors with no students
select m.*, s.student_firstname, s.student_lastname
from majors as m left join students as s 
    on s.student_major_id = m.major_id
where s.student_id is null 
order by m.major_id 

-- only students with no selected major
select s.*
from students as s left join majors as m 
    on s.student_major_id = m.major_id
where m.major_id is null 


-- full join example
select *
from students full join majors 
    on student_major_id = major_id



-- self-join example
use payroll
go
select emps.employee_id, emps.employee_firstname + ' '  + emps.employee_lastname as employee_name,
    emps.employee_supervisor_employee_id,
    sups.employee_id, sups.employee_firstname + ' '  + sups.employee_lastname as supervisor_employee_name
    from employees as emps
        left join employees as sups 
        on sups.employee_id = emps.employee_supervisor_employee_id


-- just because we can join it and there is no error does not imply its correct!
-- you need to know your schema (table metadata) and join tables properly!!!!
use tinyu
go
select * from students
SELECT * from majors 

select * 
from students 
    join majors on student_id = major_id