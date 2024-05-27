USE [master]
GO
if exists (select name from sys.databases where name='vbay')
    ALTER DATABASE  vbay SET SINGLE_USER WITH ROLLBACK IMMEDIATE
GO
drop database if exists vbay;
