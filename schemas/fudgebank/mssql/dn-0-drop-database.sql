USE [master]
GO
if exists (select name from sys.databases where name='fudgebank')
    ALTER DATABASE fudgebank SET SINGLE_USER WITH ROLLBACK IMMEDIATE
GO
drop database if exists fudgebank;
