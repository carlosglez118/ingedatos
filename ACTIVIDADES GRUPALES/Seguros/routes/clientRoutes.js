import { Router } from "express";
import { crearDatos, obtenerDatos } from "../controller/clientController.js";
const router = Router()

router.get('/clients', obtenerDatos);
router.post('/clients', crearDatos);

export default router;