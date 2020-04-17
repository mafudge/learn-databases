-- Part 6: Create views --

-- 6.1 CREATE VIEW: v_vbay_users
create view v_vbay_users
as
select [user_id],user_email, user_firstname + ' ' + user_lastname as user_name, user_zip_code 
	from vb_users
GO
	
-- 6.2 CREATE VIEW: v_users_with_cityst
create view v_users_with_cityst
as
select [user_id],user_email, user_firstname + ' ' + user_lastname as user_name, zip_city, zip_state, user_zip_code 
	from vb_users join vb_zip_codes on user_zip_code = zip_code

GO

-- 6.3 CREATE VIEW: v_users_count_by_cityst
create view v_users_count_by_cityst
as
select zip_city, zip_state, count(user_zip_code) as user_count
	from vb_zip_codes join vb_users on user_zip_code = zip_code
	group by zip_city, zip_state
GO

-- 6.4 CREATE VIEW: v_state_user_count
create view v_state_user_count
as
select zip_state, count(user_zip_code) as user_count
	from vb_users right join vb_zip_codes on user_zip_code = zip_code
	group by zip_state
	--order by zip_state
	
GO
	
-- 6.5 CREATE VIEW: v_seller_ratings
create view v_seller_ratings
as
select b.user_firstname + ' ' + b.user_lastname as rating_by, f.user_firstname + ' ' + f.user_lastname as rating_for,
	rating_astype, rating_value , rating_comment
	from vb_user_ratings 
		join vb_users as b on rating_by_user_id= b.user_id
		join vb_users as f on rating_for_user_id= f.user_id
	where rating_astype='Seller'
GO
	
-- 6.6 CREATE VIEW: v_seller_avg_ratings
create view v_seller_avg_ratings
as
select f.user_firstname + ' ' + f.user_lastname as rating_for,
	rating_astype, count(rating_id) as count_of_ratings, avg(cast (rating_value as decimal(4,1))) as avg_rating
	from vb_user_ratings 
		join vb_users as f on rating_for_user_id= f.user_id
	where rating_astype='Seller'
	group by f.user_firstname, f.user_lastname, rating_astype
GO

-- 6.7 CREATE VIEW: v_count_of_item_types
create view v_count_of_item_types
as
select it.item_type, count(item_id) as item_count
	from vb_items as i 
		right join vb_item_types_lookup as it on i.item_type=it.item_type
	group by it.item_type
GO

-- 6.8 CREATE VIEW: v_items_for_bid
create view v_items_for_bid
as
select item_id, item_name, item_type, item_reserve, s.user_firstname + ' ' + s.user_lastname as seller_name
	from vb_items
		join vb_users as s on item_seller_user_id=s.[user_id]
	where item_sold=0
GO

-- 6.9 CREATE VIEW: v_items_sold
create view v_items_sold
as
select item_id, item_name, item_type, item_reserve, s.user_firstname + ' ' + s.user_lastname as seller_name,
	b.user_firstname + ' ' + b.user_lastname as buyer_name,
	item_soldamount
	from vb_items
		join vb_users as s on item_seller_user_id=s.[user_id]
		join vb_users as b on item_buyer_user_id=b.[user_id]
	where item_sold=1
GO

-- 6.10 CREATE VIEW: v_bidless_items
create view v_bidless_items
as
select item_id, item_name, item_type, item_reserve, s.user_firstname + ' ' + s.user_lastname as seller_name,
	bid_id
	from vb_items
		left join vb_bids on item_id=bid_item_id
		join vb_users as s on item_seller_user_id=s.[user_id]
	where bid_id is null
GO		

-- 6.11 CREATE VIEW: v_unaccepted_bids
create view v_unaccepted_bids
as
select bid_id, item_name, item_type, item_reserve, s.user_firstname + ' ' + s.user_lastname as seller_name,
	b.user_firstname + ' ' + b.user_lastname as bidder_name,
	bid_amount, bid_status
	from vb_items
		join vb_bids on item_id=bid_item_id
		join vb_users as s on item_seller_user_id=s.[user_id]
		join vb_users as b on bid_user_id=b.[user_id]
	where bid_status <> 'ok'
GO

-- 6.12 CREATE VIEW: v_items_with_high_bidder
-- TODO: 5.7
create view v_items_with_high_bidder
as
select item_id, item_name, item_type, item_reserve, s.user_firstname + ' ' + s.user_lastname as seller_name,
	max(b.user_firstname + ' ' + b.user_lastname) as high_bidder_name,
	max(bid_amount) as high_bid_amount
	from vb_items
		 join vb_bids on item_id=bid_item_id
		 join vb_users as s on item_seller_user_id=s.[user_id]
		 join vb_users as b on bid_user_id=b.[user_id]
	where item_sold=0 and (bid_status='ok')
	group by item_id, item_name, item_type, item_reserve, s.user_firstname , s.user_lastname 
GO

-- 6.13 CREATE VIEW: v_items_sold_by_state
create view v_items_sold_by_state
as
select zip_state, count(item_id) as count_of_items_sold 
	from vb_items
		join vb_users as s on item_seller_user_id=s.[user_id]
		join vb_users as b on item_buyer_user_id=b.[user_id]
		join vb_zip_codes on b.user_zip_code = zip_code
	where item_sold=1
	group by zip_state
GO

-- 6.14 CREATE VIEW: v_items_sold_by_location
create view v_items_sold_by_location
as
select item_id, item_name, item_type, item_reserve, sz.zip_city + ',' + sz.zip_state as seller_location,
	bz.zip_city + ',' + bz.zip_state as buyer_location,
	item_soldamount
	from vb_items
		join vb_users as s on item_seller_user_id=s.[user_id]
		join vb_users as b on item_buyer_user_id=b.[user_id]
		join vb_zip_codes bz on b.user_zip_code = bz.zip_code
		join vb_zip_codes sz on s.user_zip_code = sz.zip_code
	where item_sold=1
GO

-- 6.15 CREATE VIEW: v_vbay_take_of_items_sold
create view v_vbay_take_of_items_sold
as
select item_id, item_name, item_type, item_reserve, s.user_firstname + ' ' + s.user_lastname as seller_name,
	b.user_firstname + ' ' + b.user_lastname as buyer_name,
	item_soldamount, item_soldamount - item_reserve as item_profit, (item_soldamount - item_reserve) * 0.15 as vbay_take
	from vb_items
		join vb_users as s on item_seller_user_id=s.[user_id]
		join vb_users as b on item_buyer_user_id=b.[user_id]
	where item_sold=1
GO


-- 6.16 CREATE VIEW: v_total_bids_by_user
create view v_total_bids_by_user
as
select high_bidder_name, count(*) as count_of_bids, sum(high_bid_amount) as total_high_bid_amount 
	from v_items_with_high_bidder
	group by high_bidder_name
GO
