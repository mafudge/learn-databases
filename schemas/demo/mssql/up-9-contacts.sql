use demo
go
drop table if exists contacts
go
create table contacts (
    contact_id int not null,
    contact_name varchar(50),
    home_phone varchar(20),
    mobile_phone varchar(20),
    work_phone varchar(20),
    other_phone varchar(20),
    constraint pk_contact primary key (contact_id)
)
insert into contacts (contact_id, contact_name, home_phone, mobile_phone, work_phone, other_phone)
    VALUES
    (1,'Cesar Salad', '415-555-0092', null, null, '415-555-1294'),
    (2,'Crystal Ball', null, '315-555-4450','315-555-8882', null),
    (3,'Maddie Furr', null, null, '415-555-4534', null),
    (4,'Sherry Whyne', '315-555-5059','415-555-3033', '315-555-6419',null)