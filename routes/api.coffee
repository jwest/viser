exports.event = (req, res) ->
  
  if not req.body.source?
  	res.send 400,
    	status: "source field not defined"
    return
  
  if not req.body.target?
  	res.send 400,
    	status: "target field not defined"
    return

  res.send 200,
    status: "success"