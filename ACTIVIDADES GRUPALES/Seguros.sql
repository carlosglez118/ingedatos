create database Seguros;

use Seguros;
-- Tabla Cliente
CREATE TABLE Cliente (
    idCliente INT PRIMARY KEY auto_increment,
    nombreCliente VARCHAR(40) not null,
    direccionCliente VARCHAR(40) not null,
    telefonoCliente VARCHAR(20) not null,
    emailCliente VARCHAR(40)not null
);

-- Tabla Usuario
CREATE TABLE Usuario (
    idUsuario INT PRIMARY KEY auto_increment,
    nombreUsuario VARCHAR(40)not null,
    emailUsuario VARCHAR(40) not null,
    rolUsuario VARCHAR(20) not null,
    passwordUsuario VARCHAR(20) not null
);

-- Tabla Vehículo
CREATE TABLE Vehiculo (
    idVehiculo INT PRIMARY KEY auto_increment,
    marcaVehiculo VARCHAR(20)not null,
    modeloVehiculo VARCHAR(40)not null,
    añoVehiculo year not null,
    placaVehiculo VARCHAR(20) unique
);

-- Tabla Aseguradora
CREATE TABLE Aseguradora (
    idAseguradora INT PRIMARY KEY auto_increment,
    nombreAseguradora VARCHAR(20) not null
);

-- Tabla Poliza
CREATE TABLE Poliza (
    numeroPoliza varchar(20) PRIMARY KEY,
    fechaInicio DATE not null,
    fechaFin DATE not null,
    montoPagado DECIMAL(10, 2) not null,
    idClienteFK INT,
    idUsuarioFK INT,
    idAseguradoraFK INT,
    idVehiculoFK INT,
    montoTotal decimal(10,2) not null,
    FOREIGN KEY (idClienteFK) REFERENCES Cliente(idCliente),
    FOREIGN KEY (idUsuarioFK) REFERENCES Usuario(idUsuario),
    FOREIGN KEY (idAseguradoraFK) REFERENCES Aseguradora(idAseguradora),
    FOREIGN KEY (idVehiculoFK) REFERENCES Vehiculo(idVehiculo)

);

-- Tabla Pago
CREATE TABLE Pago (
    idPago INT PRIMARY KEY auto_increment,
    metodoPago VARCHAR(50)not null,
    montoPago DECIMAL(10, 2) not null,
    numeroPolizaFK varchar(20),
    FOREIGN KEY (numeroPolizaFK) REFERENCES Poliza(numeroPoliza)
);

