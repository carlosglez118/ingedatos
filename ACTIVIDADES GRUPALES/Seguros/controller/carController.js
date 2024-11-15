import { carModel } from "../model/carModel.js";

// Obtener los datos de los usuarios
export const obtenerDatos = async (peticion, respuesta) => {
    try {
        let carros = await carModel.find()
        respuesta.status(200).send(carros);
    } catch (error) {
        console.log(error);
        respuesta.status(500).send("Error al obtener los datos");
    }
};


// Crear un nuevo usuario
export const crearDatos = async (peticion, respuesta) => {
    try {
        let data = peticion.body;
        await carModel.create(data);
        let usuarios = await carModel.find();
        respuesta.status(201).json({ message: "Usuario creado", usuarios });
    } catch (error) {
        console.log(error);
        respuesta.status(500).json({ message: "Error al crear usuario" });
    }
};