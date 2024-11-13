CREATE DATABASE OnlineBD;
USE OnlineBD;

CREATE TABLE Cliente (
    idCliente INT AUTO_INCREMENT PRIMARY KEY,
    cedulaCliente INT NOT NULL UNIQUE, 
    nombreCliente VARCHAR(100) NOT NULL,
    apellidoCliente VARCHAR(100) NOT NULL
);

CREATE TABLE Libros (
    idLibro INT AUTO_INCREMENT PRIMARY KEY,
    nombreLibro VARCHAR(100) NOT NULL,
    autor VARCHAR(100) NOT NULL,
    anio YEAR NOT NULL,
    precio DECIMAL(10, 2) NOT NULL,  
    stock INT NOT NULL, 
    prestado BOOLEAN
);

CREATE TABLE Pedidos (
    idPedido INT AUTO_INCREMENT PRIMARY KEY,
    idClienteFK INT,
    idLibroFK INT,
    cantidad INT NOT NULL ,
    total DECIMAL(10, 2) NOT NULL,
    fechaPedido DATE NOT NULL,
    FOREIGN KEY (idClienteFK) REFERENCES Cliente(idCliente) ,  
    FOREIGN KEY (idLibroFK) REFERENCES Libros(idLibro)
);

INSERT INTO Cliente(idCliente, cedulaCliente, nombreCliente, ApellidoCliente) VALUES
('', 1000000, 'Carlos', 'Gonzalez'),
('', 1000001, 'Cristian', 'Ruiz'),
('', 1000002, 'Lucia', 'Bravo'),
('', 1000003, 'Brandon', 'Ayala'),
('', 1000004, 'Vianey', 'Hernandez');

INSERT INTO Libros(idLibro, nombreLibro, autor, anio, precio, stock, prestado) VALUES
('', 'Don Quijote', 'Miguel de Cervantes', 1880, 25000, 150, FALSE),
('', 'Harry Potter', 'JK Rowlings', 2002, 30000, 200, FALSE),
('', 'El Principito', 'Antonio Perez', 1994, 150000, 100, FALSE),
('', 'Juegos del Hambre', 'Liam Johnson', 2010, 40000, 200, FALSE),
('', 'Dama de azul', 'John F Kennedy', 2008, 13900, 50, FALSE);

INSERT INTO Pedidos (idClienteFK, idLibroFK, cantidad, total, fechaPedido) VALUES
(1, 1, 2, 50000, '2024-10-01'), -- Carlos compra 2 libros de Don Quijote
(2, 2, 1, 30000, '2024-10-02'), -- Cristian compra 1 libro de Harry Potter
(3, 3, 3, 450000, '2024-10-03'), -- Lucia compra 3 libros de El Principito
(4, 4, 1, 40000, '2024-10-04'), -- Brandon compra 1 libro de Juegos del Hambre
(5, 5, 2, 27800, '2024-10-05'); -- Vianey compra 2 libros de Dama de azul

INSERT INTO Pedidos (idClienteFK, idLibroFK, cantidad, total, fechaPedido) VALUES
(4, 1, 1, 25000, '2024-09-15'); 


-- Actualizar stock cada vez que se realice un pedido
UPDATE Libros
JOIN Pedidos ON Libros.idLibro = Pedidos.idLibroFK
SET Libros.stock = Libros.stock - Pedidos.cantidad
WHERE Pedidos.idPedido = idPedido;


-- Listar los pedidos hechos por un cliente específico y obtener detalles de los libros completos
SELECT Cliente.nombreCliente, Cliente.apellidoCliente, Libros.nombreLibro, Pedidos.cantidad, Pedidos.total
FROM Pedidos
JOIN Cliente ON Pedidos.idClienteFK = Cliente.idCliente
JOIN Libros ON Pedidos.idLibroFK = Libros.idLibro
WHERE Cliente.idCliente = idCliente;

-- Consultar el cliente que ha realizado el mayor número de pedidos
SELECT Cliente.nombreCliente, Cliente.apellidoCliente, COUNT(Pedidos.idPedido) AS numPedidos
FROM Pedidos
JOIN Cliente ON Pedidos.idClienteFK = Cliente.idCliente
GROUP BY Cliente.idCliente
ORDER BY numPedidos DESC
LIMIT 1;

-- Crear un procedimiento almacenado que permita registrar un nuevo pedido, actualizando la tabla pedidos y reduciendo el stock del libro correspondiente
DELIMITER //

CREATE PROCEDURE NuevoPedido(
    IN p_idCliente INT,
    IN p_idLibro INT,
    IN p_cantidad INT,
    IN p_total DECIMAL(10,2),
    IN p_fechaPedido DATE
)
BEGIN
    -- Inserta el nuevo pedido
    INSERT INTO Pedidos (idClienteFK, idLibroFK, cantidad, total, fechaPedido)
    VALUES (p_idCliente, p_idLibro, p_cantidad, p_total, p_fechaPedido);
    
    -- Actualiza el stock del libro
    UPDATE Libros
    SET stock = stock - p_cantidad
    WHERE idLibro = p_idLibro;
END//


DELIMITER ;

-- Ejecucion del procedimiento
CALL NuevoPedido(1, 2, 3, 450.00, '2024-10-07');
SELECT * FROM Pedidos;

-- Libros que su precio sea mayor a 20000
SELECT * FROM Libros WHERE precio > 20000;

-- Pedidos que sean despues del 1 de octubre de 2024
SELECT * FROM Pedidos WHERE fechaPedido > '2024-10-01';

-- Selecciona todos los libros ordenados por su precio de mayor a menor
SELECT * FROM Libros WHERE precio ORDER BY precio DESC;

-- Obten el total de clientes registrados en la tabla clientes
SELECT COUNT(idCliente) AS clientesRegistrados FROM Cliente;

-- Obten el total de unidades vendidas en la tabla pedidos
SELECT SUM(cantidad) AS totalUnidadesVendidas 
FROM Pedidos;

-- Muestra el numero de pedidos realizados por cada cliente
SELECT Cliente.nombreCliente, Cliente.apellidoCliente, COUNT(Pedidos.idPedido) AS numPedidos
FROM Pedidos
JOIN Cliente ON Pedidos.idClienteFK = Cliente.idCliente
GROUP BY Cliente.idCliente;

-- Muestra el nombre del cliente, el titulo del libro y la cantidad de cada pedido
SELECT Cliente.nombreCliente, Cliente.apellidoCliente, Libros.nombreLibro, Pedidos.cantidad
FROM Pedidos
JOIN Cliente ON Pedidos.idClienteFK = Cliente.idCliente
JOIN Libros ON Pedidos.idLibroFK = Libros.idLibro;

-- Muestra el titulo de los libros y la cantidad total vendida de cada uno
SELECT Libros.nombreLibro, SUM(Pedidos.cantidad) AS totalVendido
FROM Pedidos
JOIN Libros ON Pedidos.idLibroFK = Libros.idLibro
GROUP BY Libros.idLibro;