INSERT INTO Cliente (nombreCliente, direccionCliente, telefonoCliente, emailCliente) VALUES
('Juan Pérez', 'Av. Siempre Viva 123', '555-1234', 'juanperez1@gmail.com'),
('María García', 'Calle Falsa 456', '555-5678', 'maria.garcia2@yahoo.com'),
('Carlos López', 'Blvd. Reforma 789', '555-8765', 'carlos.lopez3@hotmail.com'),
('Laura Hernández', 'Calle Palma 123', '555-4321', 'laura.hernandez4@gmail.com'),
('José Ramírez', 'Avenida Central 456', '555-9876', 'jose.ramirez5@gmail.com'),
('Ana Martínez', 'Carrera 7 No 89', '555-5432', 'ana.martinez6@yahoo.com'),
('Luis González', 'Avenida Libertad 789', '555-1111', 'luis.gonzalez7@gmail.com'),
('Sofía Torres', 'Calle del Sol 123', '555-2222', 'sofia.torres8@gmail.com'),
('Pedro Sánchez', 'Paseo de la Reforma 456', '555-3333', 'pedro.sanchez9@yahoo.com'),
('Carmen Rodríguez', 'Av. Chapultepec 789', '555-4444', 'carmen.rodriguez10@hotmail.com'),
('Raúl Pérez', 'Calle Larga 123', '555-5555', 'raul.perez11@gmail.com'),
('Mónica Díaz', 'Avenida Juárez 456', '555-6666', 'monica.diaz12@yahoo.com'),
('Jorge Morales', 'Calle Angosta 789', '555-7777', 'jorge.morales13@hotmail.com'),
('Gabriela Ruiz', 'Avenida Insurgentes 123', '555-8888', 'gabriela.ruiz14@gmail.com'),
('Ricardo Herrera', 'Blvd. Los Arcos 456', '555-9999', 'ricardo.herrera15@gmail.com'),
('Patricia Mendoza', 'Avenida Las Rosas 789', '555-1212', 'patricia.mendoza16@hotmail.com'),
('Daniel Ortiz', 'Calle San Juan 123', '555-3434', 'daniel.ortiz17@gmail.com'),
('Andrés Paredes', 'Carrera 10 No 20', '555-5656', 'andres.paredes18@yahoo.com'),
('Isabel Castro', 'Paseo del Parque 456', '555-7878', 'isabel.castro19@gmail.com'),
('Felipe Vargas', 'Avenida Principal 789', '555-9090', 'felipe.vargas20@hotmail.com'),
('Natalia Reyes', 'Calle San Miguel 123', '555-1010', 'natalia.reyes21@gmail.com'),
('Adriana Cruz', 'Calle Bella Vista 456', '555-1213', 'adriana.cruz22@yahoo.com'),
('Manuel Flores', 'Calle Las Palmeras 789', '555-1414', 'manuel.flores23@hotmail.com'),
('Verónica Ramos', 'Avenida Independencia 123', '555-1515', 'veronica.ramos24@gmail.com'),
('Fernando Rivas', 'Calle Olmos 456', '555-1616', 'fernando.rivas25@gmail.com'),
('Andrea Muñoz', 'Carrera 8 No 25', '555-1717', 'andrea.munoz26@hotmail.com'),
('Javier Castillo', 'Avenida Los Alpes 789', '555-1818', 'javier.castillo27@gmail.com'),
('Lucía Figueroa', 'Calle Nueva 123', '555-1919', 'lucia.figueroa28@yahoo.com'),
('Alejandro Ávila', 'Avenida del Mar 456', '555-2020', 'alejandro.avila29@hotmail.com'),
('Santiago Peña', 'Calle Vieja 789', '555-2121', 'santiago.pena30@gmail.com'),
('Valeria Gutiérrez', 'Blvd. Paseo de la Luz 123', '555-2222', 'valeria.gutierrez31@gmail.com'),
('Hugo Silva', 'Carrera 15 No 35', '555-2323', 'hugo.silva32@yahoo.com'),
('Claudia Morales', 'Avenida Las Flores 456', '555-2424', 'claudia.morales33@hotmail.com'),
('Miguel Espinosa', 'Calle de las Estrellas 789', '555-2525', 'miguel.espinosa34@gmail.com'),
('Elena Vargas', 'Avenida Norte 123', '555-2626', 'elena.vargas35@gmail.com'),
('Tomás Luna', 'Calle Luna Nueva 456', '555-2727', 'tomas.luna36@yahoo.com'),
('Lorena Guzmán', 'Carrera 18 No 45', '555-2828', 'lorena.guzman37@hotmail.com'),
('Guillermo Castro', 'Blvd. San Antonio 789', '555-2929', 'guillermo.castro38@gmail.com'),
('Laura Ortega', 'Avenida del Sol 123', '555-3030', 'laura.ortega39@gmail.com'),
('Diego Márquez', 'Calle del Lago 456', '555-3131', 'diego.marquez40@yahoo.com'),
('Mariana Ochoa', 'Avenida del Cielo 789', '555-3232', 'mariana.ochoa41@hotmail.com'),
('Álvaro Solís', 'Carrera 12 No 55', '555-3333', 'alvaro.solis42@gmail.com'),
('Paola Delgado', 'Blvd. Los Pinos 123', '555-3434', 'paola.delgado43@gmail.com'),
('Oscar Roldán', 'Avenida Alameda 456', '555-3535', 'oscar.roldan44@yahoo.com'),
('Lorena Salinas', 'Calle del Río 789', '555-3636', 'lorena.salinas45@hotmail.com'),
('Mario Suárez', 'Blvd. Central 123', '555-3737', 'mario.suarez46@gmail.com'),
('Silvia Fernández', 'Avenida Los Olivos 456', '555-3838', 'silvia.fernandez47@gmail.com'),
('Ignacio Serrano', 'Carrera 16 No 65', '555-3939', 'ignacio.serrano48@yahoo.com'),
('Rebeca Jiménez', 'Blvd. El Prado 789', '555-4040', 'rebeca.jimenez49@hotmail.com'),
('Víctor Velasco', 'Avenida Las Colinas 123', '555-4141', 'victor.velasco50@gmail.com');
INSERT INTO Cliente (nombreCliente, direccionCliente, telefonoCliente, emailCliente) VALUES
('Rebeca Ramirez', 'Avenida Las Colinas 123', '555-4141', 'victor.velasco50@gmail.com');
select * from cliente;
INSERT INTO Usuario (nombreUsuario, emailUsuario, rolUsuario, passwordUsuario) VALUES
('Juan Gonzalez', 'Juanglez@gmail.com', 'admin', 'password1'),
('Carlos Gonzalez', 'carlosglez@gmail.com', 'admin', 'password2'),
('Cristian Ruiz', 'cristianrb04@gmail.com', 'admin', 'password3');

