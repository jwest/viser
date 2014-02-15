Engine = require('tingodb')()
db = new Engine.Db '/tmp', {}
collection = db.collection 'events'

class Repository

	save: (source, target, id, cb) ->
		obj =
			source: source
			target: target
			id: id
			datetime: new Date().getTime()

		collection.insert [ obj ], { w : 1 }, (err, result) ->
		  	cb (err is null)

	count: (filters, cb) ->
		collection.count filters, (err, result) ->
			cb err, result

	countByRange: (start, end, cb) ->
		collection.count { datetime: {"$gte": start, "$lt": end} }, (err, result) ->
			cb err, result

	clean: (cb) ->
		collection.remove {}, cb

module.exports = new Repository