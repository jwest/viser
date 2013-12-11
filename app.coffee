express = require 'express'
routes =
	index: require './routes/index'
	dashboard: require './routes/dashboard'
	api: require './routes/api'
http = require 'http'
path = require 'path'
coffeeMiddleware = require 'coffee-middleware'

app = express()

# all environments process.env.PORT || 
app.set 'port', 3000
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
if 'development' == app.get('env')
  app.use express.errorHandler()

app.get '/', routes.index.show
app.get '/dashboard', routes.dashboard.show
app.post '/api/v1/event', routes.api.post

server = http.createServer app

io = require('socket.io').listen server

io.sockets.on 'connection', (socket) ->
  routes.api.on "flow", (source, target) ->
  	socket.emit "flow", source, target

server.listen 3000