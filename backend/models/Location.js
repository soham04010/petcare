const mongoose = require('mongoose');

// Define the schema for a location
const locationSchema = new mongoose.Schema({
    name: { type: String, required: true },
    address: { type: String, required: true },
    city: { type: String, required: true },
    contact: { type: String, required: true }
}, { timestamps: true }); // Adding timestamps to keep track of creation and update times

// Create a model for Location using the schema
const Location = mongoose.model('Location', locationSchema);

module.exports = Location;
