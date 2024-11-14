import { Router } from "express";
import { crearDatos, obtenerDatos,  modificarDatosPorId, modificarDatosPorNombre, buscarProductoPorId,obtenerProductosPorPrecio, ordenarProductosPorPrecio, agregarCampo, actualizarCampoPorPrecio, eliminarProductosPorPrecio, obtenerPrecioPromedioPorCategoria, obtenerCategoriaConMayorPrecioPromedio} from "../controller/productoController.js";
const router = Router()

router.get('/productos', obtenerDatos)
router.post('/productos', crearDatos)
router.post('/productos/buscar', buscarProductoPorId);
router.put('/productos/modificarId', modificarDatosPorId);
router.put('/productos/modificarNombre', modificarDatosPorNombre);
router.post('/productos/filtrar-precio', obtenerProductosPorPrecio);
router.post('/productos/ordenar', ordenarProductosPorPrecio);
router.put('/productos/agregar-campo', agregarCampo);
router.put('/productos/actualizar-campo', actualizarCampoPorPrecio);
router.delete('/productos/eliminar', eliminarProductosPorPrecio);
router.get('/productos/precio-promedio-categoria', obtenerPrecioPromedioPorCategoria);
router.get('/productos/categoria-mayor-promedio', obtenerCategoriaConMayorPrecioPromedio);

export default router;