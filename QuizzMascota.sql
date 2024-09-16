/*Primer Punto*/
CREATE DATABASE Mascotas;
/*Segundo y tercer Punto*/
USE DATABASE Mascotas;

CREATE TABLE Mascota(
	idMascota INT PRIMARY KEY,
    nombreMascota VARCHAR(15),
    generoMascota VARCHAR(15),
    razaMascota VARCHAR(15),
    cantidad INT
);

CREATE TABLE Cliente (
	cedulaCliente INT PRIMARY KEY,
    nombreCliente VARCHAR(15),
    apellidoCliente VARCHAR(15),
    direccionCliente VARCHAR(15),
    telefono INT(10),
    idMascotaFK INT,
    FOREIGN KEY (idMascotaFK) REFERENCES Mascota(idMascota)
);


CREATE TABLE Producto(
	codigoProducto INT PRIMARY KEY,
    nombreProducto VARCHAR(15),
    marca VARCHAR(15),
    precio FLOAT,
    cedulaClienteFK INT,
    FOREIGN KEY (cedulaClienteFK) REFERENCES Cliente(cedulaCliente)
);


CREATE TABLE Vacuna(
	codigoVacuna INT PRIMARY KEY,
    nombreVacuna VARCHAR(15),
    dosisVacuna INT,
    enfermedad VARCHAR(15)
);


CREATE TABLE Mascota_vacuna(
	codigoVacunaFK INT,
    idMascotaFK INT,
    enfermedad VARCHAR (15),
    FOREIGN KEY (codigoVacunaFK) REFERENCES Vacuna(codigoVacuna),
    FOREIGN KEY (idMascotaFK) REFERENCES Mascota(idMascota)
);
/*Puntos 4, 5 y 6 */
ALTER TABLE Producto ADD COLUMN cantidad INT NOT NULL;
ALTER TABLE Mascota CHANGE COLUMN cantidad cantidadMascota INT;
ALTER TABLE Mascota_vacuna RENAME TO detalle_vacuna;