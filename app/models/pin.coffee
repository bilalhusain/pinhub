mongoose = require 'mongoose'

# yup, used nosql when sql was perfect fit. kill me!
pinSchema = new mongoose.Schema
	#_id: Object
	address: String
	code: String # may be future postal codes are alphanumeric?

pinSchema.statics.getPin = (pin, callback) ->
	this.find {code: pin}, (err, ps) ->
		return callback([{error: 'not found'}]) if err or not ps
		callback(ps)

pinSchema.statics.searchAddress = (address, callback) ->
	return callback([{error: 'too much information (irony mark here)'}]) if address.length < 3
	this.find {address: new RegExp(address, 'i') }, [], {limit: 10}, (err, ps) ->
		return callback([{error: 'not found'}]) if err or not ps
		callback(ps)

mongoose.model 'pinhub_pin', pinSchema
module.exports = mongoose.model 'pinhub_pin'
