alter table test SET (SYSTEM_VERSIONING=OFF) 
drop table if exists test
drop table if exists test_history

CREATE TABLE test
(
    id INT NOT NULL PRIMARY KEY CLUSTERED
  , data VARCHAR(50) NOT NULL
  , valid_from DATETIME2 GENERATED ALWAYS AS ROW START NOT NULL
  , valid_to DATETIME2 GENERATED ALWAYS AS ROW END NOT NULL
  , PERIOD FOR SYSTEM_TIME (valid_from, valid_to)
)
WITH (SYSTEM_VERSIONING = ON (HISTORY_TABLE = dbo.test_history));

go
insert into test (id,data) values (1,'mike')
insert into test (id,data) values (2,'dave')

update test set data='mikee' where id=1

select * from test
select * from test_history


/** retro add script **/
-- turn off temporal table
alter table test SET (SYSTEM_VERSIONING=OFF); 
alter table test DROP PERIOD FOR SYSTEM_TIME

-- procedure
drop procedure if exists p_add_or_update_test
go
create procedure p_add_or_update_test
(
    @id int,
    @data varchar(50),
    @date datetime2
)
as begin 
    if not exists(select id from test where id=@id) begin
        insert into test (id,data, valid_from, valid_to)
        values(@id, @data, @date, '9999-12-31 23:59:59.9999999')
    end
    else begin 
        insert into test_history (id,data, valid_from, valid_to)
            select id,data, valid_from, @date from test
                where id = @id;
        update test set 
            data = @data,
            valid_from = @date
            where id=@id;
    end
end
GO

--Example of manual updates
exec p_add_or_update_test @id=1, @data = 'mike', @date='2020-03-01'
exec p_add_or_update_test @id=2, @data = 'dave', @date='2020-03-01'
exec p_add_or_update_test @id=1, @data = 'mikey', @date='2020-03-02'
exec p_add_or_update_test @id=3, @data = 'bob', @date='2020-03-06'
exec p_add_or_update_test @id=2, @data = 'david', @date='2020-03-10'

-- turn on temporal
alter table test add PERIOD FOR SYSTEM_TIME (valid_from, valid_to);
alter table test SET (SYSTEM_VERSIONING=ON (HISTORY_TABLE=dbo.test_history));

-- done.


select * from test for SYSTEM_TIME AS OF '2020-03-02'
select * from test_history
select * from test;


insert into test (id,data) values (1,'mike')
insert into test (id,data) values (2,'dave')

update test set data='mikee' where id=1

select * from test
select * from test_history
