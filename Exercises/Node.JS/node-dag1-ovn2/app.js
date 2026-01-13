const express = require("express");
const app = express();
const port = 3000;

app.get("/user", (req, res) => {
  res.send("Get request till /user");
});

app.post("/user", (req, res) => {
  res.send("Post request till /user");
});

app.put("/user", (req, res) => {
  res.send("Put request till /user");
});

app.delete("/user", (req, res) => {
  res.send("Delete request till /user");
});

// Samma sak för categories

app.get("/categories", (req, res) => {
  res.send("GET request till categories");
});

app.post("/categories", (req, res) => {
  res.send("POST request till categories");
});

app.put("/categories", (req, res) => {
  res.send("PUT request till categories");
});

app.delete("/categories", (req, res) => {
  res.send("DELETE request till categories");
});

app.listen(port, () => console.log(`Example app listening on port ${port}!`));
