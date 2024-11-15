import mongoose, { Schema } from 'mongoose';

const userSchema = new Schema ({
    nombre: String,
    rol: String,
    telefono: String,
}, { strict: false });

export const userModel = new mongoose.model('users', userSchema)