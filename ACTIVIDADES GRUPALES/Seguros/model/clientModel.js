import mongoose, { Schema } from 'mongoose';

const clientSchema = new Schema ({
    nombre: String,
    direccion: String,
    telefono: String,
    email: String
}, { strict: false });

export const clientModel = new mongoose.model('clients', clientSchema)