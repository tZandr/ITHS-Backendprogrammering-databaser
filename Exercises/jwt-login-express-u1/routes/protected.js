const express = require("express");
const router = express.Router();
const { protect } = require("../middleware/auth");

router.get("/protected", protect, (req, res) => { res.send("Skyddad data"); })

module.exports = router;
