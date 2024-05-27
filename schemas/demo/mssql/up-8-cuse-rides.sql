use demo
go
drop table if exists cr_fleet
go
create table cr_fleet (
    driver_id int not null,
    driver_name varchar(50) not null,
    driver_fee money not null,
    region1 varchar(20) null,
    region2 varchar(20) null,
    region3 varchar(20) null,
    licplate varchar(10) not null,
    make varchar(20) not null,
    model varchar(20) not null,
    car_size char(1) not null,
    car_fee money not null,
    car_features varchar(50) null,
    test_date date not null,
    test_score int not null,
    constraint pk_fleet primary key (driver_id, licplate)
)
insert into cr_fleet (driver_id, driver_name,driver_fee,region1,region2,region3,
    licplate,make,model,car_size,car_fee,car_features,
    test_date,test_score)
    VALUES
    (101,'Bill Melator', 7.5, 'West','North','Downtown', 'PPF673', 'Cadillac', 'Escalade','M',10,'USB Port,Navigation,XM Radio,Bluetooth','2020-04-05',88 ),
    (101,'Bill Melator', 7.5, 'West','North','Downtown', 'PXK3D7T', 'Chevy', 'Tahoe','L',12.5,'USB Port,Navigation','2020-04-06',92 ),
    (101,'Bill Melator', 7.5, 'West','North','Downtown', '445GH2', 'Nissan', 'Leaf','S',7.5,'USB Port,XM Radio','2020-04-03',90 ),
    (101,'Bill Melator', 7.5, 'West','North','Downtown', '59DLLK', 'Chevy', 'Trax','S',7.5,'USB Port,Bluetooth','2020-04-01',78 ),
    (102,'Willie Dryve', 12.5, 'South','Downtown',NULL, 'PXK3D7T', 'Chevy', 'Tahoe','L',12.5,'USB Port,Navigation','2020-04-05',80 ),
    (102,'Willie Dryve', 12.5, 'South','Downtown',NULL, '663ETMP', 'Chevy', 'Surburban','L',12.5,'XM Radio','2020-04-03',90 ),
    (103,'Sal Debote', 10.0, 'North','Downtown','East', '445GH2', 'Nissan', 'Leaf','S',7.5,'USB Port,XM Radio','2020-04-12',90 ),
    (103,'Sal Debote', 10.0, 'North','Downtown','East', '59DLLK','Chevy', 'Trax','S',7.5,'USB Port,Bluetooth','2020-04-02',85 ),
    (103,'Sal Debote', 10.0, 'North','Downtown','East', '667GM8', 'Nissan', 'Altima','M',10, 'USB Port,Bluetooth,Navigation','2020-04-11',97 ),
    (104,'Carol Ling', 12.5, 'South',NULL,'West', '667GM8', 'Nissan', 'Altima','M',10, 'USB Port,Bluetooth,Navigation','2020-04-09',94 ),
    (104,'Carol Ling', 12.5, 'South',NULL,'West', 'PPF673', 'Cadillac', 'Escalade','M',10,'USB Port,Navigation,XM Radio,Bluetooth','2020-04-04',83 ),
    (104,'Carol Ling', 12.5, 'South',NULL,'West', '663ETMP', 'Chevy', 'Surburban','L',12.5,'XM Radio','2020-04-12',92 ),
    (105,'Ida Knowe', 5, NULL,NULL,'Downtown', '445GH2', 'Nissan', 'Leaf','S',7.5,'USB Port,XM Radio','2020-04-17',99 )
