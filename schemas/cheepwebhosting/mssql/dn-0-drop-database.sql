USE [master]
GO
if exists (select name from sys.databases where name='cheepwebhosting')
    ALTER DATABASE cheepwebhosting SET SINGLE_USER WITH ROLLBACK IMMEDIATE
GO
drop database if exists cheepwebhosting;
