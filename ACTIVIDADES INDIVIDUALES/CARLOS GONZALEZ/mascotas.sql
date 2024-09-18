-- CREATE DATABASE Mascotas;
USE Mascotas;
-- Tabla mascota
CREATE TABLE Mascota(
	idMascota INT PRIMARY KEY,
    nombreMascota VARCHAR(15),
    generoMascota VARCHAR(15),
    razaMascota VARCHAR(15),
    cantidad INT
);

-- Tabla cliente
CREATE TABLE Cliente (
	cedulaCliente INT PRIMARY KEY,
    nombreCliente VARCHAR(15),
    apellidoCliente VARCHAR(15),
    direccionCliente VARCHAR(15),
    telefono INT(10),
    idMascotaFK INT,
    FOREIGN KEY (idMascotaFK) REFERENCES Mascota(idMascota)
);

-- Tabla producto
CREATE TABLE Producto(
	codigoProducto INT PRIMARY KEY,
    nombreProducto VARCHAR(15),
    marca VARCHAR(15),
    precio FLOAT,
    cedulaClienteFK INT,
    FOREIGN KEY (cedulaClienteFK) REFERENCES Cliente(cedulaCliente)
);

-- Tabla Vacuna
CREATE TABLE Vacuna(
	codigoVacuna INT PRIMARY KEY,
    nombreVacuna VARCHAR(15),
    dosisVacuna INT,
    enfermedad VARCHAR(15)
);

-- Tabla mascota vacuna
CREATE TABLE Mascota_vacuna(
	codigoVacunaFK INT,
    idMascotaFK INT,
    enfermedad VARCHAR (15),
    FOREIGN KEY (codigoVacunaFK) REFERENCES Vacuna(codigoVacuna),
    FOREIGN KEY (idMascotaFK) REFERENCES Mascota(idMascota)
);

ALTER TABLE Producto ADD COLUMN cantidad INT NOT NULL;
ALTER TABLE Mascota CHANGE COLUMN cantidad cantidadMascota INT;
ALTER TABLE Mascota_vacuna RENAME TO detalle_vacuna;
ALTER TABLE Cliente CHANGE COLUMN telefono telefono VARCHAR(20);

SELECT * FROM Mascota;
SELECT * FROM Cliente;
SELECT * FROM Producto;
SELECT * FROM Vacuna;
SELECT * FROM detalle_vacuna;
SELECT * FROM Producto;
DESCRIBE Mascota;
DESCRIBE Producto;
DESCRIBE Cliente;
DESCRIBE Vacuna;
DESCRIBE detalle_vacuna;
INSERT INTO Vacuna VALUES(1, 'Clembuterol', 1, 'Moquillo'), (2, 'Penicilina', 1, 'Fiebre');
INSERT INTO Cliente VALUES (548874, 'Cristian', 'Ruiz', 'AVCL 19 #81', 3312457889, 1);
INSERT INTO Cliente VALUES (1639980, 'Lucia', 'Bravo', '5 de mayo #122', 3521104887, 2);
INSERT INTO Producto VALUES (1, 'Shampoo', 'Perro consentido', 10500, 548874, 1);
INSERT INTO Producto VALUES(2, 'Cepillo', 'PetCare', 9500, 1639980, 1);
INSERT INTO Mascota VALUES(1, 'Rusth', 'M', 'Criollo', 1);
INSERT INTO Mascota VALUES(2, 'Lisa', 'F', 'Criollo', 1), (3, 'Bravo', 'M', 'Criollo', 1);
INSERT INTO Mascota VALUES(4, '', '', '', '');
INSERT INTO detalle_vacuna VALUES(1, 1, 'Moquillo');
INSERT INTO detalle_vacuna VALUES(2, 2, 'Fiebre');
UPDATE Cliente SET telefono = '3521104887' WHERE cedulaCliente=548874;
UPDATE Cliente SET telefono = '3312457889' WHERE cedulaCliente=1639980;


