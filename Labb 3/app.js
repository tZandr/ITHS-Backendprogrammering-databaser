const express = require("express");
const mysql = require("mysql2");

const app = express();
app.use(express.json());
const port = 3000;

app.get("/", (req, res) => {
  res.send("Hello World!");
});

app.listen(port, () => {
  console.log(`Example app listening on port ${port}`);
});

const connection = mysql.createConnection({
  host: "localhost",
  user: "root",
  password: "root",
  database: "myArtists",
});

connection.query("SELECT * FROM artists", (error, results) => {
  if (error) {
    console.error(error);
  } else {
    console.log(results);
  }
});

connection.query("SELECT * FROM albums", (error, results) => {
  if (error) {
    console.error(error);
  } else {
    console.log(results);
  }
});

// --- Routes / Endpoints --- //

// CREATE - Lägga till:
app.post("/artists", (req, res) => {
  const { name, country, debutYear } = req.body;
  connection.query(
    "INSERT INTO artists (name, country, debutYear) VALUES (?, ?, ?)",
    [name, country, debutYear],
    (error, results) => {
      if (error) {
        res.status(500).json({ error: error.message });
      } else {
        res
          .status(201)
          .json({ id: results.insertId, name, country, debutYear });
      }
    },
  );
});

app.post("/albums", (req, res) => {
  const { artist_id, title, releaseYear } = req.body;
  connection.query(
    "INSERT INTO albums (artist_id, title, releaseYear) VALUES (?, ?, ?)",
    [artist_id, title, releaseYear],
    (error, results) => {
      if (error) {
        res.status(500).json({ error: error.message });
      } else {
        res
          .status(201)
          .json({ id: results.insertId, artist_id, title, releaseYear });
      }
    },
  );
});

// READ - Visa alla:
app.get("/artists", (req, res) => {
  connection.query("SELECT * FROM artists", (error, results) => {
    if (error) {
      console.error(error);
    } else {
      console.log(results);
      res.json(results);
    }
  });
});

app.get("/albums", (req, res) => {
  connection.query("SELECT * FROM albums", (error, results) => {
    if (error) {
      console.error(error);
    } else {
      console.log(results);
      res.json(results);
    }
  });
});

// READ - Visa en med en parameter
app.get("/artists/:id", (req, res) => {
  const id = req.params.id;
  connection.query(
    "SELECT * FROM artists WHERE id = ?",
    [id],
    (error, results) => {
      if (error) {
        res.status(500).json({ error: error.message });
      } else if (results.length === 0) {
        res.status(404).json({ message: "Artist not found." });
      } else {
        console.log(results);
        res.json(results[0]);
      }
    },
  );
});

app.get("/albums/:id", (req, res) => {
  const id = req.params.id;
  connection.query(
    "SELECT * FROM albums WHERE id = ?",
    [id],
    (error, results) => {
      if (error) {
        res.status(500).json({ error: error.message });
      } else if (results.length === 0) {
        res.status(404).json({ message: "Album not found." });
      } else {
        res.json(results[0]);
      }
    },
  );
});

// UPDATE - Uppdatera
app.put("/artists/:id", (req, res) => {
  const id = req.params.id;
  const { name, country, debutYear } = req.body;
  connection.query(
    "UPDATE artists SET name = ?, country = ?, debutYear = ? WHERE id = ?",
    [name, country, debutYear, id],
    (error, results) => {
      if (error) {
        res.status(500).json({ error: error.message });
      } else if (results.affectedRows === 0) {
        res.status(404).json({ message: "Artist not found." });
      } else {
        res.json({ message: "Artist updated." });
      }
    },
  );
});

app.put("/albums/:id", (req, res) => {
  const id = req.params.id;
  const { artist_id, title, releaseYear } = req.body;
  connection.query(
    "UPDATE albums SET artist_id = ?, title = ?, releaseYear = ? WHERE id = ?",
    [artist_id, title, releaseYear, id],
    (error, results) => {
      if (error) {
        res.status(500).json({ error: error.message });
      } else if (results.affectedRows === 0) {
        res.status(404).json({ message: "Album not found." });
      } else {
        res.status(201).json({ message: "Album updated." });
      }
    },
  );
});

// DELETE - Radera med en parameter
app.delete("/artists/:id", (req, res) => {
  const id = req.params.id;
  connection.query(
    "DELETE FROM artists WHERE id = ?",
    [id],
    (error, results) => {
      if (error) {
        res.status(500).json({ error: error.message });
      } else if (results.length === 0) {
        res.status(404).json({ message: "Artist not found." });
      } else {
        res.status(201).json({ message: "Artist deleted." });
      }
    },
  );
});

app.delete("/albums/:id", (req, res) => {
  const id = req.params.id;
  connection.query(
    "DELETE FROM albums WHERE id = ?",
    [id],
    (error, results) => {
      if (error) {
        res.status(500).json({ error: error.message });
      } else if (results.length === 0) {
        res.status(404).json({ message: "Album not found." });
      } else {
        res.status(201).json({ message: "Album deleted." });
      }
    },
  );
});

// Statistik
app.get("/stats", (req, res) => {
  connection.query(
    "SELECT artists.name, COUNT(albums.id) AS albumCount FROM artists LEFT JOIN albums ON artists.id = albums.artist_id GROUP BY artists.id",
    (error, results) => {
      if (error) {
        res.status(500).json({ error: error.message });
      } else {
        res.json(results);
      }
    },
  );
});
