-- delete the extra row that was inserted
DELETE FROM animals
WHERE id = 6;

-- ALL TRANSACTIONS

-- Begin transaction 1
BEGIN;

--  Update data
UPDATE animals 
SET species = 'unspecified';

-- To verify the changes
SELECT species FROM animals;

-- Rollback transaction
ROLLBACK;

-- Verify change after rollback
SELECT * FROM animals;


-- Begin transaction 2
BEGIN;
UPDATE animals SET species = 'digimon' WHERE name LIKE '%mon%';
UPDATE animals SET species = 'pokemon' WHERE species is NULL;
COMMIT;
SELECT * FROM animals;


-- Begin transaction 3
BEGIN;
DELETE FROM animals;
SELECT * FROM animals;
ROLLBACK;


-- Begin transaction 4
BEGIN;

DELETE FROM animals
WHERE date_of_birth > '2022-01-01';

-- create savepoint
SAVEPOINT SP1;

UPDATE animals
SET weight_kg = weight_kg * -1;

ROLLBACK TO SP1;

UPDATE animals
SET weight_kg = weight_kg * -1 WHERE weight_kg < 0;

COMMIT;
