USE [demo]
GO
DROP TABLE if exists [dbo].[surveys]
GO
DROP TABLE if exists [dbo].[customers]
GO
CREATE TABLE [dbo].[customers](
	[First] [nvarchar](50) NOT NULL,
	[Last] [nvarchar](50) NOT NULL,
	[Email] [nvarchar](50) NOT NULL,
	[Gender] [nvarchar](50) NOT NULL,
	[Last_IP_Address] [nvarchar](50) NOT NULL,
	[City] [nvarchar](50) NOT NULL,
	[State] [nvarchar](50) NOT NULL,
	[Total_Orders] [tinyint] NOT NULL,
	[Total_Purchased] [smallint] NOT NULL,
	[Months_Customer] [tinyint] NOT NULL
) ON [PRIMARY]
GO
CREATE TABLE [dbo].[surveys](
	[Email] [nvarchar](50) NOT NULL,
	[Twitter_Username] [nvarchar](50) NOT NULL,
	[Marital_Status] [nvarchar](50) NOT NULL,
	[Household_Income] [varchar](50) NULL,
	[Own_Home] [varchar](50) NULL,
	[Education] [nvarchar](50) NOT NULL,
	[Favorite_Department] [nvarchar](50) NOT NULL
) ON [PRIMARY]
GO
INSERT [dbo].[customers] ([First], [Last], [Email], [Gender], [Last_IP_Address], [City], [State], [Total_Orders], [Total_Purchased], [Months_Customer]) VALUES (N'Al', N'Fresco', N'afresco@dayrep.com', N'M', N'74.111.18.161', N'Syracuse', N'NY', 1, 45, 1)
GO
INSERT [dbo].[customers] ([First], [Last], [Email], [Gender], [Last_IP_Address], [City], [State], [Total_Orders], [Total_Purchased], [Months_Customer]) VALUES (N'Abby', N'Kuss', N'akuss@rhyta.com', N'F', N'23.80.125.101', N'Phoenix', N'AZ', 1, 25, 2)
GO
INSERT [dbo].[customers] ([First], [Last], [Email], [Gender], [Last_IP_Address], [City], [State], [Total_Orders], [Total_Purchased], [Months_Customer]) VALUES (N'Arial', N'Photo', N'aphoto@dayrep.com', N'F', N'24.0.14.56', N'Newark', N'NJ', 1, 680, 1)
GO
INSERT [dbo].[customers] ([First], [Last], [Email], [Gender], [Last_IP_Address], [City], [State], [Total_Orders], [Total_Purchased], [Months_Customer]) VALUES (N'Bette', N'Alott', N'balott@rhyta.com', N'F', N'56.216.127.219', N'Raleigh', N'NC', 6, 560, 18)
GO
INSERT [dbo].[customers] ([First], [Last], [Email], [Gender], [Last_IP_Address], [City], [State], [Total_Orders], [Total_Purchased], [Months_Customer]) VALUES (N'Barb ', N'Barion', N'bbarion@superrito.com', N'F', N'38.68.15.223', N'Dallas', N'TX', 4, 1590, 1)
GO
INSERT [dbo].[customers] ([First], [Last], [Email], [Gender], [Last_IP_Address], [City], [State], [Total_Orders], [Total_Purchased], [Months_Customer]) VALUES (N'Barry', N'DeHatchett', N'bdehatchett@dayrep.com', N'M', N'23.192.215.78', N'Boston', N'MA', 1, 15, 6)
GO
INSERT [dbo].[customers] ([First], [Last], [Email], [Gender], [Last_IP_Address], [City], [State], [Total_Orders], [Total_Purchased], [Months_Customer]) VALUES (N'Bill', N'Melator', N'bmelator@einrot.com', N'M', N'24.11.125.10', N'Orem', N'UT', 9, 6090, 35)
GO
INSERT [dbo].[customers] ([First], [Last], [Email], [Gender], [Last_IP_Address], [City], [State], [Total_Orders], [Total_Purchased], [Months_Customer]) VALUES (N'Candi', N'Cayne', N'ccayne@rhyta.com', N'F', N'24.39.14.15', N'Portland', N'ME', 1, 620, 2)
GO
INSERT [dbo].[customers] ([First], [Last], [Email], [Gender], [Last_IP_Address], [City], [State], [Total_Orders], [Total_Purchased], [Months_Customer]) VALUES (N'Carol', N'Ling', N'cling@superrito.com', N'F', N'23.180.242.66', N'Syracuse', N'NY', 2, 440, 6)
GO
INSERT [dbo].[customers] ([First], [Last], [Email], [Gender], [Last_IP_Address], [City], [State], [Total_Orders], [Total_Purchased], [Months_Customer]) VALUES (N'Cam', N'Rha', N'crha@einrot.com', N'M', N'24.1.25.140', N'Chicago', N'IL', 0, 0, 1)
GO
INSERT [dbo].[customers] ([First], [Last], [Email], [Gender], [Last_IP_Address], [City], [State], [Total_Orders], [Total_Purchased], [Months_Customer]) VALUES (N'Dan', N'Delyons', N'ddelyons@dayrep.com', N'M', N'24.38.224.161', N'Greenwich', N'CT', 2, 2570, 10)
GO
INSERT [dbo].[customers] ([First], [Last], [Email], [Gender], [Last_IP_Address], [City], [State], [Total_Orders], [Total_Purchased], [Months_Customer]) VALUES (N'Erin', N'Detyers', N'edetyers@dayrep.com', N'F', N'70.209.14.54', N'Tampa', N'FL', 5, 1105, 38)
GO
INSERT [dbo].[customers] ([First], [Last], [Email], [Gender], [Last_IP_Address], [City], [State], [Total_Orders], [Total_Purchased], [Months_Customer]) VALUES (N'Euron', N'Tasomthin', N'etasomthin@superrito.com', N'M', N'68.199.40.156', N'Hempstead', N'NY', 13, 4630, 28)
GO
INSERT [dbo].[customers] ([First], [Last], [Email], [Gender], [Last_IP_Address], [City], [State], [Total_Orders], [Total_Purchased], [Months_Customer]) VALUES (N'Justin', N'Case', N'jcase@dayrep.com', N'M', N'23.192.215.44', N'Boston', N'MA', 3, 1050, 1)
GO
INSERT [dbo].[customers] ([First], [Last], [Email], [Gender], [Last_IP_Address], [City], [State], [Total_Orders], [Total_Purchased], [Months_Customer]) VALUES (N'Jean', N'Poole', N'jpoole@dayrep.com', N'F', N'23.182.25.40', N'Kingston', N'NY', 7, 185, 12)
GO
INSERT [dbo].[customers] ([First], [Last], [Email], [Gender], [Last_IP_Address], [City], [State], [Total_Orders], [Total_Purchased], [Months_Customer]) VALUES (N'Lee', N'Hvmeehom', N'lhvmeehom@einrot.com', N'F', N'215.82.23.2', N'Columbus', N'OH', 9, 207, 18)
GO
INSERT [dbo].[customers] ([First], [Last], [Email], [Gender], [Last_IP_Address], [City], [State], [Total_Orders], [Total_Purchased], [Months_Customer]) VALUES (N'Lisa', N'Karfurless', N'lkarfurless@dayrep.com', N'F', N'172.189.252.8', N'Fairfax', N'VA', 6, 250, 27)
GO
INSERT [dbo].[customers] ([First], [Last], [Email], [Gender], [Last_IP_Address], [City], [State], [Total_Orders], [Total_Purchased], [Months_Customer]) VALUES (N'Mary', N'Melator', N'mmelator@rhyta.com', N'F', N'23.88.15.5', N'Los Angeles', N'CA', 8, 4275, 40)
GO
INSERT [dbo].[customers] ([First], [Last], [Email], [Gender], [Last_IP_Address], [City], [State], [Total_Orders], [Total_Purchased], [Months_Customer]) VALUES (N'Mike', N'Rofone', N'mrofone@dayrep.com', N'M', N'23.224.160.4', N'Cheyenne', N'WY', 0, 0, 0)
GO
INSERT [dbo].[customers] ([First], [Last], [Email], [Gender], [Last_IP_Address], [City], [State], [Total_Orders], [Total_Purchased], [Months_Customer]) VALUES (N'Oren', N'Jouglad', N'ojouglad@einrot.com', N'M', N'128.122.140.238', N'New York', N'NY', 12, 4500, 36)
GO
INSERT [dbo].[customers] ([First], [Last], [Email], [Gender], [Last_IP_Address], [City], [State], [Total_Orders], [Total_Purchased], [Months_Customer]) VALUES (N'Phil', N'Meaup', N'pmeaup@dayrep.com', N'M', N'23.83.132.200', N'Phoenix', N'AZ', 4, 930, 24)
GO
INSERT [dbo].[customers] ([First], [Last], [Email], [Gender], [Last_IP_Address], [City], [State], [Total_Orders], [Total_Purchased], [Months_Customer]) VALUES (N'Rowan', N'Deboat', N'rdeboat@dayrep.com', N'M', N'23.84.32.22', N'Topeka', N'KS', 1, 3500, 42)
GO
INSERT [dbo].[customers] ([First], [Last], [Email], [Gender], [Last_IP_Address], [City], [State], [Total_Orders], [Total_Purchased], [Months_Customer]) VALUES (N'Ray', N'Ovlight', N'rovlight@dayrep.com', N'M', N'74.111.18.59', N'Syracuse', N'NY', 6, 125, 42)
GO
INSERT [dbo].[customers] ([First], [Last], [Email], [Gender], [Last_IP_Address], [City], [State], [Total_Orders], [Total_Purchased], [Months_Customer]) VALUES (N'Sara', N'Bellum', N'sbellum@superrito.com', N'F', N'74.111.6.173', N'Alexandria', N'VA', 2, 189, 2)
GO
INSERT [dbo].[customers] ([First], [Last], [Email], [Gender], [Last_IP_Address], [City], [State], [Total_Orders], [Total_Purchased], [Months_Customer]) VALUES (N'Sal', N'Ladd', N'sladd@superrito.com', N'M', N'23.112.202.16', N'Rochester', N'NY', 14, 594, 10)
GO
INSERT [dbo].[customers] ([First], [Last], [Email], [Gender], [Last_IP_Address], [City], [State], [Total_Orders], [Total_Purchased], [Months_Customer]) VALUES (N'Seymour', N'Ofewe', N'sofewe@dayrep.com', N'M', N'98.29.25.44', N'Cleveland', N'OH', 9, 1190, 3)
GO
INSERT [dbo].[customers] ([First], [Last], [Email], [Gender], [Last_IP_Address], [City], [State], [Total_Orders], [Total_Purchased], [Months_Customer]) VALUES (N'Ty', N'Anott', N'tanott@rhyta.com', N'M', N'23.230.12.5', N'San Jose', N'CA', 1, 50, 3)
GO
INSERT [dbo].[customers] ([First], [Last], [Email], [Gender], [Last_IP_Address], [City], [State], [Total_Orders], [Total_Purchased], [Months_Customer]) VALUES (N'Tally', N'Itupp', N'titupp@superrito.com', N'F', N'24.38.114.105', N'Sea Cliff', N'NY', 11, 380, 42)
GO
INSERT [dbo].[customers] ([First], [Last], [Email], [Gender], [Last_IP_Address], [City], [State], [Total_Orders], [Total_Purchased], [Months_Customer]) VALUES (N'Tim', N'Pani', N'tpani@superrito.com', N'M', N'23.84.132.226', N'Buffalo', N'NY', 0, 0, 1)
GO
INSERT [dbo].[customers] ([First], [Last], [Email], [Gender], [Last_IP_Address], [City], [State], [Total_Orders], [Total_Purchased], [Months_Customer]) VALUES (N'Victor', N'Rhee', N'vrhee@einrot.com', N'M', N'23.112.232.160', N'Green Bay', N'WI', 0, 0, 2)
GO
INSERT [dbo].[surveys] ([Email], [Twitter_Username], [Marital_Status], [Household_Income], [Own_Home], [Education], [Favorite_Department]) VALUES (N'ojouglad@einrot.com', N'ojouglad', N'Married', N'65000', N'No', N'4 Year Degree', N'Electronics')
GO
INSERT [dbo].[surveys] ([Email], [Twitter_Username], [Marital_Status], [Household_Income], [Own_Home], [Education], [Favorite_Department]) VALUES (N'lkarfurless@dayrep.com', N'lkarfurless', N'Single', N'143000', N'Yes', N'Graduate Degree', N'Apparel')
GO
INSERT [dbo].[surveys] ([Email], [Twitter_Username], [Marital_Status], [Household_Income], [Own_Home], [Education], [Favorite_Department]) VALUES (N'lhvmeehom@einrot.com', N'lhvmeehom', N'Prefer not to Answer', N'75000', N'Yes', N'4 Year Degree', N'Prefer not to Answer')
GO
INSERT [dbo].[surveys] ([Email], [Twitter_Username], [Marital_Status], [Household_Income], [Own_Home], [Education], [Favorite_Department]) VALUES (N'sladd@superrito.com', N'sladd', N'Married', N'52000', N'Yes', N'2 Year Degree', N'None')
GO
INSERT [dbo].[surveys] ([Email], [Twitter_Username], [Marital_Status], [Household_Income], [Own_Home], [Education], [Favorite_Department]) VALUES (N'vrhee@einrot.com', N'vrhee', N'Prefer not to Answer', N'17500', N'No', N'High School', N'Books')
GO
INSERT [dbo].[surveys] ([Email], [Twitter_Username], [Marital_Status], [Household_Income], [Own_Home], [Education], [Favorite_Department]) VALUES (N'jpoole@dayrep.com', N'jpoole', N'Married', N'Prefer not to Answer', N'Yes', N'Some College', N'Books')
GO
INSERT [dbo].[surveys] ([Email], [Twitter_Username], [Marital_Status], [Household_Income], [Own_Home], [Education], [Favorite_Department]) VALUES (N'bdehatchett@dayrep.com', N'bdehatchett', N'Prefer not to Answer', N'67000', N'Yes', N'4 Year Degree', N'Electronics')
GO
INSERT [dbo].[surveys] ([Email], [Twitter_Username], [Marital_Status], [Household_Income], [Own_Home], [Education], [Favorite_Department]) VALUES (N'mrofone@dayrep.com', N'mrofone', N'Single', N'121000', N'Yes', N'Prefer not to Answer', N'Jewelry')
GO
INSERT [dbo].[surveys] ([Email], [Twitter_Username], [Marital_Status], [Household_Income], [Own_Home], [Education], [Favorite_Department]) VALUES (N'tanott@rhyta.com', N'tanott', N'Single', N'26000', N'No', N'2 Year Degree', N'Digital Downloads')
GO
INSERT [dbo].[surveys] ([Email], [Twitter_Username], [Marital_Status], [Household_Income], [Own_Home], [Education], [Favorite_Department]) VALUES (N'akuss@rhyta.com', N'akuss', N'Single', N'22500', N'No', N'High School', N'None')
GO
INSERT [dbo].[surveys] ([Email], [Twitter_Username], [Marital_Status], [Household_Income], [Own_Home], [Education], [Favorite_Department]) VALUES (N'tpani@superrito.com', N'tpani', N'Prefer not to Answer', N'89000', N'Yes', N'Graduate Degree', N'Jewelry')
GO
INSERT [dbo].[surveys] ([Email], [Twitter_Username], [Marital_Status], [Household_Income], [Own_Home], [Education], [Favorite_Department]) VALUES (N'rdeboat@dayrep.com', N'rdeboat', N'Single', N'69000', N'Yes', N'Graduate Degree', N'Electronics')
GO
INSERT [dbo].[surveys] ([Email], [Twitter_Username], [Marital_Status], [Household_Income], [Own_Home], [Education], [Favorite_Department]) VALUES (N'mmelator@rhyta.com', N'mmelator', N'Prefer not to Answer', N'42000', N'No', N'4 Year Degree', N'Books')
GO
INSERT [dbo].[surveys] ([Email], [Twitter_Username], [Marital_Status], [Household_Income], [Own_Home], [Education], [Favorite_Department]) VALUES (N'crha@einrot.com', N'crha', N'Married', N'34000', N'Prefer not to Answer', N'4 Year Degree', N'Books')
GO
INSERT [dbo].[surveys] ([Email], [Twitter_Username], [Marital_Status], [Household_Income], [Own_Home], [Education], [Favorite_Department]) VALUES (N'bmelator@einrot.com', N'bmelator', N'Single', N'13000', N'No', N'2 Year Degree', N'Digital Downloads')
GO
INSERT [dbo].[surveys] ([Email], [Twitter_Username], [Marital_Status], [Household_Income], [Own_Home], [Education], [Favorite_Department]) VALUES (N'ddelyons@dayrep.com', N'ddelyons', N'Single', N'105000', N'Yes', N'High School', N'Electronics')
GO
INSERT [dbo].[surveys] ([Email], [Twitter_Username], [Marital_Status], [Household_Income], [Own_Home], [Education], [Favorite_Department]) VALUES (N'ccayne@rhyta.com', N'ccayne', N'Married', N'62000', N'Yes', N'4 Year Degree', N'None')
GO
INSERT [dbo].[surveys] ([Email], [Twitter_Username], [Marital_Status], [Household_Income], [Own_Home], [Education], [Favorite_Department]) VALUES (N'bbarion@superrito.com', N'bbarion', N'Single', N'74000', N'No', N'4 Year Degree', N'Jewelry')
GO
INSERT [dbo].[surveys] ([Email], [Twitter_Username], [Marital_Status], [Household_Income], [Own_Home], [Education], [Favorite_Department]) VALUES (N'balott@rhyta.com', N'balott', N'Married', N'Prefer not to Answer', N'Prefer not to Answer', N'Graduate Degree', N'Apparel')
GO
INSERT [dbo].[surveys] ([Email], [Twitter_Username], [Marital_Status], [Household_Income], [Own_Home], [Education], [Favorite_Department]) VALUES (N'etasomthin@superrito.com', N'etasomthin', N'Married', N'39000', N'No', N'2 Year Degree', N'Prefer not to Answer')
GO
INSERT [dbo].[surveys] ([Email], [Twitter_Username], [Marital_Status], [Household_Income], [Own_Home], [Education], [Favorite_Department]) VALUES (N'edetyers@dayrep.com', N'edetyers', N'Single', N'Prefer not to Answer', N'No', N'Prefer not to Answer', N'Apparel')
GO
INSERT [dbo].[surveys] ([Email], [Twitter_Username], [Marital_Status], [Household_Income], [Own_Home], [Education], [Favorite_Department]) VALUES (N'afresco@dayrep.com', N'afresco', N'Married', N'45000', N'No', N'High School', N'Apparel')
GO
INSERT [dbo].[surveys] ([Email], [Twitter_Username], [Marital_Status], [Household_Income], [Own_Home], [Education], [Favorite_Department]) VALUES (N'rovlight@dayrep.com', N'rovlight', N'Prefer not to Answer', N'28000', N'No', N'2 Year Degree', N'Digital Downloads')
GO
INSERT [dbo].[surveys] ([Email], [Twitter_Username], [Marital_Status], [Household_Income], [Own_Home], [Education], [Favorite_Department]) VALUES (N'sbellum@superrito.com', N'sbellum', N'Married', N'100000', N'Yes', N'Graduate Degree', N'Jewelry')
GO
INSERT [dbo].[surveys] ([Email], [Twitter_Username], [Marital_Status], [Household_Income], [Own_Home], [Education], [Favorite_Department]) VALUES (N'sofewe@dayrep.com', N'sofewe', N'Single', N'50000', N'Yes', N'4 Year Degree', N'Books')
GO


