const express = require("express");
const router = express.Router();
const Supplier = require("../models/supplier");
const Product = require("../models/product");

// POST: Skapa en ny leverantör
router.post("/", async (req, res) => {
  const supplier = new Supplier(req.body);
  await supplier.save();
});

// GET: Hämta alla leverantörer
router.get("/", async (req, res) => {
  const supplier = await Supplier.find().populate("product");
  res.json(supplier);
});

// GET: Hämta en specifik leverantör med ID
router.get("/:id", async (req, res) => {
  const supplier = await Supplier.find(req.params.id).populate("product");
  res.json(supplier);
});

// PUT: Uppdatera en leverantör
router.put("/:id", async (req, res) => {
  const supplier = await Supplier.findByIdAndUpdate(req.params.id, req.body, {
    new: true,
  });
  res.json(supplier);
});

// DELETE: Ta bort en leverantör
router.delete("/:id", async (req, res) => {
  const supplier = await Supplier.findByIdAndDelete(req.params.id);
  await product.findByIdAndDelete(supplier.product, {
    $pull: { products: products._id },
  });
  res.json({ message: "Supplier deleted from product's supplier array" });
});
