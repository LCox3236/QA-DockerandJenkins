const express = require('express');
const app = express();
const port = 5000

const add = (x,y) => x+y
const sub = (x,y) => x-y
const mult = (x,y) => x*y
const div = (x,y) => x/y
const validateInput = (x, y) => {
    if (isNaN(x) || isNaN(y)) {
        return false
    }
    return true
}
module.exports = {add, sub, mult, div, validateInput}
app.get('/', (req, res) => res.send('Hello World!'))

app.listen(5000, () => console.log(`App running on port ${port}`));