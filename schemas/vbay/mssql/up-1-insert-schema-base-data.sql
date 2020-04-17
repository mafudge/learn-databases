-- vBay!
-- A Carlos V. Inspired E-Bay Clone

use vbay
GO

-- Part 1: Create tables --

-- 1.1 CREATE TABLE: vb_users
create table vb_users
(
	[user_id] int identity(1,1) not null,
	user_email varchar(100) not null,
	user_firstname varchar(50) not null,
	user_lastname varchar(50) not null,
	user_zip_code char(5) not null
)
GO

-- 1.2 CREATE TABLE: vb_item_types_lookup
create table vb_item_types_lookup
(
	item_type varchar(20) not null
)
GO

-- 1.3 CREATE TABLE: vb_items
create table vb_items
(
	item_id int identity(1,1) not null,
	item_name varchar(100) not null,
	item_type varchar(20) not null,
	item_description text null,
	item_reserve money not null default(0),
	item_enddate datetime not null default(dateadd(dd,7,getdate())),
	item_sold bit not null default(0),
	item_seller_user_id int not null,
	item_buyer_user_id int null,
	item_soldamount money null
)
GO

-- 1.4 CREATE TABLE: vb_rating_astypes_lookup
create table vb_rating_astypes_lookup
(
	rating_astype varchar(20) not null
)
GO

-- 1.5 CREATE TABLE: vb_user_ratings
create table vb_user_ratings
(
	rating_id int identity(1,1) not null,
	rating_by_user_id int not null,
	rating_for_user_id int not null,
	rating_astype varchar(20) not null,
	rating_value int not null,
	rating_comment text null
)
GO

-- 1.6 CREATE TABLE: vb_bid_status_lookup
create table vb_bid_status_lookup
(
	bid_status varchar(20) not null
)
GO

-- 1.7 CREATE TABLE: vb_bids
create table  vb_bids
(
	bid_id int identity(1,1) not null,
	bid_user_id int not null,
	bid_item_id int not null,
	bid_datetime datetime not null default(getdate()),
	bid_amount money not null,
	bid_status varchar(20) not null
)
GO

-- 1.8 CREATE TABLE: vb_zip_codes
create table  vb_zip_codes
(
	zip_code char(5) not null,
	zip_city varchar(50) not null,
	zip_state char(2) not null,
	zip_lat decimal(9,4) not null,
	zip_lng decimal(9,4) not null
)
GO

-- Part 2: Add Table Constraints --

-- 2.1 ADD TABLE CONSTRAINTS: vb_users
alter table vb_users
	add
	constraint pk_user_id primary key([user_id]),
	constraint u_email unique(user_email)
GO

-- 2.2 ADD TABLE CONSTRAINTS: vb_item_types_lookup
alter table vb_item_types_lookup
	add
	constraint pk_item_type primary key (item_type)
GO


-- 2.3 ADD TABLE CONSTRAINTS: vb_items
alter table vb_items
	add
		constraint pk_item_id primary key (item_id),
		constraint ck_reserve_valid check (item_reserve >=0),
		constraint ck_soldamount_valid check (item_soldamount >= item_reserve)
GO

-- 2.4 ADD TABLE CONSTRAINTS: vb_rating_astypes_lookup
alter table vb_rating_astypes_lookup
	add
	constraint pk_rating_astype primary key(rating_astype)
GO


-- 2.5 ADD TABLE CONSTRAINTS: vb_user_ratings
alter table vb_user_ratings
	add
		constraint pk_rating_id primary key (rating_id),
		constraint ck_rating_value_valid check (rating_value between 0 and 5),
		constraint ck_cant_rate_yourself check (rating_for_user_id <> rating_by_user_id)
GO

-- 2.6 ADD TABLE CONSTRAINTS: vb_bid_status_lookup
alter table vb_bid_status_lookup
	add
		constraint pk_bid_status primary key (bid_status)
GO

-- 2.7 ADD TABLE CONSTRAINTS: vb_bids
alter table  vb_bids
	add
		constraint pk_bid_id primary key(bid_id)
GO

-- 2.8 ADD TABLE CONSTRAINT: vb_zip_codes
alter table  vb_zip_codes
	add
		constraint pk_zip_code primary key (zip_code)
GO

-- Part 3: Add Foreign Key Constraints --

-- 3.1 ADD FOREIGN KEY CONSTRAINTS: vb_bids
alter table vb_bids add
	constraint fk_bid_status foreign key (bid_status) references vb_bid_status_lookup(bid_status),
	constraint fk_bid_user_id foreign key (bid_user_id) references vb_users([user_id]),
	constraint fk_bid_item_id foreign key (bid_item_id) references vb_items(item_id)
GO

-- 3.2 ADD FOREIGN KEY CONSTRAINTS: vb_users
alter table vb_users add
	constraint fk_user_zip_code foreign key (user_zip_code) references vb_zip_codes(zip_code)
GO

-- 3.3 ADD FOREIGN KEY CONSTRAINTS: vb_items
alter table vb_items add
	constraint fk_item_type foreign key (item_type) references vb_item_types_lookup(item_type),
	constraint fk_item_seller_user_id foreign key (item_seller_user_id) 
				references vb_users([user_id]),
	constraint fk_item_buyer_user_id foreign key (item_buyer_user_id) 
				references vb_users([user_id])				
GO

