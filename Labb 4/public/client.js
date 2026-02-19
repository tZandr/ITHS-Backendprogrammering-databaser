const socket = io();

const userForm = document.getElementById("userForm");
const userInput = document.getElementById("userInput");
const messageForm = document.getElementById("messageForm");
const messageInput = document.getElementById("messageInput");
const chatBox = document.getElementById("chatBox");
const userDiv = document.getElementById("userDiv");

let user;

userForm.addEventListener("submit", function (e) {
  e.preventDefault();
  user = userInput.value;

  userDiv.style.display = "none";
  chatBox.style.display = "block";

  let welcomeUser = document.createElement("li");
  welcomeUser.innerHTML = `Welcome <strong>${user}</strong>!`;
  chatBox.appendChild(welcomeUser);
});
