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
insert into producto values (2, 'Shampoo', 'dove', '20900','4983', 12);
insert into vacuna values (1, 'AstraZeneca', '10ml', 'moquillo'), (2, 'Pfizer', '15ml', 'rabia');
insert into vacuna values (3, 'AstraZeneca', '5ml', 'Pentavelante');

insert into cliente values(1203, 'Cristian', 'Ruiz', 'Calle 19 4-88',3321739886, '3');
insert into cliente values(4983, 'Carlos', 'Gonzalez', 'Calle 21',3525932010, '1');

update cliente set telefono='3321739886' where cedulaCliente=1203;
update cliente set telefono='3525932010' where cedulaCliente=4983;
alter table cliente change column telefono telefono varchar(15);

insert into detalle_vacuna values(1, 3, 'moquillo'), (2, 1, 'rabia');
insert into producto values(1, 'Shampoo', 'moquillo'), (2, 1, 'rabia');

select *from mascota;
select *from vacuna;
select *from detalle_vacuna;
describe producto;
describe cliente;
describe vacuna;
describe mascota;
describe detalle_vacuna;
use mascotas;

select nombreMascota, razaMascota from mascota;
select * from mascota where idMascota ='1';

select cedulaCliente AS 'Documento', direccionCliente AS 'Direccion' from cliente;
select *from cliente;
describe vacuna;
describe producto;
/*1er Ejercicio*/

select razaMascota AS 'raza', idMascota AS 'ID' from mascota;
select nombreVacuna AS 'vacuna', dosisVacuna AS 'dosis' from vacuna;
select cedulaClienteFK AS 'Cliente', nombreProducto AS 'producto' from producto;


select nombreCliente AS 'Cliente', cedulaCliente as 'Documento'from cliente order by cedulaCliente DESC;

select idMascota as 'ID', generoMascota as 'Genero' from mascota order by generoMascota DESC;

select marca, nombreProducto as 'Producto' from producto order by precio DESC;

select nombreMascota from mascota where idMascota >1;

select nombreProducto from producto where precio >11000;

select enfermedad from detalle_vacuna where codigoVacunaFK =1;

select nombreProducto from producto where precio >10000 or codigoProducto <2;

select enfermedad from vacuna where nombreVacuna = 'Pfizer' or dosisVacuna = '10ml';
select codigoVacuna from vacuna where dosisVacuna = '10ml' or enfermedad = 'rabia';

select cedulaCliente from cliente where nombreCliente ='Cristian' and  apellidoCliente='Ruiz';
select cedulaCliente, nombreCliente from cliente where telefono='3525932010' or  idMascotaFK=1;

select nombreMascota, generoMascota  from mascota where razaMascota ='criollo' and cantidadMascota >= 2;
select nombreMascota  from mascota where  generoMascota='mujer' or cantidadMascota > 0;

select nombreProducto from producto where precio between  1000 and 100000;
use mascotas;
describe mascota;

select nombreMascota from mascota where generoMascota like'f%' or generoMascota like 'mu%'; 
select idMascota, nombreMascota from mascota where razaMascota like'crio%' or generoMascota like 'mest%'; 
describe cliente;

select nombreCliente, apellidoCliente, direccionCliente from cliente where telefono like'33%'; 
select nombreCliente, idMascotaFK from cliente where direccionCliente like'%19%'; 
describe producto;

select cedulaClienteFK, nombreProducto from producto where marca like'%ve'; 
select codigoProducto, NombreProducto, precio  from producto where nombreProducto like'%b%'; 
describe vacuna;
select nombreVacuna, dosisVacuna from vacuna where enfermedad like'%b%'; 
select enfermedad from vacuna where nombreVacuna like'%f%'; 
describe detalle_vacuna;
select idMascotaFK from detalle_vacuna where enfermedad like'%o%'; 
select codigoVacunaFK from detalle_vacuna where enfermedad like'ra%'; 



select m.*, c.nombreCliente, max(cantidadMascota) from mascota m inner join cliente c on m.idMascota = c.idMascotaFK;
select m.*, c.nombreCliente, p.nombreProducto from mascota m inner join cliente c on m.idMascota = c.idMascotaFK
inner join producto p on p.cedulaCienteFK = c.cedulaCliente;

select*from mascota;
describe mascota;
describe vacuna;
describe cliente;
describe detalle_vacuna;