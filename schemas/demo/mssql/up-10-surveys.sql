use demo
go
drop table if exists surveys
go
GO
CREATE TABLE [dbo].[surveys](
	[Email] [varchar](50) NOT NULL,
	[Twitter_Username] [varchar](50) NOT NULL,
	[Marital_Status] [varchar](50) NOT NULL,
	[Household_Income] [varchar](50) NULL,
	[Own_Home] [varchar](50) NULL,
	[Education] [varchar](50) NOT NULL,
	[Favorite_Department] [varchar](50) NOT NULL
) ON [PRIMARY]
GO

insert [surveys] ([Email],[Twitter_Username],[Marital_Status],[Household_Income],[Own_Home],[Education],[Favorite_Department])
select 'ojouglad@gustr.com','ojouglad','Married','65000','No','4 Year Degree','Electronics' UNION ALL
select 'lkarfurless@dayrep.com','lkarforless','Single','143000','Yes','Graduate Degree','Apparel' UNION ALL
select 'lhvmeehom@einrot.com','lhvmeehom','Prefer not to Answer','75000','Yes','4 Year Degree','Prefer not to Answer' UNION ALL
select 'sladd@superrito.com','sladd','Married','52000','Yes','2 Year Degree','None' UNION ALL
select 'vrhee@einrot.com','vrhee','Prefer not to Answer','17500','No','High School','Books' UNION ALL
select 'jpoole@dayrep.com','jpoole','Married','Prefer not to Answer','Yes','Some College','Books' UNION ALL
select 'bdehatchett@dayrep.com','bdehatchett','Prefer not to Answer','67000','Yes','4 Year Degree','Electronics' UNION ALL
select 'mrofone@dayrep.com','mrofone','Single','121000','Yes','Prefer not to Answer','Jewelry' UNION ALL
select 'tanott@rhyta.com','tanott','Single','26000','No','2 Year Degree','Digital Downloads' UNION ALL
select 'akuss@rhyta.com','akuss','Single','22500','No','High School','None' UNION ALL
select 'tpani@superrito.com','tpani','Prefer not to Answer','89000','Yes','Graduate Degree','Jewelry' UNION ALL
select 'rdeboat@dayrep.com','rdeboat','Single','69000','Yes','Graduate Degree','Electronics' UNION ALL
select 'mmelator@rhyta.com','mmelator','Prefer not to Answer','42000','No','4 Year Degree','Books' UNION ALL
select 'crha@einrot.com','crha','Married','34000','Prefer not to Answer','4 Year Degree','Books' UNION ALL
select 'bmelator@einrot.com','bmelator','Single','13000','No','2 Year Degree','Digital Downloads' UNION ALL
select 'ddelyons@dayrep.com','ddelyons','Single','105000','Yes','High School','Electronics' UNION ALL
select 'ccayne@rhyta.com','ccayne','Married','62000','Yes','4 Year Degree','None' UNION ALL
select 'bbarion@superrito.com','bbarion','Single','74000','No','4 Year Degree','Jewelry' UNION ALL
select 'balott@rhyta.com','balott','Married','Prefer not to Answer','Prefer not to Answer','Graduate Degree','Apparel' UNION ALL
select 'etasomthin@superrito.com','etasomthin','Married','39000','No','2 Year Degree','Prefer not to Answer' UNION ALL
select 'edetyers@dayrep.com','edetyers','Single','Prefer not to Answer','No','Prefer not to Answer','Apparel' UNION ALL
select 'afresco@dayrep.com','afresco','Married','45000','No','High School','Apparel' UNION ALL
select 'rovlight@dayrep.com','rovlight','Prefer not to Answer','28000','No','2 Year Degree','Digital Downloads' UNION ALL
select 'sbellum@superrito.com','sbellum','Married','100000','Yes','Graduate Degree','Jewelry' UNION ALL
select 'sofewe@dayrep.com','sofewe','Single','50000','Yes','4 Year Degree','Books';
