import { Router } from "express";
import { crearDatos, obtenerDatos } from "../controller/vehiculosController.js";
const router = Router()

router.get('/vehiculos', obtenerDatos);
router.post('/vehiculos', crearDatos);

export default router;