-- teams
create table if not exists teams (
  description text,
  id serial primary key
);
insert into teams (description)
select distinct (team)
from import.master_plan
where not exists (select description from teams);

-- spass_types
create table if not exists spass_types (
  description text,
  id serial primary key
);
insert into spass_types (description)
select distinct (spass_type)
from import.master_plan
where not exists (select description from spass_types);

-- targets
create table if not exists targets (
  description text,
  id serial primary key
);
insert into targets (description)
select distinct (target)
from import.master_plan
where not exists (select description from targets);

-- requests
create table if not exists requests (
  description text,
  id serial primary key
);
insert into requests (description)
select distinct (request_name)
from import.master_plan
where not exists (select description from requests);

-- event_types
create table if not exists event_types (
  description text,
  id serial primary key
);
insert into event_types (description)
select distinct (library_definition)
from import.master_plan
where not exists (select description from event_types);


