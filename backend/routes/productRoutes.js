const express = require('express');
const { getProducts, addProduct, buyProduct } = require('../controllers/productController');
const { protect } = require('../middleware/authMiddleware');

const router = express.Router();

router.get('/', getProducts); // Fetch all products
router.post('/add', protect, addProduct); // Add new product (only authenticated users)
router.post('/buy/:id', protect, buyProduct); // Buy a product (user must be logged in)

module.exports = router;
