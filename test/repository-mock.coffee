moment = require 'moment'

module.exports =
    countByRange: (obj, cb) ->

    	cb null, obj.end - obj.start
    	return