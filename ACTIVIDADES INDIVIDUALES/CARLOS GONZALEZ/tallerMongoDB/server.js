import { config } from "dotenv"
import express, {json} from "express"

import { connectDatabase } from "./config/database.js"
import userRoutes from "./routes/userRoutes.js"
import productRoutes from "./routes/productRoutes.js"
config()

// Conexión Base de Datos
connectDatabase()
    .then(() => {
        console.log("Conexión Base de Datos Exitosa")
    })
    .catch((error) => {
        console.error("Error al conectar a la Base de Datos:", error)
        process.exit(1)
    });

// Configuración del servidor
const server = express()
const PORT = process.env.PORT

server.use(json());
server.use(express.urlencoded({ extended: true }));
server.use(express.static('public'))



// Configuración Rutas
server.use(userRoutes)
server.use(productRoutes)


server.listen(PORT, () => console.log(`Server running in port https://localhost:${PORT}`))