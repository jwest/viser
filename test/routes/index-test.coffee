vows = require 'vows'
assert = require '../assert'

index = require '../../routes/index'

vows
  .describe('Index action')
  .addBatch
    'when show index page':
        topic: index

        'should see index view': (index) ->
            index.show {}, 
                assert.responseRender 'index', {}

  .export module