-- 3.4 ADD FOREIGN KEY CONSTRAINTS: vb_user_ratings
alter table vb_user_ratings add
	constraint fk_rating_astype foreign key (rating_astype) references vb_rating_astypes_lookup(rating_astype),
	constraint fk_rating_for_user_id foreign key (rating_for_user_id) 
				references vb_users([user_id]),
	constraint fk_rating_by_user_id foreign key (rating_by_user_id) 
				references vb_users([user_id])				
GO


-- Part 4: Insert Base Data --

-- 4.1 INSERT DATA : vb_item_types_lookup
insert into vb_item_types_lookup (item_type)
	select 'All Other' union all
	select 'Antiques' union all
	select 'Books' union all
	select 'Collectables' union all
	select 'Electronics' union all
	select 'Jewelry' union all
	select 'Music' union all
	select 'Sporting Goods' union all
	select 'Tickets' 
GO

-- 4.2 INSERT DATA: vb_rating_astypes_lookup
insert into vb_rating_astypes_lookup (rating_astype)
	select 'Buyer' union all
	select 'Seller' 
GO

-- 4.3 INSERT DATA: vb_bid_status_lookup
insert into vb_bid_status_lookup (bid_status)
	select 'ok' union all
	select 'low_bid' union all
	select 'item_seller' 
GO

insert into vb_zip_codes values ('14263','BUFFALO','NY','42.88','-78.85');
insert into vb_zip_codes values ('14264','BUFFALO','NY','42.88','-78.85');
insert into vb_zip_codes values ('14265','BUFFALO','NY','42.88','-78.85');
insert into vb_zip_codes values ('14623','ROCHESTER','NY','43.16','-77.61');
insert into vb_zip_codes values ('14624','ROCHESTER','NY','43.16','-77.61');
insert into vb_zip_codes values ('14625','ROCHESTER','NY','43.16','-77.61');
insert into vb_zip_codes values ('14626','ROCHESTER','NY','43.16','-77.61');
insert into vb_zip_codes values ('82834','BUFFALO','WY','44.34','-106.71');
insert into vb_zip_codes values ('55901','ROCHESTER','MN','44.01','-92.47');
insert into vb_zip_codes values ('55902','ROCHESTER','MN','44.01','-92.47');
insert into vb_zip_codes values ('55904','ROCHESTER','MN','44.01','-92.47');
insert into vb_zip_codes values ('55905','ROCHESTER','MN','44.01','-92.47');
insert into vb_zip_codes values ('55906','ROCHESTER','MN','44.01','-92.47');
insert into vb_zip_codes values ('21229','BALTIMORE','MD','39.3','-76.61');
insert into vb_zip_codes values ('21230','BALTIMORE','MD','39.3','-76.61');
insert into vb_zip_codes values ('21231','BALTIMORE','MD','39.3','-76.61');
insert into vb_zip_codes values ('21233','BALTIMORE','MD','39.3','-76.61');
insert into vb_zip_codes values ('21234','PARKVILLE','MD','39.38','-76.55');
insert into vb_zip_codes values ('21235','BALTIMORE','MD','39.3','-76.61');
insert into vb_zip_codes values ('21236','NOTTINGHAM','MD','39.38','-76.48');
insert into vb_zip_codes values ('21237','ROSEDALE','MD','39.32','-76.5');
insert into vb_zip_codes values ('21239','BALTIMORE','MD','39.3','-76.61');
insert into vb_zip_codes values ('21240','BALTIMORE','MD','39.3','-76.61');
insert into vb_zip_codes values ('21241','BALTIMORE','MD','39.3','-76.61');
insert into vb_zip_codes values ('21244','WINDSOR MILL','MD','39.33','-76.78');
insert into vb_zip_codes values ('21250','BALTIMORE','MD','39.3','-76.61');
insert into vb_zip_codes values ('21251','BALTIMORE','MD','39.3','-76.61');

GO

insert into vb_zip_codes values ('21252','TOWSON','MD','39.3','-76.61');
insert into vb_zip_codes values ('21263','BALTIMORE','MD','39.3','-76.61');
insert into vb_zip_codes values ('21264','BALTIMORE','MD','39.3','-76.61');
insert into vb_zip_codes values ('21273','BALTIMORE','MD','39.3','-76.61');
insert into vb_zip_codes values ('21275','BALTIMORE','MD','39.3','-76.61');
insert into vb_zip_codes values ('21278','BALTIMORE','MD','39.3','-76.61');
insert into vb_zip_codes values ('21279','BALTIMORE','MD','39.3','-76.61');
insert into vb_zip_codes values ('21280','BALTIMORE','MD','39.3','-76.61');
insert into vb_zip_codes values ('43105','BALTIMORE','OH','39.84','-82.6');
insert into vb_zip_codes values ('13202','SYRACUSE','NY','43.04','-76.14');
insert into vb_zip_codes values ('13203','SYRACUSE','NY','43.04','-76.14');
insert into vb_zip_codes values ('13204','SYRACUSE','NY','43.04','-76.14');
insert into vb_zip_codes values ('13205','SYRACUSE','NY','43.04','-76.14');
insert into vb_zip_codes values ('13206','SYRACUSE','NY','43.04','-76.14');
insert into vb_zip_codes values ('13207','SYRACUSE','NY','43.04','-76.14');
insert into vb_zip_codes values ('13208','SYRACUSE','NY','43.04','-76.14');
insert into vb_zip_codes values ('13209','SYRACUSE','NY','43.04','-76.14');
insert into vb_zip_codes values ('13210','SYRACUSE','NY','43.04','-76.14');
insert into vb_zip_codes values ('13211','SYRACUSE','NY','43.04','-76.14');
insert into vb_zip_codes values ('13212','SYRACUSE','NY','43.04','-76.14');
insert into vb_zip_codes values ('13214','SYRACUSE','NY','43.04','-76.14');
insert into vb_zip_codes values ('13215','SYRACUSE','NY','43.04','-76.14');
insert into vb_zip_codes values ('13219','SYRACUSE','NY','43.04','-76.14');
insert into vb_zip_codes values ('14802','ALFRED','NY','42.25','-77.78');
insert into vb_zip_codes values ('12946','LAKE PLACID','NY','44.28','-73.98');
insert into vb_zip_codes values ('12108','LAKE PLEASANT','NY','43.55','-74.43');
insert into vb_zip_codes values ('12260','ALBANY','NY','42.66','-73.79');
insert into vb_zip_codes values ('12261','ALBANY','NY','42.66','-73.79');
insert into vb_zip_codes values ('12288','ALBANY','NY','42.66','-73.79');
insert into vb_zip_codes values ('12007','ALCOVE','NY','42.45','-74.03');
insert into vb_zip_codes values ('13301','ALDER CREEK','NY','43.42','-75.22');
insert into vb_zip_codes values ('13607','ALEXANDRIA BAY','NY','44.33','-75.91');
insert into vb_zip_codes values ('10022','NEW YORK','NY','40.71','-73.99');
insert into vb_zip_codes values ('10023','NEW YORK','NY','40.71','-73.99');
insert into vb_zip_codes values ('10024','NEW YORK','NY','40.71','-73.99');

