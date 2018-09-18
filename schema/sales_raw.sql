DROP SCHEMA IF EXISTS psi CASCADE;
CREATE SCHEMA psi;

CREATE DOMAIN psi.zone AS char(4);
CREATE UNLOGGED TABLE psi.zones
(
    "code" psi.zone PRIMARY KEY,
    "name" text,
    "class" text
);

-- http://www.valuergeneral.nsw.gov.au/__data/assets/pdf_file/0014/216401/Archived_Property_Sales_Data_File_Format_1990_to_2001_V2.pdf
CREATE UNLOGGED TABLE psi.sales_archived_raw
(
    "record_type" char(1),
    "district_code" char(3),
    "source" char(8),
    "valuation_number" char(16),
    "property_id" numeric(10),
    "unit_number" char(6),
    "house_number" char(14),
    "street_name" char(30),
    "suburb_name" char(40),
    "postcode" char(9),
    "contract_date" char(10),
    "purchase_price" numeric(12),
    "land_description" text,
    "area" char(10),
    "area_type" char(1),
    "dimensions" char(40),
    "comp_code" char(2),
    "zone_code" char(4),
    "vendor_name" text,
    "purchaser_name" text
);

-- http://www.valuergeneral.nsw.gov.au/__data/assets/pdf_file/0015/216402/Current_Property_Sales_Data_File_Format_2001_to_Current.pdf
CREATE UNLOGGED TABLE psi.sales_current_raw
(
    "record_type" char(1),
    "district_code" char(3),
    "property_id" char(10),
    "sale_counter" text,
    "download_date_time" char(16),
    "property_name" char(40),
    "property_unit_number" char(10),
    "property_house_number" char(10),
    "property_street_name" text,
    "property_locality" char(40),
    "property_postcode" char(4),
    "area" numeric,
    "area_type" char(1),
    "contract_date" char(8),
    "settlement_date" char(8),
    "purchase_price" bigint,
    "zoning" char(4),
    "nature_of_property" char(1),
    "primary_purpose" text,
    "strata_lot_number" smallint,
    "component_code" char(3),
    "sale_code" char(3),
    "percent_of_interest_sale" char(3),
    "dealing_number" char(10)
);
