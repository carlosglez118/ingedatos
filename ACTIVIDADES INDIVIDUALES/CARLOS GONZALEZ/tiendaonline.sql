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

