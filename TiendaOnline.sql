/*1er Punto*/
create database TiendaOnline;
/*2do Punto*/
use TiendaOnline;
/*3er Punto Crear tablas*/
/*4to Punto crear Relaciones*/

CREATE TABLE Producto (
    idProducto INT AUTO_INCREMENT UNIQUE,
    codigoBarras VARCHAR(50) PRIMARY KEY,
    nombreProducto VARCHAR(25),
    precioProducto DECIMAL(10, 2) NOT NULL,
    stock INT NOT NULL
);


CREATE TABLE Usuario (
    idUsuario INT AUTO_INCREMENT PRIMARY KEY,
    nombreUsuario VARCHAR(25),
    rolUsuario VARCHAR(25),
    correoUsuario VARCHAR(25),
    fecha_registro DATE
);

CREATE TABLE Cliente (
    idCliente INT AUTO_INCREMENT PRIMARY KEY,
    nombreCliente VARCHAR(30),
    correoCliente VARCHAR(30),
    direccionCliente VARCHAR(50),
    telefonoCliente VARCHAR(50),
    fecha_registro DATE
);


CREATE TABLE Venta (
    idVenta INT AUTO_INCREMENT PRIMARY KEY,
    idClienteFK INT,
    idUsuarioFK INT,
    total DECIMAL(10, 2),
    total_productos_diferentes INT,
    fecha_venta DATE,
    FOREIGN KEY (idClienteFK) REFERENCES Cliente(idCliente),
    FOREIGN KEY (idUsuarioFK) REFERENCES Usuario(idUsuario)
);


CREATE TABLE detalle_venta (
    idDetalleVenta INT AUTO_INCREMENT PRIMARY KEY, 
    cantidad INT NOT NULL,
    precio_unitario DECIMAL(10, 2) NOT NULL,
    subtotal DECIMAL(10, 2) GENERATED ALWAYS AS (cantidad * precio_unitario) STORED,
    idVentaFK INT,
    codigoBarrasFK VARCHAR(50),
    FOREIGN KEY (idVentaFK) REFERENCES Venta(idVenta),
    FOREIGN KEY (codigoBarrasFK) REFERENCES Producto(codigoBarras)
);


insert into Producto (idProducto, codigoBarras, nombreProducto, precioProducto, stock) 
values ('','1234567890123', 'Laptop', 6000000.00, 10), 
       ('','9876543210987', 'Smartphone', 3200000.00, 20),
       ('','1111222233334', 'Teclado', 200000.00, 50),
       ('','4444555566667', 'Mouse', 120000.00, 100),
       ('','5555666677778', 'Cargador de celular', 15000.00, 100),
       ('','6666777788889', 'Audífonos', 30000.00, 50);


insert into Usuario (nombreUsuario, rolUsuario, correoUsuario, fecha_registro) 
values ('Juan Pérez', 'Gerente', 'juan.perez@tienda.com', '2023-01-15'),
       ('María López', 'Empleado', 'maria.lopez@tienda.com', '2023-02-20'),
       ('Carlos Ruiz', 'Administrador', 'carlos.ruiz@tienda.com', '2023-03-05'),
       ('Ana Torres', 'Empleado', 'ana.torres@tienda.com', '2023-04-18');

insert into Cliente (nombreCliente, correoCliente, direccionCliente, telefonoCliente, fecha_registro) 
values ('Pedro Gómez', 'pedro.gomez@correo.com', 'Calle 1, Ciudad', '5551234567', '2002-01-25'),
       ('Lucía Ramírez', 'lucia.ramirez@correo.com', 'Calle 2, Ciudad', '5559876543', '1996-02-28'),
       ('José Fernández', 'jose.fernandez@correo.com', 'Calle 3, Ciudad', '5553456789', '1995-03-15'),
       ('Laura García', 'laura.garcia@correo.com', 'Calle 4, Ciudad', '5557654321', '2000-04-22');


insert into Venta (idClienteFK, idUsuarioFK, total, total_productos_diferentes, fecha_venta) 
values (1, 1, 6240000.00, 2, '2023-06-01'), 
       (2, 2, 600000.00, 2, '2023-06-05'), 
       (3, 3,3200000.00, 1, '2023-06-10'), 
       (4, 4, 6120000.00, 3, '2023-06-15');


insert into detalle_venta (cantidad, precio_unitario, idVentaFK, codigoBarrasFK) 
values (1, 15000.00, 1, '5555666677778'),
       (2, 30000.00, 1, '6666777788889'); 


