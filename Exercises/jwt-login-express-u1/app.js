require("dotenv").config();
const express = require("express");
const connection = require("./connection");

const protectedRoutes = require("./routes/protected");
const signupRoutes = require("./routes/signup");
const loginRoutes = require("./routes/login");

const app = express();
app.use(express.json());

connection();

app.use("/protected", protectedRoutes);
app.use("/signup", signupRoutes);
app.use("/login", loginRoutes);

app.listen(3000, () => {
  console.log("Server is running on port 3000");
});
