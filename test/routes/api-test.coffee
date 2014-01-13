vows = require 'vows'
assert = require '../assert'

api = require '../../routes/api'
console.log api
vows
  .describe('Api action')
  .addBatch
    'when sent event via Api':
        topic: api

        'is valid':
            'and all fields are set':
                'should get success and emit event': (api) ->
                    eventExecuted = false
                    eventAssert = (source, target, id) ->
                        assert.equal source, "1"
                        assert.equal target, "2"
                        assert.equal id, "3"
                        eventExecuted = true
    
                    request = 
                        body: 
                            source: "1"
                            target: "2"
                            id: "3"
    
                    api.once "flow", eventAssert
    
                    api.post request, 
                        assert.responseSend 200, 
                            status: 
                                'success'
    
                    assert eventExecuted

            'and all fields but id are set':
                'should get success and emit event': (api) ->
                    eventExecuted = false
                    eventAssert = (source, target, id) ->
                        assert.equal source, "1"
                        assert.equal target, "2"
                        assert.isNull id
                        eventExecuted = true
    
                    request = 
                        body: 
                            source: "1"
                            target: "2"
    
                    api.once "flow", eventAssert
    
                    api.post request, 
                        assert.responseSend 200, 
                            status: 
                                'success'
    
                    assert eventExecuted

        'is invalid': 
            'because field SOURCE does not exist': 
                'should return bad request': (api) ->
                    request = 
                        body: 
                            target: "2"

                    api.once "flow", ->
                        assert false

                    api.post request, 
                        assert.responseSend 400, 
                            status: 
                                'source field not defined'

            'because field TARGET does not exist': 
                'should return bad request': (api) ->
                    request = 
                        body: 
                            source: "1"

                    api.once "flow", ->
                        assert false

                    api.post request, 
                        assert.responseSend 400, 
                            status: 
                                'target field not defined'

  .export module