GO

insert into vb_zip_codes values ('10025','NEW YORK','NY','40.71','-73.99');
insert into vb_zip_codes values ('10026','NEW YORK','NY','40.71','-73.99');
insert into vb_zip_codes values ('10027','NEW YORK','NY','40.71','-73.99');
insert into vb_zip_codes values ('10028','NEW YORK','NY','40.71','-73.99');
insert into vb_zip_codes values ('10029','NEW YORK','NY','40.71','-73.99');
insert into vb_zip_codes values ('10030','NEW YORK','NY','40.71','-73.99');
insert into vb_zip_codes values ('10031','NEW YORK','NY','40.71','-73.99');
insert into vb_zip_codes values ('10032','NEW YORK','NY','40.71','-73.99');
insert into vb_zip_codes values ('10033','NEW YORK','NY','40.71','-73.99');
insert into vb_zip_codes values ('10034','NEW YORK','NY','40.71','-73.99');
insert into vb_zip_codes values ('37402','CHATTANOOGA','TN','35.06','-85.25');
insert into vb_zip_codes values ('37403','CHATTANOOGA','TN','35.06','-85.25');
insert into vb_zip_codes values ('37404','CHATTANOOGA','TN','35.06','-85.25');
insert into vb_zip_codes values ('37405','CHATTANOOGA','TN','35.06','-85.25');
insert into vb_zip_codes values ('37406','CHATTANOOGA','TN','35.06','-85.25');
insert into vb_zip_codes values ('37407','CHATTANOOGA','TN','35.06','-85.25');
insert into vb_zip_codes values ('37408','CHATTANOOGA','TN','35.06','-85.25');
insert into vb_zip_codes values ('94952','PETALUMA','CA','38.21','-122.76');
insert into vb_zip_codes values ('94954','PETALUMA','CA','38.23','-122.56');
insert into vb_zip_codes values ('94999','PETALUMA','CA','38.32','-122.64');
insert into vb_zip_codes values ('99605','HOPE','AK','60.84','-149.4');
insert into vb_zip_codes values ('99705','NORTH POLE','AK','64.77','-147.33');
insert into vb_zip_codes values ('99709','FAIRBANKS','AK','64.9','-148.16');
insert into vb_zip_codes values ('99712','FAIRBANKS','AK','64.93','-146.61');
insert into vb_zip_codes values ('10001','NEW YORK','NY','40.71','-73.99');
insert into vb_zip_codes values ('10002','NEW YORK','NY','40.71','-73.99');
insert into vb_zip_codes values ('10003','NEW YORK','NY','40.71','-73.99');
insert into vb_zip_codes values ('10004','NEW YORK','NY','40.71','-73.99');
insert into vb_zip_codes values ('10005','NEW YORK','NY','40.71','-73.99');
insert into vb_zip_codes values ('10006','NEW YORK','NY','40.71','-73.99');
insert into vb_zip_codes values ('10007','NEW YORK','NY','40.71','-73.99');
insert into vb_zip_codes values ('10009','NEW YORK','NY','40.71','-73.99');
insert into vb_zip_codes values ('10010','NEW YORK','NY','40.71','-73.99');
insert into vb_zip_codes values ('10011','NEW YORK','NY','40.71','-73.99');
insert into vb_zip_codes values ('10012','NEW YORK','NY','40.71','-73.99');
insert into vb_zip_codes values ('10013','NEW YORK','NY','40.71','-73.99');
insert into vb_zip_codes values ('10014','NEW YORK','NY','40.71','-73.99');
insert into vb_zip_codes values ('10016','NEW YORK','NY','40.71','-73.99');
insert into vb_zip_codes values ('10017','NEW YORK','NY','40.71','-73.99');
insert into vb_zip_codes values ('10018','NEW YORK','NY','40.71','-73.99');

GO

