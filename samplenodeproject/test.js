const assert = require('assert')
const main = require('./calculator')
it('AdditionGivesCorrectValue', () => {
    assert.equal(main.add(2, 2), 4)
})
it('SubtractionGivesCorrectValue', () => {
    assert.equal(main.sub(12, 2), 10)
})
it('MultiplicationGivesCorrectValue', () => {
    assert.equal(main.mult(20, 2), 40)
})
it('DivisionGivesCorrectValue', () => {
    assert.equal(main.div(50, 2), 25)
})
it('AdditionOfNegativesGivesCorrectValue', () => {
    assert.equal(main.add(-15, 5), -10)
})
it('ErrorWhenStringEntered', () => {
    assert.equal(main.validateInput("error", 2), false)
})