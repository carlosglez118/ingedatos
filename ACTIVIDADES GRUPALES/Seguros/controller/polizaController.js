import { polizaModel } from "../model/polizaModel.js";

// Obtener los datos de los usuarios
export const obtenerDatos = async (peticion, respuesta) => {
    try {
        let usuarios = await polizaModel.find()
        respuesta.status(200).send(usuarios);
    } catch (error) {
        console.log(error);
        respuesta.status(500).send("Error al obtener los datos");
    }
};


// Crear datos y automaticamente calcula el monto pendiente
export const crearDatos = async (peticion, respuesta) => {
    try {
        let data = peticion.body;

        // Calcular el monto pendiente al momento de crear la póliza
        if (data.montoTotal && data.monto_pagado !== undefined) {
            data.montoPendiente = data.montoTotal - data.monto_pagado;
        } else {
            // Si no hay valores de montoTotal o monto_pagado, asignamos un valor por defecto
            data.montoPendiente = data.montoTotal || 0;
        }

        // Crear la nueva póliza en la base de datos
        await polizaModel.create(data);

        // Obtener todas las pólizas
        let polizas = await polizaModel.find();

        // Responder con éxito
        respuesta.status(201).json({ message: "Poliza creada", polizas });
    } catch (error) {
        console.log(error);
        respuesta.status(500).json({ message: "Error al crear la poliza: Número de póliza ya existente" });
    }
};

// Actualizar status manualmente
export const actualizarEstado = async (peticion, respuesta) => {
    try{
        const { n_poliza, valor } = peticion.body;
        const resultado = await polizaModel.updateMany(
            { n_poliza: n_poliza },
            { $set: { stock: valor}} 
        );

        if (resultado.modifiedCount = 0){
            return respuesta.status(404).send("No se encontro la poliza para actualizar")
        }

        const polizas = await polizaModel.find();
        return respuesta.status(200).json({message: "Poliza actualizada", polizas})
    } catch(error){
        console.error(error);
        return respuesta.status(500).send("Error al actualizar los datos");
    }
};

// Actualizar los datos
export const actualizarDatos = async (peticion, respuesta) => {
    try {
        // Desestructurar el identificador y los datos a actualizar desde el cuerpo de la solicitud
        const { n_poliza, data } = peticion.body;

        // Verificar que se haya proporcionado un identificador
        if (!n_poliza) {
            return respuesta.status(400).json({ message: "Se requiere el número de póliza" });
        }

        // Actualizar el documento en la base de datos
        const resultado = await polizaModel.findOneAndUpdate(
            { n_poliza: n_poliza },  // Filtro: buscar por el número de póliza
            { $set: data },           // Datos a actualizar
            { new: true }             // Devuelve el documento actualizado
        );

        // Verificar si se encontró y actualizó el documento
        if (!resultado) {
            return respuesta.status(404).json({ message: "Poliza no encontrada" });
        }

        // Enviar la respuesta con el documento actualizado
        return respuesta.status(200).json({ message: "Poliza actualizada", poliza: resultado });
    } catch (error) {
        console.error("Error al actualizar la póliza:", error);
        return respuesta.status(500).json({ message: "Error al actualizar los datos" });
    }
};


// Obtener las polizas que tiene una aseguradora
export const obtenerVehiculosPorAseguradora = async (peticion, respuesta) => {
    try {
        const { aseguradora } = peticion.body;

        // Consulta para encontrar pólizas de la aseguradora especificada
        const polizas = await polizaModel.find({ aseguradora: aseguradora });

        // Enviar respuesta con los vehículos asegurados
        respuesta.status(200).json({ polizas });
    } catch (error) {
        respuesta.status(500).json({ message: 'Error al obtener los vehículos asegurados', error });
    }
};

// Mostrar una poliza en especifico
export const obtenerPolizasPorNumero = async (peticion, respuesta) => {
    try{
        const { n_poliza } = peticion.body;

        const poliza = await polizaModel.find({ n_poliza: n_poliza });

        respuesta.status(200).json({ message: "Poliza encontrada", poliza })
    } catch(error){
        console.error(error);
        respuesta.status(500).send("Error al obtener los datos")
    }
};

