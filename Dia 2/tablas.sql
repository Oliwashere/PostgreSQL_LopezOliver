create database operaciones_avanzadas;

CREATE TABLE regiones (
    id SERIAL PRIMARY KEY,
    region VARCHAR(100) UNIQUE NOT NULL
);

CREATE TABLE departamentos (
    id SERIAL PRIMARY KEY,
    departamento VARCHAR(100) UNIQUE NOT NULL,
    codigo_departamento INT UNIQUE NOT NULL,
    region_id INT REFERENCES regiones(id) ON DELETE CASCADE
);

CREATE TABLE municipios (
    id SERIAL PRIMARY KEY,
    municipio VARCHAR(100) UNIQUE NOT NULL,
    codigo_municipio INT UNIQUE NOT NULL,
    departamento_id INT REFERENCES departamentos(id) ON DELETE CASCADE
);

CREATE TABLE personas (
    id SERIAL PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    apellido VARCHAR(100) NOT NULL,
    municipio_nacimiento INT REFERENCES municipios(id),
    municipio_domicilio INT REFERENCES municipios(id)
);