Space = require('../src/space')
chai = require('chai')
should = chai.should()

describe('Space', ->
  it('init test', () ->
    Space.should.be.a('function')
  )
)