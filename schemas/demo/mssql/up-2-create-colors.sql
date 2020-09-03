use demo 
go

drop table if exists rainbow_colors
drop table if exists flag_colors
GO

create table rainbow_colors
(
    color varchar(20) not null,
    constraint pk_rainbow_colors_color primary key (color)
)

create table flag_colors 
(
    color varchar(20) not null,
    constraint pk_flag_colors_color primary key (color)
)

GO

insert into rainbow_colors (color) values
 ('red'),
 ('orange'),
 ('yellow'),
 ('green'),
 ('blue'),
 ('purple')

 insert into flag_colors (color) VALUES
 ('red'),
 ('white'),
 ('blue')
