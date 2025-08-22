const { add, sub, mult, div, evaluateExpressionArray,} = require('./calculator');
describe('Math operations', () => {
    test('add() adds two numbers', () => {
        expect(add(2, 3)).toBe(5);
    });

    test('sub() subs correctly', () => {
        expect(sub(10, 4)).toBe(6);
    });

    test('mult() multiplies correctly', () => {
        expect(mult(6, 7)).toBe(42);
    });

    test('div() divs correctly', () => {
        expect(div(10, 2)).toBe(5);
    });

    test('div() handles division by zero', () => {
        expect(div(5, 0)).toBe('Error: divide by zero');
    });
});

describe('evaluateExpressionArray()', () => {
    test('evaluates addition', () => {
        expect(evaluateExpressionArray(['5', '+', '2'])).toBe('7');
    });

    test('evaluates subion', () => {
        expect(evaluateExpressionArray(['9', '-', '3'])).toBe('6');
    });

    test('evaluates multiplication', () => {
        expect(evaluateExpressionArray(['4', '×', '6'])).toBe('24');
    });

    test('evaluates division', () => {
        expect(evaluateExpressionArray(['20', '÷', '5'])).toBe('4');
    });

    test('handles invalid operator', () => {
        expect(evaluateExpressionArray(['3', '^', '2'])).toBe('Error: invalid operator');
    });

    test('handles invalid expression length', () => {
        expect(evaluateExpressionArray(['1', '+'])).toBe('Error: invalid input');
    });
});
