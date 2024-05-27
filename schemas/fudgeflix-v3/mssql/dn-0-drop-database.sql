USE [master]
GO
if exists (select name from sys.databases where name='fudgeflix_v3')
    ALTER DATABASE fudgeflix_v3 SET SINGLE_USER WITH ROLLBACK IMMEDIATE
GO
drop database if exists fudgeflix_v3;
