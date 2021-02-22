/* ----------
Spiffy Lube 

Motor Vehicle Services
- Oil Changes
- Tire Rotations

Create Tables:

- Customers
    - Email (business key)
    - First Name
    - Last Name

- Vehicles
    - VIN 
    - Make
    - Model
    - Mileage
    - Last Visit
    - Customer ???

- Add Data
macar@dayrep.com    Mac Arrone 
wshore@armyspy.com  Windy Shores
ctyze@teleworm.us   Chaz Tyze 
ceue@gustr.com      Carri Eue 

12346   Subaru  Outback  123060   1/27/2021
12345   Chevy   Traverse 20992   1/28/2021
12348   Chevy   Tahoe   35045   1/30/2021
12347   Ford   F150   87600   1/31/2021
12344   Ford   F250   187600   1/31/2021
------------ */
use spiffylube
GO
drop table if exists customers
go
create table customers (
    id int IDENTITY not null, --surrogate key
    email varchar(100) not null,
    first_name varchar(50) not null,
    last_name varchar(50) not null,
    constraint pk_customers_id primary key (id)
)
insert into customers 
    (email, first_name, last_name) values 
    ('macar@dayrep.com', 'Mac', 'Arrone'),
    ('wshore@armyspy.com','Windy', 'Shores'),
    ('ctyze@teleworm.us','Chaz','Tyze')

select * from customers

drop table if exists vehicles
GO
create table vehicles (
    id int IDENTITY not null, --surrogate
    vin VARCHAR(20) not null,
    make varchar(20) not null,
    model varchar(20) not null,
    mileage int not null,
    last_visit date not NULL,
    customer_id int null
)
insert into vehicles (vin, make, model, mileage, last_visit)
VALUES
('12346','Subaru', 'Outback',123060,'2021-01-27'),
('12345','Chevy','Traverse',20992,'1/28/2021'),
('12348','Chevy','Tahoe',35045,'1/30/2021')

select * from vehicles 


