use demo
GO

if exists(SELECT temporal_type FROM sys.tables WHERE  object_id = OBJECT_ID('dbo.stocks', 'u') and temporal_type=2)
    ALTER TABLE stocks
        SET (SYSTEM_VERSIONING = OFF); 
drop table if exists stocks
drop table if exists stocks_history
GO

create table stocks 
(
    ticker varchar(10) not null,
    price money not null
    constraint pk_stocks_stock_ticker primary key (ticker)
)
GO

-- turn it into a temporal table
ALTER TABLE stocks
ADD   
    valid_from datetime2 (2)  GENERATED ALWAYS AS ROW START     
        constraint df_stocks_valid_from DEFAULT DATEADD(second, -1, SYSUTCDATETIME())  
    , valid_to datetime2 (2)  GENERATED ALWAYS AS ROW END 
        constraint df_stocks_valid_to DEFAULT '9999.12.31 23:59:59.99'  
    , PERIOD FOR SYSTEM_TIME (valid_from, valid_to);   
go

ALTER TABLE stocks
    SET (SYSTEM_VERSIONING = ON (HISTORY_TABLE = dbo.stocks_history)); 
go

-- turn OFF temporal table
alter table stocks SET (SYSTEM_VERSIONING=OFF); 
alter table stocks DROP PERIOD FOR SYSTEM_TIME
GO

-- procedure
drop procedure if exists p_add_or_update_stock
go
create procedure p_add_or_update_stock
(
    @ticker varchar(10),
    @price money,
    @date datetime2
)
as begin 
    if not exists(select ticker from stocks where ticker=@ticker) begin
        insert into stocks (ticker, price, valid_from, valid_to)
        values(@ticker, @price, @date, '9999-12-31 23:59:59.9999999')
    end
    else begin 
        insert into stocks_history (ticker, price, valid_from, valid_to)
            select ticker,price, valid_from, @date from stocks
                where ticker = @ticker;
        update stocks set 
            price = @price,
            valid_from = @date
            where ticker=@ticker;
    end
end
GO

--Example of manual updates
exec p_add_or_update_stock @ticker='AAPL', @price = 108, @date='2020-04-01'
exec p_add_or_update_stock @ticker='AMZN', @price = 2987, @date='2020-04-01'
exec p_add_or_update_stock @ticker='GOOGL', @price = 1467, @date='2020-04-01'
exec p_add_or_update_stock @ticker='MSFT', @price = 201, @date='2020-04-01'

exec p_add_or_update_stock @ticker='AAPL', @price = 112, @date='2020-04-02'
exec p_add_or_update_stock @ticker='AMZN', @price = 2980, @date='2020-04-02'
exec p_add_or_update_stock @ticker='GOOGL', @price = 1505, @date='2020-04-02'
exec p_add_or_update_stock @ticker='MSFT', @price = 211, @date='2020-04-02'

exec p_add_or_update_stock @ticker='AAPL', @price = 116, @date='2020-04-03'
exec p_add_or_update_stock @ticker='AMZN', @price = 2990, @date='2020-04-03'
exec p_add_or_update_stock @ticker='GOOGL', @price = 1570, @date='2020-04-03'
exec p_add_or_update_stock @ticker='MSFT', @price = 230, @date='2020-04-03'

exec p_add_or_update_stock @ticker='AAPL', @price = 122, @date='2020-04-04'
exec p_add_or_update_stock @ticker='AMZN', @price = 2950, @date='2020-04-04'
exec p_add_or_update_stock @ticker='GOOGL', @price = 1652, @date='2020-04-04'
exec p_add_or_update_stock @ticker='MSFT', @price = 235, @date='2020-04-04'

exec p_add_or_update_stock @ticker='AAPL', @price = 128, @date='2020-04-05'
exec p_add_or_update_stock @ticker='AMZN', @price = 3005, @date='2020-04-05'
exec p_add_or_update_stock @ticker='GOOGL', @price = 1520, @date='2020-04-05'
exec p_add_or_update_stock @ticker='MSFT', @price = 233, @date='2020-04-05'

exec p_add_or_update_stock @ticker='AAPL', @price = 130, @date='2020-04-06'
exec p_add_or_update_stock @ticker='AMZN', @price = 2957, @date='2020-04-06'
exec p_add_or_update_stock @ticker='GOOGL', @price = 1482, @date='2020-04-06'
exec p_add_or_update_stock @ticker='MSFT', @price = 228, @date='2020-04-06'

exec p_add_or_update_stock @ticker='AAPL', @price = 125, @date='2020-04-07'
exec p_add_or_update_stock @ticker='AMZN', @price = 2912, @date='2020-04-07'
exec p_add_or_update_stock @ticker='GOOGL', @price = 1425, @date='2020-04-07'
exec p_add_or_update_stock @ticker='MSFT', @price = 215, @date='2020-04-07'


-- turn ON temporal table
alter table stocks add PERIOD FOR SYSTEM_TIME (valid_from, valid_to);
alter table stocks SET (SYSTEM_VERSIONING=ON (HISTORY_TABLE=dbo.stocks_history));

-- done.
select * from stocks
select * from stocks_history 

--insert into stocks (ticker,price) values ('TEST', 123)
--update stocks_history set valid_from = '2022-01-01' where ticker = 'AAPL'