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
    actualizarStatus,
    obtenerPolizasActivas,
    obtenerPolizasPorMontoPagado,
    obtenerPolizasVencidas,
    obtenerPolizasOrdenadasPorMonto,
    agruparPolizasPorAseguradora,
    filtrarPolizasPorRangoMontoPagado,
    obtenerPolizasConPagoMayor50,
    obtenerPolizasProximasAVencer,
    obtenerPolizasConPagosPendientes,
    obtenerClienteConMayorMontoAsegurado } from "../controller/polizaController.js";
const router = Router()


// Consultas básicas
router.get('/polizas', obtenerDatos);
router.get('/polizas/aseguradora', obtenerVehiculosPorAseguradora);
router.get('/polizas/obtenerPolizas', obtenerPolizasPorNumero);
router.get('/polizas/obtenerVehiculo', obtenerVehiculo);
router.get('/polizas/polizasActivas', obtenerPolizasActivas);
router.get('/polizas/porMontoPagado', obtenerPolizasPorMontoPagado);
router.get('/polizas/polizasVencidas', obtenerPolizasVencidas);


// Consultas específicas
router.get('/polizas/ordenadasPorMonto', obtenerPolizasOrdenadasPorMonto);
router.get('/polizas/agruparAseguradoras', agruparPolizasPorAseguradora);
router.get('/polizas/rangoMontos', filtrarPolizasPorRangoMontoPagado);
router.get('/polizas/moreThanHalf', obtenerPolizasConPagoMayor50);
router.get('/polizas/pagosPendientes', obtenerPolizasConPagosPendientes);
router.get('/polizas/proximasVencer', obtenerPolizasProximasAVencer);
router.get('/polizas/mayorMontoTotal', obtenerClienteConMayorMontoAsegurado);


// 5 Modificaciones
router.put('/polizas/actualizarEstado', actualizarEstado);
router.put('/polizas/actualizar', actualizarDatos);
router.put('/polizas/registrarPago', registrarPago);
router.put('/polizas/actualizarStatus', actualizarStatus);
router.put('/polizas/calcularMontoPendiente', calcularMontoPendiente);
router.post('/polizas', crearDatos);

// Eliminacion
router.delete('/polizas/eliminar', eliminarPoliza);



export default router;