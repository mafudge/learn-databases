use tinyu;

create table students
(
    student_id int identity not null,
    student_firstname varchar(50) not null,
    student_lastname varchar(50) not null,
    student_year_name varchar(20) not null, 
    student_major_id int null,
    student_gpa decimal (4,3) null,
    student_notes text null,
    constraint ck_students_student_gpa_bt_0_and_4
        check (student_gpa between 0 and 4),
    constraint pk_students_student_id
        primary key (student_id)
);

create table year_names
(
    year_name varchar(20) not null,
    sort_order int,
    constraint pk_year_names_year_name
        primary key (year_name)
);

create table majors
(
    major_id int not null,
    major_code char(3) not null,
    major_name varchar(50) not null,
    constraint pk_majors_major_id
        primary key (major_id)
);

alter table students add 
        constraint fk_students_student_major_id  
            foreign key (student_major_id) references majors(major_id),
        constraint fk_students_student_year_name
            foreign key (student_year_name) references year_names(year_name);
        