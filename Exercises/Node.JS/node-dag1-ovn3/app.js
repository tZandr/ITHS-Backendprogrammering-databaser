const express = require("express");
const app = express();
const port = 3000;

app.use(express.json());
app.use(express.urlencoded({ extended: true }));

app.get("/public", (req, res) => {
  res.send("gpt thinks this is wrong:)");
});

app.post("/records", (req, res) => {
  const { artist, title } = req.body;
  res.send("jag heter " + artist);
});

app.use(express.static("public"));
app.listen(port, () => console.log(`Example app listening on port ${port}!`));
