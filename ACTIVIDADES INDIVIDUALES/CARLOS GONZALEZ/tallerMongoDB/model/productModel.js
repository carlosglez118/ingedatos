import mongoose, { Schema } from "mongoose";

const productSchema = new Schema({
    nombre: String,
    precio: Number,
    categoria: String
}, { strict: false});

export const productModel = new mongoose.model('productos', productSchema)