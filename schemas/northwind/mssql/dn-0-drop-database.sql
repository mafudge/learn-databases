USE [master]
GO
if exists (select name from sys.databases where name='northwind')
    ALTER DATABASE northwind SET SINGLE_USER WITH ROLLBACK IMMEDIATE
GO
drop database if exists northwind;
