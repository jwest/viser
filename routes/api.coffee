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

    @emit "flow", req.body.source, req.body.target, req.body.id

    res.send 200,
      status: "success"

module.exports = new Api