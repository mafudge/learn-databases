/* ----------
Spiffy Lube 

Motor Vehicle Services
- Oil Changes
- Tire Rotations
------------- */
use spiffylube
GO
-- #1  drop constraints
if exists(select * from INFORMATION_SCHEMA.TABLE_CONSTRAINTS where CONSTRAINT_NAME ='fk_vehicles_customer_id')
    alter table vehicles drop constraint fk_vehicles_customer_id
-- #2 drop tables
drop table if exists customers
drop table if exists vehicles

-- #3 create tables
go
create table customers (
    id int IDENTITY not null, --surrogate key
    email varchar(100) not null,
    first_name varchar(50) not null,
    last_name varchar(50) not null,
    constraint pk_customers_id primary key (id),
    constraint u_customers_email unique(email)
)
insert into customers 
    (email, first_name, last_name) values 
    ('macar@dayrep.com', 'Mac', 'Arrone'),
    ('wshore@armyspy.com','Windy', 'Shores'),
    ('ctyze@teleworm.us','Chaz','Tyze')
GO
create table vehicles (
    id int IDENTITY not null, --surrogate
    vin VARCHAR(20) not null,
    make varchar(20) not null,
    model varchar(20) not null,
    mileage int not null,
    last_visit date not NULL,
    customer_id int null,
    constraint pk_vehicle_id primary key(id),
    constraint u_vehicles_vin unique (vin),
    constraint ck_vehicles_mileage_gt_or_eq_0 check ( mileage >=0 )
)
insert into vehicles (vin, make, model, mileage, last_visit, customer_id)
VALUES
('12346','Subaru', 'Outback',123060,'2021-01-27',1),
('12345','Chevy','Traverse',20992,'1/28/2021',2),
('12348','Chevy','Tahoe',35045,'1/30/2021',2),
('12347','Ford','F150',87600,'1/31/2021',3)

--#4 add FK constraint 
-- foreign key constraint 
alter table vehicles add CONSTRAINT fk_vehicles_customer_id
    foreign key (customer_id) references customers(id)


select * from customers 
select * from vehicles


select * from INFORMATION_SCHEMA.TABLES 
    where table_name = 'customers'

select * from INFORMATION_SCHEMA.TABLES 
    where table_name = 'oil_changes'

select * from INFORMATION_SCHEMA.COLUMNS
    where table_name ='vehicles'

select * from INFORMATION_SCHEMA.CHECK_CONSTRAINTS

select * from INFORMATION_SCHEMA.TABLE_CONSTRAINTS