// Calcula el monto pendiente
export const calcularMontoPendiente = async (peticion, respuesta) => {
     try {
         // Encuentra todas las pólizas en la base de datos
         const polizas = await polizaModel.find();
         // Verifica si existen pólizas
         if (polizas.length === 0) {
             return respuesta.status(404).json({ message: "No se encontraron pólizas." });
         }
         // Actualiza cada póliza con el campo `montoPendiente`
         for (let poliza of polizas) {
             // Calcula el monto pendiente
             const montoPendiente = poliza.montoTotal - poliza.monto_pagado;
             // Actualiza la póliza con el nuevo campo
             await polizaModel.updateOne(
                 { _id: poliza._id },
                 { $set: { montoPendiente: montoPendiente } }
             );
         }
         // Obtén todas las pólizas actualizadas para mostrar
         const polizasActualizadas = await polizaModel.find();
         return respuesta.status(200).json(polizasActualizadas);
     } catch (error) {
         console.error("Error al calcular el monto pendiente:", error);
         return respuesta.status(500).json({ message: "Error al calcular el monto pendiente." });
     }
};

// Eliminar una poliza en especifico
export const eliminarPoliza = async (peticion, respuesta) => {
    try {
        const { n_poliza } = peticion.body;

        // Verificar si el número de póliza fue proporcionado
        if (!n_poliza) {
            return respuesta.status(400).json({ message: "El número de póliza es requerido" });
        }

        // Buscar y eliminar la póliza con el número especificado
        const resultado = await polizaModel.deleteOne({ n_poliza });

        // Verificar si se eliminó alguna póliza
        if (resultado.deletedCount === 0) {
            return respuesta.status(404).json({ message: "No se encontró la póliza con el número proporcionado" });
        }

        const polizas = await polizaModel.find();
        return respuesta.status(400).json({message: "Póliza eliminada correctamente", polizas})

    } catch (error) {
        console.error("Error al eliminar la póliza:", error);
        return respuesta.status(500).json({ message: "Error al eliminar la póliza" });
    }
};

// Mostrar la poliza de un vehiculo segun su placa
export const obtenerVehiculo = async (peticion, respuesta) => {
    try {
        const { placa_vehiculo } = peticion.body;

        // Verificar si se proporcionó la placa del vehículo
        if (!placa_vehiculo) {
            return respuesta.status(400).json({ message: "La placa del vehículo es requerida" });
        }

        // Buscar la póliza según la placa del vehículo
        const poliza = await polizaModel.findOne({ placa_vehiculo: placa_vehiculo });

        // Verificar si la póliza fue encontrada
        if (!poliza) {
            return respuesta.status(404).json({ message: "No se encontró una póliza para el vehículo con la placa proporcionada" });
        }

        // Devolver la póliza encontrada
        return respuesta.status(200).json({ message: "Póliza encontrada", poliza });
    } catch (error) {
        console.error("Error al obtener los datos:", error);
        return respuesta.status(500).send("Error al obtener los datos");
    }
};

// Registrar un nuevo pago
export const registrarPago = async (peticion, respuesta) => {
    try {
        const { n_poliza, nuevoPago } = peticion.body;

        // Verificar que se hayan proporcionado ambos valores
        if (!n_poliza || !nuevoPago) {
            return respuesta.status(400).json({ message: "Es necesario proporcionar el número de póliza y el monto del pago" });
        }

        // Buscar la póliza
        const poliza = await polizaModel.findOne({ n_poliza });

        if (!poliza) {
            return respuesta.status(404).json({ message: "No se encontró la póliza especificada" });
        }

        // Actualizar el monto pagado y calcular el monto pendiente
        poliza.monto_pagado += nuevoPago;
        poliza.montoPendiente = poliza.montoTotal - poliza.monto_pagado;

        // Guardar los cambios
        await poliza.save();

        return respuesta.status(200).json({ message: "Pago registrado exitosamente", poliza });
    } catch (error) {
        console.error("Error al registrar el pago:", error);
        return respuesta.status(500).json({ message: "Error al registrar el pago" });
    }
};


// Actualiza el status a false si la fecha de fin ya pasó
export const actualizarStatus = async (peticion, respuesta) => {
    try {
        // Obtener la fecha actual
        const fechaActual = new Date();

        // Actualizar las pólizas cuyo `fecha_fin` ya haya pasado
        const resultado = await polizaModel.updateMany(
            { fecha_fin: { $lt: fechaActual } },  // Filtro: fecha_fin menor a la fecha actual
            { $set: { status: false } }           // Actualizar el campo `status` a false
        );

        // Verificar si se actualizó alguna póliza
        if (resultado.nModified === 0) {
            return respuesta.status(404).json({ message: "No se encontraron pólizas con fecha de fin pasada." });
        }

        // Enviar la respuesta
        return respuesta.status(200).json({ message: "Pólizas actualizadas correctamente", resultado });
    } catch (error) {
        console.error("Error al actualizar el status:", error);
        return respuesta.status(500).json({ message: "Error al actualizar el status de las pólizas" });
    }
};

