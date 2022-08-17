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
