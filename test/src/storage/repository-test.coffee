repository = require '../../../storage/repository'
assert = require 'assert'
sleep = require 'sleep'

module.exports =

    'Repository':
        'when add item to repository':

            'should get one item after save one': (done) ->

                repository.clean =>                
                    repository.save 'source-1', 'target-1', 1, (err, result) =>
                        repository.count {}, (err, result) =>
                            assert.equal result, 1
                            done()

            'should get two items after save two': (done) ->

                repository.clean () =>                
                    repository.save 'source-1', 'target-1', 1, (err, result) =>
                        repository.save 'source-1', 'target-1', 2, (err, result) =>
                            repository.count {}, (err, result) =>
                                assert.equal result, 2         
                                done()

        'when count items with filters':

            'should return by id': (done) ->

                repository.clean () =>                
                    repository.save 'source-1', 'target-1', 1, (err, result) =>
                        repository.save 'source-1', 'target-1', 2, (err, result) =>
                            repository.count { id : 2 }, (err, result) =>
                                assert.equal result, 1         
                                done()

            'should return by source': (done) ->

                repository.clean () =>                
                    repository.save 'source-1', 'target-1', 1, (err, result) =>
                        repository.save 'source-2', 'target-1', 1, (err, result) =>
                            repository.count { source : 'source-2' }, (err, result) =>
                                assert.equal result, 1         
                                done()

            'should return by target': (done) ->

                repository.clean () =>                
                    repository.save 'source-1', 'target-1', 1, (err, result) =>
                        repository.save 'source-1', 'target-2', 1, (err, result) =>
                            repository.count { target : 'target-2' }, (err, result) =>
                                assert.equal result, 1         
                                done()


        'when count items with datetime filters': 

            'should return one item in date range': (done) ->

                start = new Date().getTime()

                repository.clean () =>                
                    repository.save 'source-1', 'target-1', 1, (err, result) =>
                        
                        sleep.usleep 100000
                        end = new Date().getTime()
                        
                        repository.save 'source-1', 'target-2', 1, (err, result) =>
                            repository.countByRange { start: start, end: end }, (err, result) =>
                                assert.equal result, 1         
                                done()

            'should return one item in other date range': (done) ->

                repository.clean () =>                
                    repository.save 'source-1', 'target-1', 1, (err, result) =>

                        sleep.usleep 300000
                        start = new Date().getTime()

                        repository.save 'source-1', 'target-2', 1, (err, result) =>
                        
                            end = new Date().getTime()

                            repository.countByRange { start: start, end: end }, (err, result) =>
                                assert.equal result, 1         
                                done()

