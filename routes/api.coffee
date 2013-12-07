exports.event = (req, res) ->
  
  res.send(400,
    status: "source not defined"
  ) if not req.body.source?
  
  res.send(400,
    status: "target not defined"
  ) if not req.body.target?

  res.send 200,
    status: "success"
    source: req.body.source 
    target: req.body.target