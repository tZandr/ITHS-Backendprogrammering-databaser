const jwt = require("jsonwebtoken");

const protect = (req, res, next) => {
  // Get the token from the Authorization header:
  const token = req.headers.authorization?.split(" ")[1];
  if (!token) {
    return res.status(401).send("No token provided");
  }
  try {
    // Verify the token and extract the user ID:
    const decoded = jwt.verify(token, process.env.JWT_SECRET);
    req.userId = decoded.userId;
    next();
  } catch (err) {
    return res.status(401).send("Invalid token");
  }
};

module.exports = protect;
