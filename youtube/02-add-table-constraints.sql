/* ----------
Spiffy Lube 

Motor Vehicle Services
- Oil Changes
- Tire Rotations

Constraints:

- Customers
    - ID
    - Email (unique)
    - First Name
    - Last Name

- Vehicles
    - ID
    - VIN (unique)
    - Make (default "Ford")
    - Model
    - Mileage (check > 0)
    - Last Visit
    - CustomerID (Foreign key)

macar@dayrep.com    Mac Arrone 
wshore@armyspy.com  Windy Shores 
ctyze@teleworm.us   Chaz Tyze 
ceue@gustr.com      Carri Eue  

12346   Subaru  Outback  123060   1/27/2021 macar@dayrep.com
12345   Chevy   Traverse 20992   1/28/2021  wshore@armyspy.com
12348   Chevy   Tahoe   35045   1/30/2021   wshore@armyspy.com
12347   Ford   F150   87600   1/31/2021     ctyze@teleworm.us
12344   Ford   F250   187600   1/31/2021    ceue@gustr.com

------------- */
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
    customer_id int null,
    constraint pk_vehicle_id primary key(id)
)
insert into vehicles (vin, make, model, mileage, last_visit)
VALUES
('12346','Subaru', 'Outback',123060,'2021-01-27'),
('12345','Chevy','Traverse',20992,'1/28/2021'),
('12348','Chevy','Tahoe',35045,'1/30/2021')

select * from vehicles 
-- part 2
alter table vehicles drop column customer_id
alter table vehicles 
    add customer_id int null 
alter table vehicles 
    add constraint u_vehicles_vin unique (vin)
alter table vehicles   
    add constraint ck_vehicles_mileage_gt_or_eq_0 check ( mileage >=0 )

/*
insert into vehicles (vin, make, model, mileage, last_visit)
VALUES
('1234A','Subaru', 'Forrester',-100,'2021-01-27')
*/
alter table customers add constraint u_customers_email unique(email)

-- foreign key constraint 
alter table vehicles add CONSTRAINT fk_vehicles_customer_id
    foreign key (customer_id) references customers(id)
    