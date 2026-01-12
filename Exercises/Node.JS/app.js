const express = require('express');
const app = express();
const port = 3000;

app.get('/', (req, res) => {
res.send('Hello World!');
});

app.post('/', (req, res) => {
res.send('You just posted cringe! You are going to lose subscriber!')
})

app.listen(port, () => {
console.log(`Example app listening on port ${port}`);
})
