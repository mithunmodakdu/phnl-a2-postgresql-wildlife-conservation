-- Active: 1747559888393@@127.0.0.1@5432@conservation_db
CREATE DATABASE conservation_db;

CREATE TABLE rangers(
  ranger_id SERIAL PRIMARY KEY,
  name VARCHAR(50) NOT NULL,
  region VARCHAR(100) NOT NULL
);

SELECT * FROM rangers;

INSERT INTO rangers(ranger_id, name, region)
  VALUES
    (1, 'Alice Green', 'Northern Hills'),
    (2, 'Bob White', 'River Delta'),
    (3, 'Carol King', 'Mountain Range');


CREATE TABLE species(
  species_id SERIAL PRIMARY KEY,
  common_name VARCHAR(100) NOT NULL,
  scientific_name VARCHAR(100) NOT NULL,
  discovery_date DATE NOT NULL,
  conservation_status VARCHAR(50) NOT NULL
);

SELECT * FROM species;

INSERT INTO species(common_name, scientific_name, discovery_date, conservation_status)
  VALUES 
    ('Snow Leopard', 'Panthera uncia', '1775-01-01', 'Endangered'),
    ('Bengal Tiger', 'Panthera tigris tigris', '1758-01-01', 'Endangered'),
    ('Red Panda', 'Ailurus fulgens', '1825-01-01', 'Vulnerable'),
    ('Asiatic Elephant', 'Elephas maximus indicus', '1758-01-01', 'Endangered');

CREATE TABLE sightings(
  sighting_id SERIAL PRIMARY KEY,
  species_id INTEGER REFERENCES species(species_id),
  ranger_id INTEGER REFERENCES rangers(ranger_id),
  location VARCHAR(100) NOT NULL,
  sighting_time TIMESTAMP NOT NULL,
  notes TEXT
);

SELECT * FROM sightings;

INSERT INTO sightings (species_id, ranger_id, location, sighting_time, notes)
  VALUES
    (1, 1, 'Peak Ridge', '2024-05-10 07:45:00', 'Camera trap image captured' ),
    (2, 2, 'Bankwood Area', '2024-05-12 16:20:00', 'Juvenile seen' ),
    (3, 3, 'Bamboo Grove East', '2024-05-15 09:10:00', 'Feeding observed' ),
    (1, 2, 'Snowfall Pass ', '2024-05-18 18:30:00', NULL);



-- Problem 1
INSERT INTO rangers(name, region)
  VALUES
    ('Derek Fox', 'Coastal Plains');


-- Problem 2
SELECT COUNT(DISTINCT species_id) AS "unique_species_count" FROM sightings;


-- Problem 3
SELECT * FROM sightings
  WHERE location LIKE '%Pass%';


-- Problem 4
SELECT r.name, COUNT(s.sighting_id) AS "total_sightings" FROM rangers AS r
  JOIN sightings AS s ON r.ranger_id = s.ranger_id
  GROUP BY r.name
  ORDER BY r.name;
  
  
-- Problem 5
SELECT sp.common_name FROM species AS sp 
  FULL OUTER JOIN sightings AS s ON sp.species_id = s.species_id
  WHERE s.species_id IS NULL;


-- Problem 6
SELECT sp.common_name, s.sighting_time, r.name FROM sightings AS s
  JOIN species AS sp ON s.species_id = sp.species_id
  JOIN rangers AS r ON s.ranger_id = r.ranger_id
  ORDER BY s.sighting_time DESC
  LIMIT 2;


-- Problem 7
UPDATE species
  SET conservation_status = 'Historic'
  WHERE EXTRACT(YEAR FROM discovery_date) < 1800;


-- Problem 8
SELECT s.sighting_id, td.time_of_day FROM sightings AS s
  JOIN (
    VALUES
    ('Morning', 0, 12),
    ('Afternoon', 12, 17),
    ('Evening', 17, 24)
  ) AS td(time_of_day, start_hour, end_hour)
  ON EXTRACT(HOUR FROM s.sighting_time) >= td.start_hour
  AND EXTRACT(HOUR FROM s.sighting_time) < td.end_hour;


-- Problem 9
DELETE FROM rangers 
WHERE ranger_id = (SELECT r.ranger_id FROM rangers AS r 
  FULL OUTER JOIN sightings AS s ON r.ranger_id = s.ranger_id
  WHERE s.ranger_id IS NULL);

