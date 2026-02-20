const socket = io();

const userForm = document.getElementById("userForm");
const userInput = document.getElementById("userInput");
const messageForm = document.getElementById("messageForm");
const messageInput = document.getElementById("messageInput");
const chatBox = document.getElementById("chatBox");
const userDiv = document.getElementById("userDiv");
const lobby = document.getElementById("lobby");

let user;

userForm.addEventListener("submit", function (e) {
  e.preventDefault();
  user = userInput.value;

  userDiv.style.display = "none";
  lobby.style.display = "block";

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
