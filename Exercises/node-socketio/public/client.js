const socket = io();

const button = document.querySelector("#button");
let countDisplay = document.querySelector("#countDisplay");

socket.on("count", (count) => {
  countDisplay.innerHTML = count;
});

button.addEventListener("click", () => {
  socket.emit("increment");
});
