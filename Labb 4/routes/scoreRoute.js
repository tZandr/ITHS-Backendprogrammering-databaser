const express = require("express");
const scoreModel = require("../models/scoreModel");
const router = express.Router();

router.get("/scores", async (req, res) => {
  try {
    const scores = await scoreModel.find();
    res.json(scores);
  } catch (err) {
    console.error(err);
    res.status(500).json({ error: "Server error" });
  }
});

module.exports = router;
