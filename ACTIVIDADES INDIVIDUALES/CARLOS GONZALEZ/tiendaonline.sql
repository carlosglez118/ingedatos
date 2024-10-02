CREATE DATABASE TiendaOnline;
USE TiendaOnline;

-- Id autoincrement	
CREATE TABLE Producto(
	idProducto INT AUTO_INCREMENT UNIQUE,
    codigoBarras VARCHAR(50) PRIMARY KEY,
    nombreProducto VARCHAR(25),
    precioProducto DECIMAL(10, 2) NOT NULL,
    stock INT NOT NULL
);

CREATE TABLE Usuario(
	idUsuario INT AUTO_INCREMENT PRIMARY KEY,
    nombreUsuario VARCHAR(25),
    rolUsuario VARCHAR(25),
    correoUsuario VARCHAR(25),
    fecha_registro DATE
);

-- Autoincrement
CREATE TABLE Cliente(
	idCliente INT AUTO_INCREMENT PRIMARY KEY,
    nombreCliente VARCHAR (30),
    correoCliente VARCHAR (30),
    direccionCliente VARCHAR (50),
    telefonoCliente VARCHAR (50),
    fecha_registro DATE
);

CREATE TABLE Venta(
	idVenta INT AUTO_INCREMENT PRIMARY KEY,
    idClienteFK INT,
    idUsuarioFK INT,
    FOREIGN KEY (idClienteFK) REFERENCES Cliente(idCliente),
    FOREIGN KEY (idUsuarioFK) REFERENCES Usuario(idUsuario),
    fecha_venta DATE
);

CREATE TABLE detalle_venta(
    cantidad INT NOT NULL,
    precio_unitario DECIMAL(10,2) NOT NULL,
    idVentaFK INT,
    codigoBarrasFK VARCHAR(50),
    FOREIGN KEY (idVentaFK) REFERENCES Venta(idVenta),
    FOREIGN KEY (codigoBarrasFK) REFERENCES Producto(codigoBarras)
);

INSERT INTO Producto(codigoBarras, nombreProducto, precioProducto, stock) VALUES
('1000000', 'Llaveros', 15000, 150),
('1000001', 'Calcetas', 30000, 50),
('1000002', 'Manilla', 20000, 60),
('1000003', 'Peine', 10000, 45);

SELECT * FROM Producto;

ALTER TABLE Usuario ADD COLUMN apellidoUsuario VARCHAR(25);

INSERT INTO Usuario(nombreUsuario, apellidoUsuario, rolUsuario, correoUsuario, fecha_registro) VALUES
('Carlos', 'Gonzalez', 'admin', 'carlos@gmail.com', '2023-03-20'),
('Lucia' , 'Bravo', 'empleado', 'lucia@gmail.com', '2023-03-20'),
('Cristian', 'Ruiz', 'empleado', 'cristian@gmail.com', '2024-05-08'),
('Alejandra', 'Gutierrez', 'empleado', 'ale@gmail.com', '2024-01-25');

INSERT INTO Cliente(nombreCliente, correoCliente, direccionCliente, telefonoCliente, fecha_registro) VALUES
('Arturo Ramirez', 'arturo@gmail.com', 'Cl 21 5-31', '3216549870', '2023-05-15'),
('Guadalupe Garcia', 'gpe@gmail.com', 'AvCl 19 81-01', '3326549871', '2023-11-03'),
('Adrian Sanchez', 'adr@gmail.com', 'Cl 50 25-50', '1234567890', '2024-01-30'),
('Arely Leal', 'arely@gmail.com', 'Cl 89 43-87', '4567891236', '2024-03-19');

INSERT INTO Venta(idClienteFK, idUsuarioFK, fecha_venta) VALUES
(1, 1, '2024-03-08'),
(2, 2, '2024-05-17'),
(3, 3, '2024-04-20'),
(4, 4, '2024-09-11');

INSERT INTO detalle_venta(idVentaFK, codigoBarrasFK, cantidad, precio_unitario) VALUES
(1, 1000000, 2, 15000),
(2, 1000001, 1, 30000),
(3, 1000002, 3, 20000),
(4, 1000003, 1, 10000);

