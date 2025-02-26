const mongoose = require('mongoose');

const locationSchema = new mongoose.Schema({
    name: { type: String, required: true },
    address: { type: String, required: true },
    city: { type: String, required: true },
    contact: { type: String, required: true },
    location: {
        type: { type: String, default: "Point" },
        coordinates: { type: [Number], required: true }
    }
});

// Create an index for geospatial queries
locationSchema.index({ location: "2dsphere" });

module.exports = mongoose.model('Location', locationSchema);
