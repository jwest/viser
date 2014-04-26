statistics = require './../../storage/statistics'
statistics.repository = require './../../storage/repository'
moment = require 'moment'

exports.show = (req, res) ->

  unit = if req.param('unit')? then req.param('unit') else "minute"
  count = if req.param('count')? then parseInt req.param('count') else 10

  statistics.getByRange unit, moment().subtract(count, unit), moment(), (err, result) ->
    res.render 'stats/simple-stat-by-range',
      unit: unit
      count: count
      data: JSON.stringify(result)
