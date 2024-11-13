import { productModel } from "../model/productModel.js";

export const obtenerDatos = async (peticion, respuesta) => {
    try {
        let usuarios = await productModel.find()
        respuesta.status(200).send(usuarios);
    } catch (error) {
        console.log(error);
        respuesta.status(500).send("Error al obtener los datos");
    }
};

export const crearDatos = async (peticion, respuesta) => {
    try {
        let data = peticion.body;
        await productModel.create(data);
        let productos = await productModel.find();
        respuesta.status(201).json({ message: "Producto creado", productos });
    } catch (error) {
        console.log(error);
        respuesta.status(500).json({ message: "Error al crear usuario" });
    }
};

export const moreThan100 = async (peticion, respuesta) => {
    try {
        const { precio } = peticion.body;

        // if (!nombre) {
        //     return respuesta.status(400).json({ message: "Digite el nombre correctamente" });
        // }

        const producto = await productModel.find({ precio: {$gt: precio} });
        
        if (!producto) {
            return respuesta.status(404).json({ message: "Producto no encontrado" });
        }

        return respuesta.status(200).json({ producto });
    } catch (error) {
        console.error(error);
        return respuesta.status(500).send("Error al obtener el producto");
    }
}

export const productsDescent = async (peticion, respuesta) => {
    try {
        const productos = await productModel.find().sort({precio: -1})
        respuesta.status(200).send(productos)
    } catch (error) {
        console.log(error);
        return respuesta.status(500).send("Error al obtener los productos")
    }
}

export const stockTrue = async (peticion, respuesta) => {
    try {
        const { campo, valor } = peticion.body;

        // Validar que el campo sea "stock" y el valor sea true
        if (campo !== 'stock' || valor !== true) {
            return respuesta.status(400).send("Solo se puede añadir el valor 'true' al campo 'stock'.");
        }

        // Imprimir datos de la solicitud para verificar
        console.log("Campo a actualizar:", campo);
        console.log("Valor a asignar:", valor);

        // Ejecutar la actualización en todos los documentos
        const resultado = await productModel.updateMany(
            {},  // Sin filtro, aplica a todos los documentos
            { $set: { [campo]: valor } }  // Añadir o actualizar el campo 'stock' con valor 'true'
        );

        // Verificar el resultado de la actualización
        console.log("Resultado de la actualización:", resultado);
        console.log("Número de documentos modificados:", resultado.modifiedCount);

        // Obtener todos los documentos para mostrar
        const mostrar = await productModel.find();

        // Devolver los documentos actualizados
        return respuesta.status(200).json({ message: "Campo 'stock' actualizado", mostrar });
    } catch (error) {
        console.error("Error al añadir el campo:", error);
        return respuesta.status(500).send("Error al añadir los campos");
    }
};



export const stockFalse = async (peticion, respuesta) => {
    try {
        const { valor } = peticion.body;

        // Actualizar documentos donde el precio es mayor a 500 y establecer `stock` en el valor proporcionado
        const resultado = await productModel.updateMany(
            { /*precio: { $gte: 500 }*/ },  // Condición para precios mayores a 500
            { $set: { stock: valor } }  // Establece `stock` en `valor` 
        );

        // Verifica si se modificaron documentos
        if (resultado.modifiedCount === 0) {
            return respuesta.status(404).send("No se encontraron productos para actualizar.");
        }

        // Obtener los productos actualizados para confirmar el cambio
        const productos = await productModel.find();
        return respuesta.status(200).json({ message: "Productos actualizados", productos });
        
    } catch (error) {
        console.error("Error al actualizar los datos:", error);
        return respuesta.status(500).send("Error al actualizar los datos");
    }
}

export const lessThan50 = async(peticion, respuesta) => {
    try {
        const { precio } = peticion.body;  
        // Verifica que se haya pasado una edad
        if (!precio) {
            return respuesta.status(400).json({ message: "Debe proporcionar el precio de los productos a eliminar" });
        }

        // Eliminar solo el usuario con el nombre proporcionado
        const resultado = await productModel.deleteMany({ precio: {$lt:precio} });

        // Verifica si se eliminó algún documento
        if (resultado.deletedCount === 0) {
            return respuesta.status(404).json({ message: "Productos no encontrado" });
        }

        // Obtener todos los usuarios restantes para mostrar
        const mostrar = await productModel.find();
        return respuesta.status(200).json({ message: "Producto eliminado", mostrar });
    } catch (error) {
        console.error(error);
        return respuesta.status(500).send("Error al eliminar los datos");
    }
}

export const precioPromedioPorCategoria = async (peticion, respuesta) => {
    try {
        console.log('Se está llamando a la ruta /precioCategoria');
        
        const resultado = await productModel.aggregate([
            {
                $group: {
                    _id: "$categoria",             
                    precioPromedio: { $avg: "$precio" }  
                }
            },
            {
                $project: {
                    _id: 0,                        
                    categoria: "$_id",             
                    precioPromedio: 1             
                }
            }
        ]);

        console.log('Resultado de la agregación:', resultado);

        if (resultado.length === 0) {
            return respuesta.status(404).json({ message: "No se encontraron productos" });
        }

        return respuesta.status(200).json(resultado);
    } catch (error) {
        console.error("Error al calcular el precio promedio:", error);
        return respuesta.status(500).send("Error al calcular el precio promedio");
    }
};


export const categoriaConMayorPrecioPromedio = async (peticion, respuesta) => {
    try {
        const resultado = await productModel.aggregate([
            {
                $group: {
                    _id: "$categoria",             // Agrupar por categoría
                    precioPromedio: { $avg: "$precio" }  // Calcular el precio promedio
                }
            },
            {
                $sort: { precioPromedio: -1 }  // Ordenar por precio promedio en orden descendente
            },
            {
                $limit: 1  // Limitar a la primera categoría con el mayor precio promedio
            },
            {
                $project: {
                    _id: 0,                        // Opcional: excluir el campo _id
                    categoria: "$_id",             // Renombrar _id a "categoria"
                    precioPromedio: 1             // Mostrar el precio promedio
                }
            }
        ]);

        // Verificar si se obtuvieron resultados
        if (resultado.length === 0) {
            return respuesta.status(404).json({ message: "No se encontraron productos" });
        }

        // Devolver la categoría con el mayor precio promedio
        return respuesta.status(200).json(resultado[0]);
    } catch (error) {
        console.error("Error al calcular el precio promedio:", error);
        return respuesta.status(500).send("Error al calcular el precio promedio");
    }
};

