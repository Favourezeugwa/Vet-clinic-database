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


/* PROJECT DAY 4 - QUERIES FOR JOIN MULTIPLE TABLES WITH CONDITIONS */

-- 1. Who was the last animal seen by William Tatcher?
SELECT animals.name, visits.date_of_visit
FROM animals
INNER JOIN visits ON visits.animals_id = animals.id
INNER JOIN vets ON visits.vets_id = vets.id
WHERE vets.name = 'William Tatcher'
ORDER BY visits.date_of_visit DESC
LIMIT 1;

-- 2. How many different animals did Stephanie Mendez see?
SELECT COUNT(animals.name)
FROM animals
INNER JOIN visits ON visits.animals_id = animals.id
INNER JOIN vets ON visits.vets_id = vets.id
WHERE vets.name = 'Stephanie Mendez';

-- 3. List all vets and their specialties, including vets with no specialties.
SELECT vets.name AS vets_name, species.name AS species_name
FROM vets
LEFT JOIN specializations ON specializations.vets_id = vets.id
LEFT JOIN species ON species.id = specializations.species_id;

-- 4. List all animals that visited Stephanie Mendez between April 1st and August 30th, 2020.
SELECT animals.name, visits.date_of_visit AS date_of_visit
FROM animals
INNER JOIN visits ON visits.animals_id = animals.id
INNER JOIN vets ON vets.id = visits.vets_id
WHERE vets.name = 'Stephanie Mendez'
AND visits.date_of_visit BETWEEN '2020-04-01' AND '2020-08-30';

-- 5. What animal has the most visits to vets?
SELECT animals.name, COUNT(visits.date_of_visit) AS total_visits
FROM animals
INNER JOIN visits ON visits.animals_id = animals.id
GROUP BY animals.name
ORDER BY total_visits DESC;

-- 6. Who was Maisy Smith's first visit?
SELECT animals.name, visits.date_of_visit
FROM animals
INNER JOIN visits ON visits.animals_id = animals.id
INNER JOIN vets ON vets.id = visits.vets_id
WHERE vets.name = 'Maisy Smith'
ORDER BY date_of_visit ASC LIMIT 1;

-- 7. Details for most recent visit: animal information, vet information, and date of visit.
SELECT animals.name AS animal_name, animals.date_of_birth, animals.neutered, animals.escape_attempts, animals.weight_kg, vets.name AS vets_name, visits.date_of_visit AS date_visited
FROM animals
INNER JOIN visits ON visits.animals_id = animals.id
INNER JOIN vets ON vets.id = visits.vets_id
ORDER BY date_visited DESC LIMIT 1;

-- 8. How many visits were with a vet that did not specialize in that animal's species?
SELECT COUNT(visits.animals_id)
FROM visits
INNER JOIN vets ON visits.vets_id = vets.id
INNER JOIN animals ON animals.id = visits.animals_id
INNER JOIN specializations ON specializations.species_id = vets.id
WHERE specializations.species_id != animals.species_id;

-- 9. What specialty should Maisy Smith consider getting? Look for the species she gets the most.
SELECT species.name AS specie, COUNT(visits.animals_id) AS visits
FROM visits
INNER JOIN vets ON vets.id = visits.vets_id
INNER JOIN animals ON animals.id = visits.animals_id
INNER JOIN species ON species.id = animals.species_id
WHERE vets.name = 'Maisy Smith'
GROUP BY species.name
ORDER BY visits DESC;


/* PROJECT - DATABASE PERFORMANCE AUDIT DAY 1 */
EXPLAIN ANALYZE SELECT COUNT(*) FROM owners WHERE animals_id = 4;
EXPLAIN ANALYZE SELECT * FROM visits where vets_id = 2;
EXPLAIN ANALYZE SELECT * FROM owners where email = 'owner_18327@mail.com';