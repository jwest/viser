repository = require '../../../storage/repository'
assert = require '../../assert'

module.exports =

    'Repository':
        'when add item to repository':

            'should get one item after save one': (test) ->

                repository.clean =>                
                    repository.save 'source-1', 'target-1', 1, (err, result) =>
                        repository.count {}, (err, result) =>
                            assert.equal result, 1
                            test()

            'should get two items after save two': (test) ->

                repository.clean () =>                
                    repository.save 'source-1', 'target-1', 1, (err, result) =>
                        repository.save 'source-1', 'target-1', 2, (err, result) =>
                            repository.count {}, (err, result) =>
                                assert.equal result, 2         
                                test()

        'when count items with filters':

            'should return by id': (test) ->

                repository.clean () =>                
                    repository.save 'source-1', 'target-1', 1, (err, result) =>
                        repository.save 'source-1', 'target-1', 2, (err, result) =>
                            repository.count { id : 1 }, (err, result) =>
                                assert.equal result, 1         
                                test()

            'should return by source': (test) ->

                repository.clean () =>                
                    repository.save 'source-1', 'target-1', 1, (err, result) =>
                        repository.save 'source-2', 'target-1', 1, (err, result) =>
                            repository.count { source : 'source-2' }, (err, result) =>
                                assert.equal result, 1         
                                test()

            'should return by target': (test) ->

                repository.clean () =>                
                    repository.save 'source-1', 'target-1', 1, (err, result) =>
                        repository.save 'source-1', 'target-2', 1, (err, result) =>
                            repository.count { target : 'target-2' }, (err, result) =>
                                assert.equal result, 1         
                                test()