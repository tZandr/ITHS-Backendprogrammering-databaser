const express = require("express");
const router = express.Router();
const Supplier = require("../models/supplier");
const Product = require("../models/product");

console.log("Supplier routes loaded");

// POST: Skapa en ny leverantör
router.post("/", async (req, res) => {
  try {
    const supplier = new Supplier(req.body);
    await supplier.save();

    // Skicka tillbaka skapad supplier
    res.status(201).json(supplier);
  } catch (error) {
    console.error(error);
    res.status(400).json({ message: error.message });
  }
});


// GET: Hämta alla leverantörer
router.get("/", async (req, res) => {
  const supplier = await Supplier.find().populate("products");

  res.json(supplier);
});

// GET: Hämta en specifik leverantör med ID
router.get("/:id", async (req, res) => {
  const supplier = await Supplier.find(req.params.id).populate("products");
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

module.exports = router;
