express = require 'express'
routes = require './routes'
dashboard = require './routes/dashboard'
http = require 'http'
path = require 'path'
coffeeMiddleware = require 'coffee-middleware'

app = express()

# all environments
app.set 'port', process.env.PORT || 3000
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

app.get '/', routes.index
app.get '/dashboard', dashboard.show

http.createServer(app).listen app.get('port'), ->
  console.log 'Express server listening on port ' + app.get 'port'