INSERT INTO Vehiculo (marcaVehiculo, modeloVehiculo, añoVehiculo, placaVehiculo) VALUES
('Toyota', 'Corolla', 2020, 'ABC123'),
('Honda', 'Civic', 2019, 'DEF456'),
('Ford', 'Focus', 2021, 'GHI789'),
('Chevrolet', 'Malibu', 2018, 'JKL101'),
('Nissan', 'Sentra', 2020, 'MNO102'),
('BMW', 'X5', 2022, 'PQR103'),
('Audi', 'A3', 2017, 'STU104'),
('Kia', 'Soul', 2021, 'VWX105'),
('Mazda', 'CX-5', 2020, 'YZA106'),
('Mercedes', 'C-Class', 2019, 'BCD107'),
('Volkswagen', 'Jetta', 2020, 'EFG108'),
('Subaru', 'Impreza', 2021, 'HIJ109'),
('Hyundai', 'Elantra', 2018, 'KLM110'),
('Tesla', 'Model S', 2022, 'NOP111'),
('Toyota', 'Camry', 2020, 'QRS112'),
('Ford', 'Mustang', 2019, 'TUV113'),
('Honda', 'Accord', 2021, 'WXY114'),
('Chevrolet', 'Cruze', 2018, 'ZAB115'),
('BMW', '3 Series', 2020, 'CDE116'),
('Audi', 'Q7', 2022, 'FGH117'),
('Mazda', 'MX-5', 2019, 'IJK118'),
('Mercedes', 'E-Class', 2021, 'LMN119'),
('Volkswagen', 'Passat', 2020, 'OPQ120'),
('Hyundai', 'Sonata', 2018, 'RST121'),
('Subaru', 'Forester', 2021, 'UVW122'),
('Tesla', 'Model 3', 2020, 'XYZ123'),
('Nissan', 'Altima', 2019, 'ABC124'),
('Kia', 'Sportage', 2021, 'DEF125'),
('Honda', 'Fit', 2018, 'GHI126'),
('Ford', 'Explorer', 2020, 'JKL127'),
('Toyota', 'RAV4', 2021, 'MNO128'),
('Chevrolet', 'Trax', 2018, 'PQR129'),
('Audi', 'A4', 2022, 'STU130'),
('BMW', 'X3', 2019, 'VWX131'),
('Mercedes', 'GLA', 2021, 'YZA132'),
('Mazda', 'Mazda6', 2020, 'BCD133'),
('Volkswagen', 'Golf', 2018, 'EFG134'),
('Hyundai', 'Tucson', 2021, 'HIJ135'),
('Subaru', 'Outback', 2019, 'KLM136'),
('Tesla', 'Model X', 2020, 'NOP137'),
('Nissan', 'Rogue', 2021, 'QRS138'),
('Honda', 'Pilot', 2018, 'TUV139'),
('Ford', 'Edge', 2020, 'WXY140'),
('Toyota', 'Highlander', 2021, 'ZAB141'),
('Chevrolet', 'Equinox', 2019, 'CDE142'),
('BMW', '7 Series', 2022, 'FGH143'),
('Audi', 'A6', 2018, 'IJK144'),
('Mazda', 'CX-9', 2021, 'LMN145'),
('Mercedes', 'S-Class', 2020, 'OPQ146'),
('Audi', 'A5', 2022, 'JSQ187');

INSERT INTO Aseguradora (nombreAseguradora) VALUES
('AXA Seguros'),
('BBVA Seguros'),
('Chubb Seguros');

