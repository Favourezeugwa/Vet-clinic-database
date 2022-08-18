/* Database schema to keep the structure of entire database. */

-- create database
CREATE DATABASE vet_clinic;

-- create table
CREATE TABLE animals(
  id INT NOT NULL GENERATED ALWAYS AS IDENTITY,
  name VARCHAR(250) NOT NULL,
  date_of_birth date NOT NULL,
  escape_attempts INT NOT NULL,
  neutered boolean NOT NULL,
  weight_kg decimal NOT NULL,
  PRIMARY KEY(id)
);

-- Add a new column to the table
ALTER TABLE animals ADD COLUMN species VARCHAR(250);


/* PROJECT MULTIPLE TABLES */

-- create a new table for owners
CREATE TABLE owners(
  id INT NOT NULL GENERATED ALWAYS AS IDENTITY,
  full_name VARCHAR(250) NOT NULL,
  age INT NOT NULL,
  PRIMARY KEY(id)
);

-- create a new table for species
CREATE TABLE species(
  id INT NOT NULL GENERATED ALWAYS AS IDENTITY,
  name VARCHAR(250) NOT NULL,
  PRIMARY KEY(id)
);


-- modify animals table 

-- remove the species column
ALTER TABLE animals DROP COLUMN species;

-- add a new column species_id to the animal table
ALTER TABLE animals ADD COLUMN species_id INT;

ALTER TABLE animals ADD CONSTRAINT fk_animals_species FOREIGN KEY (species_id) REFERENCES species(id);

-- add a new column owner_id to the animal table
ALTER TABLE animals ADD COLUMN owner_id INT;

ALTER TABLE animals ADD CONSTRAINT fk_animals_owners FOREIGN KEY (owner_id) REFERENCES owners(id);