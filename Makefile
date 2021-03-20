ZIP = http://archive.redfour.io/cassini/cassini_data.zip

all : data

cassini_data.zip :
	wget $(ZIP)

data : cassini_data.zip
	unzip cassini_data.zip curious_data/data/*
	find . -name '.DS_Store' -type f -delete
	mv curious_data/data data
	rm -rf curious_data
	sed -i 's//\n/g' data/master_plan.csv