insert into vb_zip_codes values ('10019','NEW YORK','NY','40.71','-73.99');
insert into vb_zip_codes values ('10020','NEW YORK','NY','40.71','-73.99');
insert into vb_zip_codes values ('10021','NEW YORK','NY','40.77','-73.95');
insert into vb_zip_codes values ('99801','JUNEAU','AK','58.58','-134.77');
insert into vb_zip_codes values ('99811','JUNEAU','AK','58.47','-134.15');
insert into vb_zip_codes values ('99812','JUNEAU','AK','58.28','-134.4');
insert into vb_zip_codes values ('35160','TALLADEGA','AL','33.43','-86.09');
insert into vb_zip_codes values ('36078','TALLASSEE','AL','32.53','-85.89');
insert into vb_zip_codes values ('36079','TROY','AL','31.8','-85.96');
insert into vb_zip_codes values ('36081','TROY','AL','31.8','-85.96');
insert into vb_zip_codes values ('36082','TROY','AL','31.8','-85.96');
insert into vb_zip_codes values ('35173','TRUSSVILLE','AL','33.63','-86.59');
insert into vb_zip_codes values ('35401','TUSCALOOSA','AL','33.23','-87.54');
insert into vb_zip_codes values ('85201','MESA','AZ','33.44','-111.85');
insert into vb_zip_codes values ('85202','MESA','AZ','33.38','-111.87');
insert into vb_zip_codes values ('85203','MESA','AZ','33.44','-111.8');
insert into vb_zip_codes values ('85204','MESA','AZ','33.39','-111.78');
insert into vb_zip_codes values ('33540','ZEPHYRHILLS','FL','28.23','-82.17');
insert into vb_zip_codes values ('33541','ZEPHYRHILLS','FL','28.23','-82.17');
insert into vb_zip_codes values ('33542','ZEPHYRHILLS','FL','28.23','-82.17');
insert into vb_zip_codes values ('85205','MESA','AZ','33.43','-111.71');
insert into vb_zip_codes values ('85206','MESA','AZ','33.39','-111.71');
insert into vb_zip_codes values ('85207','MESA','AZ','33.45','-111.64');
insert into vb_zip_codes values ('85003','PHOENIX','AZ','33.45','-112.07');
insert into vb_zip_codes values ('85004','PHOENIX','AZ','33.44','-112.07');
insert into vb_zip_codes values ('85006','PHOENIX','AZ','33.46','-112.05');
insert into vb_zip_codes values ('85007','PHOENIX','AZ','33.44','-112.08');
insert into vb_zip_codes values ('85008','PHOENIX','AZ','33.46','-111.98');
insert into vb_zip_codes values ('85009','PHOENIX','AZ','33.44','-112.13');
insert into vb_zip_codes values ('85145','RED ROCK','AZ','32.57','-111.36');
insert into vb_zip_codes values ('95190','SAN JOSE','CA','37.37','-121.9');
insert into vb_zip_codes values ('95191','SAN JOSE','CA','37.32','-121.91');
insert into vb_zip_codes values ('95192','SAN JOSE','CA','37.34','-121.89');
insert into vb_zip_codes values ('95193','SAN JOSE','CA','37.24','-121.83');
insert into vb_zip_codes values ('95194','SAN JOSE','CA','37.34','-121.88');
insert into vb_zip_codes values ('95196','SAN JOSE','CA','37.33','-121.89');
insert into vb_zip_codes values ('95050','SANTA CLARA','CA','37.34','-121.95');
insert into vb_zip_codes values ('95051','SANTA CLARA','CA','37.35','-121.98');
insert into vb_zip_codes values ('95053','SANTA CLARA','CA','37.34','-121.93');
insert into vb_zip_codes values ('95054','SANTA CLARA','CA','37.39','-121.96');
insert into vb_zip_codes values ('95060','SANTA CRUZ','CA','37.04','-122.1');
insert into vb_zip_codes values ('95062','SANTA CRUZ','CA','36.97','-121.98');
insert into vb_zip_codes values ('95064','SANTA CRUZ','CA','36.98','-122.06');
insert into vb_zip_codes values ('95065','SANTA CRUZ','CA','37.03','-121.98');
insert into vb_zip_codes values ('95066','SCOTTS VALLEY','CA','37.06','-122.01');
insert into vb_zip_codes values ('95070','SARATOGA','CA','37.25','-122.06');
insert into vb_zip_codes values ('93955','SEASIDE','CA','36.62','-121.82');
insert into vb_zip_codes values ('94102','SAN FRANCISCO','CA','37.77','-122.41');
insert into vb_zip_codes values ('94103','SAN FRANCISCO','CA','37.77','-122.41');
insert into vb_zip_codes values ('94104','SAN FRANCISCO','CA','37.79','-122.4');
insert into vb_zip_codes values ('94105','SAN FRANCISCO','CA','37.78','-122.39');
insert into vb_zip_codes values ('94107','SAN FRANCISCO','CA','37.76','-122.39');

GO

