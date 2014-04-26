stats = require '../../../../routes/stats/simple-stat-by-range'
assert = require '../../../assert'
repository = require '../../../../storage/repository'

module.exports =

    'Simple stat by range action':
        'when get data with template':
            'via rage by minutes': (done) ->

                repository.clean () =>                
                    repository.save 'source-1', 'target-1', 1, (err, result) =>
                        repository.save 'source-1', 'target-2', 1, (err, result) =>
                            repository.count {}, (err, result) =>
                                request = { body: '' }

                                stats.show request,
                                    assert.responseRender 'stats/simple-stat-by-range', {}, done
