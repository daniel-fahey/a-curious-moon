ZIP=http://archive.redfour.io/cassini/cassini_data.zip
DB=enceladus
BUILD=${CURDIR}/build.sql
SCRIPTS=${CURDIR}/scripts
CSV='${CURDIR}/data/master_plan.csv'
MASTER=$(SCRIPTS)/import.sql
NORMALISE=$(SCRIPTS)/normalise.sql

all: normalise
	psql $(DB) -f $(BUILD)

cassini_data.zip:
	wget $(ZIP)

data: cassini_data.zip
	unzip cassini_data.zip curious_data/data/*
	find . -name '.DS_Store' -type f -delete
	mv curious_data/data data
	rm -rf curious_data

data/master_plan.csv: data
	sed -i 's//\n/g' data/master_plan.csv

master:
	@cat $(MASTER) >> $(BUILD)

import: master data/master_plan.csv
	@echo \
	"COPY import.master_plan\
	 FROM $(CSV)\
	 WITH DELIMITER ',' HEADER CSV;" >> $(BUILD)

normalise: import
	@cat $(NORMALISE) >> $(BUILD)

clean:
	@rm -rf $(BUILD)
