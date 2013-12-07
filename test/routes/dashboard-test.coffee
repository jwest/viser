vows = require 'vows'
assert = require '../assert'

dashboard = require '../../routes/dashboard'

vows
  .describe('Dashboard action')
  .addBatch
    'when show dashboard':
        topic: dashboard

        'should see dashboard view': (dashboard) ->
            dashboard.show {}, 
                assert.responseRender 'dashboard', {}

  .export module