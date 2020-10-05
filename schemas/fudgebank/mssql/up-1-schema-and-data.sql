use fudgebank
go

if exists(select * from INFORMATION_SCHEMA.TABLE_CONSTRAINTS where CONSTRAINT_NAME = 'fk_accounts_account_type')
	alter table accounts drop fk_accounts_account_type

drop table if exists accounts
drop table if exists account_types 

GO 
create table account_types (
	account_type varchar(50) not null,
	constraint pk_account_types_account_type primary key (account_type)
)
CREATE TABLE accounts(
	account_id int IDENTITY not null,
	account_num int not null,
	account_type [varchar](50) NOT NULL,
	balance [money] NOT NULL,
	CONSTRAINT ck_accounts_balance_not_less_than_zero  CHECK (balance>=0),
	CONSTRAINT pk_accounts_account_id PRIMARY KEY  (account_id),
	constraint u_accounts_business_key UNIQUE (account_num, account_type)
)
alter table accounts add CONSTRAINT
	fk_accounts_account_type foreign key (account_type) references account_types (account_type)

GO

insert into account_types VALUES
	('Checking'),('Savings'), ('Money-Market')

-- Starting balances
insert into accounts values (101, 'Checking', 500)
insert into accounts values (101, 'Savings', 1000)

select * from accounts


/*   
Turn ON system versioning in Employee table in two steps   
(1) add new period columns (HIDDEN)   
(2) create default history table   
*/ 
ALTER TABLE accounts   
ADD   
    valid_from datetime2 (2)  GENERATED ALWAYS AS ROW START     
        constraint df_valid_from DEFAULT DATEADD(second, -1, SYSUTCDATETIME())  
    , valid_to datetime2 (2)  GENERATED ALWAYS AS ROW END 
        constraint df_valid_to DEFAULT '9999.12.31 23:59:59.99'  
    , PERIOD FOR SYSTEM_TIME (valid_from, valid_to);   
go

ALTER TABLE accounts   
    SET (SYSTEM_VERSIONING = ON (HISTORY_TABLE = dbo.accounts_history)); 
go

select  * from accounts
select * from accounts_history

update 

-- execute some transfers, pause a few seconds between each
exec dbo.p_transfer_money 'checking','savings', 100
WAITFOR DELAY '00:00:05'
exec dbo.p_transfer_money 'checking','savings', 100
WAITFOR DELAY '00:00:05'
exec dbo.p_transfer_money 'savings','checking', 200
WAITFOR DELAY '00:00:05'
exec dbo.p_transfer_money 'checking','savings', 300
WAITFOR DELAY '00:00:05'
update accounts set locked = 0 where account = 'money-market'
exec dbo.p_transfer_money 'money-market','checking', 1000
WAITFOR DELAY '00:00:05'
exec dbo.p_transfer_money 'money-market','savings', 1500
WAITFOR DELAY '00:00:05'


select  * from accounts
select * from accounts_history



