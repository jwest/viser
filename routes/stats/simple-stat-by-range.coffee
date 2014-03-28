statistics = require './../../storage/statistics'
moment = require 'moment'

exports.show = (req, res) ->
  statistics.getMinutesByRange moment(), moment().subtract(1, 'h'), (err, result) ->
    console.log err
    console.log result
    res.render 'stats/simple-stat-by-range', {}