insert into vb_zip_codes values ('94108','SAN FRANCISCO','CA','37.79','-122.4');
insert into vb_zip_codes values ('94109','SAN FRANCISCO','CA','37.79','-122.42');
insert into vb_zip_codes values ('94110','SAN FRANCISCO','CA','37.74','-122.41');
insert into vb_zip_codes values ('94111','SAN FRANCISCO','CA','37.79','-122.39');
insert into vb_zip_codes values ('94112','SAN FRANCISCO','CA','37.72','-122.44');
insert into vb_zip_codes values ('13148','SENECA FALLS','NY','42.91','-76.79');
insert into vb_zip_codes values ('13459','SHARON SPRINGS','NY','42.79','-74.61');
insert into vb_zip_codes values ('13460','SHERBURNE','NY','42.67','-75.49');
insert into vb_zip_codes values ('13461','SHERRILL','NY','43.07','-75.59');
insert into vb_zip_codes values ('12873','SHUSHAN','NY','43.12','-73.3');
insert into vb_zip_codes values ('13838','SIDNEY','NY','42.31','-75.39');
insert into vb_zip_codes values ('13224','SYRACUSE','NY','43.04','-76.14');
insert into vb_zip_codes values ('13225','SYRACUSE','NY','43.04','-76.14');
insert into vb_zip_codes values ('13244','SYRACUSE','NY','43.04','-76.14');
insert into vb_zip_codes values ('13250','SYRACUSE','NY','43.04','-76.14');
insert into vb_zip_codes values ('13251','SYRACUSE','NY','43.04','-76.14');
insert into vb_zip_codes values ('13252','SYRACUSE','NY','43.04','-76.14');
insert into vb_zip_codes values ('13290','SYRACUSE','NY','43.04','-76.14');
insert into vb_zip_codes values ('13471','TABERG','NY','43.3','-75.61');
insert into vb_zip_codes values ('13675','PLESSIS','NY','44.27','-75.84');
insert into vb_zip_codes values ('13691','THERESA','NY','44.21','-75.79');
insert into vb_zip_codes values ('13693','THREE MILE BAY','NY','43.99','-76.25');
insert into vb_zip_codes values ('12858','PARADOX','NY','43.9','-73.63');
insert into vb_zip_codes values ('12883','TICONDEROGA','NY','43.84','-73.42');
insert into vb_zip_codes values ('12180','TROY','NY','42.73','-73.67');
insert into vb_zip_codes values ('30295','ZEBULON','GA','33.1','-84.34');

GO

-- 4.4 INSERT DATA: vb_users (25 users total)
insert into vb_users (user_email, user_firstname, user_lastname, user_zip_code)
	select 'abuss@mail.org', 'Abby', 'Kuss', '94112' union all
	select 'adwewy@mail.org', 'Anne', 'Dewey', '35160' union all
	select 'bbarion@mail.org', 'Barb', 'Barion', '85202' union all
	select 'bdehatchett@mail.org', 'Barry', 'DeHatchett' , '95191' union all
	select 'benarreau@mail.org', 'Bo', 'Enarreau' , '30295' union all
	select 'gtoffwind@mail.org', 'Gus', 'Toffwind' , '94999' union all
	select 'igunner@mail.org', 'Isabelle', 'Gunnering' , '95191' union all
	select 'lismoore@mail.org', 'Les', 'Ismoore' , '37403' union all
	select 'meveyzing@mail.org', 'Martin', 'Eyezing' , '13244' union all
	select 'mmelator@mail.org', 'Mary', 'Melator' , '33541' union all
	select 'rabovdu@mail.org', 'Rose', 'Abov-Duresst' , '10027' union all
	select 'rovlight@mail.org', 'Ray', 'Ovlight' , '13607' union all
	select 'vrhee@mail.org', 'Victor', 'Rhee' , '12946' union all
	select 'tanott@mail.org', 'Ty','Anott' , '13244' union all
	select 'sofewe@mail.org', 'Seymour', 'Ofewe' , '10006' union all
	select 'pmoss@mail.org','Pete','Moss' , '14802' union all
	select 'omoni@mail.org','Otto','Moni' , '10017' union all
	select 'ppincher@mail.org','Penny','Pincher' , '13212' union all
	select 'ostuff@mail.org','Oliver','Stuffismission' , '13219' union all
	select 'herchief@mail.org','Hank','Erchief' , '13290' union all
	select 'jpoole@mail.org','Jean','Poole' , '43105' union all
	select 'ajob@mail.org','Anita','Job' , '21241' union all
	select 'ddeloyons@mail.org','Dan','Delyons' , '55901' union all
	select 'afresco@mail.org','Al','Fresco' , '82834' union all	 
	select 'cdababbi@mail.org','Carrie','Dababbi' , '14264'
		
GO
	
	
-- Part 5: Procedures / Data Insertion --

-- 5.1 CREATE PROCEDURE: dbo.p_new_auction_item
if exists(select name from sys.objects where name='p_new_auction_item') drop procedure p_new_auction_item
GO
create procedure dbo.p_new_auction_item 
(
	@item_name varchar(100),
	@item_type varchar(20),
	@item_description text,
	@item_reserve money,
	@item_seller_user_id int
)
as
begin
	-- TODO: 5.1
	insert into vb_items (item_name, item_type, item_description, item_reserve, item_seller_user_id)
	values (@item_name,@item_type, @item_description, @item_reserve, @item_seller_user_id)
	
	return @@identity 
	-- 
end
GO

