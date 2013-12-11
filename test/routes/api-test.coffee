vows = require 'vows'
assert = require '../assert'

api = require '../../routes/api'
console.log api
vows
  .describe('Api action')
  .addBatch
    'when sended event via Api':
        topic: api

        'is valid': 
            'should get success and emit event': (api) ->
                eventExecuted = false
                eventAssert = (source, target) ->
                    assert.equal source, "1"
                    assert.equal target, "2"
                    eventExecuted = true

                request = 
                    body: 
                        source: "1"
                        target: "2"

                api.on "flow", eventAssert

                api.post request, 
                    assert.responseSend 200, 
                        status: 
                            'success'

                assert eventExecuted

        'is invalid': 
            'becouse field SOURCE not exist': 
                'should return bad request': (api) ->
                    request = 
                        body: 
                            target: "2"

                    api.on "flow", ->
                        assert false

                    api.post request, 
                        assert.responseSend 400, 
                            status: 
                                'source field not defined'

            'becouse field TARGET not exist': 
                'should return bad request': (api) ->
                    request = 
                        body: 
                            source: "1"

                    api.on "flow", ->
                        assert false

                    api.post request, 
                        assert.responseSend 400, 
                            status: 
                                'target field not defined'

  .export module