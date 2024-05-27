-- Fudgemart Business Apps
-- Vacation Request
-- Accident Reporting 

if exists(select * from sys.objects where name='v_fudgemart_employee_list')
	drop view v_fudgemart_employee_list
if exists(select * from sys.objects where name='v_fudgemart_manager_list')
	drop view v_fudgemart_manager_list
if exists(select * from sys.objects where name='fudgemart_vacation_requests')
	drop table fudgemart_vacation_requests
if exists(select * from sys.objects where name='fudgemart_workplace_accidents')
	drop table fudgemart_workplace_accidents
if exists(select * from sys.objects where name='fudgemart_employees')
	drop table fudgemart_employees
if exists(select * from sys.objects where name='fudgemart_departments_lookup')
	drop table fudgemart_departments_lookup
GO


CREATE TABLE [dbo].[fudgemart_departments_lookup](
	[department_id] [varchar](20) NOT NULL,
 CONSTRAINT [PK_fudgemart_departments_lookup_department_id] PRIMARY KEY ([department_id])
 )


CREATE TABLE [dbo].[fudgemart_employees](
	[employee_id] [int] NOT NULL,
	[employee_ssn] [char](9) NOT NULL,
	[employee_lastname] [varchar](50) NOT NULL,
	[employee_firstname] [varchar](50) NOT NULL,
	[employee_jobtitle] [varchar](20) NOT NULL,
	[employee_department] [varchar](20) NOT NULL,
	[employee_birthdate] [datetime] NOT NULL,
	[employee_hiredate] [datetime] NOT NULL,
	[employee_termdate] [datetime] NULL,
	[employee_hourlywage] [money] NOT NULL,
	[employee_fulltime] [bit] NOT NULL,
	[employee_supervisor_id] [int] NULL,
 CONSTRAINT [PK_fudgemart_employees_employee_id] PRIMARY KEY ([employee_id] ),
 constraint [fk_fudgemart_employees_employee_department] FOREIGN KEY (employee_department) REFERENCES fudgemart_departments_lookup(department_id)
 )

create table fudgemart_workplace_accidents
(
	accident_id int identity not null,
	accident_reported_by_employee_id int not null,
	accident_department varchar(20) not null,
	accident_date date not null,
	accident_osha_contacted bit default(0) not null,
	accident_acknowledged_by_store_mgr_employee_id int null,
    accident_acknowledged_date date null,
	accident_description varchar(max) not null,
	constraint pk_fudgemart_workplace_accidents_accident_id 
		primary key(accident_id),
	constraint fk_fudgemart_workplace_accidents_accident_reported_by_employee_id
		foreign key (accident_reported_by_employee_id) references fudgemart_employees(employee_id),
	constraint fk_fudgemart_workplace_accidents_accident_acknowledged_by_store_mgr_employee_id
		foreign key (accident_acknowledged_by_store_mgr_employee_id) references fudgemart_employees(employee_id),
	constraint fk_fudgemart_workplace_accidents_accident_department
		foreign key (accident_department) references fudgemart_departments_lookup(department_id)
)
go
create table fudgemart_vacation_requests
(
	request_id int identity not null,
	request_name varchar(50) not null,
	request_employee_id int not null,
	request_start_date datetime default (getdate()) not null,
	request_number_of_days int default(1) not null,
	request_approved_employee_id int null,
	request_approved_date datetime null,
	constraint pk_fudgemart_vacation_requests_request_id primary key (request_id),
	constraint fk_fudgemart_vacation_requests_request_employee_id 
		foreign key (request_employee_id) references fudgemart_employees(employee_id),
	constraint fk_fudgemart_vacation_requests_request_approved_employee_id
			foreign key (request_approved_employee_id) references fudgemart_employees(employee_id)
)
go
create view v_fudgemart_employee_list as
	select employee_id, employee_firstname + ' ' + employee_lastname as employee_name
		from fudgemart_employees
go
create view v_fudgemart_manager_list as
	select distinct e.* from v_fudgemart_employee_list e join fudgemart_employees m on e.employee_id = m.employee_supervisor_id 
go

