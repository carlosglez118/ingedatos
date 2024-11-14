import { productoModel } from "../model/productoModel.js";

// Obtener todos los productos
export const obtenerDatos = async (peticion, respuesta) => {
    try {
        let productos = await productoModel.find();
        respuesta.status(200).json({ productos });
    } catch (error) {
        console.error(error);
        respuesta.status(500).json({ message: "Error al obtener productos" });
    }
};

// Crear un nuevo producto
export const crearDatos = async (peticion, respuesta) => {
    try {
        let data = peticion.body;
        await productoModel.create(data);
        let productos = await productoModel.find();
        respuesta.status(201).json({ message: "Producto creado", productos });
    } catch (error) {
        console.error(error);
        respuesta.status(500).json({ message: "Error al crear producto" });
    }
};

// Buscar producto por ID
export const buscarProductoPorId = async (peticion, respuesta) => {
    try {
        const { id } = peticion.body;

        if (!id) {
            return respuesta.status(400).json({ message: "El ID es necesario" });
        }

        const producto = await productoModel.findById(id);

        if (!producto) {
            return respuesta.status(404).json({ message: "Producto no encontrado" });
        }

        return respuesta.status(200).json({ producto });
    } catch (error) {
        console.error(error);
        respuesta.status(500).json({ message: "Error al buscar producto" });
    }
};

// Modificar datos de un producto por ID
export const modificarDatosPorId = async (peticion, respuesta) => {
    try {
        const { id, name, precio, categoria } = peticion.body;

        if (!id) {
            return respuesta.status(400).json({ message: "El ID es necesario" });
        }

        const productoActualizado = await productoModel.findByIdAndUpdate(
            id,
            { name, precio, categoria },
            { new: true }
        );

        const productos = await productoModel.find();
        respuesta.status(200).json({ message: "Producto actualizado", productos });
    } catch (error) {
        console.error(error);
        respuesta.status(500).json({ message: "Error al modificar producto" });
    }
};

// Modificar datos por nombre
export const modificarDatosPorNombre = async (peticion, respuesta) => {
    try {
        const { name, precio, categoria } = peticion.body;

        if (!name) {
            return respuesta.status(400).json({ message: "El nombre es necesario" });
        }

        await productoModel.findOneAndUpdate(
            { name },
            { precio, categoria },
            { new: true }
        );

        const productos = await productoModel.find();
        respuesta.status(200).json({ message: "Producto actualizado por nombre", productos });
    } catch (error) {
        console.error(error);
        respuesta.status(500).json({ message: "Error al modificar producto por nombre" });
    }
};

// Obtener productos por precio
export const obtenerProductosPorPrecio = async (peticion, respuesta) => {
    try {
        const { precio } = peticion.body;
        const productos = await productoModel.find({ precio: { $gt: precio } });
        respuesta.status(200).json(productos);
    } catch (error) {
        console.error(error);
        respuesta.status(500).json({ message: "Error al obtener productos por precio" });
    }
};

// Ordenar productos por precio
export const ordenarProductosPorPrecio = async (peticion, respuesta) => {
    try {
        const { orden } = peticion.body;
        const productos = await productoModel.find().sort({ precio: orden === 'asc' ? 1 : -1 });
        respuesta.status(200).json(productos);
    } catch (error) {
        console.error(error);
        respuesta.status(500).json({ message: "Error al ordenar productos" });
    }
};

// Agregar un nuevo campo a todos los productos
export const agregarCampo = async (req, res) => {
    try {
        const { campo, valor } = req.body;

        if (!campo || valor === undefined) {
            return res.status(400).json({ message: "El campo y su valor son necesarios" });
        }

        await productoModel.updateMany({}, { $set: { [campo]: valor } });
        const productos = await productoModel.find();
        res.status(200).json({ message: `Campo "${campo}" añadido`, productos });
    } catch (error) {
        console.error(error);
        res.status(500).json({ message: "Error al añadir campo" });
    }
};

// Actualizar campo en productos según el precio
export const actualizarCampoPorPrecio = async (req, res) => {
    try {
        const { precio, valor } = req.body;
        await productoModel.updateMany({ precio: { $gt: precio } }, { $set: { valor } });
        const productos = await productoModel.find();
        res.status(200).json({ message: "Campo actualizado", productos });
    } catch (error) {
        console.error(error);
        res.status(500).json({ message: "Error al actualizar campo" });
    }
};

// Eliminar productos por precio
export const eliminarProductosPorPrecio = async (req, res) => {
    try {
        const { precio } = req.body;
        await productoModel.deleteMany({ precio: { $lt: precio } });
        const productos = await productoModel.find();
        res.status(200).json({ message: "Productos eliminados", productos });
    } catch (error) {
        console.error(error);
        res.status(500).json({ message: "Error al eliminar productos" });
    }
};

// Obtener el precio promedio por categoría
export const obtenerPrecioPromedioPorCategoria = async (req, res) => {
    try {
        const resultado = await productoModel.aggregate([
            { $group: { _id: "$categoria", precioPromedio: { $avg: "$precio" } } },
            { $sort: { precioPromedio: -1 } }
        ]);
        res.status(200).json({ message: "Precio promedio por categoría", resultado });
    } catch (error) {
        console.error(error);
        res.status(500).json({ message: "Error al calcular precio promedio" });
    }
};

// Obtener la categoría con el mayor precio promedio
export const obtenerCategoriaConMayorPrecioPromedio = async (req, res) => {
    try {
        const resultado = await productoModel.aggregate([
            { $group: { _id: "$categoria", precioPromedio: { $avg: "$precio" } } },
            { $sort: { precioPromedio: -1 } },
            { $limit: 1 }
        ]);
        res.status(200).json({ message: "Categoría con mayor precio promedio", resultado });
    } catch (error) {
        console.error(error);
        res.status(500).json({ message: "Error al obtener categoría" });
    }
};
