SELECT
  osm_id,              
  name,                 
  way AS geometry       
FROM
  planet_osm_point     
WHERE
  railway = 'station'; 
