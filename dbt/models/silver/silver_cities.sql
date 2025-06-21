-- Clean reference table with standardized city data and geolocation
select *
from (values
  -- (city_sk, name, country, latitude, longitude)
  (1,  'Arequipa',         'PER', -16.4090, -71.5375),
  (2,  'Barranquilla',     'COL',  10.9685, -74.7813),
  (3,  'Bogotá',           'COL',   4.7110, -74.0721),
  (4,  'Buenos Aires',     'ARG', -34.6037, -58.3816),
  (5,  'Cali',             'COL',   3.4516, -76.5320),
  (6,  'Ciudad de México', 'MEX',  19.4326, -99.1332),
  (7,  'Concepción',       'CHL', -36.8201, -73.0444),
  (8,  'Córdoba',          'ARG', -31.4201, -64.1888),
  (9,  'Guadalajara',      'MEX',  20.6597, -103.3496),
  (10, 'Lima',             'PER', -12.0464, -77.0428),
  (11, 'Medellín',         'COL',   6.2442, -75.5812),
  (12, 'Monterrey',        'MEX',  25.6866, -100.3161),
  (13, 'Rosario',          'ARG', -32.9587, -60.6930),
  (14, 'Santiago',         'CHL', -33.4489, -70.6693),
  (15, 'Trujillo',         'PER',  -8.1091, -79.0215),
  (16, 'Valparaíso',       'CHL', -33.0472, -71.6127)
) as t(
  city_sk,   -- Surrogate key for city
  name,      -- Standardized city name
  country,   -- ISO-3 country code
  latitude,  -- Latitude coordinate
  longitude  -- Longitude coordinate
)
