/****** Object:  View [dbo].[v_70s_sci_fi_titles]    Script Date: 10/3/2019 10:57:32 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[v_70s_sci_fi_titles]'))
EXEC dbo.sp_executesql @statement = N'create view [dbo].[v_70s_sci_fi_titles]
as
--begin 5.5
-- list the titles in the genre containting ''Sci-Fi'' which were released in the 1970''s
select distinct title_id, title_name, title_type, title_release_year
	from nf_titles
		join nf_title_genres on title_id = tg_title_id
	where tg_genre_name like ''%Sci-Fi%''
		and title_release_year between 1970 and 1979
--end 5.5
' 
GO
/****** Object:  View [dbo].[v_best_baldwin]    Script Date: 10/3/2019 10:57:32 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[v_best_baldwin]'))
EXEC dbo.sp_executesql @statement = N'create view [dbo].[v_best_baldwin]
as
--begin 5.17
-- Who''s the best baldwin? all the actors with last name ''Baldwin'' list the number of ''Movies'' appeared in along with the average of their title_avg_rating
select top 100 percent
	people_name as actor_name, 
	count(*) as number_of_movies_in,
	avg(title_avg_rating) as avg_netflix_movie_rating
	from nf_titles 
		join nf_cast on title_id = cast_title_id
		join nf_people on people_id = cast_people_id
	where people_name like ''% Baldwin'' 
		and title_type=''Movie''
	group by  people_name
	order by avg_netflix_movie_rating desc
--end 5.17
' 
GO
/****** Object:  View [dbo].[v_cheadle_with_damon]    Script Date: 10/3/2019 10:57:32 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[v_cheadle_with_damon]'))
EXEC dbo.sp_executesql @statement = N'create view [dbo].[v_cheadle_with_damon]
as
--begin 5.18
-- list all titles where both ''Don Cheadle'' and ''Matt Damon'' appear as actors together in the same title
select  top 100 percent
	title_name, title_release_year, title_rating 
	from nf_titles 
		join nf_cast on title_id = cast_title_id
		join nf_people on people_id = cast_people_id		
	where people_name  in (''Don Cheadle'', ''Matt Damon'')
	group by title_name, title_release_year, title_rating 
	having count(*) = 2
	order by title_name
--end 5.18
' 
GO
/****** Object:  View [dbo].[v_count_of_decade_titles]    Script Date: 10/3/2019 10:57:32 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[v_count_of_decade_titles]'))
EXEC dbo.sp_executesql @statement = N'create view [dbo].[v_count_of_decade_titles]
as
--begin 5.16
-- how many netflix titles were released each year from 2000 to 2010?
select top 100 percent 
		title_release_year, 
		count(*) as count_of_titles
	from nf_titles 
	where title_release_year between 2000 and 2010
	group by title_release_year
	order by title_release_year
--end 5.16
' 
GO
/****** Object:  View [dbo].[v_g_rated_titles]    Script Date: 10/3/2019 10:57:32 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[v_g_rated_titles]'))
EXEC dbo.sp_executesql @statement = N'create view [dbo].[v_g_rated_titles]
as
--begin 5.4
-- List all the rated G netflix titles available for in all formats DVD, BluRay and Instant
select * from nf_titles
	where title_bluray_available=1
		and title_dvd_available=1
		and title_instant_available=1
		and title_rating = ''G''
--end 5.4
' 
GO
/****** Object:  View [dbo].[v_harry_potter_fanboy]    Script Date: 10/3/2019 10:57:32 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[v_harry_potter_fanboy]'))
EXEC dbo.sp_executesql @statement = N'create view [dbo].[v_harry_potter_fanboy]
as
--begin 5.2
-- list all of the ''Harry Potter'' associated titles in NetFlix and sort be release year.
select top 100 percent
	title_id, title_name, title_type, title_release_year
	from nf_titles 
	where title_name like ''Harry Potter%''
	order by title_release_year
--end 5.2
' 
GO
/****** Object:  View [dbo].[v_inactive_accounts]    Script Date: 10/3/2019 10:57:32 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[v_inactive_accounts]'))
EXEC dbo.sp_executesql @statement = N'create view [dbo].[v_inactive_accounts]
as
--begin 5.12
-- inactive accounts: write a select statement to display accounts with no account titles 
select account_id, account_firstname + '' '' +  account_lastname as account_name, at_account_id
	from nf_accounts
		 left join nf_account_titles on account_id = at_account_id
	where at_account_id is null
--end 5.12
' 
GO
/****** Object:  View [dbo].[v_james_cameron_genres]    Script Date: 10/3/2019 10:57:32 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[v_james_cameron_genres]'))
EXEC dbo.sp_executesql @statement = N'create view [dbo].[v_james_cameron_genres]
as
--begin 5.13
-- what genre of titles has James Cameron directed? Sort by name of genre
select distinct top 100 percent
	people_name as director_name, 
	tg_genre_name as genre_name	
	from nf_titles 
		join nf_directors on title_id = director_title_id
		join nf_people on people_id = director_people_id
		join nf_title_genres on title_id = tg_title_id
	where people_name = ''James Cameron'' 
	order by genre_name 
--end 5.13
' 
GO
/****** Object:  View [dbo].[v_lika_da_sci_fi]    Script Date: 10/3/2019 10:57:32 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[v_lika_da_sci_fi]'))
EXEC dbo.sp_executesql @statement = N'create view [dbo].[v_lika_da_sci_fi]
as
--begin 5.3
-- list all the netflix Genres with ''Sci-Fi'' in their genre name
select genre_name from nf_genres
	where genre_name like ''%Sci-Fi%''
--end 5.3
' 
GO
/****** Object:  View [dbo].[v_number_of_accounts_by_state]    Script Date: 10/3/2019 10:57:32 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[v_number_of_accounts_by_state]'))
EXEC dbo.sp_executesql @statement = N'create view [dbo].[v_number_of_accounts_by_state]
as
--begin 5.15
-- netFlix Accounts by state
select zip_state, count(*) as number_of_accounts
	from nf_accounts
	join nf_zipcodes on account_zipcode = zip_code
	group by zip_state
--end 5.15
' 
GO
/****** Object:  View [dbo].[v_popular_don_cheadle_movies]    Script Date: 10/3/2019 10:57:32 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[v_popular_don_cheadle_movies]'))
EXEC dbo.sp_executesql @statement = N'create view [dbo].[v_popular_don_cheadle_movies]
as
--begin 5.14
-- which Don Cheadle movies (only Movies) have an avg rating higher than 3.5? Sort highest rated at the top
select top 100 percent
	people_name as actor_name, 
	title_name, title_release_year, title_avg_rating, title_rating 
	from nf_titles 
		join nf_cast on title_id = cast_title_id
		join nf_people on people_id = cast_people_id
	where people_name = ''Don Cheadle'' 
		and title_avg_rating > 3.5
		and title_type=''Movie''
	order by title_avg_rating desc
--end 5.14
' 
GO
/****** Object:  View [dbo].[v_queued_titles]    Script Date: 10/3/2019 10:57:32 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[v_queued_titles]'))
EXEC dbo.sp_executesql @statement = N'create view [dbo].[v_queued_titles]
as
--begin 5.7
-- lists titles in customer account queues (not shipped or returned)
select 
	account_id,
	account_firstname + '' '' + account_lastname as account_name,
	account_email,
	title_name, 
	title_rating,
	at_queue_date
	from nf_account_titles
		join nf_accounts on at_account_id = account_id
		join nf_titles on at_title_id = title_id
	where at_queue_date is not null 
		and at_shipped_date is null
		and at_returned_date is null
--end 5.7
' 
GO
/****** Object:  View [dbo].[v_shipped_out_titles]    Script Date: 10/3/2019 10:57:32 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[v_shipped_out_titles]'))
EXEC dbo.sp_executesql @statement = N'create view [dbo].[v_shipped_out_titles]
as
--begin 5.8
-- lists titles shipped out to customers (accounts), but not returned
select 
	account_id,
	account_firstname + '' '' + account_lastname as account_name,
	account_email,
	title_name, 
	title_rating,
	at_shipped_date
	from nf_account_titles
		join nf_accounts on at_account_id = account_id
		join nf_titles on at_title_id = title_id
	where at_queue_date is not null 
		and at_shipped_date is not null
		and at_returned_date is null
--end 5.8
' 
GO
/****** Object:  View [dbo].[v_title_count_by_rating]    Script Date: 10/3/2019 10:57:32 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[v_title_count_by_rating]'))
EXEC dbo.sp_executesql @statement = N'create view [dbo].[v_title_count_by_rating]
as
--begin 5.10
-- break out the counts of all the titles by rating
select top 100 percent
	title_rating, count(*) as total_titles
	from nf_titles
	group by title_rating
	order by title_rating
--end 5.10
' 
GO
/****** Object:  View [dbo].[v_title_history]    Script Date: 10/3/2019 10:57:32 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[v_title_history]'))
EXEC dbo.sp_executesql @statement = N'create view [dbo].[v_title_history]
as
--begin 5.9
-- list titles returned and include number of days at in queue, and # of days at customer.
select top 100 percent
	account_id,
	account_firstname + '' '' + account_lastname as account_name,
	account_email,
	title_name, 
	title_rating,
	datediff(dd,at_queue_date, at_shipped_date) as days_in_queue,
	datediff(dd,at_shipped_date, at_returned_date) as days_with_customer,
	at_returned_date
	from nf_account_titles
		join nf_accounts on at_account_id = account_id
		join nf_titles on at_title_id = title_id
	where at_queue_date is not null 
		and at_shipped_date is not null
		and at_returned_date is not null
	order by at_returned_date
--end 5.9
' 
GO
/****** Object:  View [dbo].[v_titles_watched_by_account]    Script Date: 10/3/2019 10:57:32 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[v_titles_watched_by_account]'))
EXEC dbo.sp_executesql @statement = N'create view [dbo].[v_titles_watched_by_account]
as
--begin 5.11
-- list the number (count) of titles watched by each account. hint: A watched title has been returned. Sort by the number of titles watched
select top 100 percent
	account_id,
	account_firstname + '' '' + account_lastname as account_name,
	account_email,
	count(*) as numberof_titles_watched
	from nf_account_titles
		join nf_accounts on at_account_id = account_id
		join nf_titles on at_title_id = title_id
	where at_queue_date is not null 
		and at_shipped_date is not null
		and at_returned_date is not null
	group by account_id, account_firstname , account_lastname, account_email
	order by numberof_titles_watched desc
--end 5.11
' 
GO
/****** Object:  View [dbo].[v_titles_with_low_rating]    Script Date: 10/3/2019 10:57:32 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[v_titles_with_low_rating]'))
EXEC dbo.sp_executesql @statement = N'create view [dbo].[v_titles_with_low_rating]
as
--begin 5.1
-- really crappy movies have a rating of 1.5 or below sort so the crappiest are at the top
select top 100 percent 
	title_id, title_name, title_rating, title_avg_rating
	from nf_titles 
	where title_avg_rating <= 1.5
	order by title_avg_rating
--end 5.1
' 
GO
/****** Object:  View [dbo].[v_zach_attack]    Script Date: 10/3/2019 10:57:32 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[v_zach_attack]'))
EXEC dbo.sp_executesql @statement = N'create view [dbo].[v_zach_attack]
as
--begin 5.6
-- Zach Attack! list all the actors with first name ''Zach'' sort by name
select distinct top 100 percent 
	people_name as zach_attack_actor_name
	from nf_cast
		join nf_people on people_id = cast_people_id
	where people_name like  ''Zach %'' 
	order by people_name
--end 5.6
' 
GO
/****** Object:  View [dbo].[vTopGenres]    Script Date: 10/3/2019 10:57:32 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[vTopGenres]'))
EXEC dbo.sp_executesql @statement = N'/****** Script for SelectTopNRows command from SSMS  ******/
create view [dbo].[vTopGenres]
as
SELECT tg_genre_name,
      count(*) as genre_count
  FROM [fudgeflix_v3].[dbo].[ff_title_genres]
  GROUP BY tg_genre_name
  ' 
