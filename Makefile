ZIP = http://archive.redfour.io/cassini/cassini_data.zip

all : data

cassini_data.zip :
	wget $(ZIP)

data : cassini_data.zip
	unzip cassini_data.zip curious_data/data/*
	mv curious_data/data data
	rm -rf curious_data
	find data -name '.DS_Store' -type f -delete
	find data -type f -print0 | xargs -0 mac2unix
