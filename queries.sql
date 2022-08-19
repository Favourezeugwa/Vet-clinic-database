/*Queries that provide answers to the questions from all projects.*/

SELECT * FROM animals WHERE name LIKE '%mon%';
SELECT name FROM animals WHERE date_of_birth BETWEEN '2016-01-01' AND '2019-12-31';
SELECT name FROM animals WHERE neutered = true AND escape_attempts < 3;
SELECT date_of_birth FROM animals WHERE name = 'Agumon' OR name = 'Pikachu';
SELECT name, escape_attempts FROM animals WHERE weight_kg > 10.5;
SELECT * FROM animals WHERE neutered = true;
SELECT * FROM animals WHERE name != 'Gabumon';
SELECT * FROM animals WHERE weight_kg BETWEEN 10.4 AND 17.3;

SELECT COUNT(id) FROM animals;
SELECT COUNT (*) FROM animals WHERE escape_attempts = 0;
SELECT AVG(weight_kg) FROM animals;
SELECT neutered, SUM(escape_attempts) FROM animals GROUP BY neutered;
SELECT species, MIN(weight_kg), MAX(weight_kg) FROM animals GROUP BY species;
SELECT species, AVG(escape_attempts) 
FROM animals 
WHERE date_of_birth BETWEEN '1990-01-01' AND '2000-12-31' 
GROUP BY species;



/* QUERIES FOR JOIN MULTIPLE TABLES */

-- SELECT table1.column1, table2.column2...
-- FROM table1
-- INNER JOIN table2
-- ON table1.common_field = table2.common_field
-- WHERE table.column = 'value'
-- GROUP BY table.column
-- ORDER BY table1.column1, table2.column2;

-- 1. What animals belong to Melody Pond?
SELECT animals.name 
FROM animals 
INNER JOIN owners 
ON animals.owner_id = owners.id 
WHERE owners.full_name = 'Melody Pond';

-- 2. List of all animals that are pokemon (their type is Pokemon).
SELECT animals.name
FROM animals
INNER JOIN species
ON animals.species_id = species.id
WHERE species.name = 'Pokemon';

-- 3. List all owners and their animals
SELECT owners.full_name,animals.name
FROM owners
LEFT JOIN animals 
ON owners.id = animals.owner_id;

-- 4. How many animals are there per species?
SELECT species.name, COUNT(animals.name)
FROM animals
INNER JOIN species
ON animals.species_id = species.id
GROUP BY species.name;

-- 5. List all Digimon owned by Jennifer Orwell
SELECT animals.name
FROM animals
INNER JOIN owners
ON animals.owner_id = owners.id
WHERE owners.full_name = 'Jennifer Orwell';

-- 6. List all animals owned by Dean Winchester that haven't tried to escape
SELECT animals.name
FROM animals
INNER JOIN owners
ON animals.owner_id = owners.id
WHERE owners.full_name = 'Dean Winchester' AND animals.escape_attempts = 0;

-- 7. Who owns the most animals?
SELECT owners.full_name, COUNT(animals.name)
FROM owners
LEFT JOIN animals
ON owners.id = animals.owner_id
GROUP BY owners.full_name
ORDER BY COUNT(animals.name) DESC;