-- 5.2 EXECUTE PROCEDURE: dbo.p_new_auction_item (or do the INSERTS manually for some credit)
-- 37 Inserts total
exec dbo.p_new_auction_item 'Used Pink Bathrobe', 'All Other', null, 15.95, 1
exec dbo.p_new_auction_item 'Rare Mint Snow Globe', 'Collectables', null, 30.50, 2
exec dbo.p_new_auction_item 'Smurf TV Tray', 'Collectables', null, 25, 3
exec dbo.p_new_auction_item 'Pet Rock', 'All Other', null, 2.50, 4
exec dbo.p_new_auction_item 'Alf Alarm Clock', 'Collectables', null, 5, 25
exec dbo.p_new_auction_item 'Shatner''s old Toupee', 'Collectables', null, 199.99, 17
exec dbo.p_new_auction_item 'Slightly-damaged Golf Bag', 'Sporting Goods', null, 12.75, 8
exec dbo.p_new_auction_item 'Some Beanie Babies, New with Tag!', 'Collectables', null, 99.99, 9
exec dbo.p_new_auction_item 'Tchotchkes', 'All Other', null, 0.99, 10
exec dbo.p_new_auction_item 'Your Watch, Please?', 'Jewelry', null, 6.95, 11
exec dbo.p_new_auction_item 'Dukes Of Hazard ashtray', 'Collectables', null, 149.99, 11
exec dbo.p_new_auction_item 'PacMan Fever lunchbox', 'Collectables', null, 29.99, 25
exec dbo.p_new_auction_item 'case of vintage tube socks', 'Antiques', null, 9.00, 22
exec dbo.p_new_auction_item 'Kleenex used by Dr. Dre', 'Collectables', null, 500.00, 22
exec dbo.p_new_auction_item 'Farrah Fawcet poster', 'Collectables', null, 50.00, 14
exec dbo.p_new_auction_item 'Pez dispensers', 'Collectables', null, 10.00, 13
exec dbo.p_new_auction_item 'a Toaster', 'Antiques', null, 20.00, 17
exec dbo.p_new_auction_item 'Antique Desk', 'Antiques', null, 250, 11
exec dbo.p_new_auction_item 'SQL for Dummies', 'Books', null, 10.99, 25
exec dbo.p_new_auction_item 'Mike Fudge BobbleHead', 'Collectables', null, 49.95, 9
exec dbo.p_new_auction_item 'Carlos Villalba BobbleHead', 'Collectables', null, 49.95, 9
exec dbo.p_new_auction_item 'Fuzzy Logic', 'Books', null, 4.50, 15
exec dbo.p_new_auction_item 'Dusty Vase', 'Antiques', null, 100, 1
exec dbo.p_new_auction_item 'Old Diamond Ring', 'Jewelry', null, 599.99, 1
exec dbo.p_new_auction_item 'Betamax Player', 'Electronics', null, 15.00, 15
exec dbo.p_new_auction_item 'Joe Montanna Figurine', 'Collectables', null, 200, 11
exec dbo.p_new_auction_item 'Ark of the Covenant', 'All Other', null, 10000000, 1
exec dbo.p_new_auction_item 'Superbowl XLIV tickets', 'Tickets', null, 750, 3
exec dbo.p_new_auction_item 'NBA Basketball', 'Sporting Goods', null, 45.95, 3
exec dbo.p_new_auction_item 'Avatar 3D Two Tickets', 'Tickets', null, 5.0, 25
exec dbo.p_new_auction_item 'Linux in a Nutshell', 'Books', null, 9.95, 25
exec dbo.p_new_auction_item 'Ten Speed Bike', 'Sporting Goods', null, 12.50, 3
exec dbo.p_new_auction_item 'Original Coke Bottle from 1960', 'Antiques', null, 65, 19
exec dbo.p_new_auction_item 'Client/Server Survival Guide', 'Books', null, 9.95, 5
exec dbo.p_new_auction_item 'Brass French Press', 'Antiques', null, 45.50, 25
exec dbo.p_new_auction_item 'Autographed Mik Jagger Poster', 'Collectables', null, 75, 25
exec dbo.p_new_auction_item 'Brass Letter Opener', 'Antiques', null, 150, 1
GO

-- 5.3 CREATE PROCEDURE: dbo.p_rate_user
if exists(select name from sys.objects where name='p_rate_user') drop procedure p_rate_user
GO
create procedure dbo.p_rate_user
(
	@rating_by_user_id int,
	@rating_for_user_id int,
	@rating_astype varchar(20),
	@rating_value int,
	@rating_comment text 
)
as
begin
	-- TODO: 5.3
	insert into vb_user_ratings (rating_by_user_id, rating_for_user_id, rating_astype, rating_value,rating_comment)
	values (@rating_by_user_id, @rating_for_user_id, @rating_astype, @rating_value, @rating_comment)
	
	return @@identity 
end
GO

-- 5.4 EXECUTE PROCEDURE : dbo.p_rate_user (or do the INSERTS manually for some credit)
-- Buyer Ratings (20 total)
exec dbo.p_rate_user  25, 10, 'Buyer', 5, 'Pays on time.'
exec dbo.p_rate_user  24, 7, 'Buyer', 4, 'Not Bad'
exec dbo.p_rate_user  23, 8,'Buyer', 3, 'Okay'
exec dbo.p_rate_user  22, 1,'Buyer', 4, 'Reliable'
exec dbo.p_rate_user  21, 3,'Buyer', 5, 'Great!!'
exec dbo.p_rate_user  20, 6,'Buyer', 3, 'Not Bad'
exec dbo.p_rate_user  19, 8,'Buyer', 1, 'Really Bad'
exec dbo.p_rate_user  18, 10,'Buyer', 4, 'GOod'
exec dbo.p_rate_user  17, 4,'Buyer', 5, 'A+++++'
exec dbo.p_rate_user  16, 8,'Buyer', 1, 'Meh.'
exec dbo.p_rate_user  15, 10, 'Buyer', 5, 'Pays on time.'
exec dbo.p_rate_user  14, 7, 'Buyer', 4, 'Not Bad'
exec dbo.p_rate_user  13, 8,'Buyer', 3, 'Okay'
exec dbo.p_rate_user  12, 1,'Buyer', 4, 'Reliable'
exec dbo.p_rate_user  15, 3,'Buyer', 5, 'Great!!'
exec dbo.p_rate_user  17, 6,'Buyer', 3, 'So so.'
exec dbo.p_rate_user  19, 8,'Buyer', 1, 'Really Bad'
exec dbo.p_rate_user  25, 10,'Buyer', 4, 'GOod'
exec dbo.p_rate_user  11, 4,'Buyer', 5, 'A++'
exec dbo.p_rate_user  11, 8,'Buyer', 1, 'Boo. Hiss.'

