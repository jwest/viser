statistics = require './../../storage/statistics'
statistics.repository = require './../../storage/repository'
moment = require 'moment'

exports.show = (req, res) ->
  statistics.getMinutesByRange moment().subtract(10, 'minute'), moment(), (err, result) ->
    res.render 'stats/simple-stat-by-range', {}