const socket = io();

const formUser = document.querySelector("#formUser");
const inputUser = document.querySelector("#inputUser");
const messages = document.querySelector("#messages");
const formMessage = document.querySelector("#formMessage");
const inputMessage = document.querySelector("#inputMessage");
const userContainer = document.querySelector("#userContainer");

formUser.addEventListener("submit", function (e) {
  e.preventDefault();
  myUser = inputUser.value;
  userContainer.innerHTML = "<h2>Welcome, " + myUser + "</h2>";
  document.getElementById("user").style.display = "none";
  document.getElementById("message").style.display = "block";
});

formMessage.addEventListener("submit", function (e) {
  e.preventDefault();
  if (inputMessage.value) {
    socket.emit('chatMessage', {user: myUser, message: inputMessage.value});;
    inputMessage.value = "";
  }
});

socket.on("newChatMessage", (msg) => {
  let item = document.createElement("li");
  // item.textContent = msg; // ovn 1(ingen user)
  item.textContent = msg.user + ": " + msg.message;
  messages.appendChild(item);
});
