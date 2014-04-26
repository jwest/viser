stats = require '../../../../routes/stats/simple-stat-by-range'
assert = require '../../../assert'
repository = require '../../../../storage/repository'

module.exports =

    'Simple stat by range action':

        before: (done) ->
          repository.clean () =>
            repository.save 'source-1', 'target-1', 1, (err, result) =>
              repository.save 'source-1', 'target-2', 1, (err, result) =>
                done()

        'when get data with template':
            'via rage by minutes': (done) ->
                stats.show { body: '', param: -> },
                    render: (template, data) ->
                      assert.equal template, 'stats/simple-stat-by-range'
                      assert.equal JSON.parse(data.data).pop().count, 2
                      done()

        'check parameters':
            'when you get default chart': (done) ->
                stats.show { body: '', param: -> },
                    render: (template, data) ->
                        assert.equal data.unit, 'minute'
                        assert.equal data.count, 10
                        done()

            'when you get chart with other unit': (done) ->
                stats.show { body: '', param: (name) -> if name is 'unit' then 'hour' },
                    render: (template, data) ->
                        assert.equal data.unit, 'hour'
                        assert.equal data.count, 10
                        done()

            'when you get chart with other count': (done) ->
                stats.show { body: '', param: (name) -> if name is 'count' then '20' },
                    render: (template, data) ->
                        assert.equal data.unit, 'minute'
                        assert.equal data.count, 20
                        done()