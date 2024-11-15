import { Router } from "express";
import { crearDatos, 
    obtenerDatos, 
    obtenerVehiculosPorAseguradora, 
    actualizarDatos, 
    obtenerPolizasPorNumero,
    actualizarEstado,
    calcularMontoPendiente,
    eliminarPoliza,
    obtenerVehiculo,
    registrarPago,
    actualizarStatus } from "../controller/polizaController.js";
const router = Router()

router.get('/polizas', obtenerDatos);
router.post('/polizas', crearDatos);
router.get('/polizas/aseguradora', obtenerVehiculosPorAseguradora);
router.put('/polizas/actualizar', actualizarDatos);
router.get('/polizas/obtenerPolizas', obtenerPolizasPorNumero);
router.put('/polizas/actualizarEstado', actualizarEstado);
router.put('/polizas/montoPendiente', calcularMontoPendiente);
router.delete('/polizas/eliminar', eliminarPoliza);
router.get('/polizas/obtenerVehiculo', obtenerVehiculo);
router.put('/polizas/registrarPago', registrarPago);
router.put('/polizas/actualizarStatus', actualizarStatus);


export default router;