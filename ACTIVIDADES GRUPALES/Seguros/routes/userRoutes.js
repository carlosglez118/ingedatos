import { Router } from "express";
import { crearDatos, obtenerDatos } from "../controller/userController.js";
const router = Router()

router.get('/users', obtenerDatos);
router.post('/users', crearDatos);

export default router;