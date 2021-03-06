Engine = require('tingodb')()
db = new Engine.Db '.', {}
collection = db.collection 'events'
moment = require 'moment'

class Repository

  save: (source, target, id, cb) ->
    obj =
      source: source
      target: target
      id: id
      datetime: moment().valueOf()

    collection.insert [ obj ], { w : 1 }, (err, result) ->
      cb (err is null)

  count: (filters, cb) ->
    collection.count filters, (err, result) ->
      cb err, result
#
#  find: (cb) ->
#    collection.find().toArray (err, result) ->
#      cb err, result

  countByRange: (obj, cb) ->
    collection.count { datetime: {"$gte": obj.start, "$lt": obj.end} }, (err, result) ->
      cb err, result

  clean: (cb) ->
    collection.remove {}, cb

module.exports = new Repository
