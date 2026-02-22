const socket = io();

const userForm = document.getElementById("userForm");
const userInput = document.getElementById("userInput");
const messageForm = document.getElementById("messageForm");
const messageInput = document.getElementById("messageInput");
const chatBox = document.getElementById("chatBox");
const userDiv = document.getElementById("userDiv");
const lobby = document.getElementById("lobby");
const rollButton = document.getElementById("rollButton");
const diceOne = document.getElementById("diceOne");
const diceTwo = document.getElementById("diceTwo");
const sum = document.getElementById("sum");

let user;

userForm.addEventListener("submit", function (e) {
  e.preventDefault();
  user = userInput.value;

  userDiv.style.display = "none";
  lobby.style.display = "flex";

  let welcomeUser = document.createElement("li");
  welcomeUser.innerHTML = `Welcome <strong>${user}</strong>!`;
  chatBox.appendChild(welcomeUser);
});

messageForm.addEventListener("submit", function (e) {
  e.preventDefault();
  if (messageInput.value) {
    socket.emit("chatMessage", { user: user, message: messageInput.value });
    messageInput.value = "";
  }
});

socket.on("newMessage", function (msg) {
  let item = document.createElement("li");
  item.textContent = msg;
  chatBox.appendChild(item);
});

let totalScore = 0;

rollButton.addEventListener("click", function () {
  const dice1 = Math.floor(Math.random() * 6) + 1;
  const dice2 = Math.floor(Math.random() * 6) + 1;
  const sumDice = dice1 + dice2;

  diceOne.innerText = dice1;
  diceTwo.innerText = dice2;
  sum.innerText = sumDice;

  totalScore += sumDice;
  console.log(totalScore);
  socket.emit("rollDice", {
    user: user,
    score: sumDice,
    total: totalScore,
  });
});

socket.on("scoreMessage", function (data) {
  console.log("User scoreMessage:", data);
  let item = document.createElement("li");
  item.textContent = data.message;
  chatBox.appendChild(item);

  if (data.type === "system") {
    item.style.color = "yellow";
    item.style.fontStyle = "italic";
  }
});
