CREATE TABLE buildings (
    egid BIGINT PRIMARY KEY,  -- Assuming 'egid' as a unique identifier
    buildingStatus INT,
    buildingCategory INT,
    buildingClass INT,
    municipalityNumber INT,
    municipalityName VARCHAR(255),
    canton VARCHAR(2),  -- Assuming canton codes are two letters
    geometry GEOMETRY(POINT, 4326),  -- Geometry in WGS 84
    geometry_wkt TEXT,  -- Well-Known Text representation of the geometry
    longitude DOUBLE PRECISION,
    latitude DOUBLE PRECISION
);