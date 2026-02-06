const express = require("express");
const http = require("http");
const socketIo = require("socket.io");

const app = express();
const server = http.createServer(app);
const io = socketIo(server);

let count = 0;

app.use(express.static("public"));

io.on("connection", (socket) => {
  console.log("A user has connected.");
  socket.emit("count", count);
});



server.listen(3000, () => {
  console.log("Server is listening on port 3000");
});
