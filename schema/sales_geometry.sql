CREATE INDEX property_id_idx ON psi.sales (property_id);
CREATE INDEX propid_idx ON psi.property (propid);

CREATE TABLE psi.sales_geometry AS
    SELECT
        sales.*,
        ST_Centroid(property.wkb_geometry) AS geom
    FROM
        psi.sales sales
        LEFT OUTER JOIN
        psi.property property
        ON (sales.property_id = nsw_property.propid);
