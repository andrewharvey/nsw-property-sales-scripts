# nsw-property-sales-scripts

UNIX scripts to work with [NSW Property Sales data](https://valuation.property.nsw.gov.au/embed/propertySalesInformation).

- Download data `make download`
- Extract `make unzip`
- Load into PostgreSQL `make pgschema load sales`
- Export to CSV `make csv`

# Matching to NSW Property

- Download a static NSW Property database from https://s3.amazonaws.com/data.openaddresses.io/runs/489246/cache.zip
- `unzip cache.zip`
- `ogr2ogr -f PostgreSQL PG:dbname=geo /vsizip/cache.zip/NSW_Property_Sept18.geojson -nln nsw_property`
- `psql -c 'CREATE INDEX property_id_idx ON psi.sales (property_id);'
- `psql -c 'CREATE INDEX propid_idx ON nsw_property (propid);'
- `psql -c 'CREATE TABLE sales_geometry AS SELECT sales.*, ST_Centroid(nsw_property.wkb_geometry) AS geometry FROM psi.sales_top sales LEFT OUTER JOIN nsw_property ON (sales.property_id = nsw_property.propid);'`
