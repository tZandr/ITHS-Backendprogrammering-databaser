const express = require("express");
const app = express();
const mysql = require("mysql2");

app.use(express.json());

app.listen(3000, () => {
  console.log("Server running on http://localhost:3000");
});

const db = mysql.createConnection({
  host: "localhost",
  user: "root",
  password: "root",
  database: "phone_db",
});

db.query("SELECT * FROM phone", (err, results) => {
  if (err) {
    console.error(err);
  } else {
    console.log(results);
  }
});

app.get("/api/phones", (req, res) => {
  db.query("SELECT * FROM phone", (err, results) => {
    if (err) {
      console.error(err);
    } else {
      res.json(results);
    }
  });
});

app.get("/api/phones/:id", (req, res) => {
  const id = req.params.id; // detta hämtar talet efter /phones/

  db.query("SELECT * FROM phone WHERE id = ?", [id], (err, results) => {
    if (err) {
      res.status(500).json({ error: err.message });
    } else if (results.length === 0) {
      res.status(404).json({ message: "Phone not found." });
    } else {
      res.json(results[0]);
    }
  });
});

app.post("/api/phones", (req, res) => {
  const { brand, model, price } = req.body;

  db.query(
    "INSERT INTO phone (brand, model, price) VALUES (?, ?, ?)",
    [brand, model, price],
    (err, result) => {
      if (err) {
        res.status(500).json({ error: err.message });
      } else {
        res.status(201).json({
          id: result.insertId,
          brand,
          model,
          price,
        });
      }
    },
  );
});
