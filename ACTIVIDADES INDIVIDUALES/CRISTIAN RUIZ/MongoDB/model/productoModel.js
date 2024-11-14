import mongoose, { Schema } from "mongoose";

const productoSchema = new Schema({
    name: String,
    precio: Number,
    categoria: String
    
}, { strict: false }); // Agregar `{ strict: false }` permite campos adicionales

export const productoModel = new mongoose.model('Productos', productoSchema)