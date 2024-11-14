-- Creacion de la base de datos
-- CREATE DATABASE votaciones2503816;
-- USE votaciones2503816;

-- Tabla genero
CREATE Table Genero(
	idGenero INT PRIMARY KEY auto_increment,
    nomGenero VARCHAR(100) NOT NULL,
    estadoG BOOLEAN NOT NULL
);

-- Tabla Jornada
CREATE TABLE Jornada(
	idJornada INT PRIMARY KEY AUTO_INCREMENT,
    nomJornada VARCHAR(100) NOT NULL,
	estadoJ	BOOLEAN NOT NULL
);

-- Tabla tipo documento 
CREATE TABLE TipoDocumento(
	idTipoDoc INT PRIMARY KEY AUTO_INCREMENT,
    nomTipoDoc VARCHAR(100) NOT NULL,
    estadoTD BOOLEAN NOT NULL
);

-- Tabla Curso
CREATE TABLE Curso(
	idCurso INT PRIMARY KEY AUTO_INCREMENT,
    nomCurso VARCHAR(100) NOT NULL,
    estadoCu BOOLEAN NOT NULL
);

CREATE TABLE Concejo(
	idConcejo INT PRIMARY KEY AUTO_INCREMENT,
    nomConcejo VARCHAR(100) NOT NULL,
    estadoCO BOOLEAN NOT NULL
);

CREATE TABLE TipoMiembro(
	idTipoMiembro INT PRIMARY KEY AUTO_INCREMENT,
    nomTipoMiembro VARCHAR(100) NOT NULL,
    estadoTM BOOLEAN NOT NULL
);

CREATE TABLE Eleccion(
	idEleccion INT PRIMARY KEY AUTO_INCREMENT,
    fechaEleccion DATE NOT NULL,
    anioEleccion YEAR NOT NULL,
    estadoEL BOOLEAN NOT NULL
);

CREATE TABLE Cargo(
	idCargo INT PRIMARY KEY AUTO_INCREMENT,
    nomCargo VARCHAR(100) NOT NULL,
    idConcejoFK INT,
    FOREIGN KEY(idConcejoFK) REFERENCES Concejo(idConcejo),
    estadoC BOOLEAN NOT NULL
);

CREATE TABLE Postulacion_candidato(
	idPostCandidato INT PRIMARY KEY AUTO_INCREMENT,
    idUsuarioFK INT,
    idEleccionFK INT,
    idCargoFK INT, 
    FOREIGN KEY(idEleccionFK) REFERENCES Eleccion(idEleccion),
    FOREIGN KEY(idCargoFK) REFERENCES Cargo(idCargo),
    propuestas VARCHAR(200) NOT NULL,
    totalVotos INT NOT NULL,
    estadoCan BOOLEAN NOT NULL
);

CREATE TABLE Usuario(
	idUsuario INT PRIMARY KEY AUTO_INCREMENT, 
    noDocUsuario VARCHAR(100) NOT NULL,
    idTipoDocFK INT,
    nombreUsuario VARCHAR(100) NOT NULL,
    apellidoUsuario VARCHAR(100) NOT NULL,
    idGeneroFK INT, 
    fechaNacUsuario DATE NOT NULL,
    emailUsuario VARCHAR(100),
    passwordUsuario VARCHAR(100),
    fotoUsuario BLOB,
    idJornadaFK INT,
    idTipoMiembroFK INT, 
    idCursoFK INT,
    estadoU BOOLEAN NOT NULL,
    FOREIGN KEY(idJornadaFK) REFERENCES Jornada(idJornada),
    FOREIGN KEY(idTipoMiembroFK) REFERENCES TipoMiembro(idTipoMiembro),
    FOREIGN KEY(idCursoFK) REFERENCES Curso(idCurso)
);

CREATE TABLE Votacion(
	idVotacion INT PRIMARY KEY AUTO_INCREMENT,
    horaVotacion TIME NOT NULL,
    idUsuarioVotanteFK INT,
    idPostCandidatoFK INT,
    estadoV BOOLEAN NOT NULL,
    FOREIGN KEY(idUsuarioVotanteFK) REFERENCES Usuario(idUsuario),
    FOREIGN KEY(idPostCandidatoFK) REFERENCES Postulacion_candidato(idPostCandidato)
);

ALTER TABLE Postulacion_candidato
ADD CONSTRAINT idUsuarioFK
FOREIGN KEY (idUsuarioFK)
REFERENCES Usuario(idUsuario);
 
ALTER TABLE Usuario 
ADD CONSTRAINT idTipoDocFK
FOREIGN KEY (idTipoDocFK)
REFERENCES TipoDocumento(idTipoDoc); 

ALTER TABLE Usuario
ADD CONSTRAINT idGeneroFK
FOREIGN KEY (idGeneroFK)
REFERENCES Genero(idGenero);

INSERT INTO Genero(nomGenero, estadoG) VALUES
('Femenino', TRUE),
('Masculino', TRUE);



