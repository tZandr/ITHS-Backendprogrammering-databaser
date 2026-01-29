require("dotenv").config();
const express = require("express");
const connectDB = require("./db");

const productRoutes = require("./routes/products");
const supplierRoutes = require("./routes/suppliers");

const app = express();
app.use(express.json());

connectDB();

app.use("./routes/products", productRoutes);
app.use("./routes/suppliers", supplierRoutes);

app.listen(3000, () => {
  console.log("Server is running on port 3000");
});
