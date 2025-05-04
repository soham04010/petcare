// routes/productRoutes.js
const express = require("express");
const router = express.Router();
const Product = require("../models/Product");

// Get all products
router.get("/", async (req, res) => {
  const products = await Product.find();
  res.json(products);
});

// Get single product
router.get("/:id", async (req, res) => {
  const product = await Product.findById(req.params.id);
  res.json(product);
});

// Add product
router.post("/", async (req, res) => {
  const { name, image, description, price, category, stock } = req.body;
  const product = new Product({ name, image, description, price, category, stock });
  await product.save();
  res.status(201).json(product);
});

module.exports = router;
