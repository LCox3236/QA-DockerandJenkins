// calculator.js

const add = (x,y) => x+y
const sub = (x,y) => x-y
const mult = (x,y) => x*y
const div = (a, b) => {
    if (b === 0) return 'Error: divide by zero';
    return a / b;
}
const validateInput = (x, y) => {
    if (isNaN(x) || isNaN(y)) {
        return false
    }
    return true
}

function evaluateExpressionArray(arr) {
    if (arr.length !== 3) return 'Error: invalid input';

    const [left, op, right] = arr;
    const a = parseFloat(left);
    const b = parseFloat(right);

    switch (op) {
        case '+': return add(a, b).toString();
        case '-': return subtract(a, b).toString();
        case '*':
        case '×': return multiply(a, b).toString();
        case '/':
        case '÷': return divide(a, b).toString();
        default: return 'Error: invalid operator';
    }
}

module.exports = {
    add,
    sub,
    mult,
    div,
    validateInput,
    evaluateExpressionArray,
};
