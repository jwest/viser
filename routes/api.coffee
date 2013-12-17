{EventEmitter} = require 'events'

class Api extends EventEmitter 

  post: (req, res) =>
    
    if not req.body.source?
      res.send 400,
        status: "source field not defined"
      return
    
    if not req.body.target?
      res.send 400,
        status: "target field not defined"
      return

    id = if req.body.id? then req.body.id else null
    
    @emit "flow", req.body.source, req.body.target, id

    res.send 200,
      status: "success"

module.exports = new Api