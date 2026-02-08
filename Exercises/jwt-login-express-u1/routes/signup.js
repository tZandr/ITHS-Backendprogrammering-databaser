const express = require("express");
const router = express.Router();
const User = require("../models/users");

console.log("Signup route loaded")

export const register = async (email, password) => {
  // Check if the user already exists:
  const existingUser = await User.findOne({ email });
  if (existingUser) {
    throw new Error("A user with that email already exists.");
  }

  // Hash the password:
  const hash = await bcrypt.hash(password, 12);

  // Create the user:
  return await User.create({
    email,
    password: hash,
  });
};

router.post("/", async (req, res) => {
  const { email, password } = req.body;
  try {
    await register(email, password);
    res.status(201).json({ message: "User registered" });
  } catch (error) {
    res.status(400).json({ error: error.message });
  }
});

module.exports = router;
