dashboard = require '../../../routes/dashboard'
assert = require '../../assert'

module.exports =

    'Dashboard action':
        'when show dashboard':
            'should see dashboard view': ->
                
                dashboard.show {},
                     assert.responseRender 'dashboard', {}
