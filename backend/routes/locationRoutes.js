const express = require('express');
const router = express.Router();

// Example controller functions (you will replace them with actual logic)
const { getLocation, addLocation } = require('../controllers/locationController');

// Route to get locations (could be based on a search or all locations)
router.get('/', getLocation);

// Route to add a new location (for example, a pet store or vet shop)
router.post('/', addLocation);

module.exports = router;
