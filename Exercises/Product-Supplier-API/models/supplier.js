const mongoose = require("mongoose");

const supplierSchema = new mongoose.Schema({
  name: { type: String, required: true },
  company: { type: String, required: true },
  email: { type: String, required: true, unique: true },
  phone: { type: String, required: true },
  rating: { type: Number, min: 1, max: 5 },
  isActive: { type: Boolean, default: true },
  adress: {
    street: { type: String },
    city: { type: String },
    country: { type: String },
  },
  products: [{ type: mongoose.Schema.Types.ObjectId, ref: "Product" }],
});

module.exports = mongoose.model("Supplier", supplierSchema);
