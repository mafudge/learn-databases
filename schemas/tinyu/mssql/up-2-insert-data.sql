use tinyu;


insert into majors (major_id, major_code, major_name)
    values (1, 'IMT', 'Information Management and Technology');
insert into majors (major_id, major_code, major_name)
    values (2, 'ADS', 'Applied Data Science');
insert into majors (major_id, major_code, major_name)
    values (3, 'ACC', 'Accounting');
insert into majors (major_id, major_code, major_name)
    values (4, 'CSC', 'Computer Sciences');
insert into majors (major_id, major_code, major_name)
    values (5, 'BSK', 'Basket Weaving');

GO

insert into year_names (year_name, sort_order) values ('Freshman',1);
insert into year_names (year_name, sort_order) values ('Sophomore',2);
insert into year_names (year_name, sort_order) values ('Junior',3);
insert into year_names (year_name, sort_order) values ('Senior',4);
insert into year_names (year_name, sort_order) values ('Graduate',5);

GO


insert into students (student_firstname, student_lastname, student_year_name, student_major_id, student_gpa, student_notes) values ('Robin','Banks','Freshman',3,4.000,'');
insert into students (student_firstname, student_lastname, student_year_name, student_major_id, student_gpa, student_notes) values ('Victor','Edance','Freshman',2,2.404,'');
insert into students (student_firstname, student_lastname, student_year_name, student_major_id, student_gpa, student_notes) values ('Erin','Yortires','Junior',1,2.401,'');
insert into students (student_firstname, student_lastname, student_year_name, student_major_id, student_gpa, student_notes) values ('Aurora','Borealis','Senior',1,3.024,'');
insert into students (student_firstname, student_lastname, student_year_name, student_major_id, student_gpa, student_notes) values ('Tuck','Androll','Senior',2,3.333,'');
insert into students (student_firstname, student_lastname, student_year_name, student_major_id, student_gpa, student_notes) values ('Eura','Quittin','Senior',2,3.372,'');
insert into students (student_firstname, student_lastname, student_year_name, student_major_id, student_gpa, student_notes) values ('Willie','Survive','Sophomore',2,2.608,'');
insert into students (student_firstname, student_lastname, student_year_name, student_major_id, student_gpa, student_notes) values ('Lola','Dabridgeda','Freshman',1,2.732,'');
insert into students (student_firstname, student_lastname, student_year_name, student_major_id, student_gpa, student_notes) values ('Doris','Closed','Senior',3,3.173,'');
insert into students (student_firstname, student_lastname, student_year_name, student_major_id, student_gpa, student_notes) values ('Phil','McCup','Freshman',2,2.705,'');
insert into students (student_firstname, student_lastname, student_year_name, student_major_id, student_gpa, student_notes) values ('Jack','Itupp','Sophomore',3,3.386,'');
insert into students (student_firstname, student_lastname, student_year_name, student_major_id, student_gpa, student_notes) values ('Val','Idation','Senior',1,3.5,'');
insert into students (student_firstname, student_lastname, student_year_name, student_major_id, student_gpa, student_notes) values ('Ida','Knowe','Junior',4,2.724,'');
insert into students (student_firstname, student_lastname, student_year_name, student_major_id, student_gpa, student_notes) values ('Lee','Hvmeehom','Junior',2,1.916,'meet with student');
insert into students (student_firstname, student_lastname, student_year_name, student_major_id, student_gpa, student_notes) values ('Ginger','Beer','Graduate',2,4.0,'');
insert into students (student_firstname, student_lastname, student_year_name, student_major_id, student_gpa, student_notes) values ('Buck','Naked','Freshman',2,2.434,'');
insert into students (student_firstname, student_lastname, student_year_name, student_major_id, student_gpa, student_notes) values ('Val','Uation','Junior',4,3.384,'');
insert into students (student_firstname, student_lastname, student_year_name, student_major_id, student_gpa, student_notes) values ('Robin','Eue','Sophomore',2,3.006,'');
insert into students (student_firstname, student_lastname, student_year_name, student_major_id, student_gpa, student_notes) values ('Tera','Dactyl','Junior',1,2.367,'');
insert into students (student_firstname, student_lastname, student_year_name, student_major_id, student_gpa, student_notes) values ('Lilly','Padz','Senior',4,1.8,'meet with student');
insert into students (student_firstname, student_lastname, student_year_name, student_major_id, student_gpa, student_notes) values ('Cook','Myefoud','Freshman',2,3.593,'');
insert into students (student_firstname, student_lastname, student_year_name, student_major_id, student_gpa, student_notes) values ('Heath','Barr','Sophomore',1,2.971,'');
insert into students (student_firstname, student_lastname, student_year_name, student_major_id, student_gpa, student_notes) values ('Dan','Delyons','Sophomore',1,2.005,'');
insert into students (student_firstname, student_lastname, student_year_name, student_major_id, student_gpa, student_notes) values ('Frank','Furter','Junior',2,3.464,'');
insert into students (student_firstname, student_lastname, student_year_name, student_major_id, student_gpa, student_notes) values ('Oliver','Stuffismission','Freshman',2,3.118,'');
insert into students (student_firstname, student_lastname, student_year_name, student_major_id, student_gpa, student_notes) values ('Sonny','Shores','Senior',1,2.972,'');
insert into students (student_firstname, student_lastname, student_year_name, student_major_id, student_gpa, student_notes) values ('Brayden','Yourhair','Senior',1,2.904,'');
insert into students (student_firstname, student_lastname, student_year_name, student_major_id, student_gpa, student_notes) values ('Oliver','Thingz','Sophomore',2,3.279,'');
insert into students (student_firstname, student_lastname, student_year_name, student_major_id, student_gpa, student_notes) values ('Bette','Itall','Sophomore',2,2.298,'');
insert into students (student_firstname, student_lastname, student_year_name, student_major_id, student_gpa, student_notes) values ('Carol','Ling','Graduate',2,3.736,'');
insert into students (student_firstname, student_lastname, student_year_name, student_major_id, student_gpa, student_notes) values ('Michael','Fudge','Graduate',NULL,4.0,'Undeclared');

