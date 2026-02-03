const mongoose = require("mongoose");

const connection = async () => {
  try {
    await mongoose.connect(
      "mongodb://admin:admin@localhost:27017/?authSource=admin",
    );
  } catch (error) {
    console.error(error);
    process.exit(1);
  }
};

module.exports = connection;
