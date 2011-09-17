pin = require '../models/pin'

module.exports = (app) ->
	app.get '/search/:address', (req, res) ->
		pin.searchAddress req.params.address, (ps) ->
			res.send JSON.stringify(ps)

