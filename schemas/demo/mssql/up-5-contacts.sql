use demo
GO

drop table if exists contacts
go

CREATE TABLE contacts (
	[contact_id] [int]  identity NOT NULL,
	[contact_name] [varchar](50) NOT NULL,
	[home_phone] [varchar](20) NULL,
	[mobile_phone] [varchar](20) NULL,
	[work_phone] [varchar](20) NULL,
	[other_phone] [varchar](20) NULL,
 CONSTRAINT [pk_contacts_contact_id] PRIMARY KEY ([contact_id] ),
 CONSTRAINT [ck_one_phone_not_null] check (not (home_phone is null and mobile_phone is null and work_phone is null and other_phone is null) )
)
GO
insert into contacts (contact_name, home_phone, mobile_phone,work_phone,other_phone)
values
('Cesar Salad', '415-555-0092', NULL, NULL, '415-555-1294'),
('Crystal Ball', NULL, '315-555-4450', '315-555-8882', NULL),
('Maddie Furr', NULL, NULL, '415-555-4534', NULL),
('Sherry Whyne', '315-555-5059', '415-555-3033', '315-555-6419', NULL)

