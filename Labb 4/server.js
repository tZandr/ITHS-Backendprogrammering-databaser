const express = require("express");
const { createServer } = require("node:http");
const { Server } = require('socket.io');

const app = express();
const server = createServer(app);
const io = new Server(server);

const port = 3000;

app.use(express.static("public"));

app.get("/", (req, res) => {
  res.send("Hello hello");
});

server.listen(port, () => {
  console.log(`Server running on port ${port}`);
});
