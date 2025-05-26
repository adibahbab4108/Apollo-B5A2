-- Active: 1747405685788@@127.0.0.1@5432@conservation_db
-- Active: 1747405685788@@127.0.0.1@5432@conservation_db
CREATE DATABASE conservation_db;

DROP TABLE rangers;

DROP TABLE species;

DROP TABLE sightings;

CREATE TABLE rangers (
    ranger_id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    region TEXT
)

CREATE TABLE species (
    species_id SERIAL PRIMARY KEY,
    common_name VARCHAR(100) NOT NULL,
    scientific_name VARCHAR(150) NOT NULL UNIQUE,
    discovery_date DATE,
    conservation_status VARCHAR(50) CHECK (
        conservation_status IN ('Vulnerable', 'Endangered')
    )
);

ALTER TABLE species
DROP CONSTRAINT species_conservation_status_check;

ALTER TABLE species
ADD CONSTRAINT species_conservation_status_check CHECK (
    conservation_status IN (
        'Vulnerable',
        'Endangered',
        'Historic'
    )
)

CREATE TABLE sightings (
    sighting_id SERIAL PRIMARY KEY,
    ranger_id INT NOT NULL,
    species_id INT NOT NULL,
    sighting_time TIMESTAMP NOT NULL,
    location VARCHAR(255) NOT NULL,
    notes TEXT,
    FOREIGN KEY (ranger_id) REFERENCES rangers (ranger_id) ON DELETE CASCADE,
    FOREIGN KEY (species_id) REFERENCES species (species_id) ON DELETE CASCADE
);

INSERT INTO
    rangers (name, region)
VALUES (
        'Alice Greeen',
        ' Northern Hills'
    ),
    ('Bob White', 'River Delta'),
    (
        'Carol King',
        'Mountain Range'
    );

INSERT INTO
    species (
        common_name,
        scientific_name,
        discovery_date,
        conservation_status
    )
VALUES (
        'Snow Leopard',
        'Panthera uncia',
        '1775-01-01',
        'Endangered'
    ),
    (
        'Bengal Tiger',
        'Panthera tigris tigris',
        '1758-01-01',
        'Endangered'
    ),
    (
        'Red Panda',
        'Ailurus fulgens',
        '1825-01-01',
        'Vulnerable'
    ),
    (
        'Asiatic Elephant',
        'Elephas maximus indicus',
        '1758-01-01',
        'Endangered'
    );

INSERT INTO
    sightings (
        species_id,
        ranger_id,
        location,
        sighting_time,
        notes
    )
VALUES (
        1,
        1,
        'Peak Ridge',
        '2024-05-10 07:45:00',
        'Camera trap image captured'
    ),
    (
        2,
        2,
        'Bankwood Area',
        '2024-05-12 16:20:00',
        'Juvenile seen'
    ),
    (
        3,
        3,
        'Bamboo Grove East',
        '2024-05-15 09:10:00',
        'Feeding observed'
    ),
    (
        1,
        2,
        'Snowfall Pass',
        '2024-05-18 18:30:00',
        NULL
    );

SELECT * FROM sightings

SELECT * FROM rangers

SELECT * FROM species

-- 1️⃣ Register a new ranger with provided data with name = 'Derek Fox' and region = 'Coastal Plains'
INSERT INTO
    rangers (name, region)
VALUES ('Derek Fox', 'Coastal Plains');

-- 2️⃣ Count unique species ever sighted.
SELECT COUNT(DISTINCT species_id) FROM sightings;

-- 3️⃣ Find all sightings where the location includes "Pass".
SELECT * FROM sightings WHERE location LIKE '%Pass%';

-- 4️⃣ List each ranger's name and their total number of sightings.
SELECT rangers.name, COUNT(species_id) as number_of_sightings
FROM rangers
    LEFT JOIN sightings ON rangers.ranger_id = sightings.ranger_id
GROUP BY
    rangers.name;

-- 5️⃣ List species that have never been sighted.
SELECT *
FROM species
WHERE
    species.species_id NOT IN (
        SELECT species_id
        FROM sightings
    );

-- 6️⃣ Show the most recent 2 sightings.
SELECT common_name, sighting_time, name
FROM
    sightings
    JOIN rangers ON sightings.ranger_id = rangers.ranger_id
    JOIN species ON sightings.species_id = species.species_id
ORDER BY sighting_time DESC
LIMIT 2;

-- 7️⃣ Update all species discovered before year 1800 to have status 'Historic'.
UPDATE species
SET
    conservation_status = 'Historic'
WHERE
    EXTRACT(
        YEAR
        FROM discovery_date
    ) < 1800;

-- 8️⃣ Label each sighting's time of day as 'Morning', 'Afternoon', or 'Evening'.
SELECT
    sighting_id,
    location,
    CASE
        WHEN EXTRACT(
            HOUR
            FROM sighting_time
        ) BETWEEN 5 AND 11  THEN 'Morning'
        WHEN EXTRACT(
            HOUR
            FROM sighting_time
        ) BETWEEN 12 AND 17  THEN 'Afternoon'
        WHEN EXTRACT(
            HOUR
            FROM sighting_time
        ) BETWEEN 18 AND 21  THEN 'Evening'
        ELSE 'Night'
    END AS time_of_day
FROM sightings;

-- 9️⃣ Delete rangers who have never sighted any species
DELETE FROM rangers
WHERE
    NOT EXISTS (
        SELECT *
        FROM sightings
        WHERE
            sightings.ranger_id = rangers.ranger_id
    );
