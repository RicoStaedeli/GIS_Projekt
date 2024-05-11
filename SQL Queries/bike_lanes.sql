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
   AND (bicycle IS NULL OR bicycle <> 'no'));