-- Create buffers around major roads
WITH lake_buffers AS (
	SELECT 
		osm_id,
		ST_Perimeter(ST_Transform(p.way,4326)::geography) AS lake_umfang,
		ST_Transform(ST_Buffer(p.way::geometry, 150), 4326) AS buffer_geom,
		ST_Transform(p.way::geometry, 4326) AS lake
	FROM public.planet_osm_polygon AS p
	WHERE
		p.water = 'lake' and ST_Perimeter(ST_Transform(p.way,4326)::geography) >= 10000
),
-- Preselection of buildings (to reduce data size)
bike_ways AS (
	SELECT
	  osm_id,
	  name,
	  way AS geom
	FROM
	  planet_osm_line
	WHERE
	  (highway IN ('cycleway', 'path', 'footway', 'bridleway', 'track', 'residential', 'tertiary', 'tertiary_link', 'secondary', 'secondary_link', 'service')
	   AND (bicycle IS NOT NULL AND bicycle <> 'no'))
	  OR
	  (highway NOT IN ('motorway', 'motorway_link', 'trunk', 'trunk_link', 'primary', 'primary_link')
	   AND (bicycle IS NULL OR bicycle <> 'no'))
)
-- Select buildings inside supermarket buffers
SELECT
    b.geom AS building_geom,
    l.osm_id,
    l.buffer_geom AS buffer_geom
FROM
    bike_ways AS b
JOIN
    lake_buffers AS l ON ST_Intersects(b.geom, l.buffer_geom);