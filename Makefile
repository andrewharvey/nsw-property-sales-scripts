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

property:
	wget https://s3.amazonaws.com/data.openaddresses.io/runs/489246/cache.zip
	unzip cache.zip
	ogr2ogr -f PostgreSQL PG: NSW_Property_Sept18.geojson -lco SCHEMA=psi -lco UNLOGGED=YES -nln property
	psql -f schema/sales_geometry.sql

dump:
	mkdir -p output
	pg_dump --schema=psi --no-owner | pxz --stdout > output/nsw-property-sales.sql.gz

csv:
	mkdirp -p output
	psql -c "COPY psi.sales TO PROGRAM 'pxz --stdout > output/nsw-property-sales.csv.xz' WITH CSV HEADER;"
	ogr2ogr -f GeoJSON output/nsw-property-sales.geojson PG: psi.sales_geometry
	pxz output/nsw-property-sales.geojson
