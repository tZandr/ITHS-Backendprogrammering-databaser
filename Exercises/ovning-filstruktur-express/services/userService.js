let users = [
  { id: 1, name: "Alice" },
  { id: 2, name: "Bob" },
  { id: 3, name: "Charlie" },
];

const getUsers = () => {
    return users;
}

const getUserById = (id) => {
    return users.find(user => user.id === id);
};

module.exports = {
    getUsers,
    getUserById
}
