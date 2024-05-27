USE [master]
GO
if exists (select name from sys.databases where name='tinyu')
    ALTER DATABASE tinyu SET SINGLE_USER WITH ROLLBACK IMMEDIATE
GO

drop database if exists tinyu;