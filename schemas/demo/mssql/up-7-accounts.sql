USE [demo]
GO

if exists(select * from sys.objects where name='accounts')
    DROP TABLE [dbo].[accounts]
GO 

CREATE TABLE [dbo].[accounts](
[account] [varchar](50) NOT NULL,
[balance] [money] NOT NULL,
[locked] bit default(0) NOT NULL,
CONSTRAINT [CK_account_balance_not_less_than_zero]  CHECK ([balance] >=0),
CONSTRAINT [PK_accounts] PRIMARY KEY  ([account])
)
GO

-- Starting balances
insert into accounts values ('checking', 500,0)
insert into accounts values ('savings', 1000,0)
insert into accounts values ('money-market', 5000,0)

go