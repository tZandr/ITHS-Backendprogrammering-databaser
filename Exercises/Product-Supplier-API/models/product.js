const mongoose = require("mongoose");

const productSchema = new mongoose.Schema({
  name: { type: String, required: true },
  category: { type: String, enum: ["electronics", "clothes", "food"] },
  price: { type: Number, required: true },
  stock: { type: Number, default: 0 },
  tags: [String],
  details: { brand: String, color: String, weight: String },
  supplier: {
    type: mongoose.Schema.Types.ObjectId,
    ref: "Supplier",
    required: true,
  },
});

module.exports = mongoose.model("Product", productSchema);
