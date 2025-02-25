const express = require('express');
const { getConsultants, bookConsultant } = require('../controllers/consultantController');
const { protect } = require('../middleware/authMiddleware');

const router = express.Router();

router.get('/', getConsultants); // Fetch all available consultants
router.post('/book/:id', protect, bookConsultant); // Book a consultant (user must be logged in)

module.exports = router;
