const express = require("express")
const router = express.Router();
const User = require("../models/users");

console.log("Login route loaded");

export const login = async (email, password) => {

    // Find the user by email:
    const user = await User.findOne({ email });
    if (!user) {
        throw new Error("No user found with that email.");
    }

    // Compare the password to the hash:
    const ok = await bcrypt.compare(password, user.password);
    if (!ok) {
        throw new Error("Incorrect password.");
    }

    // Create a JWT token:
    const token = jwt.sign(
        { userId: user._id },
        process.env.JWT_SECRET,
        { expiresIn: "1h" }
    );
    return token;
}

module.exports = router;
