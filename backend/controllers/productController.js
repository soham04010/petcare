const Product = require('../models/Product');

// Get all products
exports.getProducts = async (req, res) => {
    try {
        const products = await Product.find();
        res.json(products);
    } catch (error) {
        res.status(500).json({ message: 'Error fetching products', error });
    }
};

// Add a new product
exports.addProduct = async (req, res) => {
    const { name, description, price, imageUrl, category, stock } = req.body;
    try {
        const product = new Product({ name, description, price, imageUrl, category, stock });
        await product.save();
        res.status(201).json({ message: 'Product added successfully', product });
    } catch (error) {
        res.status(500).json({ message: 'Error adding product', error });
    }
};

// Buy a product
exports.buyProduct = async (req, res) => {
    try {
        const product = await Product.findById(req.params.id);
        if (!product) return res.status(404).json({ message: 'Product not found' });

        if (product.stock > 0) {
            product.stock -= 1;
            await product.save();
            res.json({ message: 'Product purchased successfully', product });
        } else {
            res.status(400).json({ message: 'Out of stock' });
        }
    } catch (error) {
        res.status(500).json({ message: 'Error purchasing product', error });
    }
};