SELECT * FROM Producto;
SELECT * FROM Producto ORDER BY precioProducto ASC;
SELECT * FROM Cliente WHERE(fecha_registro) = 1;
SELECT * FROM Usuario WHERE	rolUsuario LIKE 'empleado%';
SELECT * FROM Venta WHERE MONTH(fecha_venta) BETWEEN 3 AND 6;
SELECT * FROM Producto WHERE nombreProducto LIKE '%r%';
SELECT * FROM detalle_venta WHERE precio_unitario = 15000 OR precio_unitario = 30000;
SELECT AVG(precio_unitario) FROM detalle_venta;
SELECT SUM(precio_unitario) FROM detalle_venta;
SELECT MIN(precio_unitario) FROM detalle_venta;
SELECT COUNT(*) AS cantidad_clientes FROM Cliente;

SELECT * FROM Venta INNER JOIN Cliente ON Venta.idClienteFK = Cliente.idCliente;

-- Consultar cliente de la maxima venta hecha
SELECT Cliente.nombreCliente, Venta.idVenta, SUM(detalle_venta.cantidad * detalle_venta.precio_unitario) AS total_venta
FROM Venta
INNER JOIN Cliente ON Venta.idClienteFK = Cliente.idCliente
INNER JOIN detalle_venta ON Venta.idVenta = detalle_venta.idVentaFK
GROUP BY Venta.idVenta
ORDER BY total_venta DESC
LIMIT 1;

-- Consultar usuario y cliente de una venta especifica
SELECT Venta.idVenta, Usuario.nombreUsuario, Cliente.nombreCliente
FROM Venta
INNER JOIN Usuario ON Venta.idUsuarioFK = Usuario.idUsuario
INNER JOIN Cliente ON Venta.idClienteFK = Cliente.idCliente
WHERE Venta.idVenta = 1;
-- Consultar los productos que compro un cliente especifico
SELECT Producto.nombreProducto, detalle_venta.cantidad, detalle_venta.precio_unitario
FROM detalle_venta
INNER JOIN Producto ON detalle_venta.codigoBarrasFK = Producto.codigoBarras
INNER JOIN Venta ON detalle_venta.idVentaFK = Venta.idVenta
WHERE Venta.idClienteFK = 1;
-- Consultar todos los clientes que han hecho compras
SELECT DISTINCT Cliente.nombreCliente, Cliente.correoCliente, Cliente.telefonoCliente
FROM Venta
INNER JOIN Cliente ON Venta.idClienteFK = Cliente.idCliente;
SELECT * FROM Producto;

delimiter //
CREATE PROCEDURE crear_producto(
idProducto INT, 
codigoBarras varchar(50), 
nombreProducto varchar(50), 
precioProducto DECIMAL, 
stock INT)
BEGIN
	INSERT INTO Producto (idProducto, codigoBarras, nombreProducto, precioProducto, stock) 
    VALUES(idProducto, codigoBarras, nombreProducto, precioProducto, stock);

END //
delimiter ;

CALL crear_producto('','100004','Marcadores', 20000, 200);

CREATE VIEW consultar_cliente AS
SELECT * FROM Cliente;

SELECT * FROM consultar_cliente;


/* Crear 3 procedimientos para inactivar un cliente,  para consultar los productos
que ha comprado un cliente, y para modificar la fecha de nacimiento de cliente*/

-- Inactivar un cliente
DELIMITER //
CREATE PROCEDURE inactivar_cliente(
    IN idCliente INT
)
BEGIN
    UPDATE Cliente
    SET fecha_registro = NULL
    WHERE idCliente = idCliente;
END //
DELIMITER ;

