express = require 'express'
mongoose = require 'mongoose'
request = require 'request'

pin = require './app/models/pin'

MONGOHQ_URL = process.env.MONGOHQ_URL or 'mongodb://localhost/db'
APP_PORT = process.env.PORT or 3003

mongoose.connect MONGOHQ_URL, {auto_reconnect: true, poolSize: 4}

seed = () ->
	request.get 'http://ec2-204-236-206-235.compute-1.amazonaws.com:8080/pinhub/pin.csv', (err, rez, data) ->
		r = new RegExp('([0-9]+),(.*)\n', 'g')
		while m = r.exec(data)
			p = new pin()
			p.address = m[1]
			p.code = m[2]
			p.save (err) ->
				# silent

app = express.createServer()

app.get '/', (req, res) ->
	res.send 'warming up, nothing in place yet'

app.get '/seed', (req, res) ->
	pin.count {}, (err, d) ->
		if not err and +d is 0
			seed()
			res.send 'all triggered as async save'
		else
			res.send "already #{d} records"

require('./app/routes/pin')(app)
require('./app/routes/search')(app)

app.listen APP_PORT