insert into detalle_venta (cantidad, precio_unitario, idVentaFK, codigoBarrasFK) 
values (1, 200000.00, 2, '1111222233334'),   
       (2, 200000.00, 2, '1111222233334');   


insert into detalle_venta (cantidad, precio_unitario, idVentaFK, codigoBarrasFK) 
values (1, 3200000.00, 3, '9876543210987');   


insert into detalle_venta (cantidad, precio_unitario, idVentaFK, codigoBarrasFK) 
values (1, 6000000.00, 4, '1234567890123'),  
       (2, 120000.00, 4, '4444555566667'),    
       (1, 200000.00, 4, '1111222233334');   


select * from producto;

select * from Producto
order by precioProducto ASC;

select * from Cliente
where month(fecha_registro) = 1;

select * from Usuario
where rolUsuario = 'Empleado';

select * from Venta
where month(fecha_venta) BETWEEN 3 AND 6;

select * from Producto
where nombreProducto like '%r%';

select  v.*, p.nombreProducto, p.precioProducto
from Venta v inner join detalle_venta dv on v.idVenta = dv.idVentaFK
inner join Producto p on dv.codigoBarrasFK = p.codigoBarras
where p.precioProducto = 15000 or p.precioProducto = 30000;

select u.nombreUsuario, c.nombreCliente, v.idVenta from usuario u inner join venta v on u.idUsuario = v.idUsuarioFK
inner join cliente c on c.idCliente = v.idClienteFK where v.idVenta = 2;

select c.nombreCliente, p.nombreProducto, dv.cantidad, dv.precio_unitario, v.fecha_venta
from Cliente c
inner join Venta v on c.idCliente = v.idClienteFK
inner join detalle_venta dv on v.idVenta = dv.idVentaFK
inner join Producto p on dv.codigoBarrasFK = p.codigoBarras
where c.idCliente = 1;

select v.idVenta, v.total, c.* from venta v right join cliente c on c.idCliente = v.idClienteFK;
describe cliente;
insert into cliente values('','Tatiana Cabrera','tatiana@gmail.com','Calle 40, Ciudad', '3124678123','2024-06-15');
select * from usuario;
select * from cliente;
describe usuario;
insert into usuario values('','Cristian Ruiz','Empleado','cristian@gmail.com', '27-09-2024');
describe producto;
insert into producto values('','8899447733991','Mameluco','40000.00', '30'),('','2299881122334','Biberon','20000.00', '30');
update producto set stock=40 where idProducto=6;
select* from cliente;
update usuario set  fecha_registro='2002-03-22' where idUsuario=5;
describe venta;
insert into venta (idClienteFK, idUsuarioFK, total, total_productos_diferentes, fecha_venta) 
values ('5', 5, 60000.00, 2, '2023-06-01');
insert into venta (idClienteFK, idUsuarioFK, total, total_productos_diferentes, fecha_venta) 
values ('2', 5, 50000.00, 2, '2024-09-12');

select * from venta;
select * from detalle_venta;
insert into detalle_venta (cantidad, precio_unitario, idVentaFK, codigoBarrasFK) 
values (1, 30000.00, 6, '8899447733991'),  
       (1, 20000.00, 6, '2299881122334');

select * from producto;
delete from producto where codigoBarras= '1234567891234';


use tiendaOnline;
select * from cliente;
select nombreCliente from cliente where nombreCliente = 'Pedro Gómez';

/*
DELIMITER//
CREATE PROCEDURE crear_productos(codigoBarras, nombreProducto, precioProducto, stock)
BEGIN
	insert into producto values(idProducto, codigoBarras, nombreProducto, precioProducto, stock);
END

DELIMITER;

DELIMITER//

CREATE PROCEDURE nombre_Procedimiento()
BEGIN
--- LOGICA DE LA SENTENCIA QUE SE QUIERE UTILIZAR
END

DELIMITER;
*/
select * from producto where idProducto = 6;

delimiter //
CREATE PROCEDURE crear_productos(idProducto int, 
codigoBarras varchar(50), 
nombreProducto varchar(25), 
precioProducto decimal(10,2), 
stock int)
BEGIN
	insert into producto values(idProducto, codigoBarras, nombreProducto, precioProducto, stock);
END //

delimiter ;

delimiter //
CREATE PROCEDURE modificar_producto(idProducto int, 
codigoBarra varchar(50), 
nuevoNombre varchar(25), 
precioProducto decimal(10,2), 
stock int)
BEGIN
	update producto set nombreProducto = nuevoNombre where codigoBarras = codigoBarra;