-- Seller Ratings (20 total)
exec dbo.p_rate_user  1, 25,'Seller', 5, 'Top Notch!'
exec dbo.p_rate_user  2, 25,'Seller', 4, 'GOod'
exec dbo.p_rate_user  3, 22,'Seller', 3, 'Okay'
exec dbo.p_rate_user  4, 1,'Seller', 4, 'Reliable'
exec dbo.p_rate_user  5, 25,'Seller', 5, 'Execellent!'
exec dbo.p_rate_user  6, 9,'Seller', 3, 'Not Bad'
exec dbo.p_rate_user  25, 11,'Seller', 0, 'Horrible.'
exec dbo.p_rate_user  8, 3,'Seller', 5, 'Nice!'
exec dbo.p_rate_user  9, 1,'Seller', 5, 'The Best!'
exec dbo.p_rate_user  10, 9,'Seller', 2, 'So-So'
exec dbo.p_rate_user  1, 11,'Seller', 2, 'Needs Improvement'
exec dbo.p_rate_user  12, 3,'Seller', 2, 'Bad Experience.'
exec dbo.p_rate_user  2, 11,'Seller', 1, 'Bad.'
exec dbo.p_rate_user  7, 14,'Seller', 1, 'Poor'
exec dbo.p_rate_user  25, 1,'Seller', 4, 'Great!'
exec dbo.p_rate_user  16, 25,'Seller', 5, 'Super Great!'
exec dbo.p_rate_user  17, 14,'Seller', 4, 'Great!'
exec dbo.p_rate_user  15, 8,'Seller', 2, 'Bad!'
exec dbo.p_rate_user  14, 8,'Seller', 3, 'Okay'
exec dbo.p_rate_user  8, 13,'Seller', 4, 'Great!'

GO

-- 5.5 CREATE PROCEDURE: dbo.p_place_bid
if exists(select name from sys.objects where name='p_place_bid') drop procedure p_place_bid
GO
create procedure dbo.p_place_bid
(
	@bid_item_id int,
	@bid_user_id int,
	@bid_amount money
)
as
begin
	declare @max_bid_amount money
	declare @item_seller_user_id int
	declare @bid_status varchar(20)
	
	-- be optimistic :-)
	set @bid_status = 'ok'
	
	-- TODO: 5.5.1 set @max_bid_amount to the higest bid amount for that item id 
	set @max_bid_amount = (select max(bid_amount) from vb_bids where bid_item_id=@bid_item_id and bid_status='ok') 
	
	-- TODO: 5.5.2 set @item_seller_user_id to the seller_user_id for the item id
	set @item_seller_user_id = (select item_seller_user_id from vb_items where item_id=@bid_item_id) 

	-- TODO: 5.5.3 if no bids then set the @max_bid_amount to the item_reserve amount for the item_id
	if (@max_bid_amount is null) 
		set @max_bid_amount = (select item_reserve from vb_items where item_id=@bid_item_id) 
	
	-- if you're the item seller, set bid status
	if ( @item_seller_user_id = @bid_user_id)
		set @bid_status = 'item_seller'
	
	-- if the current bid lower or equal to the last bid, set bid status
	if ( @bid_amount <= @max_bid_amount)
		set @bid_status = 'low_bid'
		
	-- TODO: 5.5.4 insert the bid at this point and return the bid_id 		
	insert into vb_bids (bid_user_id, bid_item_id, bid_amount, bid_status)
		values (@bid_user_id, @bid_item_id, @bid_amount, @bid_status)
	return  @@identity 
	-- 
end
GO

-- 5.6 EXECUTE PROCDURE : dbo.p_place_bid (or do the INSERTS manually for some credit)
exec dbo.p_place_bid 1, 2, 16
exec dbo.p_place_bid 1, 3, 16.5
exec dbo.p_place_bid 1, 2, 16.5
exec dbo.p_place_bid 1, 2, 17
exec dbo.p_place_bid 1, 1, 20
exec dbo.p_place_bid 1, 5, 22.5

exec dbo.p_place_bid 2, 10, 30
exec dbo.p_place_bid 2, 5, 35
exec dbo.p_place_bid 2, 11, 40

exec dbo.p_place_bid 3, 8, 26

exec dbo.p_place_bid 5, 8, 5.01

exec dbo.p_place_bid 6, 23, 200
exec dbo.p_place_bid 6, 17, 500
exec dbo.p_place_bid 6, 21, 201 
exec dbo.p_place_bid 6, 17, 500
exec dbo.p_place_bid 6, 23, 202

exec dbo.p_place_bid 7, 15, 13
exec dbo.p_place_bid 7, 11, 14
exec dbo.p_place_bid 7, 15, 14.50

