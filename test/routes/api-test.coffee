vows = require 'vows'
assert = require '../assert'

api = require '../../routes/api'

vows
  .describe('Api action')
  .addBatch
    'when sended event via Api':
        topic: api

        'is valid': 
            'should get success': (api) ->
                request = 
                    body: 
                        source: "1"
                        target: "2"

                api.event request, 
                    assert.responseSend 200, 
                        status: 
                            'success'

        'is invalid': 
            'becouse field SOURCE not exist': 
                'should return bad request': (api) ->
                    request = 
                        body: 
                            target: "2"

                    api.event request, 
                        assert.responseSend 400, 
                            status: 
                                'source field not defined'

            'becouse field TARGET not exist': 
                'should return bad request': (api) ->
                    request = 
                        body: 
                            source: "1"

                    api.event request, 
                        assert.responseSend 400, 
                            status: 
                                'target field not defined'
  .export module