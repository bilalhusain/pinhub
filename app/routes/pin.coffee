pin = require '../models/pin'

module.exports = (app) ->
	app.get '/pins/:pin', (req, res) ->
		pin.getPin req.params.pin, (ps) ->
			res.send JSON.stringify(ps)

