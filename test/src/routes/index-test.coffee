index = require '../../../routes/index'
assert = require '../../assert'

module.exports =

    'Index action':
        'when show index page':
            'should see index view': ->

                index.show {},
                     assert.responseRender 'index', {}