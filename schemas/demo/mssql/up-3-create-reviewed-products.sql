use demo 
go

drop table if exists reviewed_products
go
create table reviewed_products
(
	id int primary key not null,
	name varchar(50) not null,
	price money not null,
	reviews varchar(max) null,
	constraint ck_product_review_is_json check (isjson(reviews)>0)
)
go 

insert into reviewed_products (id, name, price, reviews) values (1, 'Bike-Pump', 15, '[
		{"Reviewer":{"Name": "Erin Detyers","Email": "edt@mail.com", "Rating" : 5 }}
	]')
insert into reviewed_products (id, name, price, reviews) values (2, 'Handlebars', 30, '[
		{"Reviewer":{"Name": "Kent Belevit", "Rating" : 2 }}, 
		{"Reviewer":{"Name": "Artie Choke", "Email": "ack@mail.com", "Rating" : 3 }}
	]')
insert into reviewed_products (id, name, price, reviews) values (3, 'Seat', 40, null)

insert into reviewed_products (id, name, price, reviews) values (4, 'Rim', 35,  '[
		{"Reviewer":{"Name": "Sally Mander", "Rating" : 4 }}, 
		{"Reviewer":{"Name": "Artie Choke", "Rating" : 4 }},
		{"Reviewer":{"Name": "Erin Detyers","Email": "edt@mail.com",  "Rating" : 5 }}
        	]')

insert into reviewed_products (id, name, price, reviews) values (5, 'Tire', 30,  '[
		{"Reviewer":{"Name": "Penny Pincher", "Email" : "pp@mail.com", "Rating" : 1 }}, 
		{"Reviewer":{"Name": "Alice Ofchores", "Email" : "aoc@mail.com", "Rating" : 2 }}

]')

-- simple query of reviews
select * from reviewed_products
select id, name,price, JSON_QUERY(reviews) as Reviews from reviewed_products


