const express = require('express');
const app = express();
const port = 5000;

app.get('/', (req, res) => {
    res.send(`
    <!DOCTYPE html>
    <html>
    <head>
      <title>Calculator</title>
      <style>
        body {
          font-family: sans-serif;
          display: flex;
          justify-content: center;
          align-items: center;
          height: 100vh;
          background-color: #f0f0f0;
        }
        .calculator {
          display: grid;
          grid-template-columns: repeat(4, 80px);
          gap: 10px;
          padding: 20px;
          background: white;
          border-radius: 10px;
          box-shadow: 0 0 10px rgba(0,0,0,0.1);
        }
        .display {
          grid-column: span 4;
          height: 50px;
          font-size: 24px;
          padding: 10px;
          text-align: right;
          border: none;
          background-color: #f4f4f4;
          border-radius: 8px;
        }
        .calculator button {
          font-size: 24px;
          padding: 20px;
          border: none;
          background-color: #e0e0e0;
          border-radius: 8px;
          cursor: pointer;
        }
        .calculator button:hover {
          background-color: #ccc;
        }
        .span-two {
          grid-column: span 2;
        }
      </style>
    </head>
    <body>
      <div class="calculator">
        <input type="text" id="display" class="display" disabled />

        <button onclick="sendValue('C')">C</button>
        <button onclick="sendValue('±')">±</button>
        <button onclick="sendValue('%')">%</button>
        <button onclick="sendValue('÷')">÷</button>

        <button onclick="sendValue('7')">7</button>
        <button onclick="sendValue('8')">8</button>
        <button onclick="sendValue('9')">9</button>
        <button onclick="sendValue('×')">×</button>

        <button onclick="sendValue('4')">4</button>
        <button onclick="sendValue('5')">5</button>
        <button onclick="sendValue('6')">6</button>
        <button onclick="sendValue('-')">−</button>

        <button onclick="sendValue('1')">1</button>
        <button onclick="sendValue('2')">2</button>
        <button onclick="sendValue('3')">3</button>
        <button onclick="sendValue('+')">+</button>

        <button onclick="sendValue('0')" class="span-two">0</button>
        <button onclick="sendValue('.')">.</button>
        <button onclick="sendValue('=')">=</button>
      </div>

      <script>
        let expression = [];
        let display = "";

        function add(a, b) {
          return a + b;
        }

        function subtract(a, b) {
          return a - b;
        }

        function multiply(a, b) {
          return a * b;
        }

        function divide(a, b) {
          if (b === 0) return "Error: divide by zero";
          return a / b;
        }

        function evaluateExpressionArray(arr) {
          if (arr.length !== 3) return "Error: invalid input";
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
            default: return "Error: invalid operator";
          }
        }

        function sendValue(val) {
          if (val === 'C') {
            expression = [];
            display = "";
            updateDisplay();
            return;
          }

          if (val === '=') {
            if (expression.length === 3) {
              const result = evaluateExpressionArray(expression);
              display = result;
              expression = [result]; // allow chaining
              updateDisplay();
            }
            return;
          }

          // Operators
          if (['+', '-', '×', '÷'].includes(val)) {
            if (expression.length === 1) {
              expression.push(val);
              display += val;
            }
          } else {
            // Digits or decimal
            if (expression.length === 0 || expression.length === 2) {
              expression.push(val);
            } else {
              expression[expression.length - 1] += val;
            }
            display += val;
          }

          updateDisplay();
        }

        function updateDisplay() {
          document.getElementById('display').value = display;
        }
      </script>
    </body>
    </html>
  `);
});

app.listen(port, () => console.log(`App running on port ${port}`));
