	SELECT 
		osm_id,
		ST_Perimeter(ST_Transform(p.way,4326)::geography) AS lake_umfang,
		ST_Transform(ST_Buffer(p.way::geometry, 1000), 4326) AS buffer_geom,
		ST_Transform(p.way::geometry, 4326) AS lake
	FROM public.planet_osm_polygon AS p
	WHERE
		p.water = 'lake' and ST_Perimeter(ST_Transform(p.way,4326)::geography) >= 10000