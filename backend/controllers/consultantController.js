const Consultant = require('../models/Consultant');

// Get all available consultants
exports.getConsultants = async (req, res) => {
    try {
        const consultants = await Consultant.find({ available: true }); // Only fetch available consultants
        res.json(consultants);
    } catch (error) {
        res.status(500).json({ message: 'Error fetching consultants', error });
    }
};

// Book a consultant
exports.bookConsultant = async (req, res) => {
    try {
        const consultant = await Consultant.findById(req.params.id);
        if (!consultant) return res.status(404).json({ message: 'Consultant not found' });

        // Mark consultant as unavailable after booking
        consultant.available = false;
        await consultant.save();

        res.json({ message: 'Consultant booked successfully', consultant });
    } catch (error) {
        res.status(500).json({ message: 'Error booking consultant', error });
    }
};
