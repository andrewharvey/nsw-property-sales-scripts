all: download unzip pgschema load sales

download:
	./nsw-property-sales-mirror

unzip:
	./nsw-property-sales-unzip

pgschema:
	psql -f schema/sales_raw.sql
	cat schema/zones.csv | psql -c "COPY psi.zones FROM STDIN WITH DELIMITER ',';"

validate_raw_data:
	#cat schema/zones.csv | psql -c "COPY psi.sales_raw_b FROM STDIN WITH DELIMITER ',';"
	./validate.sh

load:
	./load.sh

sales:
	psql -f schema/sales.sql

