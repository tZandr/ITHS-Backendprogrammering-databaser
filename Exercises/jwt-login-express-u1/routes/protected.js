const express = require("express");
const router = express.Router();
const protect = require("../middleware/authMiddleware");
const User = require("../models/users");

router.get("/protected", protect, (req, res) => {
  res.send("Skyddad data");
});

module.exports = router;
