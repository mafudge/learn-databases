use demo
GO
if exists(select * from INFORMATION_SCHEMA.TABLES where TABLE_NAME='games')
    ALTER TABLE games SET (SYSTEM_VERSIONING = OFF )
DROP TABLE IF EXISTS games_history    
DROP TABLE IF EXISTS games
go
CREATE TABLE games
(
    name varchar(50) primary key not null,
    price money not NULL
)
GO
ALTER TABLE games ADD   
    valid_from datetime2 (2)  GENERATED ALWAYS AS ROW START     
        constraint df_books_valid_from DEFAULT DATEADD(second, -1, SYSUTCDATETIME()),  
    valid_to datetime2 (2)  GENERATED ALWAYS AS ROW END 
        constraint df_books_valid_to DEFAULT '9999.12.31 23:59:59.99',  
    PERIOD FOR SYSTEM_TIME (valid_from, valid_to)   
go
 ALTER TABLE games SET (SYSTEM_VERSIONING = ON (HISTORY_TABLE = dbo.games_history)); 
GO

waitfor delay '00:01:00'
insert into games (name, price) values ('Monopoly',29.95 )
waitfor delay '00:01:00'
insert into games (name, price) values ('Catan',39.95 )
waitfor delay '00:01:00'
insert into games (name, price) values ('Ticket to Ride',34.95 )
waitfor delay '00:01:00'
insert into games (name, price) values ('Yam Slam',14.95 )
waitfor delay '00:01:00'
insert into games (name, price) values ('Word on the Street',24.95 )
waitfor delay '00:01:00'
update games set price = 19.95 where name = 'Monopoly'
waitfor delay '00:01:00'
update games set price = 39.95 where name = 'Ticket to Ride'
waitfor delay '00:01:00'
insert into games (name, price) values ('Rumikub', 33.95)
waitfor delay '00:01:00'
update games set price = 19.95 where name = 'Word on the Street'
waitfor delay '00:01:00'
insert into games (name, price) values ('Blokus', 22.95)
waitfor delay '00:01:00'
delete from games where name = 'Yam Slam'
waitfor delay '00:01:00'
update games set price = 14.95 where name = 'Monopoly'
waitfor delay '00:01:00'
-- now
select name, price from games 
select * from games_history


-- ALL
select * from games for SYSTEM_TIME ALL
    where name = 'Monopoly'


-- what did the table look like at 2021-03-09 14:50:00 ?
select * from games for system_time as of '2021-03-09 14:50:00'

-- same thing at 14:54
select * from games for system_time as of '2021-03-09 14:54:00'

-- what was in this table yesterday?
select * from games for system_time as of '2021-03-08 14:54:00'

-- what does this look like tomorrow?
select * from games for system_time as of '2021-03-10 14:54:00'

--- which is the same as today
select * from games

-- changes made in a 2 minute interval 
select * from games 
    for system_time from '2021-03-09 14:57:00' to '2021-03-09 14:59:00'

-- a little further back
select * from games 
    for system_time from '2021-03-09 14:54:00' to '2021-03-09 14:57:00'

