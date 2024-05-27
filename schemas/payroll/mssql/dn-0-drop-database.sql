USE [master]
GO
if exists (select name from sys.databases where name='payroll')
    ALTER DATABASE  payroll SET SINGLE_USER WITH ROLLBACK IMMEDIATE
GO
drop database if exists payroll;
