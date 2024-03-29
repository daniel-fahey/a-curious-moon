ZIP = http://archive.redfour.io/cassini/cassini_data.zip
DB = enceladus

IMPORT = master_plan
TABLES = master_plan dims fact

all : load_data create_tables

print-% : ; @echo $($*) | tr " " "\n"

load_data : $(patsubst %, import/%, $(IMPORT))
create_tables : $(patsubst %, create_table_%, $(TABLES))

sql_% : sql/%.sql
	psql $(DB) -f $<

create_table_% : sql/tables/%.sql | sql_init
	psql $(DB) -f $<

drop_table_% :
	psql $(DB) -c "drop table if exists $* cascade"

import/master_plan : data/master_plan.csv | create_table_master_plan
	@mkdir -p import
	cat $< | psql $(DB) -c \
	"\copy import.master_plan from STDIN with delimiter ',' header csv;" \
	&& touch $@

cassini_data.zip :
	wget $(ZIP)

data : cassini_data.zip
	unzip cassini_data.zip curious_data/data/*
	mv curious_data/data data
	rm -rf curious_data
	find data -name '.DS_Store' -type f -delete
	find data -type f -print0 | xargs -0 mac2unix
