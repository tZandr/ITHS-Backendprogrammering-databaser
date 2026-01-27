// Importera Express-biblioteket, som används för att skapa en webserver
const express = require("express");

// Skapa en instans av Express-appen
const app = express();

// Importera mysql2-biblioteket för att kunna kommunicera med MySQL-databasen
const mysql = require("mysql2");

// Middleware: låter Express tolka JSON-data i request body
// Viktigt för POST-förfrågningar där vi skickar JSON
app.use(express.json());

// Starta servern och lyssna på port 3000
// När servern startar skriver vi ut en logg
app.listen(3000, () => {
  console.log("Server running on http://localhost:3000");
});

// Skapa en connection till MySQL-databasen
// Ändra host, user, password och database om du har andra värden
const db = mysql.createConnection({
  host: "localhost",
  user: "root",
  password: "root",
  database: "phone_db",
});

// Testa att databasen fungerar genom att hämta alla telefoner direkt vid start
db.query("SELECT * FROM phone", (err, results) => {
  if (err) {
    // Om något går fel, skriv ut felmeddelandet
    console.error(err);
  } else {
    // Visa alla telefoner i terminalen (för debug)
    console.log(results);
  }
});

// --------------------------------------------
// ROUTES / ENDPOINTS
// --------------------------------------------

// GET /api/phones
// Denna route hämtar alla telefoner från databasen
app.get("/api/phones", (req, res) => {
  // SQL-fråga för att hämta allt från tabellen "phone"
  db.query("SELECT * FROM phone", (err, results) => {
    if (err) {
      // Om något går fel, skriv ut fel i serverkonsolen
      console.error(err);
    } else {
      // Skicka tillbaka resultaten som JSON till frontend
      res.json(results);
    }
  });
});

// GET /api/phones/:id
// Denna route hämtar en specifik telefon baserat på id
app.get("/api/phones/:id", (req, res) => {
  // req.params.id hämtar värdet från URL:en, t.ex. /api/phones/2 → id = 2
  const id = req.params.id;

  // SQL-fråga för att hämta telefon med ett specifikt id
  // '?' används för att mysql2 säkert sätter in id (förhindrar SQL-injection)
  db.query("SELECT * FROM phone WHERE id = ?", [id], (err, results) => {
    if (err) {
      // Om något går fel, skicka 500 Internal Server Error med felmeddelande
      res.status(500).json({ error: err.message });
    } else if (results.length === 0) {
      // Om ingen telefon hittas med detta id, skicka 404 Not Found
      res.status(404).json({ message: "Phone not found." });
    } else {
      // Om telefon hittas, skicka tillbaka objektet som JSON
      res.json(results[0]);
    }
  });
});

// POST /api/phones
// Denna route används för att skapa en ny telefon
app.post("/api/phones", (req, res) => {
  // Vi hämtar brand, model och price från request body (skickad som JSON)
  const { brand, model, price } = req.body;

  // SQL-fråga för att lägga till en ny telefon i tabellen
  // '?' används för att mysql2 säkert stoppar in värdena
  db.query(
    "INSERT INTO phone (brand, model, price) VALUES (?, ?, ?)",
    [brand, model, price],
    (err, result) => {
      if (err) {
        // Om något går fel, skicka 500 Internal Server Error med felmeddelande
        res.status(500).json({ error: err.message });
      } else {
        // Om insättning lyckas, skicka tillbaka den nya telefonen inklusive id
        res.status(201).json({
          id: result.insertId, // det auto-genererade id:t från MySQL
          brand,
          model,
          price,
        });
      }
    },
  );
});
