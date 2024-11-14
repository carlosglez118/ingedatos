import { Router } from "express";
import { crearDatos, obtenerDatos, buscarPorNombre, obtenerUsuariosPorEdad, modificarEdadPorNombre, agregarCampo, eliminarUsuarioPorEdad, eliminarUsuarioPorNombre } from "../controller/userController.js";
const router = Router()

router.get('/usuarios', obtenerDatos);
router.post('/usuarios', crearDatos);
router.post('/usuarios/buscar-nombre', buscarPorNombre);
router.get('/usuarios/filtrar-edad', obtenerUsuariosPorEdad);
router.put('/usuarios/modificar-edad-por-nombre',modificarEdadPorNombre);
router.put('/usuarios/agregar-campo',agregarCampo);
router.delete('/usuarios/eliminar-por-nombre',eliminarUsuarioPorNombre);
router.delete('/usuarios/eliminar-por-edad',eliminarUsuarioPorEdad);

export default router;