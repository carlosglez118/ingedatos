import mongoose, { Schema } from "mongoose";

const userSchema = new Schema({
    nombre: String,
    edad: Number,
    email: String

}, { strict: false });

export const userModel = new mongoose.model('users', userSchema)   