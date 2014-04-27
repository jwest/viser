fs = require "fs"

exports.show = (req, res) ->
  fs.readFile 'graphDeclaration', (err, output) ->
    res.render 'dashboard',
      graph: output.toString()