exec dbo.p_place_bid 8, 8, 250

exec dbo.p_place_bid 11, 23, 150
exec dbo.p_place_bid 11, 11, 100
exec dbo.p_place_bid 11, 24, 175
exec dbo.p_place_bid 11, 25, 200
exec dbo.p_place_bid 11, 6, 225
exec dbo.p_place_bid 11, 7, 250
exec dbo.p_place_bid 11, 23, 275
exec dbo.p_place_bid 11, 25, 300
exec dbo.p_place_bid 11, 7, 325

exec dbo.p_place_bid 13, 2, 9.01
exec dbo.p_place_bid 13, 13, 9.02

exec dbo.p_place_bid 14, 12, 1000

exec dbo.p_place_bid 15, 12, 505
exec dbo.p_place_bid 15, 13, 510
exec dbo.p_place_bid 15, 12, 515

exec dbo.p_place_bid 16, 16, 10
exec dbo.p_place_bid 16, 17, 11

exec dbo.p_place_bid 18, 12, 251
exec dbo.p_place_bid 18, 3, 251
exec dbo.p_place_bid 18, 3, 252
exec dbo.p_place_bid 18, 12, 253
exec dbo.p_place_bid 18, 3, 254
exec dbo.p_place_bid 18, 12, 255

exec dbo.p_place_bid 19, 24, 11

exec dbo.p_place_bid 22, 16, 5

exec dbo.p_place_bid 23, 19, 101
exec dbo.p_place_bid 23, 20, 102
exec dbo.p_place_bid 23, 21, 103
exec dbo.p_place_bid 23, 19, 104
exec dbo.p_place_bid 23, 20, 105
exec dbo.p_place_bid 23, 21, 106

exec dbo.p_place_bid 24, 16, 600
exec dbo.p_place_bid 24, 17, 601

exec dbo.p_place_bid 26, 9, 205

exec dbo.p_place_bid 29, 9, 46
exec dbo.p_place_bid 29, 20, 47

exec dbo.p_place_bid 31, 24, 11

exec dbo.p_place_bid 32, 4, 13
exec dbo.p_place_bid 32, 7, 14
exec dbo.p_place_bid 32, 4, 15
exec dbo.p_place_bid 32, 7, 16
exec dbo.p_place_bid 32, 4, 17
exec dbo.p_place_bid 32, 7, 18
exec dbo.p_place_bid 32, 4, 19
exec dbo.p_place_bid 32, 7, 20
exec dbo.p_place_bid 32, 4, 21
exec dbo.p_place_bid 32, 7, 22

exec dbo.p_place_bid 33, 6, 70

exec dbo.p_place_bid 34, 24, 11

exec dbo.p_place_bid 36, 1, 80
exec dbo.p_place_bid 36, 2, 85
exec dbo.p_place_bid 36, 1, 90
exec dbo.p_place_bid 36, 2, 95
exec dbo.p_place_bid 36, 1, 95
exec dbo.p_place_bid 36, 1, 100
GO

-- 5.7 CREATE PROCEDURE: dbo.p_close_auction_item
if exists(select name from sys.objects where name='p_close_auction_item') drop procedure p_close_auction_item
GO
create procedure dbo.p_close_auction_item
(
	@item_id int
)
as
begin
	declare @max_bid_amount money
	declare @max_bid_user_id int
	
	-- TODO: 5.7.1 set @max_bid_amount to the higest bid amount for that item id
	set @max_bid_amount = (select max(bid_amount) from vb_bids where bid_item_id=@item_id and bid_status='ok') 
	
	-- TODO: 5.7.2 set @max_bid_user_id to the highest buyer user_id for that item
	set @max_bid_user_id = (select bid_user_id from vb_bids 
			where bid_item_id=@item_id and bid_amount=@max_bid_amount and bid_status='ok')

	-- if highest bid is null, then there are no bids
	if (@max_bid_amount is null) 
	begin
		return 0
	end 
	else
	begin
		-- TODO: 5.7.3 update the item_information, return the item_id	
		update vb_items set
			item_sold = 1,
			item_soldamount = @max_bid_amount,
			item_buyer_user_id = @max_bid_user_id,
			item_enddate = getdate()
		where item_id = @item_id
		return @item_id
	end 
	-- 
end
GO

-- 5.8 EXECUTE PROCEDURE: dbo.p_close_auction_item (or do the updates manually for some credit)
exec dbo.p_close_auction_item 1
exec dbo.p_close_auction_item 2
exec dbo.p_close_auction_item 3
exec dbo.p_close_auction_item 16
exec dbo.p_close_auction_item 22
exec dbo.p_close_auction_item 31
exec dbo.p_close_auction_item 36
GO

-- 5.9 CREATE PROCEDURE: dbo.p_delete_item
if exists(select name from sys.objects where name='p_delete_item') drop procedure p_delete_item
GO
create procedure dbo.p_delete_item
(
	@item_id int
)
as
begin	
	-- TODO: 5.9.1 delete all of the item's bids
	delete from vb_bids where bid_item_id =@item_id
	
	-- TODO: 5.9.2 delete the item
	delete from vb_items where item_id =@item_id

end
GO

-- 5.10 EXECUTE PROCEDURE: dbo.p_delete_item (or do the updates manually for some credit)
exec dbo.p_delete_item 29 
exec dbo.p_delete_item 37 
exec dbo.p_delete_item 31 


