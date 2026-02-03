const express = require("express");
const { createServer } = require("node:http");
const { Server } = require("socket.io");

const app = express();
const server = createServer(app);
const io = new Server(server);
const port = 3000;

app.use(express.static("public"));
server.listen(port, () => {
  console.log(`Socket.IO server is running on http://localhost:${port}`);
});

io.on("connection", (socket) => {
  console.log("A user connected:", socket.id);

  socket.on("chatMessage", (msg) => {
    io.emit("newChatMessage", { user: msg.user, message: msg.message }); // 
  });

  socket.on("disconnect", () => {
    console.log("A user disconnected:", socket.id);
  });
});
