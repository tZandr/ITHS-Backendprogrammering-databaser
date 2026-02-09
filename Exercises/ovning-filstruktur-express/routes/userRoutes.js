const express = require("express");
const router = express.Router();
const {
  getUsersController,
  getUserByIdController,
} = require("../controllers/userController");

router.get("/", getUsersController);
router.get("/:id", getUserByIdController);

module.exports = router;
