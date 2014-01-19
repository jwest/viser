api = require '../../../routes/api'
assert = require '../../assert'

module.exports =

    'Api action':
        'when sended event via Api':
            'is valid': 
                'should get success and emit event': (done) ->

                    request = { body: { source: "1", target: "2" } }

                    api.on "flow", (source, target) ->
                        assert.equal source, "1"
                        assert.equal target, "2"
                        done()

                    api.post request, 
                        assert.responseSend 200, 
                            status: 
                                'success'

                
            'is invalid':
                'becouse field SOURCE not exist': ->

                    request = { body: { target: "2" }}

                    api.post request, 
                        assert.responseSend 400, 
                            status: 
                                'source field not defined'

                'becouse field TARGET not exist': ->

                    request = { body: { source: "1" }}

                    api.post request, 
                        assert.responseSend 400, 
                            status: 
                                'target field not defined'
