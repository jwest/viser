repository = require './repository'
moment = require 'moment-range'
async = require 'async'

class Statistics

  @repository = repository

  getByRange: (unit, start, end, cbEnd) ->

    range = moment().range start, end
    elements = []

    range.by unit + 's', (moment) ->
      elements.push
        start: moment.startOf(unit).valueOf()
        end: moment.endOf(unit).valueOf()

    fu = (item, cb) =>
      @repository.countByRange item, (err, result) ->
        cb null,
          date : moment(item.start).format('YYYY-MM-DD HH:mm:ss')
          count : result

    async.map elements, fu, (err, results)->
      cbEnd null, results

  getDaysByRange: (start, end, cb) ->
    @getByRange 'day', start, end, cb

  getHoursByRange: (start, end, cb) ->
    @getByRange 'hour', start, end, cb

  getMinutesByRange: (start, end, cb) ->
    @getByRange 'minute', start, end, cb

module.exports = new Statistics