END //
delimiter ;

call crear_productos('','112233443322113', 'Lentes',45000.00,30);
call modificar_producto('','112233443322113', 'Jersey',45000.00,30);
 /*procedimiento para inactivar un cliente, consultar los productos que ha comprado un cliente y un procedimiento para modificar
 la fecha de nacimiento de cliente, Vista de que cliente compro un producto y cual fue su numero de orden, una vista que me muestre
 el cliente que mas compras haya hecho*/

create view consultarCliente as select * from cliente;
select * from producto;
select * from venta;
select * from consultarCliente;

DELIMITER //

CREATE PROCEDURE ObtenerProductosPorIdVenta(IN idVentaInput INT)
BEGIN
    SELECT c.nombreCliente, p.nombreProducto, dv.cantidad, dv.precio_unitario, v.fecha_venta
    FROM Cliente c
    INNER JOIN Venta v ON c.idCliente = v.idClienteFK
    INNER JOIN detalle_venta dv ON v.idVenta = dv.idVentaFK
    INNER JOIN Producto p ON dv.codigoBarrasFK = p.codigoBarras
    WHERE v.idVenta = idVentaInput;
END //
DELIMITER ;

DELIMITER //

CREATE PROCEDURE ModificarFechaCliente(IN idClienteInput INT, IN nuevaFecha DATE)
BEGIN
    UPDATE Cliente SET fecha_registro = nuevaFecha WHERE idCliente = idClienteInput;
END //

DELIMITER ;

use TiendaOnline;

CALL ObtenerProductosPorIdVenta(2);

CREATE VIEW VistaClienteProducto AS
SELECT c.nombreCliente, p.nombreProducto, v.idVenta
FROM Cliente c
INNER JOIN Venta v ON c.idCliente = v.idClienteFK
INNER JOIN detalle_venta dv ON v.idVenta = dv.idVentaFK
INNER JOIN Producto p ON dv.codigoBarrasFK = p.codigoBarras;
    
CREATE OR REPLACE VIEW VistaClienteProducto AS
SELECT c.idCliente, c.nombreCliente, p.nombreProducto, v.idVenta
FROM Cliente c
INNER JOIN Venta v ON c.idCliente = v.idClienteFK
INNER JOIN detalle_venta dv ON v.idVenta = dv.idVentaFK
INNER JOIN Producto p ON dv.codigoBarrasFK = p.codigoBarras;
    
SELECT * FROM VistaClienteProducto where idCliente = 1;

CREATE VIEW VistaClienteMasCompras AS
SELECT c.nombreCliente, COUNT(v.idVenta) AS numeroCompras
FROM Cliente c
INNER JOIN Venta v ON c.idCliente = v.idClienteFK GROUP BY  c.nombreCliente ORDER BY numeroCompras DESC LIMIT 1;


SELECT * 
FROM VistaClienteMasCompras;
SELECT * FROM VistaClienteMasCompras;

select* from venta;
insert into venta (idClienteFK, idUsuarioFK, total, total_productos_diferentes, fecha_venta) 
values ('5', 4, 70000.00, 2, '2024-07-10');

insert into detalle_venta (cantidad, precio_unitario, idVentaFK, codigoBarrasFK) 
values (2, 30000.00, 7, '6666777788889'),  
       (1, 20000.00, 7, '2299881122334');
select* from producto;
/*
select idEmpleado, nombreEmpleado, salario, (select avg(salario) from empleado) as promedio from empleado;
select idEmpleado, nombreEmpleado, salario  from empleado where salario > (select avg(salario) from empleado);
*/

use tiendaOnline;
/*calcular los productos que se vendan a un precio mayor del promedio de todos los productos
Y vamos a mostrar los clientes que el total de compra sea mayor al promedio de compras de la tienda
Mostrar  el promedio de precios de productos comprados por un cliente*/
select codigoBarras, nombreProducto, precioProducto as promedio from producto where precioProducto > (select avg(precioProducto) from producto);
select c.nombreCliente, v.idVenta, v.total FROM Cliente c
INNER JOIN Venta v ON c.idCliente = v.idClienteFK
WHERE v.total > (SELECT AVG(total) FROM Venta);
select c.nombreCliente, AVG(p.precioProducto) as precio_promedio
from cliente c inner join venta v on v.idClienteFK =c.idCliente
inner join detalle_venta dv on v.idVenta = dv.idVentaFK
inner join producto p on p.codigoBarras = dv.CodigoBarrasFK
where c.idCliente = 3; 
describe producto;
describe cliente;