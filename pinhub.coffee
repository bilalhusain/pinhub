express = require 'express'
mongoose = require 'mongoose'

MONGOHQ_URL = process.env.MONGOHQ_URL or 'mongodb://localhost/db'
APP_PORT = process.env.PORT or 3003

mongoose.connect MONGOHQ_URL, {auto_reconnect: true, poolSize: 4}

app = express.createServer()

app.get '/', (req, res) ->
	res.send 'warming up, nothing in place yet'

app.get '/seed', (req, res) ->
	pin = require './app/models/pin'
	p = new pin()
	p.address = 'New Delhi'
	p.code = '110016'
	p.save (err) ->
		res.send 'seeded'

require('./app/routes/pin')(app)
require('./app/routes/search')(app)

app.listen APP_PORT

