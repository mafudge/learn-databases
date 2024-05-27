use cheepwebhosting
GO

create table cheep_web_hosting
(
    id int identity primary key not null,
    account_name varchar(50) not null,
    account_exp datetime not null, 
    account_domains varchar(max) not null,
    account_plan varchar(10) not null,
    plan_monthly_fee money not null,
    plan_bandwidth_in_gb decimal(10,2) not null,
    plan_disk_in_gb decimal(10,2) not null,
    hosted_server_name varchar(20) not null,
    hosted_server_operating_system varchar(20) not null,
    hosted_server_ip_address varchar(16) not null,
    customer_email varchar(100) not null,
    customer_name varchar(100) not null,
    customer_credit_card varchar(100) not null
)
GO

GO
SET IDENTITY_INSERT [dbo].[cheep_web_hosting] ON 

USE [cheepwebhosting]
GO

INSERT INTO [dbo].[cheep_web_hosting]
           ([id]
           ,[account_name]
           ,[account_exp]
           ,[account_domains]
           ,[account_plan]
           ,[plan_monthly_fee]
           ,[plan_bandwidth_in_gb]
           ,[plan_disk_in_gb]
           ,[hosted_server_name]
           ,[hosted_server_operating_system]
           ,[hosted_server_ip_address]
           ,[customer_email]
           ,[customer_name]
           ,[customer_credit_card])
SELECT 1, 'bbird1', '1/1/2025', 'bigbirdfanclub.com bigbirdfanclub.org bigbirdfanclub.net', 'basic', 9.95, 1, 1,'bilbo', '10.128.232.41', 'Windows', 'bbird@coldmail.com', 'Big Bird', 'VISA 4492009044386680' UNION ALL
SELECT 2, 'bbird2', '6/1/2026', 'bigbird.com bigbird.org', 'standard', 14.95, 10, 10,'frodo', '10.128.232.42', 'Linux', 'bbird@coldmail.com', 'big  bird', 'VISA 4492009044386680' UNION ALL
SELECT 3, 'wwoodpkr', '6/1/2025', 'hahahahaha.com', 'premium', 19.95, 10, 100,'frodo', '10.128.232.42', 'Linux', 'wwood@geemail.com', 'Woody Woodpecker', 'MC 5692209046386280' UNION ALL
SELECT 4, 'fleghorn', '6/1/2024', 'isaythatis.com i-say-that-is.com', 'Premium', 19.95, 10, 100,'fordo', '10.128.232.42', 'Linux', 'foghorn@geemail.com', 'Foghorn Leghorn', 'MC 5692909046996280' UNION ALL
SELECT 5, 'tsaml', '1/1/2025', 'followyournose.com followyournose.org', 'basic', 9.95, 1, 1,'blibo', '10.128.232.41', 'Windows', 'tsam@coldmal.com', 'Toucan Sam', 'VISA 4002009044380000' UNION ALL
SELECT 6, 'tsam2', '1/1/2026', 'toucansam.com toucansam.org', 'premium', 19.95, 10, 100,'bilbo', '10.128.232.41', 'windows', 'tsam@coldmal.com', 'Toucan Sam', 'VISA 4002009044380000' UNION ALL
SELECT 7, 'twbird', '1/1/2025', 'tweety.com', 'BASIC', 9.95, 1, 1,'bilbo', '10.128.232.41', 'Windows', 'tweety@coldmail.com', 'Tweety Bird', 'MC 56609090466696200' UNION ALL
SELECT 8, 'dduckl', '6/1/2026', 'daffyduck.com', 'premium', 19.95, 10, 100,'frodo', '10.128.232.42', 'Linux', 'dduck@coldmail.com', 'Daffy Duck', 'DISC 6092209046385500' UNION ALL
SELECT 9, 'dduck2', '1/1/2027', 'bugsbunnysucks.com daffyduck.org', 'Basic', 9.95, 1, 1,'bilbo', '10.128.232.41', 'Windows', 'dduck@coldmail.com', 'Daffy duck', 'DISC 6092209046385500' UNION ALL
SELECT 10, 'sbird', '1/1/2026', 'sonny.com cukoforcocoapuffs.com sonnygoescuko.com', 'premium', 19.95, 10, 100,'bilbo', '10.128.232.41', 'Windows', 'sonny@geemail.com', 'Sonny Bird', 'MC 56601230464566200' 

SET IDENTITY_INSERT [dbo].[cheep_web_hosting] OFF


