/*1er Punto*/
create database TiendaOnline;
/*2do Punto*/
use TiendaOnline;
/*3er Punto Crear tablas*/
/*4to Punto crear Relaciones*/
CREATE TABLE producto (
    idProducto INT AUTO_INCREMENT UNIQUE,
    codigoBarras varchar(15) PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    descripcion TEXT,
    precio DECIMAL(10, 2) NOT NULL,
    stock INT NOT NULL
);
CREATE TABLE usuario (
    idUsuario INT AUTO_INCREMENT PRIMARY KEY,
    nombreUsuario VARCHAR(100) NOT NULL,
    tipoUsuario varchar(15) not null,
    emailUsuario VARCHAR(100) NOT NULL
);

CREATE TABLE cliente (
    idCliente INT AUTO_INCREMENT PRIMARY KEY,
    nombreCliente VARCHAR(100) NOT NULL,
    direccionCliente TEXT,
    fechaNacimiento DATE,
    telefonoCliente VARCHAR(15),
    emailCliente VARCHAR(100)
);

CREATE TABLE venta (
    idVenta INT AUTO_INCREMENT PRIMARY KEY,
    idClienteFK INT NOT NULL,
    idUsuarioFK INT NOT NULL,
    fechaVenta DATE NOT NULL,
    totalVenta DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (idClienteFK) REFERENCES Cliente(idCliente),
    FOREIGN KEY (idUsuarioFK) REFERENCES Usuario(idUsuario)
);

CREATE TABLE DetalleVenta (
    idDetalleVenta INT AUTO_INCREMENT,
    idVentaFK INT NOT NULL,
    codigoBarrasFK VARCHAR(11) NOT NULL,
    cantidad INT NOT NULL,
    precio DECIMAL(10, 2) NOT NULL,
    PRIMARY KEY (idDetalleVenta),
    FOREIGN KEY (idVentaFK) REFERENCES Venta(idVenta),
    FOREIGN KEY (codigoBarrasFK) REFERENCES Producto(codigoBarras)
);
/*Inserciones en cada tabla*/

describe cliente;
select *from cliente;
insert into cliente values('', 'Cristian Ruiz', 'Calle 19 4-88','2002-03-22' ,3321739886, 'cristianrb04@gmail.com');
insert into cliente values('', 'Carlos Gonzalez', 'Calle 21 5-10','2002-03-19', '3525932010', 'cristianrb04@gmail.com');
insert into cliente values('', 'Arlette Sanchez', 'David Alfaro 13','2002-06-03',3310212050, 'arlette@gmail.com');
insert into cliente values('', 'Paola Luna', 'Calle Jalisco','2002-10-01',3373218886, 'paolalu@gmail.com');

describe usuario;
select *from usuario;
insert into usuario values('', 'Tatiana','Gerente','tatiana@gmail.com'), 
('', 'Valentina', 'empleado', 'valentina@gmail.com'),
('', 'Guadalupe', 'Administrador','lupe12@gmail.com'),
('', 'Luna', 'empleado','lunita@gmail.com');

describe producto;
select *from producto;
insert into producto values('', '12345','Jabon','jabon para la cara', 10900, 100), 
('', '12346','Shampoo','contra la caida', 21900, 50),
('', '12347','Cepillo de Dientes','cepillo con pasta de dientes', 12900, 20),
('', '12348','Presto Barba','5 navajas', 19000, 30);


describe venta;
select *from venta;
insert into venta values('', '1','2','2024-09-20'), 
('', '1', 'empleado', 'valentina@gmail.com'),
('', '2', 'Administrador','lupe12@gmail.com'),
('', '4', 'empleado','lunita@gmail.com');

describe detalleVenta;
