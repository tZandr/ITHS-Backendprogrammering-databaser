const express = require("express");
const { createServer } = require("node:http");
const { Server } = require("socket.io");

const app = express();
const server = createServer(app);
const io = new Server(server);

const port = 3000;

// Mongoose
const messageModel = require("./models/messageModel");
const connection = require("./connection");
connection();

app.use(express.static("public"));

app.get("/messages", async (req, res) => {
  try {
    const allMessages = await messageModel.find();
    return res.status(200).json(allMessages);
  } catch (error) {
    return res.status(500).json({
      error: error.message,
    });
  }
});

io.on("connection", (socket) => {
  console.log(`A client with id ${socket.id} connected to the chat!`);

  socket.on("chatMessage", msg => {
    //console.log('Meddelanden: ' + msg.message)
    io.emit("newChatMessage", msg.user + " : " + msg.message);
    let today = new Date();
    let date =
      today.getFullYear() +
      "-" +
      (today.getMonth() + 1) +
      "-" +
      today.getDate();
    let time =
      today.getHours() + ":" + today.getMinutes() + ":" + today.getSeconds();
    let dateTime = date + " " + time;
    let user = msg.user;
    let message = msg.message;

    // Sparar till MongoDB med Mongoose
    const newMessage = new messageModel({
      message: message,
      user: user,
      date: dateTime,
    });
    newMessage.save();
  });

  socket.on("disconnect", () => {
    console.log(`Client ${socket.id} disconnected!`);
  });
});

server.listen(port, () => {
  console.log(`Socket.IO server is running on http://localhost:${port}`);
});
