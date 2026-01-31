const express = require("express");
const router = express.Router();
const Supplier = require("../models/supplier");
const Product = require("../models/product");

// CREATE (using new Product)
router.post("/", async (req, res) => {
  const product = new Product(req.body);
  await product.save();

  // Push product ID to supplier's products array
  await Supplier.findByIdAndUpdate(product.supplier, {
    $push: { products: product._id },
  });
  res.status(201).json(product);
});

// READ/GET all products
router.get("/", async (req, res) => {
  const products = await Product.find().populate("supplier");
  res.json(products);
});

// READ/GET single product by ID
router.get("/:id", async (req, res) => {
  const product = await Product.findById(req.params.id).populate("supplier");
  res.json(product);
});

// UPDATE single product by ID
router.put("/:id", async (req, res) => {
  const product = await Product.findByIdAndUpdate(req.params.id, req.body, {
    new: true,
  });
  res.json(product);
});

// DELETE single product by ID
router.delete("/:id", async (req, res) => {
  const product = await Product.findByIdAndDelete(req.params.id);

  // remove from suppliers product array
  await Supplier.findByIdAndDelete(product.supplier, {
    $pull: { products: product._id },
  });
  res.json({ message: "Product deleted from supplier" });
});
