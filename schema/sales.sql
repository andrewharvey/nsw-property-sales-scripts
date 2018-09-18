
--CREATE DOMAIN psi.district_code AS char(3);
--CREATE DOMAIN psi.property_id AS char(10);
--CREATE DOMAIN psi.property_name AS char(40);

CREATE TYPE psi.nature_of_property AS ENUM (
    'Vacant',
    'Residence',
    'Other'
);

CREATE TYPE psi.area_type AS ENUM (
    'square meters',
    'hectares'
);

CREATE UNLOGGED TABLE psi.sales
(
    "property_id",
    "property_name",
    "property_unit_number",
    "property_house_number",
    "property_street_name",
    "property_locality",
    "property_postcode",
    "area",
    "area_type",
    "land_description",
    "dimensions",
    "contract_date",
    "settlement_date",
    "purchase_price",
    "zone",
    "nature_of_property",
    "primary_purpose",
    "strata_lot_number"
) AS
SELECT
    "property_id"::integer AS property_id,
    NULL AS property_name,
    "unit_number" AS property_unit_number,
    "house_number" AS property_house_number,
    "street_name" AS property_street_name,
    "suburb_name" AS property_locality,
    "postcode" AS property_postcode,
    "area"::numeric AS area,
    CASE
        WHEN "area_type" = 'M' THEN 'square meters'
        WHEN "area_type" = 'H' THEN 'hectares'
        ELSE NULL
    END AS area_type,
    "land_description" AS land_description,
    "dimensions" AS dimensions,
    to_date("contract_date", 'DD/MM/YYYY') AS contract_date,
    NULL AS settlement_date,
    "purchase_price" AS purchase_price,
    "zone_code" AS zone,
    NULL AS nature_of_property,
    NULL AS primary_purpose,
    NULL AS strata_lot_number
FROM psi.sales_archived_raw
UNION
SELECT
    "property_id"::integer AS property_id,
    "property_name" AS property_name,
    "property_unit_number" AS property_unit_number,
    "property_house_number" AS property_house_number,
    "property_street_name" AS property_street_name,
    "property_locality" AS property_locality,
    "property_postcode" AS property_postcode,
    "area"::numeric AS area,
    CASE
        WHEN "area_type" = 'M' THEN 'square meters'
        WHEN "area_type" = 'H' THEN 'hectares'
        ELSE NULL
    END AS area_type,
    NULL AS land_description,
    NULL AS dimensions,
    to_date("contract_date", 'YYYYMMDD') AS contract_date,
    to_date("settlement_date", 'YYYYMMDD') AS settlement_date,
    "purchase_price" AS purchase_price,
    "zoning" AS zone,
    CASE
        WHEN "nature_of_property" = 'R' THEN 'Residence'
        WHEN "nature_of_property" = 'V' THEN 'Vacant'
        WHEN "nature_of_property" = '3' THEN 'Other'
        ELSE NULL
    END AS nature_of_property,
    "primary_purpose" AS primary_purpose,
    "strata_lot_number" AS strata_lot_number
FROM psi.sales_current_raw
;
