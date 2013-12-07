assert = require 'assert'

module.exports = assert

module.exports.responseSend = (expectedCode, expectedMessage) ->
    send: (actualCode, actualMessage) -> 
        assert.equal actualCode, expectedCode
        assert.deepEqual actualMessage, expectedMessage

module.exports.responseRender = (expectedTemplate, expectedData) ->
    render: (actualTemplate, actualData) -> 
        assert.equal actualTemplate, expectedTemplate
        assert.deepEqual actualData, expectedData
