const userService = require("../services/userService");

const getUsersController = async (req, res) => {
  let users = await userService.getUsers();
  res.json(users);
};

const getUserByIdController = async (req, res) => {
  const { id } = req.params;
  let users = await userService.getUserById(id);
  res.json(users);
};

module.exports = { getUsersController, getUserByIdController };
