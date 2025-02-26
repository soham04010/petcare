const express = require('express');
const Consultant = require('../models/Consultant');

const router = express.Router();

// Get all consultants
router.get('/', async (req, res) => {
    try {
        const consultants = await Consultant.find({});
        
        if (!consultants || consultants.length === 0) {
            return res.status(404).json({ message: "No consultants found." });
        }

        res.json(consultants);
    } catch (error) {
        console.error("Error fetching consultants:", error);
        res.status(500).json({ message: "Error fetching consultants", error });
    }
});

// Add a new consultant
router.post('/add', async (req, res) => {
    try {
        const { name, specialization, experience, phone, available } = req.body;

        const newConsultant = new Consultant({
            name,
            specialization,
            experience,
            phone,
            available
        });

        await newConsultant.save();
        res.status(201).json({ message: "Consultant added successfully", consultant: newConsultant });
    } catch (error) {
        res.status(500).json({ message: "Error adding consultant", error });
    }
});

module.exports = router;
