use demo

/*
+-----------+          +---------+
| bbplayers |>0------0|| bbteams |
+-----------+          +---------+

Basketball Player plays on 0 or 1 Basketball Teams
Basketball Team has 0 or Many Basketball Players

*/

create table bbplayers
(
    player_id int not null,
    player_name varchar(20) not null,
    player_team_id int null,
    constraint pk_bbplayers_player_id primary key (player_id)
)

create table bbteams
(
    team_id int not null,
    team_name varchar(20) not null,
    constraint pk_bbteams_team_id primary key (team_id)
)

alter table bbplayers add
    constraint fk_bbplayers_player_team_id foreign key (player_team_id)
        references bbteams (team_id)

insert into bbteams 
    (team_id, team_name) 
values
    (101, 'Bulls'),
    (102, 'Lakers'),
    (103, 'Stinkers')

insert into bbplayers 
    (player_id, player_name, player_team_id)
values
    (1, 'Jordan', 101),
    (2, 'O''Neal', 102),
    (3, 'Pippen', 101),
    (4, 'Bryant', 102),
    (5, 'Fudge', NULL)

