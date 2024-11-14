import { Router } from "express";
import { crearDatos, obtenerDatos, moreThan30, obtenerNombreEspecifico, elimLuis, lessThan30, actualizarJuanPerez, activoTrue } from "../controller/userController.js";
const router = Router()

router.get('/users', obtenerDatos);
router.post('/users', crearDatos);
router.post('/users/buscarnombre', obtenerNombreEspecifico);
router.get('/users/buscaredad', moreThan30);
router.put('/users/modificaredad', actualizarJuanPerez);
router.put('/users/agregarcampo', activoTrue);
router.delete('/users/eliminarnombre', elimLuis);
router.delete('/users/eliminaredad', lessThan30);


export default router;