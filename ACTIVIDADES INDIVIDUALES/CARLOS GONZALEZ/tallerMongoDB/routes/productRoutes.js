import { Router } from "express";
import { crearDatos,
    obtenerDatos,
    moreThan100,
    productsDescent,
    stockTrue,
    stockFalse,
    lessThan50,
    precioPromedioPorCategoria,
    categoriaConMayorPrecioPromedio
} from "../controller/productController.js";
const router = Router()

router.get('/productos', obtenerDatos);
router.post('/productos', crearDatos);
router.post('/productos/mascien', moreThan100);
router.get('/productos/desc', productsDescent);
router.put('/productos/agregarcampo', stockTrue);
router.put('/productos/modifcampo', stockFalse);
router.delete('/productos/eliminar', lessThan50);
router.get('/productos/precioCategoria', precioPromedioPorCategoria);
router.get('/productos/mayorPrecio', categoriaConMayorPrecioPromedio)


export default router;