INSERT INTO Poliza (numeroPoliza, fechaInicio, fechaFin, montoPagado, idClienteFK, idUsuarioFK, idAseguradoraFK, idVehiculoFK, montoTotal) VALUES
('A1001', '2023-01-01', '2024-01-01', 1000.00, 1, 1, 1, 1,1200),
('A1002', '2023-02-01', '2024-02-01', 1200.00, 2, 2, 2, 2,1400),
('A1003', '2023-03-01', '2024-03-01', 1100.00, 3, 3, 3, 3,1600),
('A1004', '2023-04-01', '2024-04-01', 1050.00, 4, 2, 3, 4,2700),
('A1005', '2023-05-01', '2024-05-01', 1300.00, 5, 3, 3, 5,2200),
('A1006', '2023-06-01', '2024-06-01', 1350.00, 6, 2, 3, 6,2300),
('A1007', '2023-07-01', '2024-07-01', 1400.00, 7, 1, 3, 7,2100),
('A1008', '2023-08-01', '2024-08-01', 1450.00, 8, 1, 2, 8,2300),
('A1009', '2023-09-01', '2024-09-01', 1500.00, 9, 2, 2, 9,1500),
('A1010', '2023-10-01', '2024-10-01', 1550.00, 10, 1, 1, 10,1800),
('A1011', '2023-01-15', '2024-01-15', 1600.00, 11, 1, 1, 11,1800),
('A1012', '2023-02-15', '2024-02-15', 1650.00, 12, 1, 2, 12,2300),
('A1013', '2023-03-15', '2024-03-15', 1700.00, 13, 1, 3, 13,2000),
('A1014', '2023-04-15', '2024-04-15', 1750.00, 14, 1, 1, 14,2400),
('A1015', '2023-05-15', '2024-05-15', 1800.00, 15, 1, 1, 15,2300),
('A1016', '2023-06-15', '2024-06-15', 1850.00, 16, 1, 2, 16,2200),
('A1017', '2023-07-15', '2024-07-15', 1900.00, 17, 1, 1, 17,2300),
('A1018', '2023-08-15', '2024-08-15', 1950.00, 18, 1, 3, 18,1950),
('A1019', '2023-09-15', '2024-09-15', 2000.00, 19, 1, 2, 19,2000),
('A1020', '2023-10-15', '2024-10-15', 2050.00, 20, 2, 2, 20,2300),
('A1021', '2023-01-30', '2024-01-30', 2100.00, 21, 2, 1, 21,2300),
('A1022', '2023-02-28', '2024-02-28', 2150.00, 22, 2, 2, 22,2300),
('A1023', '2023-03-30', '2024-03-30', 2200.00, 23, 2, 3, 23,2200),
('A1024', '2023-04-30', '2024-04-30', 2250.00, 24, 2, 2, 24,2600),
('A1025', '2023-05-30', '2024-05-30', 2300.00, 25, 2, 2, 25,2300),
('A1026', '2023-06-30', '2024-06-30', 2350.00, 26, 2, 2, 26,2350),
('A1027', '2023-07-30', '2024-07-30', 2400.00, 27, 2, 3, 27,2400),
('A1028', '2023-08-30', '2024-08-30', 2450.00, 28, 2, 3, 28,2800),
('A1029', '2023-09-30', '2024-09-30', 2500.00, 29, 2, 3, 29,2600),
('A1030', '2023-10-30', '2024-10-30', 2550.00, 30, 3, 3, 30,2700),
('A1031', '2023-11-01', '2024-11-01', 1250.00, 31, 3, 3, 31,2000),
('A1032', '2023-12-01', '2024-12-01', 1300.00, 32, 3, 2, 32,1300),
('A1033', '2023-01-05', '2024-01-05', 1350.00, 33, 3, 3, 33,1500),
('A1034', '2023-02-05', '2024-02-05', 1400.00, 34, 3, 3, 34,2000),
('A1035', '2023-03-05', '2024-03-05', 1450.00, 35, 3, 1, 35,3000),
('A1036', '2023-04-05', '2024-04-05', 1500.00, 36, 3, 1, 36,1500),
('A1037', '2023-05-05', '2024-05-05', 1550.00, 37, 3, 2, 37,2000.00),
('A1038', '2023-06-05', '2024-06-05', 1600.00, 38, 2, 3, 38,1900.00),
('A1039', '2023-07-05', '2024-07-05', 1650.00, 39, 1, 2, 39,1900.00),
('A1040', '2023-08-05', '2024-08-05', 1700.00, 40, 1, 1, 40,1700.00),
('A1041', '2023-09-05', '2024-09-05', 1750.00, 41, 1, 1, 41,1750.00),
('A1042', '2023-10-05', '2024-10-05', 1800.00, 42, 3, 2, 42,1800.00),
('A1043', '2023-11-05', '2024-11-05', 1850.00, 43, 2, 3, 43,2000.00),
('A1044', '2023-12-05', '2024-12-05', 1900.00, 44, 3, 1, 44,2500.00),
('A1045', '2023-06-20', '2024-06-20', 1500.00, 45, 2, 3, 45,1750.00),
('A1046', '2023-07-20', '2024-07-20', 1550.00, 46, 1, 2, 46,1850.00),
('A1047', '2023-08-20', '2024-08-20', 1600.00, 47, 1, 2, 47,1750.00),
('A1048', '2023-09-20', '2024-09-20', 1650.00, 48, 3, 1, 48,1650.00),
('A1049', '2023-10-20', '2024-10-20', 1700.00, 49, 2, 2, 49,2750.00),
('A1050', '2023-11-20', '2024-11-20', 1750.00, 50, 3, 3, 50,1750.00);


