create table if not exists events(
  id serial primary key,
  time_stamp timestamptz not null,
  title varchar(500),
  description text,
  event_type_id int references event_types(id),
  target_id int references targets(id),
  team_id int references teams(id),
  request_id int references requests(id),
  spass_type_id int references spass_types(id)
);

insert into events(
  time_stamp,
  title,
  description,
  event_type_id,
  target_id,
  team_id,
  request_id,
  spass_type_id
)
select
  import.master_plan.start_time_utc::timestamp without time zone at time zone 'UTC',
  import.master_plan.title,
  import.master_plan.description,
  event_types.id,
  targets.id,
  teams.id,
  requests.id,
  spass_types.id
from import.master_plan
left join event_types
        on event_types.description
        = import.master_plan.library_definition
left join targets
        on targets.description
        = import.master_plan.target
left join teams
        on teams.description
        = import.master_plan.team
left join requests
        on requests.description
        = import.master_plan.request_name
left join spass_types
        on spass_types.description
        = import.master_plan.spass_type
where not exists (select * from events);
