require("dotenv").config();
const express = require("express");
const { createServer } = require("node:http");
const { Server } = require("socket.io");

const app = express();
const server = createServer(app);
const io = new Server(server);

const port = 3000;

const messageModel = require("./models/messageModel");

const connectionMongoDB = require("./connectionMongoDB");
connectionMongoDB();

app.use(express.static("public"));

io.on("connection", (socket) => {
  console.log(`${socket.id} has connected!`);

  socket.on("chatMessage", (msg) => {
    let today = new Date();
    let date =
      today.getFullYear() +
      "-" +
      (today.getMonth() + 1) +
      "-" +
      today.getDate();
    let time = // Get current time
      today.getHours() + ":" + today.getMinutes() + ":" + today.getSeconds();
    let dateTime = date + " " + time;
    // emit message with current time, user and their sent message
    io.emit("newMessage", `(` + time + `)` + msg.user + ": " + msg.message);

    // save message to mongoose
    const newMessage = new messageModel({
      message: msg.message,
      user: msg.user,
      date: dateTime,
    });
    newMessage.save();
  });

  socket.on("disconnect", () => {
    console.log(`${socket.id} has disconnected!`);
  });
});

server.listen(port, () => {
  console.log(`Server running on port ${port}`);
});
