USE [master]
GO
if exists (select name from sys.databases where name='demo')
    ALTER DATABASE demo SET SINGLE_USER WITH ROLLBACK IMMEDIATE
GO
drop database if exists demo;