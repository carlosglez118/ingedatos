import mongoose, { Schema } from 'mongoose';

const polizaSchema = new Schema({
    n_poliza: {type: String, unique: true},
    fecha_inicio: Date,
    fecha_fin: Date,
    monto_pagado: Number,
    nombre_cliente: String,
    usuario: String,
    aseguradora: String,
    vehiculo: String,
    placa_vehiculo: String,
    montoTotal: Number,
    montoPendiente: Number,
    status: Boolean,

}, { strict: false});

export const polizaModel = new mongoose.model('polizas', polizaSchema);