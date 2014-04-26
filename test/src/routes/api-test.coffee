api = require '../../../routes/api'
assert = require '../../assert'

module.exports =

    'Api action':
        'when sended event via Api':
            'is valid': 
                'should get success and emit event': (done) ->

                    request = { body: { id: 1, source: "1", target: "2" } }

                    api.on "flow", (source, target, id) ->
                        assert.equal id, 1
                        assert.equal source, "1"
                        assert.equal target, "2"
                        assert.equal id, ""
                        api.removeListener "flow", arguments.callee
                        done()

                    api.post request, 
                        assert.responseSend 200, 
                            status: 
                                'success'

                'should get success and emit event with id field': (done) ->

                    request = { body: { source: "3", target: "4", id: "id" } }

                    api.on "flow", (source, target, id) ->
                        assert.equal source, "3"
                        assert.equal target, "4"
                        assert.equal id, "id"
                        api.removeListener "flow", arguments.callee
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
