express = require 'express'


app = express.createServer()

app.get '/', (req, res) ->
	res.send 'warming up, nothing in place yet'

app.listen process.env.PORT or 3003

