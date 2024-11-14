import { userModel } from "../model/userModel.js";

// Obtener los datos de los usuarios
export const obtenerDatos = async (peticion, respuesta) => {
    try {
        let usuarios = await userModel.find()
        respuesta.status(200).send(usuarios);
    } catch (error) {
        console.log(error);
        respuesta.status(500).send("Error al obtener los datos");
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

// Mostrar por nombre
export const obtenerNombreEspecifico = async (peticion, respuesta) => {
    try {
        const { nombre } = peticion.body;

        // if (!nombre) {
        //     return respuesta.status(400).json({ message: "Digite el nombre correctamente" });
        // }

        const usuario = await userModel.findOne({ nombre });
        
        if (!usuario) {
            return respuesta.status(404).json({ message: "Usuario no encontrado" });
        }

        return respuesta.status(200).json({ usuario });
    } catch (error) {
        console.error(error);
        return respuesta.status(500).send("Error al obtener el usuario");
    }
};



// Mostrar por edad
export const moreThan30 = async(peticion, respuesta) => {
    try{
        const {edad} = peticion.body;
        console.log(edad)
        const usuarios = await userModel.find({edad: {$gte: edad} });
        respuesta.status(200).json(usuarios);
    } catch (error){
        console.error(error);
        respuesta.status(500).json({message: "Error al obtener los datos"});
    }
};

// Actualizar por nombre
export const actualizarJuanPerez = async (peticion, respuesta) => {
    try {
      const { nombre, edad } = peticion.body;
  
      if (!nombre) {
        return respuesta.status(400).send("Es necesario el nombre para actualizar");
      }
  
      const usuario = await userModel.findOneAndUpdate({ nombre }, { $set: { edad } });
  
      if (!usuario) {
        return respuesta.status(404).send("Datos no encontrados");
      }
  
      const usuarios = await userModel.find();
      return respuesta.status(200).send(usuarios); // Usa return para finalizar la función
  
    } catch (error) {
      console.error(error);
      respuesta.status(500).send("Error al actualizar los datos");
    }
};
  

export const activoTrue = async (peticion, respuesta) => {
    try {
        const { campo, valor } = peticion.body;

        // Validar que el campo sea 'Activo' y el valor sea true
        if (campo !== 'activo' || valor !== true) {
            return respuesta.status(400).send("Solo se puede añadir el valor 'True' al campo 'Activo'.");
        }

        // Imprimir datos de la solicitud para verificar
        console.log("Campo a actualizar:", campo);
        console.log("Valor a asignar:", valor);

        // Actualizar los usuarios mayores de 30 años, estableciendo el campo 'Activo' con el valor true
        const resultado = await userModel.updateMany(
            { edad: { $gte: 30 } },  // Filtrar por edad mayor o igual a 30
            { $set: { [campo]: valor } }  // Usar el campo dinámico (Activo) y asignar el valor
        );

        // Verificar el resultado de la actualización
        console.log("Resultado de la actualización:", resultado);

        // Obtener los usuarios actualizados para mostrar
        const mostrar = await userModel.find({ edad: { $gte: 30 } });

        // Devolver los usuarios actualizados
        return respuesta.status(200).send(mostrar);
    } catch (error) {
        console.error("Error al añadir el campo:", error);
        return respuesta.status(500).send("Error al añadir los campos");
    }
};



// Eliminar por nombre
export const elimLuis = async (peticion, respuesta) => {
    try {
        const { nombre } = peticion.body; 
        
        // Verifica que se haya pasado un nombre
        if (!nombre) {
            return respuesta.status(400).json({ message: "Debe proporcionar el nombre del usuario a eliminar" });
        }

        // Eliminar solo el usuario con el nombre proporcionado
        const resultado = await userModel.deleteOne({ nombre: nombre });

        // Verifica si se eliminó algún documento
        if (resultado.deletedCount === 0) {
            return respuesta.status(404).json({ message: "Usuario no encontrado" });
        }

        // Obtener todos los usuarios restantes para mostrar
        const mostrar = await userModel.find();
        return respuesta.status(200).json({ message: "Usuario eliminado", mostrar });
    } catch (error) {
        console.error(error);
        return respuesta.status(500).send("Error al eliminar los datos");
    }
};


// Eliminar por edad
export const lessThan30 = async(peticion, respuesta) => {
    try {
        const { edad } = peticion.body;  
        // Verifica que se haya pasado una edad
        if (!edad) {
            return respuesta.status(400).json({ message: "Debe proporcionar la edad del usuario a eliminar" });
        }

        // Eliminar solo el usuario con el nombre proporcionado
        const resultado = await userModel.deleteMany({ edad: {$lt:edad} });

        // Verifica si se eliminó algún documento
        if (resultado.deletedCount === 0) {
            return respuesta.status(404).json({ message: "Usuario no encontrado" });
        }

        // Obtener todos los usuarios restantes para mostrar
        const mostrar = await userModel.find();
        return respuesta.status(200).json({ message: "Usuario eliminado", mostrar });
    } catch (error) {
        console.error(error);
        return respuesta.status(500).send("Error al eliminar los datos");
    }
};
