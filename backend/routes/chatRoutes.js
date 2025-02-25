const express = require('express');
const { getChatHistory, sendMessage } = require('../controllers/chatController');
const { protect } = require('../middleware/authMiddleware');

const router = express.Router();

router.get('/:userId/:consultantId', protect, getChatHistory); // Fetch chat history
router.post('/send', protect, sendMessage); // Send a new message

module.exports = router;
