statistics = require './../../storage/statistics'
moment = require 'moment'

exports.show = (req, res) ->
  statistics.repository = require './../../storage/repository'
  statistics.getMinutesByRange moment().subtract(1, 'hour').subtract(10, 'minute'), moment().subtract(1, 'hour'), (err, result) ->
    console.log result
    res.render 'stats/simple-stat-by-range', {}