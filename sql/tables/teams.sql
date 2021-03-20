create table if not exists teams as
  select distinct(team)
  as description
  from import.master_plan;

alter table teams
add id serial primary key;
