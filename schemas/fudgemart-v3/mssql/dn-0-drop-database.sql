USE [master]
GO
if exists (select name from sys.databases where name='fudgemart_v3')
    ALTER DATABASE fudgemart_v3 SET SINGLE_USER WITH ROLLBACK IMMEDIATE
GO
drop database if exists fudgemart_v3;