INSERT INTO Pago ( metodoPago, montoPago, numeroPolizaFK) VALUES
('Tarjeta de Crédito', 1000.00, 'A1001'),
('Tarjeta de Débito', 1200.00, 'A1002'),
('Transferencia', 1100.00, 'A1003'),
('Tarjeta de Crédito', 1050.00, 'A1004'),
('Efectivo', 1300.00, 'A1005'),
('Tarjeta de Crédito', 1350.00, 'A1006'),
('Transferencia', 1400.00, 'A1007'),
('Tarjeta de Débito', 1450.00, 'A1008'),
('Efectivo', 1500.00, 'A1009'),
('Tarjeta de Crédito', 1550.00, 'A1010'),
('Transferencia', 1600.00, 'A1011'),
('Efectivo', 1650.00, 'A1012'),
('Tarjeta de Débito', 1700.00, 'A1013'),
('Transferencia', 1750.00, 'A1014'),
('Tarjeta de Crédito', 1800.00, 'A1015'),
('Tarjeta de Débito', 1850.00, 'A1016'),
('Efectivo', 1900.00, 'A1017'),
('Transferencia', 1950.00, 'A1018'),
('Tarjeta de Crédito', 2000.00, 'A1019'),
('Efectivo', 2050.00, 'A1020'),
('Tarjeta de Débito', 2100.00, 'A1021'),
('Tarjeta de Crédito', 2150.00, 'A1022'),
('Efectivo', 2200.00, 'A1023'),
('Transferencia', 2250.00, 'A1024'),
('Tarjeta de Débito', 2300.00, 'A1025'),
('Tarjeta de Crédito', 2350.00, 'A1026'),
('Efectivo', 2400.00, 'A1027'),
('Transferencia', 2450.00, 'A1028'),
('Tarjeta de Crédito', 2500.00, 'A1029'),
('Efectivo', 2550.00, 'A1030'),
('Transferencia', 1250.00, 'A1031'),
('Tarjeta de Débito', 1300.00, 'A1032'),
('Tarjeta de Crédito', 1350.00, 'A1033'),
('Transferencia', 1400.00, 'A1034'),
('Efectivo', 1450.00, 'A1035'),
('Tarjeta de Débito', 1500.00, 'A1036'),
('Transferencia', 1550.00, 'A1037'),
('Tarjeta de Crédito', 1600.00, 'A1038'),
('Efectivo', 1650.00, 'A1039'),
('Transferencia', 1700.00, 'A1040'),
('Tarjeta de Débito', 1750.00, 'A1041'),
('Tarjeta de Crédito', 1800.00, 'A1042'),
('Transferencia', 1850.00, 'A1043'),
('Efectivo', 1900.00, 'A1044'),
('Tarjeta de Débito', 1500.00, 'A1045'),
('Tarjeta de Crédito', 1550.00, 'A1046'),
('Efectivo', 1600.00, 'A1047'),
('Transferencia', 1650.00, 'A1048'),
('Tarjeta de Débito', 1700.00, 'A1049'),
('Tarjeta de Crédito', 1750.00, 'A1050');