-- Productos comprados por un cliente
DELIMITER //
CREATE PROCEDURE productos_comprados_por_cliente(
    IN idCliente INT
)
BEGIN
    SELECT Producto.nombreProducto, detalle_venta.cantidad, detalle_venta.precio_unitario
    FROM detalle_venta
    INNER JOIN Producto ON detalle_venta.codigoBarrasFK = Producto.codigoBarras
    INNER JOIN Venta ON detalle_venta.idVentaFK = Venta.idVenta
    WHERE Venta.idClienteFK = idCliente;
END //
DELIMITER ;

-- Cambiar fecha de registro
DELIMITER //
CREATE PROCEDURE modificar_fecha_registro_cliente(
    IN idCliente INT,
    IN nuevaFecha DATE
)
BEGIN
    UPDATE Cliente
    SET fecha_registro = nuevaFecha
    WHERE idCliente = idCliente;
END //
DELIMITER ;

-- Cliente que compro un producto y numero de orden
CREATE VIEW cliente_que_compro_producto AS
SELECT Cliente.nombreCliente, Venta.idVenta, Producto.nombreProducto
FROM Venta
INNER JOIN Cliente ON Venta.idClienteFK = Cliente.idCliente
INNER JOIN detalle_venta ON Venta.idVenta = detalle_venta.idVentaFK
INNER JOIN Producto ON detalle_venta.codigoBarrasFK = Producto.codigoBarras;


-- Cliente con mas compras realizadas
CREATE VIEW cliente_mas_compras AS
SELECT Cliente.nombreCliente, COUNT(Venta.idVenta) AS numero_compras
FROM Venta
INNER JOIN Cliente ON Venta.idClienteFK = Cliente.idCliente
GROUP BY Cliente.idCliente
ORDER BY numero_compras DESC
LIMIT 1;

/* Subconsultas: son consultas anidadas dentro de otra consulta
select campo2, campo3 from tablagrande 
where columna2=(select columna2x from otratabla where condicion);
*/

/*Consultar los datos de los empleadods y su sueldo promedio*/
SELECT idEmpleado, nombreEmpleado, salario, (SELECT AVG(salario) FROM empleado) as promedio FROM empleado;

/* Empleado que tenga un salario mayor que el salario promedio */
SELECT idEmpleado, nombreEmpleado, salario
FROM empleado WHERE salario > (SELECT AVG(salario)
FROM empleado);

/*consultar area a la que pertenece un empleado*/
SELECT idEmpleado, nombreEmpleado, idArea, nombreArea
FROM empleado 
WHERE idArea in (SELECT idArea FROM area WHERE nombreEmpleado = 'Juan');


/*Calcular los productos que se vendan a un precio mayor del promedio de todos los productos*/
SELECT nombreProducto, precioProducto
FROM Producto
WHERE precioProducto > (SELECT AVG(precioProducto) FROM producto);
/*Mostrar los clientes que el total de compra sea mayor al promedio de compras de la tienda*/
SELECT Cliente.nombreCliente, SUM(detalle_venta.cantidad * detalle_venta.precio_unitario) AS total_compra
FROM Venta
INNER JOIN Cliente ON Venta.idClienteFK = Cliente.idCliente
INNER JOIN detalle_venta ON Venta.idVenta = detalle_venta.idVentaFK
GROUP BY Cliente.idCliente
HAVING total_compra > (
    SELECT AVG(total_venta)
    FROM (
        SELECT SUM(detalle_venta.cantidad * detalle_venta.precio_unitario) AS total_venta
        FROM Venta
        INNER JOIN detalle_venta ON Venta.idVenta = detalle_venta.idVentaFK
        GROUP BY Venta.idVenta
    ) AS subquery
);

/*Mostrar el promedio de precios de productos comprados por un cliente*/
SELECT Cliente.nombreCliente, AVG(detalle_venta.precio_unitario) AS promedio_precio_compras
FROM detalle_venta
INNER JOIN Venta ON detalle_venta.idVentaFK = Venta.idVenta
INNER JOIN Cliente ON Venta.idClienteFK = Cliente.idCliente
GROUP BY Cliente.idCliente;


/* Crear 2 vistas una que consulte que cliente compro un producto y numero de orden
y una que muestre el cliente que más compras haya hecho */