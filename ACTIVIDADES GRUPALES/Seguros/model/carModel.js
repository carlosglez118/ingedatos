import mongoose, { Schema } from 'mongoose';

const carSchema = new Schema ({
    marca: String,
    modelo: String,
    anio: Number,
    placa: String
}, { strict: false });

export const carModel = new mongoose.model('vehiculo', carSchema)