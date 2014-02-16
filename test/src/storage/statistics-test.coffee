statistics = require '../../../storage/statistics'
assert = require 'assert'
moment = require 'moment'
statistics.repository = require '../../repository-mock.coffee'

module.exports =

    'Statistics': # @see for repository mock (endDate - startDate)

        'when get stats from repository by day':

            'should return 2 dayly statistics': (done) ->

                startDate = moment('2014-02-13', "YYYY-MM-DD")
                endDate = moment('2014-02-14', "YYYY-MM-DD")

                statistics.getDaysByRange startDate, endDate, (err, days)->
                    assert.deepEqual days, [
                        { date : "2014-02-13 00:00:00", count : 86399999 }
                        { date : "2014-02-14 00:00:00", count : 86399999 }
                    ]
                    done()


            'should return 5 dayly statistics': (done) ->

                startDate = moment('2014-02-10', "YYYY-MM-DD")
                endDate = moment('2014-02-14', "YYYY-MM-DD")

                statistics.getDaysByRange startDate, endDate, (err, days)->
                    assert.deepEqual days, [
                        {"date":"2014-02-10 00:00:00","count":86399999}
                        {"date":"2014-02-11 00:00:00","count":86399999}
                        {"date":"2014-02-12 00:00:00","count":86399999}
                        {"date":"2014-02-13 00:00:00","count":86399999}
                        {"date":"2014-02-14 00:00:00","count":86399999}
                    ]
                    done()


        'when get stats from repository by hour':

            'should return 2 hourly statistics': (done) ->

                startDate = moment('2014-02-14 10:00', "YYYY-MM-DD HH:mm")
                endDate = moment('2014-02-14 11:00', "YYYY-MM-DD HH:mm") 

                statistics.getHoursByRange startDate, endDate, (err, hours)->
                    assert.deepEqual hours, [
                        {"date":"2014-02-14 10:00:00","count":3599999}
                        {"date":"2014-02-14 11:00:00","count":3599999}
                    ]
                    done()


            'should return 5 hourly statistics': (done) ->

                startDate = moment('2014-02-14 10:00', "YYYY-MM-DD HH:mm")
                endDate = moment('2014-02-14 14:00', "YYYY-MM-DD HH:mm") 

                statistics.getHoursByRange startDate, endDate, (err, hours)->
                    assert.deepEqual hours, [
                        {"date":"2014-02-14 10:00:00","count":3599999}
                        {"date":"2014-02-14 11:00:00","count":3599999}
                        {"date":"2014-02-14 12:00:00","count":3599999}
                        {"date":"2014-02-14 13:00:00","count":3599999}
                        {"date":"2014-02-14 14:00:00","count":3599999}
                    ]
                    done()


        'when get stats from repository by minutes':

            'should return 2 hourly statistics': (done) ->

                startDate = moment('2014-02-14 10:00', "YYYY-MM-DD HH:mm")
                endDate = moment('2014-02-14 10:01', "YYYY-MM-DD HH:mm") 

                statistics.getMinutesByRange startDate, endDate, (err, minutes)->
                    assert.equal minutes.length, 2
                    assert.deepEqual minutes, [
                        {"date":"2014-02-14 10:00:00","count":59999}
                        {"date":"2014-02-14 10:01:00","count":59999}
                    ]
                    done()


            'should return 5 hourly statistics': (done) ->

                startDate = moment('2014-02-14 10:00', "YYYY-MM-DD HH:mm")
                endDate = moment('2014-02-14 10:04', "YYYY-MM-DD HH:mm") 

                statistics.getMinutesByRange startDate, endDate, (err, minutes)->
                    assert.equal minutes.length, 5
                    assert.deepEqual minutes, [
                        {"date":"2014-02-14 10:00:00","count":59999}
                        {"date":"2014-02-14 10:01:00","count":59999}
                        {"date":"2014-02-14 10:02:00","count":59999}
                        {"date":"2014-02-14 10:03:00","count":59999}
                        {"date":"2014-02-14 10:04:00","count":59999}
                    ]
                    done()