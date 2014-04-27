routes =
	index: require './routes/index'
	dashboard: require './routes/dashboard'
	api: require './routes/api'
	stats: require './routes/stats'
	statsSimpleStatByRange: require './routes/stats/simple-stat-by-range'

express = require 'express'
http = require 'http'
path = require 'path'
coffeeMiddleware = require 'coffee-middleware'
repository = require './storage/repository'

repository = require './storage/repository'

app = express()

app.set 'port', 80
app.set 'views', path.join __dirname, 'views'
app.set 'view engine', 'jade'
app.use coffeeMiddleware
  src: path.join __dirname, 'public'
  compress: true
app.use express.favicon()
app.use express.logger 'dev'
app.use express.json()
app.use express.urlencoded()
app.use express.methodOverride()
app.use app.router
app.use require('stylus').middleware path.join __dirname, 'public'
app.use express.static path.join __dirname, 'public'

# development only
# if 'development' == app.get('env')
app.use express.errorHandler()

app.get '/', routes.index.show
app.get '/dashboard', routes.dashboard.show
app.post '/api/v1/event', routes.api.post
app.get '/stats', routes.stats.show
app.get '/stats/simple-stat-by-range', routes.statsSimpleStatByRange.show

server = http.createServer app

io = require('socket.io').listen server

io.sockets.on 'connection', (socket) ->
  routes.api.on "flow", (source, target, id) ->
    repository.save source, target, id, () ->
  	  socket.emit "flow", source, target

server.listen 80
