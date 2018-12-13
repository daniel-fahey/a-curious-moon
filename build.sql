create schema if not exists import;
drop table if exists import.master_plan;
create table import.master_plan(
	start_time_utc text,
	duration text,
	date text,
	team text,
	spass_type text,
	target text,
	request_name text,
	library_definition text,
	title text,
	description text	
);

\copy import.master_plan from 'data/master_plan.csv' with delimiter ',' header csv;
