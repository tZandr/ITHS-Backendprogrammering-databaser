require("dotenv").config();
const express = require("express");
const { createServer } = require("node:http");
const { Server } = require("socket.io");

const app = express();
const server = createServer(app);
const io = new Server(server);

const port = 3000;

const scoreModel = require("./models/scoreModel");
const scoresRouter = require("./routes/scoreRoute");

const connectionMongoDB = require("./connectionMongoDB");
connectionMongoDB();

app.use(express.static("public"));
app.use("/", scoresRouter);

io.on("connection", (socket) => {
  console.log(`${socket.id} has connected!`);

  socket.on("chatMessage", (msg) => {
    let today = new Date();
    let time =
      today.getHours() + ":" + today.getMinutes() + ":" + today.getSeconds();

    io.emit("newMessage", `(` + time + `) ` + msg.user + ": " + msg.message);
  });

  // Save data, send to db, emit message with score
  socket.on("rollDice", async (data) => {
    const newRoll = new scoreModel({
      user: data.user,
      score: data.score,
      total: data.total,
    });

    await newRoll.save();

    io.emit("scoreMessage", {
      type: "system",
      message: `${data.user} just rolled ${data.score}. Their total is now ${data.total}!`,
    });
  });

  socket.on("disconnect", () => {
    console.log(`${socket.id} has disconnected!`);
  });
});

server.listen(port, () => {
  console.log(`Server running on port ${port}`);
});