INSERT [dbo].[fudgemart_departments_lookup] ([department_id]) VALUES (N'Clothing')
INSERT [dbo].[fudgemart_departments_lookup] ([department_id]) VALUES (N'Customer Service')
INSERT [dbo].[fudgemart_departments_lookup] ([department_id]) VALUES (N'Electronics')
INSERT [dbo].[fudgemart_departments_lookup] ([department_id]) VALUES (N'Hardware')
INSERT [dbo].[fudgemart_departments_lookup] ([department_id]) VALUES (N'Housewares')
INSERT [dbo].[fudgemart_departments_lookup] ([department_id]) VALUES (N'Sporting Goods')
GO

INSERT [dbo].[fudgemart_employees] ([employee_id], [employee_ssn], [employee_lastname], [employee_firstname], [employee_jobtitle], [employee_department], [employee_birthdate], [employee_hiredate], [employee_termdate], [employee_hourlywage], [employee_fulltime], [employee_supervisor_id]) VALUES (1, N'111220001', N'Photo', N'Arial', N'Sales Associate', N'Electronics', CAST(N'1982-01-12T00:00:00.000' AS DateTime), CAST(N'2011-07-05T00:00:00.000' AS DateTime), NULL, 15.2830, 0, 5)
INSERT [dbo].[fudgemart_employees] ([employee_id], [employee_ssn], [employee_lastname], [employee_firstname], [employee_jobtitle], [employee_department], [employee_birthdate], [employee_hiredate], [employee_termdate], [employee_hourlywage], [employee_fulltime], [employee_supervisor_id]) VALUES (2, N'111220002', N'Ladd', N'Sal', N'Sales Associate', N'Electronics', CAST(N'1982-11-30T00:00:00.000' AS DateTime), CAST(N'2005-07-26T00:00:00.000' AS DateTime), NULL, 15.0699, 1, 5)
INSERT [dbo].[fudgemart_employees] ([employee_id], [employee_ssn], [employee_lastname], [employee_firstname], [employee_jobtitle], [employee_department], [employee_birthdate], [employee_hiredate], [employee_termdate], [employee_hourlywage], [employee_fulltime], [employee_supervisor_id]) VALUES (3, N'111220003', N'Dawind', N'Dustin', N'Sales Associate', N'Hardware', CAST(N'1972-09-03T00:00:00.000' AS DateTime), CAST(N'2004-07-02T00:00:00.000' AS DateTime), CAST(N'2010-11-06T00:00:00.000' AS DateTime), 12.4500, 0, 6)
INSERT [dbo].[fudgemart_employees] ([employee_id], [employee_ssn], [employee_lastname], [employee_firstname], [employee_jobtitle], [employee_department], [employee_birthdate], [employee_hiredate], [employee_termdate], [employee_hourlywage], [employee_fulltime], [employee_supervisor_id]) VALUES (4, N'111220004', N'Shores', N'Sandi', N'Sales Associate', N'Hardware', CAST(N'1990-05-13T00:00:00.000' AS DateTime), CAST(N'2011-01-02T00:00:00.000' AS DateTime), NULL, 13.0997, 1, 6)
INSERT [dbo].[fudgemart_employees] ([employee_id], [employee_ssn], [employee_lastname], [employee_firstname], [employee_jobtitle], [employee_department], [employee_birthdate], [employee_hiredate], [employee_termdate], [employee_hourlywage], [employee_fulltime], [employee_supervisor_id]) VALUES (5, N'111220005', N'Gunnering', N'Isabelle', N'Department Manager', N'Electronics', CAST(N'1974-02-22T00:00:00.000' AS DateTime), CAST(N'2005-08-16T00:00:00.000' AS DateTime), NULL, 20.1287, 1, 32)
INSERT [dbo].[fudgemart_employees] ([employee_id], [employee_ssn], [employee_lastname], [employee_firstname], [employee_jobtitle], [employee_department], [employee_birthdate], [employee_hiredate], [employee_termdate], [employee_hourlywage], [employee_fulltime], [employee_supervisor_id]) VALUES (6, N'111220006', N'Hvmeehom', N'Lee', N'Department Manager', N'Hardware', CAST(N'1973-07-29T00:00:00.000' AS DateTime), CAST(N'2004-01-26T00:00:00.000' AS DateTime), NULL, 18.5845, 1, 32)
INSERT [dbo].[fudgemart_employees] ([employee_id], [employee_ssn], [employee_lastname], [employee_firstname], [employee_jobtitle], [employee_department], [employee_birthdate], [employee_hiredate], [employee_termdate], [employee_hourlywage], [employee_fulltime], [employee_supervisor_id]) VALUES (7, N'111220007', N'Wrench', N'Allan', N'Sales Associate', N'Housewares', CAST(N'1988-04-03T00:00:00.000' AS DateTime), CAST(N'2005-02-22T00:00:00.000' AS DateTime), NULL, 12.0878, 1, 24)
INSERT [dbo].[fudgemart_employees] ([employee_id], [employee_ssn], [employee_lastname], [employee_firstname], [employee_jobtitle], [employee_department], [employee_birthdate], [employee_hiredate], [employee_termdate], [employee_hourlywage], [employee_fulltime], [employee_supervisor_id]) VALUES (8, N'111220008', N'Gator', N'Ally', N'Sales Associate', N'Sporting Goods', CAST(N'1973-12-13T00:00:00.000' AS DateTime), CAST(N'2005-08-14T00:00:00.000' AS DateTime), NULL, 12.3541, 1, 27)
INSERT [dbo].[fudgemart_employees] ([employee_id], [employee_ssn], [employee_lastname], [employee_firstname], [employee_jobtitle], [employee_department], [employee_birthdate], [employee_hiredate], [employee_termdate], [employee_hourlywage], [employee_fulltime], [employee_supervisor_id]) VALUES (9, N'111220009', N'Frienzergon', N'Alma', N'Sales Associate', N'Housewares', CAST(N'1980-11-30T00:00:00.000' AS DateTime), CAST(N'2004-11-12T00:00:00.000' AS DateTime), NULL, 11.7152, 1, 24)
INSERT [dbo].[fudgemart_employees] ([employee_id], [employee_ssn], [employee_lastname], [employee_firstname], [employee_jobtitle], [employee_department], [employee_birthdate], [employee_hiredate], [employee_termdate], [employee_hourlywage], [employee_fulltime], [employee_supervisor_id]) VALUES (10, N'111220010', N'Choke', N'Artie', N'Sales Associate', N'Hardware', CAST(N'1976-10-02T00:00:00.000' AS DateTime), CAST(N'2005-04-04T00:00:00.000' AS DateTime), NULL, 12.7269, 1, 6)
INSERT [dbo].[fudgemart_employees] ([employee_id], [employee_ssn], [employee_lastname], [employee_firstname], [employee_jobtitle], [employee_department], [employee_birthdate], [employee_hiredate], [employee_termdate], [employee_hourlywage], [employee_fulltime], [employee_supervisor_id]) VALUES (11, N'111220011', N'Alott', N'Bette', N'Sales Associate', N'Sporting Goods', CAST(N'1988-03-23T00:00:00.000' AS DateTime), CAST(N'2005-05-06T00:00:00.000' AS DateTime), NULL, 11.5021, 0, 27)
INSERT [dbo].[fudgemart_employees] ([employee_id], [employee_ssn], [employee_lastname], [employee_firstname], [employee_jobtitle], [employee_department], [employee_birthdate], [employee_hiredate], [employee_termdate], [employee_hourlywage], [employee_fulltime], [employee_supervisor_id]) VALUES (12, N'111220012', N'Melator', N'Bill', N'Sales Associate', N'Sporting Goods', CAST(N'1991-01-29T00:00:00.000' AS DateTime), CAST(N'2004-10-29T00:00:00.000' AS DateTime), CAST(N'2011-01-11T00:00:00.000' AS DateTime), 10.3571, 1, 27)
INSERT [dbo].[fudgemart_employees] ([employee_id], [employee_ssn], [employee_lastname], [employee_firstname], [employee_jobtitle], [employee_department], [employee_birthdate], [employee_hiredate], [employee_termdate], [employee_hourlywage], [employee_fulltime], [employee_supervisor_id]) VALUES (13, N'111220013', N'Enweave', N'Bob', N'Sales Associate', N'Sporting Goods', CAST(N'1987-11-01T00:00:00.000' AS DateTime), CAST(N'2011-09-01T00:00:00.000' AS DateTime), NULL, 12.4899, 1, 27)
INSERT [dbo].[fudgemart_employees] ([employee_id], [employee_ssn], [employee_lastname], [employee_firstname], [employee_jobtitle], [employee_department], [employee_birthdate], [employee_hiredate], [employee_termdate], [employee_hourlywage], [employee_fulltime], [employee_supervisor_id]) VALUES (14, N'111220014', N'Nugget', N'Chris P.', N'Sales Associate', N'Electronics', CAST(N'1984-05-05T00:00:00.000' AS DateTime), CAST(N'2004-07-27T00:00:00.000' AS DateTime), NULL, 15.7089, 1, 5)
INSERT [dbo].[fudgemart_employees] ([employee_id], [employee_ssn], [employee_lastname], [employee_firstname], [employee_jobtitle], [employee_department], [employee_birthdate], [employee_hiredate], [employee_termdate], [employee_hourlywage], [employee_fulltime], [employee_supervisor_id]) VALUES (15, N'111220015', N'Itupp', N'Chuck', N'Sales Associate', N'Sporting Goods', CAST(N'1991-01-29T00:00:00.000' AS DateTime), CAST(N'2005-02-23T00:00:00.000' AS DateTime), NULL, 11.2359, 0, 27)
INSERT [dbo].[fudgemart_employees] ([employee_id], [employee_ssn], [employee_lastname], [employee_firstname], [employee_jobtitle], [employee_department], [employee_birthdate], [employee_hiredate], [employee_termdate], [employee_hourlywage], [employee_fulltime], [employee_supervisor_id]) VALUES (16, N'111220016', N'Erin', N'Detyers', N'Sales Associate', N'Hardware', CAST(N'1990-04-14T00:00:00.000' AS DateTime), CAST(N'2005-05-01T00:00:00.000' AS DateTime), NULL, 13.4724, 1, 6)
INSERT [dbo].[fudgemart_employees] ([employee_id], [employee_ssn], [employee_lastname], [employee_firstname], [employee_jobtitle], [employee_department], [employee_birthdate], [employee_hiredate], [employee_termdate], [employee_hourlywage], [employee_fulltime], [employee_supervisor_id]) VALUES (17, N'111220017', N'Tan', N'Kurt', N'Sales Associate', N'Clothing', CAST(N'1985-09-17T00:00:00.000' AS DateTime), CAST(N'2004-09-04T00:00:00.000' AS DateTime), NULL, 9.8514, 0, 20)
INSERT [dbo].[fudgemart_employees] ([employee_id], [employee_ssn], [employee_lastname], [employee_firstname], [employee_jobtitle], [employee_department], [employee_birthdate], [employee_hiredate], [employee_termdate], [employee_hourlywage], [employee_fulltime], [employee_supervisor_id]) VALUES (18, N'111220018', N'Case', N'Justin', N'Sales Associate ', N'Clothing', CAST(N'1982-12-22T00:00:00.000' AS DateTime), CAST(N'2004-10-03T00:00:00.000' AS DateTime), NULL, 9.4786, 0, 20)
INSERT [dbo].[fudgemart_employees] ([employee_id], [employee_ssn], [employee_lastname], [employee_firstname], [employee_jobtitle], [employee_department], [employee_birthdate], [employee_hiredate], [employee_termdate], [employee_hourlywage], [employee_fulltime], [employee_supervisor_id]) VALUES (19, N'111220019', N'Belevit', N'Kent', N'Sales Associate', N'Clothing', CAST(N'1988-11-30T00:00:00.000' AS DateTime), CAST(N'2005-02-14T00:00:00.000' AS DateTime), NULL, 10.0644, 1, 20)
INSERT [dbo].[fudgemart_employees] ([employee_id], [employee_ssn], [employee_lastname], [employee_firstname], [employee_jobtitle], [employee_department], [employee_birthdate], [employee_hiredate], [employee_termdate], [employee_hourlywage], [employee_fulltime], [employee_supervisor_id]) VALUES (20, N'111220020', N'Mi', N'Mary', N'Department Manager', N'Clothing', CAST(N'1981-02-17T00:00:00.000' AS DateTime), CAST(N'2004-01-02T00:00:00.000' AS DateTime), NULL, 20.8210, 1, 32)
INSERT [dbo].[fudgemart_employees] ([employee_id], [employee_ssn], [employee_lastname], [employee_firstname], [employee_jobtitle], [employee_department], [employee_birthdate], [employee_hiredate], [employee_termdate], [employee_hourlywage], [employee_fulltime], [employee_supervisor_id]) VALUES (21, N'111220021', N'Mumm', N'Maxi', N'Sales Associate', N'Electronics', CAST(N'1989-04-24T00:00:00.000' AS DateTime), CAST(N'2004-01-29T00:00:00.000' AS DateTime), NULL, 14.2179, 1, 5)
INSERT [dbo].[fudgemart_employees] ([employee_id], [employee_ssn], [employee_lastname], [employee_firstname], [employee_jobtitle], [employee_department], [employee_birthdate], [employee_hiredate], [employee_termdate], [employee_hourlywage], [employee_fulltime], [employee_supervisor_id]) VALUES (22, N'111220022', N'Rophone', N'Mike', N'Sales Associate', N'Housewares', CAST(N'1988-03-23T00:00:00.000' AS DateTime), CAST(N'2005-06-20T00:00:00.000' AS DateTime), NULL, 11.7152, 0, 24)
INSERT [dbo].[fudgemart_employees] ([employee_id], [employee_ssn], [employee_lastname], [employee_firstname], [employee_jobtitle], [employee_department], [employee_birthdate], [employee_hiredate], [employee_termdate], [employee_hourlywage], [employee_fulltime], [employee_supervisor_id]) VALUES (23, N'111220023', N'Tural', N'Nat', N'Sales Associate', N'Sporting Goods', CAST(N'1990-06-02T00:00:00.000' AS DateTime), CAST(N'2010-09-20T00:00:00.000' AS DateTime), NULL, 12.0346, 0, 27)
INSERT [dbo].[fudgemart_employees] ([employee_id], [employee_ssn], [employee_lastname], [employee_firstname], [employee_jobtitle], [employee_department], [employee_birthdate], [employee_hiredate], [employee_termdate], [employee_hourlywage], [employee_fulltime], [employee_supervisor_id]) VALUES (24, N'111220024', N'Moni', N'Otto', N'Department Manager', N'Housewares', CAST(N'1983-03-13T00:00:00.000' AS DateTime), CAST(N'2005-04-09T00:00:00.000' AS DateTime), NULL, 18.6377, 1, 32)
INSERT [dbo].[fudgemart_employees] ([employee_id], [employee_ssn], [employee_lastname], [employee_firstname], [employee_jobtitle], [employee_department], [employee_birthdate], [employee_hiredate], [employee_termdate], [employee_hourlywage], [employee_fulltime], [employee_supervisor_id]) VALUES (25, N'111220025', N'O''Furniture', N'Patty', N'Sales Associate', N'Housewares', CAST(N'1987-06-25T00:00:00.000' AS DateTime), CAST(N'2005-12-08T00:00:00.000' AS DateTime), NULL, 11.6086, 1, 24)
INSERT [dbo].[fudgemart_employees] ([employee_id], [employee_ssn], [employee_lastname], [employee_firstname], [employee_jobtitle], [employee_department], [employee_birthdate], [employee_hiredate], [employee_termdate], [employee_hourlywage], [employee_fulltime], [employee_supervisor_id]) VALUES (26, N'111220026', N'Moss', N'Pete', N'Sales Associate', N'Sporting Goods', CAST(N'1987-07-07T00:00:00.000' AS DateTime), CAST(N'2004-05-10T00:00:00.000' AS DateTime), NULL, 10.6501, 0, 27)
INSERT [dbo].[fudgemart_employees] ([employee_id], [employee_ssn], [employee_lastname], [employee_firstname], [employee_jobtitle], [employee_department], [employee_birthdate], [employee_hiredate], [employee_termdate], [employee_hourlywage], [employee_fulltime], [employee_supervisor_id]) VALUES (27, N'111220027', N'Docktur-Indahaus', N'Sara', N'Department Manager', N'Sporting Goods', CAST(N'1983-10-10T00:00:00.000' AS DateTime), CAST(N'2004-06-02T00:00:00.000' AS DateTime), NULL, 20.4483, 1, 32)
INSERT [dbo].[fudgemart_employees] ([employee_id], [employee_ssn], [employee_lastname], [employee_firstname], [employee_jobtitle], [employee_department], [employee_birthdate], [employee_hiredate], [employee_termdate], [employee_hourlywage], [employee_fulltime], [employee_supervisor_id]) VALUES (28, N'111220028', N'Isnomor', N'Sara', N'Sales Associate', N'Clothing', CAST(N'1990-01-14T00:00:00.000' AS DateTime), CAST(N'2010-04-24T00:00:00.000' AS DateTime), NULL, 9.5851, 1, 20)
INSERT [dbo].[fudgemart_employees] ([employee_id], [employee_ssn], [employee_lastname], [employee_firstname], [employee_jobtitle], [employee_department], [employee_birthdate], [employee_hiredate], [employee_termdate], [employee_hourlywage], [employee_fulltime], [employee_supervisor_id]) VALUES (29, N'111220029', N'Ofewe', N'Seymour', N'Sales Associate', N'Customer Service', CAST(N'1985-03-30T00:00:00.000' AS DateTime), CAST(N'2005-05-25T00:00:00.000' AS DateTime), NULL, 14.3777, 1, 31)
INSERT [dbo].[fudgemart_employees] ([employee_id], [employee_ssn], [employee_lastname], [employee_firstname], [employee_jobtitle], [employee_department], [employee_birthdate], [employee_hiredate], [employee_termdate], [employee_hourlywage], [employee_fulltime], [employee_supervisor_id]) VALUES (30, N'111220030', N'Shores', N'Sonny', N'Sales Associate', N'Customer Service', CAST(N'1984-06-01T00:00:00.000' AS DateTime), CAST(N'2004-12-01T00:00:00.000' AS DateTime), NULL, 13.7919, 1, 31)
INSERT [dbo].[fudgemart_employees] ([employee_id], [employee_ssn], [employee_lastname], [employee_firstname], [employee_jobtitle], [employee_department], [employee_birthdate], [employee_hiredate], [employee_termdate], [employee_hourlywage], [employee_fulltime], [employee_supervisor_id]) VALUES (31, N'111220031', N'Itupp', N'Tally', N'Department Manager', N'Customer Service', CAST(N'1981-04-14T00:00:00.000' AS DateTime), CAST(N'2004-11-28T00:00:00.000' AS DateTime), NULL, 22.8977, 1, 32)
INSERT [dbo].[fudgemart_employees] ([employee_id], [employee_ssn], [employee_lastname], [employee_firstname], [employee_jobtitle], [employee_department], [employee_birthdate], [employee_hiredate], [employee_termdate], [employee_hourlywage], [employee_fulltime], [employee_supervisor_id]) VALUES (32, N'111220032', N'Androll', N'Tuck', N'Store Manager', N'Customer Service', CAST(N'1983-06-20T00:00:00.000' AS DateTime), CAST(N'2005-02-15T00:00:00.000' AS DateTime), NULL, 30.3529, 1, 33)
INSERT [dbo].[fudgemart_employees] ([employee_id], [employee_ssn], [employee_lastname], [employee_firstname], [employee_jobtitle], [employee_department], [employee_birthdate], [employee_hiredate], [employee_termdate], [employee_hourlywage], [employee_fulltime], [employee_supervisor_id]) VALUES (33, N'111220033', N'Fudge', N'Mike', N'CEO', N'Customer Service', CAST(N'1970-01-01T00:00:00.000' AS DateTime), CAST(N'2004-01-01T00:00:00.000' AS DateTime), NULL, 73.3261, 1, NULL)
GO