SELECT * FROM Cliente;
SELECT * FROM Usuario;
SELECT * FROM Pago;
SELECT * FROM Poliza;
SELECT * FROM Aseguradora;
SELECT * FROM Vehiculo;


SELECT c.nombreCliente, p.montoPago FROM Cliente c
JOIN Poliza po ON c.idCliente = po.idClienteFK
JOIN Pago p ON po.numeroPoliza = p.numeroPolizaFK
WHERE p.montoPago > 2000;

SELECT v.marcaVehiculo, v.modeloVehiculo, a.nombreAseguradora
FROM Vehiculo v
JOIN Poliza p ON v.idVehiculo = p.idVehiculoFK
JOIN Aseguradora a ON p.idAseguradoraFK = a.idAseguradora
WHERE a.nombreAseguradora like  '%AXA%';

SELECT c.nombreCliente, SUM(p.montoPago) AS totalPagado
FROM Cliente c
JOIN Poliza po ON c.idCliente = po.idClienteFK
JOIN Pago p ON po.numeroPoliza = p.numeroPolizaFK
GROUP BY c.nombreCliente;

SELECT c.nombreCliente, po.fechaFin
FROM Cliente c
JOIN Poliza po ON c.idCliente = po.idClienteFK
WHERE po.fechaFin BETWEEN CURDATE() AND CURDATE() + INTERVAL 30 DAY;

SELECT u.nombreUsuario, po.numeroPoliza, po.fechaInicio, po.fechaFin
FROM Usuario u
JOIN Poliza po ON u.idUsuario = po.idUsuarioFK
WHERE u.rolUsuario like '%admin%';

SELECT a.nombreAseguradora, COUNT(po.numeroPoliza) AS totalPolizas
FROM Aseguradora a
JOIN Poliza po ON a.idAseguradora = po.idAseguradoraFK
GROUP BY a.nombreAseguradora
HAVING COUNT(po.numeroPoliza) > 10;

SELECT v.marcaVehiculo, v.modeloVehiculo, po.fechaInicio, po.fechaFin
FROM Vehiculo v
JOIN Poliza po ON v.idVehiculo = po.idVehiculoFK
WHERE po.fechaInicio BETWEEN '2023-01-01' AND '2023-12-31';

UPDATE Cliente SET telefonoCliente = '555-9876' WHERE idCliente = 1;

UPDATE Usuario SET rolUsuario = 'Usuario' WHERE idUsuario = 2;

UPDATE Poliza SET fechaFin = '2024-12-31' WHERE numeroPoliza = 'A1001';

UPDATE Pago SET metodoPago = 'Transferencia bancaria' WHERE idPago = 1;

UPDATE Cliente SET direccionCliente = 'Calle Falsa 123' WHERE idCliente = 1;

select *from Cliente;

DELETE FROM Cliente WHERE idCliente = 51;


SELECT c.nombreCliente, po.numeroPoliza, p.montoPago
FROM Cliente c
JOIN Poliza po ON c.idCliente = po.idClienteFK
JOIN Pago p ON po.numeroPoliza = p.numeroPolizaFK;

SELECT nombreCliente
FROM Cliente
WHERE idCliente = (SELECT idClienteFK FROM Poliza WHERE numeroPoliza = (SELECT numeroPolizaFK FROM Pago ORDER BY monto DESC LIMIT 1));

DELIMITER //
CREATE PROCEDURE obtenerPolizasCliente(IN clienteID INT)
BEGIN
    SELECT numeroPoliza, fechaInicio, fechaFin, montoPagado
    FROM Poliza
    WHERE idClienteFK = clienteID;
END //
DELIMITER ;

call obtenerPolizasCliente(3);

CREATE VIEW vistaPolizasClientes AS
SELECT c.nombreCliente, a.nombreAseguradora, po.numeroPoliza, po.montoPagado
FROM Cliente c
JOIN Poliza po ON c.idCliente = po.idClienteFK
JOIN Aseguradora a ON po.idAseguradoraFK = a.idAseguradora;

select * from vistaPolizasClientes;