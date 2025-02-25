const mongoose = require('mongoose');

const consultantSchema = new mongoose.Schema({
    name: { type: String, required: true },
    specialization: { type: String, required: true },
    experience: { type: Number, required: true },
    phone: { type: String, required: true },
    available: { type: Boolean, default: true }, // Indicates if the consultant is available
    profileImage: { type: String }, // URL to consultant's profile image
});

module.exports = mongoose.model('Consultant', consultantSchema);
