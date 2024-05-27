use demo 
go

drop table if exists rainbow_colors
drop table if exists flag_colors
GO

create table rainbow_colors
(
    color varchar(20) not null,
    color_type varchar(20) not null,
    constraint pk_rainbow_colors_color primary key (color)
)

create table flag_colors 
(
    color varchar(20) not null,
    country varchar(20) not null,
    constraint pk_flag_colors_color primary key (color, country)
)

GO

insert into rainbow_colors (color, color_type) values
 ('red', 'rainbow'),
 ('orange', 'rainbow'),
 ('yellow', 'rainbow'),
 ('green', 'rainbow'),
 ('blue', 'rainbow'),
 ('purple', 'rainbow')

 insert into flag_colors (color, country) VALUES
 ('red', 'USA'),
 ('white','USA' ),
 ('blue', 'USA' ),
 ('red', 'MEX'),
 ('white','MEX' ),
 ('green', 'MEX' )
 
