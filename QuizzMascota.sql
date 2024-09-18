/*Primer Punto*/
CREATE DATABASE Mascotas;
/*Segundo y tercer Punto*/
USE Mascotas;

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

use mascotas;
select *from cliente;
insert into mascota values (1, 'bola', 'mujer','cruzado', 4);
insert into mascota values (4, '', '','', '');
insert into mascota values (2, 'Pluto', 'masculino','criollo', 2), (3, 'nini', 'mujer','mestizo', 1);
insert into producto values (1, 'jabon', 'dove', '10900','1203', 3);
insert into vacuna values (1, 'AstraZeneca', '10ml', 'moquillo'), (2, 'Pfizer', '15ml', 'rabia');
insert into vacuna values (3, 'AstraZeneca', '5ml', 'Pentavelante');

insert into cliente values(1203, 'Cristian', 'Ruiz', 'Calle 19 4-88',3321739886, '3');
insert into cliente values(4983, 'Carlos', 'Gonzalez', 'Calle 21',3525932010, '1');

update cliente set telefono='3321739886' where cedulaCliente=1203;
update cliente set telefono='3525932010' where cedulaCliente=4983;
alter table cliente change column telefono telefono varchar(15);

insert into detalle_vacuna values(1, 3, 'moquillo'), (2, 1, 'rabia');

select *from mascota;
select *from vacuna;
select *from detalle_vacuna;
describe producto;
describe cliente;
describe vacuna;
describe mascota;
describe detalle_vacuna;