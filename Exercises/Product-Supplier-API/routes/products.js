const express = require("express");
const router = express.Router();
const Supplier = require("../models/supplier");
const Product = require("../models/product");

// CREATE (using new Product)
router.post("/", async (req, res) => {
  const product = new Product(req.body);
  await product.save();

  await Supplier.findByIdAndUpdate(product.supplier, {
    $push: { products: product._id },
  });
  res.status(201).json(product);
});
