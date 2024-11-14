import { userModel } from "../model/userModel.js";

// Obtener todos los usuarios
export const obtenerDatos = async (peticion, respuesta) => {
    try {
        let usuarios = await userModel.find();
        respuesta.status(200).json({ usuarios });
    } catch (error) {
        console.log(error);
        respuesta.status(500).json({ message: "Error al obtener datos" });
    }
};

// Crear un nuevo usuario
export const crearDatos = async (peticion, respuesta) => {
    try {
        let data = peticion.body;
        await userModel.create(data);
        let usuarios = await userModel.find();
        respuesta.status(201).json({ message: "Usuario creado", usuarios });
    } catch (error) {
        console.log(error);
        respuesta.status(500).json({ message: "Error al crear usuario" });
    }
};

// Buscar usuario por nombre
export const buscarPorNombre = async (peticion, respuesta) => {
    try {
        const { name } = peticion.body;

        if (!name) {
            return respuesta.status(400).json({ message: "El nombre es necesario" });
        }

        const usuario = await userModel.findOne({ name });

        if (!usuario) {
            return respuesta.status(404).json({ message: "Usuario no encontrado" });
        }

        return respuesta.status(200).json({ usuario });
    } catch (error) {
        console.error(error);
        respuesta.status(500).json({ message: "Error al buscar usuario" });
    }
};

// Obtener usuarios por edad
export const obtenerUsuariosPorEdad = async (peticion, respuesta) => {
    try {
        const { edad } = peticion.body;
        const usuarios = await userModel.find({ edad: { $gte: edad } });
        respuesta.status(200).json(usuarios);
    } catch (error) {
        console.error(error);
        respuesta.status(500).json({ message: "Error al obtener usuarios por edad" });
    }
};

// Modificar la edad de un usuario por nombre
export const modificarEdadPorNombre = async (peticion, respuesta) => {
    try {
        const { name, edad } = peticion.body;

        if (!name) {
            return respuesta.status(400).json({ message: "El nombre es necesario" });
        }

        const usuarioActualizado = await userModel.findOneAndUpdate(
            { name },
            { edad },
            { new: true }
        );

        if (!usuarioActualizado) {
            return respuesta.status(404).json({ message: "Usuario no encontrado" });
        }

        const usuarios = await userModel.find();
        respuesta.status(200).json({ message: "Edad actualizada", usuarios });
    } catch (error) {
        console.error(error);
        respuesta.status(500).json({ message: "Error al modificar la edad" });
    }
};

// Añadir un campo "activo" a usuarios mayores de 30 años
export const agregarCampo = async (req, res) => {
    try {
        const { campo, valor } = req.body;

        if (campo !== "activo" || valor !== true) {
            return res.status(400).json({ message: "Solo se puede añadir el campo 'activo' con valor true" });
        }

        const resultado = await userModel.updateMany(
            { edad: { $gte: 30 } },
            { $set: { [campo]: valor } }
        );

        const usuarios = await userModel.find();
        res.status(200).json({ message: `Campo "${campo}" añadido`, usuarios, modificados: resultado.modifiedCount });
    } catch (error) {
        console.error(error);
        res.status(500).json({ message: "Error al añadir campo" });
    }
};

// Eliminar usuario por nombre
export const eliminarUsuarioPorNombre = async (req, res) => {
    try {
        const { name } = req.body;
        await userModel.deleteMany({ name: name });
        const usuarios = await userModel.find();
        res.status(200).json({ message: "Usuario eliminado", usuarios });
    } catch (error) {
        console.error(error);
        res.status(500).json({ message: "Error al eliminar usuario" });
    }
};

// Eliminar usuarios por edad
export const eliminarUsuarioPorEdad = async (req, res) => {
    try {
        const { edad } = req.body;
        await userModel.deleteMany({ edad: { $lt: edad } });
        const usuarios = await userModel.find();
        res.status(200).json({ message: "Usuarios eliminados", usuarios });
    } catch (error) {
        console.error(error);
        res.status(500).json({ message: "Error al eliminar usuarios" });
    }
};
